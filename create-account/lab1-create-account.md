#### 創建個人可使用的NameSpace
* 首先，請下載kubectl CLI：[kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/)
* 下載這個[檔案](https://github.com/cdan/vfsi-hol/blob/master/create-account/kubeconfig)，並置於家目錄的檔案中：~/.kube/config
* 這是一個clusteradmin的帳號，收到該帳號，即可連線vke cluster
* 嘗試 kubectl get pods --all-namespaces，你應該可以看到不少Pods
Lab 1：創建屬於自己的空間：這個Lab，我希望幫助SE都能夠做出一個未來可以展示容器的空間
1. 創建一個自己的名稱空間(NameSpace)：kubectl create namespace [your-name]
2. 下載這個[檔案](https://github.com/cdan/vfsi-hol/blob/master/create-account/02-create-namespace-admin.yaml)
   * 置換裡面的namespace 為你上一步驟做出來的名稱空間，與
   * serviceaccount 為你想要的名稱(可換可不換)
3. kubectl apply -f [第二步的檔案]
4. 透過export，設定兩個參數：
   * export namespace='your namespace'
   * export accountname='your service account name'
5. 執行[create-kubeconfig.sh](https://github.com/cdan/vfsi-hol/blob/master/create-account/create-kubeconfig.sh) 產生對應的kubeconfig檔案。並置換之前下載於~/.kube/config那個。你就完成了以後個人專屬的namespace
6. 來跑個程式玩玩看：
   * kubectl run nginx --image nginx
   * kubectl expose deployment nginx --type=LoadBalancer --port=80