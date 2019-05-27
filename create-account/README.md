#### 創建個人可使用的NameSpace
#### Lab 0: 請先註冊一個Github 帳號
1. 連線到[github](https://github.com/)
2. 註冊一個帳號
#### Lab 1：創建屬於自己的空間：這個Lab，我希望幫助SE都能夠做出一個未來可以展示容器的空間
1. 準備環境：
* 首先，請下載kubectl CLI：[kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/)
* 透過git clone 下載你的第一個專案： git clone https://github.com/cdan/vfsi-hol.git
* 進入create-account目錄：
* 將該目錄底下kubeconfig檔，置於家目錄的檔案中：~/.kube/config
* 這是一個clusteradmin的帳號，收到該帳號，即可連線vke cluster
* 嘗試 kubectl get pods --all-namespaces，你應該可以看到不少Pods
2. 創建一個自己的名稱空間(NameSpace)：kubectl create namespace [your-name]
3. 下載這個[檔案](https://github.com/cdan/vfsi-hol/blob/master/create-account/02-create-namespace-admin.yaml)
   * 置換裡面的namespace 為你上一步驟做出來的名稱空間，與
   * serviceaccount 為你想要的名稱(可換可不換)
   * 存成mynamespace.yaml
4. kubectl apply -f mynamespace.yaml
5. 透過export，設定兩個參數：
   * export namespace='your namespace'
   * export accountname='your service account name'
6. 執行[create-kubeconfig.sh](https://github.com/cdan/vfsi-hol/blob/master/create-account/create-kubeconfig.sh) 產生對應的kubeconfig檔案。並置換之前下載於~/.kube/config那個。你就完成了以後個人專屬的namespace
7. 來跑個程式玩玩看：
   * kubectl run nginx --image nginx
   * kubectl expose deployment nginx --type=LoadBalancer --port=80
8. 清除環境：
   * kubectl delete deployment nginx
   * kubectl delete svc nginx