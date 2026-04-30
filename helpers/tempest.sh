#!/usr/bin/env bash
function trun
{
  THOME=~/$(pip3 list | grep "^tempest\s" | sed -r -e "s/ +/-/")
  if [ -z "$THOME" ]
  then
    echo "Could not find tempest"
    return 1
  fi

  if ! [ -d "$THOME" ]
  then
    echo "Could not find tempest conf dir"
    return 1
  fi

  cd $THOME

  RUN_LOG_FILENAME="test-run-$(date "+%y%m%d_%H%M%S").log"
  LATEST_RUN_LOG_FILENAME="test-run-latest.log"

  tempest run --load-list smoke-tests.list | tee $RUN_LOG_FILENAME

  if test -L $LATEST_RUN_LOG_FILENAME
  then
    rm -rf $LATEST_RUN_LOG_FILENAME
    ln -s $RUN_LOG_FILENAME $LATEST_RUN_LOG_FILENAME
  fi
}

function tdiff
{
  output_width=256
  #printf '=%.0s' $(seq 1 $output_width); echo ""
  diff --width $output_width -y <(sed -n '/Totals/,$p' $1) <(sed -n '/Totals/,$p' $2)
  echo ""
  #printf '=%.0s' $(seq 1 $output_width); echo ""
  caption="Fails"
  echo "$caption"
  L=$(echo -n "$caption" | wc -c)
  printf '=%.0s' $(seq 1 $L); echo ""
  diff --width 256 -y <(cat $1| grep 'FAILED$' | awk '{print $(NF-3)}' | sort ) <(cat $2 | grep 'FAILED$' | awk '{print $(NF-3)}'| sort)
}


function tcleanup
{
  THOME=~/$(pip3 list | grep "^tempest\s" | sed -r -e "s/ +/-/")
  if [ -z "$THOME" ]
  then
    echo "Could not find tempest"
    return 1
  fi

  if ! [ -d "$THOME" ]
  then
    echo "Could not find tempest conf dir"
    return 1
  fi

  cd $THOME

  # --- 1. CREDENTIALS ---
  TEMPEST_CONF="etc/tempest.conf"
  get_conf_val() {
      sed -n "/^\[$1\]/,/^\[/p" "$TEMPEST_CONF" | grep "^$2" | head -n 1 | cut -d'=' -f2- | tr -d '[:space:]'
  }

  export OS_USERNAME=$(get_conf_val "auth" "admin_username")
  export OS_PASSWORD=$(get_conf_val "auth" "admin_password")
  export OS_PROJECT_NAME=$(get_conf_val "auth" "admin_project_name")
  export OS_AUTH_URL=$(get_conf_val "identity" "uri")
  export OS_IDENTITY_API_VERSION=3
  export OS_USER_DOMAIN_NAME="Default"
  export OS_PROJECT_DOMAIN_NAME="Default"

  # --- 2. THE SAFE LIST ---
  # We store these as a comma-separated list for jq to use
  SAFE_IDS=$(openstack project list -f value -c ID | paste -sd "," -)
  echo "Safeguarding Projects: $SAFE_IDS"

  # --- 3. THE CLEANUP ---
  # We fetch the entire FW group list as JSON
  openstack firewall group list -f json --long | jq -c '.[]' | while read -r group; do

      FW_ID=$(echo "$group" | jq -r '.ID')
      PROJ_ID=$(echo "$group" | jq -r '.Project')

      # CHECK: Is the Project ID in our safe list?
      if [[ "$SAFE_IDS" == *"$PROJ_ID"* ]]; then
          echo "PROTECTED: Group $FW_ID (Project $PROJ_ID)"
          continue
      fi

      # If we got here, it's an orphan.
      echo "----------------------------------------------------"
      echo "ORPHAN FOUND: $FW_ID (Project: $PROJ_ID)"

      # Final Safety: Check Ports again using the JSON we already have
      # Some OpenStack versions use 'Ports' (capitalized) or 'ports'
      PORT_COUNT=$(echo "$group" | jq -r '.Ports | length // .ports | length')

      if [ "$PORT_COUNT" -gt 0 ]; then
          echo "!! STOP: This group has $PORT_COUNT ports. Skipping for safety."
          continue
      fi

      # Get Policies
      IN_POL=$(echo "$group" | jq -r '."Ingress Policy ID" // ."ingress_policy_id"')
      EG_POL=$(echo "$group" | jq -r '."Egress Policy ID" // ."egress_policy_id"')

      echo "Action: Deleting Group $FW_ID..."
      openstack firewall group delete "$FW_ID"

      # Cleanup Policies
      for POL in "$IN_POL" "$EG_POL"; do
          if [[ -n "$POL" && "$POL" != "null" ]]; then
              echo "Action: Deleting Policy $POL..."
              openstack firewall group policy delete "$POL" 2>/dev/null
          fi
      done
  done
}

