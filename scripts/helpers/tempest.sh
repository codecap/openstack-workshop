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
