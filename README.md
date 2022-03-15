# Kubernetes setup in CENTOS using kubeadm method
Steps followed from [Reference Link](https://www.vultr.com/docs/deploy-kubernetes-with-kubeadm-on-centos-7/)
- Create an EC2 instance with t2 medium CPU and use it as master node.
- Create an EC2 instance with any type of CPU and can be used as worker nodes.
## Run the below Shell script in Master Node
```
bash <(curl -s https://raw.githubusercontent.com/SaiSurya9999/ShellScripts/master/kubedum_master_node.sh)
```

## Run the below Shell script in Worker Nodes
```
bash <(curl -s https://raw.githubusercontent.com/SaiSurya9999/ShellScripts/master/kubedum_worker_node.sh)
```
**Note:**  
- After running the master shell script then the output of the command should contain something like below which should be executed in all the worker nodes.
```
kubeadm join YOUR_IP:6443 --token 4if8c2.pbqh82zxcg8rswui \
--discovery-token-ca-cert-hash sha256:a0b2bb2b31bf7b06bb5058540f02724240fc9447b0e457e049e59d2ce19fcba2
```
- Don't forget to open the **6443 port** in master node inbound security rules.

**Kubernetes Setup using KOPS Method in Amazon Linux**

```
sh <(curl -s https://raw.githubusercontent.com/SaiSurya9999/ShellScripts/master/kops_configure.sh)
```
