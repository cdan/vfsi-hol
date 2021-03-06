### 學習目標：怎麼打造一個容器
### Lab 2：容器製作
1. 準備環境：
* 下載Docker：下載點與手冊 [Mac](https://docs.docker.com/v17.12/docker-for-mac/install/#install-and-run-docker-for-mac) [Windows](https://docs.docker.com/docker-for-windows/install/)
* 註冊一個Docker.io帳號，[註冊點](https://hub.docker.com/)
* 安裝Git: [Git安裝](https://gitbook.tw/chapters/environment/install-git-in-mac.html)
* 了解容器![Image架構](https://github.com/cdan/vfsi-hol/blob/master/pictures/container-image.png)

2. 下載本目錄： 
```
git clone https://github.com/cdan/vfsi-hol.git
```
3. 下載網站Binary [gowebapp](https://s3.eu-central-1.amazonaws.com/heptio-edu-static/foundations/gowebapp.tar.gz) ，並將gowebapp解開後，將gowebapp/gowebapp-mysql檔案夾的內容，拷貝到步驟2中的gowebapp/gowebapp-sql檔案夾中。
4. 使用瀏覽器，登入docker.io網站，創建兩個Repositories：gowebapp和gowebapp-mysql
5. 到gowebapp檔案夾下，編輯對應的Dockerfile，並透過
```
docker build . -t [docker.io accountname]/gowebapp:v1.0 
```
* 透過docker images，確認[docker.io accountname]/gowebapp:v1.0已經出現
6. 到gowebapp-mysql檔案夾下，編輯對應的Dockerfile，並透過
```
docker build . -t [docker.io accountname]/gowebapp-mysql:v1.0
```
* 透過docker images，確認[docker.io accountname]/gowebapp-mysql:v1.0已經出現
7. 在Terminal上，登入docker.io: 
```
docker login docker.io
``` 
依照提示輸入帳密。
8. 推送Image到Docker.io
``` 
docker push [docker.io accountname]/gowebapp:v1.0 
docker ush [docker.io accountname]/gowebapp-mysql:v1.0
```
---
休息一下，Lab2完成囉
### Lab 3：佈建程式在Docker
1. 建置docker虛擬網路：
```
docker network create gowebapp
```
2. 將剛剛佈建出來的服務，佈建在docker上：
* mysql: 
```
docker run --net gowebapp --name gowebapp-mysql --hostname gowebapp-mysql -d -e MYSQL_ROOT_PASSWORD=mypassword [docker-account-name]/gowebapp-mysql:v1.0
```

* gowebapp:
```
docker run -p 9000:80 --net gowebapp -d --name gowebapp --hostname gowebapp [docker-account-name]/gowebapp:v1.0
```
3. 打開瀏覽器，連接localhost:9000，嘗試申請幾個帳號
4. 驗證mysql database: 
```
docker exec -it gowebapp-mysql mysql -u root -pmypassword gowebapp
SHOW DATABASES;
USE gowebapp;
SHOW TABLES;
SELECT * FROM <table_name>;
exit;
```
5. 測試完畢，撤銷環境：
```
docker rm -f gowebapp gowebapp-mysql
```
### Lab 4：佈建程式在Cloud PKS上
1. 預先準備：請準備好Lab1中 所生成的./kube/config
2. 編寫yaml檔，用來佈建gowebapp-mysql。編寫練習檔案在
3. 編寫yaml檔，佈建gowebapp，並連接上述佈建的db
4. 透過更改Service種類，測試一下Cluster IP, NodePort, 與LoadBalancer的不同 
5. 測試完畢，撤銷環境：
```
kubectl delete -f gowebapp.yaml,mysql.yaml
```