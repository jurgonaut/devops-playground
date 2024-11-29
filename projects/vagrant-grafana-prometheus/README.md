Setup a `monitor` and 2 `nodes` in `Vagrant`. Install `Grafana` and `Prometheus` on `monitor`, install `node_exporter` on the `nodes`. The `prometheus` role picks up the IP addresses from the `nodes` group in the inventory.

SSH access to the `Vagrant` VM:
```bash
ssh vagrant@<ip> -i ~/.vagrant.d/insecure_private_key
```
