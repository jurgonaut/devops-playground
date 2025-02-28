### Fixes
We run kubernetes in a private network which causes kubernetes to grab the first network controller and that causes some problems. More info:

https://medium.com/@aleverycity/kubeadm-init-join-and-externalip-vs-internalip-519519ddff89
https://github.com/kubernetes/kubernetes/issues/60835
guide: https://gist.github.com/rkaramandi/44c7cea91501e735ea99e356e9ae7883

### Deploy

Add route to VirtualBox network (on your host). The ip `193.168.2.0` is for the `Metallb`,
the ip `192.168.56.20` is a private ip of the kubernetes worker.
```bash
sudo ip route add 192.168.2.0/24 via 192.168.56.20 dev vboxnet0
```

Deploy the master
```bash
ansible-playbook playbooks/kubernetes-master.yml
```

Deploy worker (fill in `token` and `cert_hash`)
```bash
ansible-playbook playbooks/kubernetes-worker.yml \
--extra-vars "token= cert_hash="
```

Deploy Metallb
```bash
ansible-playbook playbooks/metallb.yml
```

Get the ip address of the service (in `kubernetes_worker`)
```bash
kubectl get services
```

Test the deploy (see the column `EXTERNAL-IP` from above command)
```bash
curl http://192.168.2.3
```

### Additional commands

You can scale the deployment (run in `kubernetes_master`)
```bash
kubectl scale --replicas=3 deployment hello-server
```
Then you can run above `curl` and see multiple pods responding

Inspect the metallb controller deploy status
```bash
kubectl get deploy -n metallb-system -o wide
```
