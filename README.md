# Virtual Kubelet Container for AWS Fargate

![overview image](https://github.com/bbrfkr/vk-fargate/pict.png?raw=true)

## Get Started
1. Clone this repo.  
```
git clone https://github.com/bbrfkr/vk-fargate.git
```

2. Build docker image.  
```
cd vk-fargate
docker build -t <your dockerhub account>/vk-fargate:latest .
```

3. Push docker image.  
```
docker login
docker push <your dockerhub account>/vk-fargate:latest
```

4. Create EKS cluster by using iam role. (don't need to create worker nodes)

5. Create fargate task by using this image and the above iam role.

## Environment Variable
* KUBELET_PORT  
The listen port for virtual kubelet. Commonly 10250.

* EKS_CLUSTER_NAME  
The name of EKS cluster to which virtual kubelet connects.

* FARGATE_CLUSTER_REGION  
The name of region in which fargate cluster exists.

* FARGATE_CLUSTER_NAME  
The name of fargate cluster on which virtual kubelet puts.

* FARGATE_SUBNETS  
The subnets on which fargate tasks put.

* FARGATE_SGS  
The Security Groups with which fargate tasks are associated.