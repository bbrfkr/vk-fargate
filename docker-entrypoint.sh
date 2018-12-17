#!/bin/sh

if [ "$KUBELET_PORT" = "" ] ; then
  echo "ERROR: required KUBELET_PORT environment variable..."
  exit 1
fi

if [ "$EKS_CLUSTER_NAME" = "" ] ; then
  echo "ERROR: required EKS_CLUSTER_NAME environment variable..."
  exit 1
else
  aws eks update-kubeconfig --name $EKS_CLUSTER_NAME
fi

sed -i "s/FARGATE_CLUSTER_REGION/$FARGATE_CLUSTER_REGION/g" /fargate.toml
sed -i "s/FARGATE_CLUSTER_NAME/$FARGATE_CLUSTER_NAME/g" /fargate.toml
sed -i "s/FARGATE_SUBNETS/$FARGATE_SUBNETS/g" /fargate.toml
sed -i "s/FARGATE_SGS/$FARGATE_SGS/g" /fargate.toml

exec "$@"