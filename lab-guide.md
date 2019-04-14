# vfsi lab

### lab 说明
通过公有云的服务实现简单的从代码到部署的自动化的演示。


#### 如何连接vke上的Kubernetes集群？
```
export orgid=93a9beeb-d761-4551-bdba-e1f8b99fb995 
export token=038bd68d-8fd9-4bef-a452-f3bc1aa0aece
vke account login -t $orgid -r $token
vke cluster auth setup cdan-test
```
然后就可以通过标准的kubectl操作了。


### 测试代码库
https://github.com/cdan/vcas-demo



### 如何从Kubernetes cluster内部访问外部的需要登录的镜像仓库
* 创建secret，https://kubernetes.io/docs/tasks/configure-pod-container/pull-image-private-registry/
```
kubectl create secret docker-registry regcred --docker-server=<your-registry-server> --docker-username=<your-name> --docker-password=<your-pword> --docker-email=<your-email>
```

* 在yaml中使用该secret访问外部镜像仓库，见kaniko.yaml 。





