## About
Example deployment of `Mariadb`, a `Laravel` app and `Haproxy` that acts as a load balancer for `Laravel`. I used [this](https://github.com/aalhommada/laravel-crud.git) `Laravel` example app.

The idea is to simulate auto scaling useing `Consul` and `Consul template` to notify `Haproxy` when a new `Laravel` app joins/leaves the cluster.

## Usage
First deploy `Mariadb`:
```bash
ansible-playbook playbooks/maridb_setup.yml
```

Then deploy `Haproxy`:
```bash
ansible-playbook playbooks/haproxy_setup.yml
```

Finally deploy the `Laravel app`:
```bash
ansible-playbook playbooks/app_setup.yml
```

To simulate auto scaling, uncomment the `web2` ip address to the `hosts` under the group `web`. Then run the `app_setup.yml` playbook from above to configure the new node.

After that you can verify the `Haproxy` configuration file on the `proxy` host (`/etc/haproxy/haproxy.cfg`) that it contains both `web` servers ip address as the `backend`.
