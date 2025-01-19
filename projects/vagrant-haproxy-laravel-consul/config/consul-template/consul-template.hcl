template {
    source = "/etc/haproxy/haproxy.cfg.tpl"
    destination = "/etc/haproxy/haproxy.cfg"
    command = "service haproxy restart"
}
