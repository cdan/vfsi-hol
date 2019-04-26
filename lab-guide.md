# vfsi lab

### lab 说明
通过公有云的服务实现简单的从代码到部署的自动化的演示。


#### 如何连接vke上的Kubernetes集群？
```
export orgid=93a9beeb-d761-4551-bdba-e1f8b99fb995 
export token=**********************
vke account login -t $orgid -r $token
vke cluster auth setup cdan-test
```
然后就可以通过标准的kubectl操作了。
* 每人按照自己的名字创建一个namespaces，后续的应用就部署到该namespace。
> kubectl create namespace YOUR_NAME

* 设置默认的namespace
```
kubectl config set-context $(kubectl config current-context) --namespace=YOUR_NAME
# Validate it
kubectl config view | grep namespace
```

#### 如何在codestream里添加kubernetes的endpoint
```
kubectl create sa test-sa -n YOUR_NAME
kubectl get secret
kubectl describe secret test-sa-token* -n YOUR_NAME

// add new created sa as cluster-admin
kubectl create clusterrolebinding buildrobot-binding --clusterrole=cluster-admin --serviceaccount=YOURNAMESPACE:test-sa
```
copy the token for later usage.

Kubernetes cluster URL:

https://api.cdan-test-c23cfd64-12dd-11e9-958c-0a8a1b3b0536.93a9beeb-d761-4551-bdba-e1f8b99fb995.vke-user.com:443


在codestream页面添加kubernetes endpoint 选择认证类型token，把刚才的生成的token copy进去。

#### 如何在codestream里添加github的endpoint
codestream页面 -> Endpoints -> add Endpoint 选择类型Git

认证类型选择private token

* token来源
github页面 -> 头像图标 -> settings -> developer settings -> personal access token -> generate new token


### 测试代码库
https://github.com/cdan/vcas-demo

![CI-CD Workflow](https://github.com/cdan/vfsi-hol/blob/master/CICD.png)

### 如何从Kubernetes cluster内部访问外部的需要登录的镜像仓库
* 创建secret，https://kubernetes.io/docs/tasks/configure-pod-container/pull-image-private-registry/
```
kubectl create secret docker-registry docker-secret-YOURNAME -n YOUR_NAMESPACE --docker-server=<your-registry-server> --docker-username=<your-name> --docker-password=<your-pword> --docker-email=<your-email>
```
以dockerhub為例：
```
kubectl create secret docker-registry docker-secret-YOURNAME -n YOUR_NAMESPACE --docker-server=https://index.docker.io/v1/ --docker-username=[你的帳號] --docker-password=[密碼] --docker-email=[必要，但沒被使用]
```

* 在yaml中使用该secret访问外部镜像仓库，见kaniko.yaml 。
Kaniko是CNCF的一個開源專案，主要的價值是可以在一個容器中，完成Source Code下載、在容器中編譯、封裝為Docker Image、再Push進Dockerhub (或Harbor)中。可以取代過去Jenkins的大部分功能。
```
apiVersion: batch/v1
kind: Job
metadata:
  name: kaniko-job
spec:
  completions: 1
  template:
    metadata:
      name: kaniko-job
    spec:
      ttlSecondsAfterFinished: 60
      restartPolicy: Never
      # 容器開啟前，先下載https://github.com/cdan/vcas-demo.git 到container內的workspace中
      initContainers:
        - name: git-pull-init
          image: alpine/git:latest
          args: ["clone","https://github.com/cdan/vcas-demo.git","/workspace"]
          volumeMounts:
            - name: workspace-vol
              mountPath: /workspace
      containers:
      ＃ kaniko是一個pre-packaged的容器，只要給它三個參數（Dockerfile、Ｃompile位置、與Push的位置）
      - name: kaniko
        image: gcr.io/kaniko-project/executor:latest
        args: ["--dockerfile=/workspace/Dockerfile",
               "--context=/workspace",
               "--destination=cdan/vcas-demo:$${GIT_COMMIT_ID}"]
        volumeMounts:
          - name: workspace-vol
            mountPath: /workspace
            ＃ 當要push image到dockerhub時，系統預設調用~/.docker/config.json裡的設定（帳號密碼）
          - name:  registry-creds
            mountPath: /root/
      volumes:
      - name: registry-creds
        projected:
          sources:
          ＃由docker-secret中，取出.dockerconfigjson的欄位，設定掛起來的路徑為.docker/config.json
          - secret:
              name: docker-secret-YOURNAME
              items:
              - key: .dockerconfigjson
                path: .docker/config.json
      - name: workspace-vol
        emptyDir: {}
```






