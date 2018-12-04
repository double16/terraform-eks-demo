# EKS Getting Started Guide Configuration

This is the full configuration from https://www.terraform.io/docs/providers/aws/guides/eks-getting-started.html

See that guide for additional information.

NOTE: This full configuration utilizes the [Terraform http provider](https://www.terraform.io/docs/providers/http/index.html) to call out to icanhazip.com to determine your local workstation external IP for easily configuring EC2 Security Group access to the Kubernetes master servers. Feel free to replace this as necessary.

EC2 instances are autoscaled as needed.

Helm is installed according to https://medium.com/@zhaimo/using-helm-to-install-application-onto-aws-eks-36840ff84555

```shell
$ export AWS_PROFILE="admin"
$ ./up.sh
$ export KUBECONFIG="${HOME}/.kube/eks-demo-config"
$ helm install stable/kubernetes-dashboard --namespace kube-system
$ kubectl get all
```
