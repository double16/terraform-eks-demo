#!/bin/bash -xe -o pipefail

export KUBECONFIG="${HOME}/.kube/eks-demo-config"

terraform apply
terraform output -json | jq -r .kubeconfig.value > ${KUBECONFIG}
terraform output -json | jq -r .config_map_aws_auth.value | kubectl apply -f -
kubectl apply --filename storageclass-aws.yaml
kubectl patch storageclass standard -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'

# Helm, https://medium.com/@zhaimo/using-helm-to-install-application-onto-aws-eks-36840ff84555
kubectl create serviceaccount tiller --namespace kube-system
kubectl apply -f tiller-rbac-config.yaml
helm init --service-account tiller --wait
helm install stable/cluster-autoscaler -f autoscaler-values.yaml --namespace kube-system
