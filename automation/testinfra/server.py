def test_file(host):
    test_file = host.file("/etc/os-release")
    assert test_file.is_file
    assert test_file.contains("id=ubuntu")
    assert test_file.user  == "root"
    assert test_file.group == "root"
    assert test_file.mode  == 0o644

def test_router_reachable(host):
    assert host.addr("10.30.10.1").is_reachable

def test_metadata_service(host):
    output = host.check_output("curl -sS --write-out ' %{http_code}'   http://169.254.169.254/openstack/2012-08-10 | xargs")
    assert "200" in output
    assert "meta_data.json" in output

def test_volume_attached(host):
    assert host.file("/dev/vdb").exists
