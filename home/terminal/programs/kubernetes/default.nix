{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
{
  home.packages = with pkgs; [
    kubectl
    cilium-cli
    popeye
    clusterctl
    cmctl
    fluxcd
    k8sgpt
    kind
    kube-capacity
    kubectl-cnpg
    kubeseal
    kubectl-node-shell
    kubectl-tree
    kubelogin-oidc
    kubernetes-helm
    kubevirt
    velero

    argocd
    cilium-cli
    clusterctl
    cmctl
    distrobox
    helm-docs
    hubble
    # k8sgpt
    kind
    kube-capacity
    kubectl
    kubectl-cnpg
    kubectl-node-shell
    kubectl-tree
    kubectl-validate
    kubectl-neat
    kubectl-images
    kubectl-example
    kubectx
    kubeconform
    kubelogin-oidc
    kubernetes-helm
    kubeseal
    kubevirt
    # packer
    popeye
  ];
}
