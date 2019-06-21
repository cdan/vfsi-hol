#### 
#### 學習目標：怎麼打造一個容器
#### Lab 2：容器製作
1. 準備環境：
* 下載Docker：下載點與手冊 [Mac](https://docs.docker.com/v17.12/docker-for-mac/install/#install-and-run-docker-for-mac) [Windows](https://docs.docker.com/docker-for-windows/install/)
* 註冊一個Docker.io帳號，[註冊點](https://hub.docker.com/)
* 安裝Git: [Git安裝](https://gitbook.tw/chapters/environment/install-git-in-mac.html)
* 了解容器![Image架構](https://github.com/cdan/vfsi-hol/blob/master/pictures/container-image.png)

2. 下載本目錄： ```git clone https://github.com/cdan/vfsi-hol.git```
3. 下載網站Binary [gowebapp](https://s3.eu-central-1.amazonaws.com/heptio-edu-static/foundations/gowebapp.tar.gz) ，並將gowebapp解開後，將gowebapp/gowebapp-sql檔案夾的內容，拷貝到步驟2中的gowebapp/gowebapp-sql檔案夾中。
4. 使用瀏覽器，登入docker.io網站，創建兩個Repositories：gowebapp和gowebapp-sql
5. 到gowebapp檔案夾下，編輯對應的Dockerfile，並透過docker build . -t [docker.io accountname]/gowebapp:v1.0 
5-1. 透過docker images，確認[docker.io accountname]/gowebapp:v1.0已經出現
6. 到gowebapp-sql檔案夾下，編輯對應的Dockerfile，並透過docker build . -t [docker.io accountname]/gowebapp-sql:v1.0
6-1. 透過docker images，確認[docker.io accountname]/gowebapp-sql:v1.0已經出現
7. 在Terminal上，登入docker.io: docker login docker.io ，依照提示輸入帳密。
8. docker push [docker.io accountname]/gowebapp:v1.0 & [docker.io accountname]/gowebapp-sql:v1.0
---
休息一下，Lab2完成囉
#### Lab 2：佈建程式在Docker
1. 建置docker虛擬網路：docker network create gowebapp
2. 將剛剛佈建出來的服務，佈建在docker上：
* mysql: 
```docker run --net gowebapp --name gowebapp-mysql --hostname gowebapp-mysql -d -e MYSQL_ROOT_PASSWORD=mypassword gowebapp-mysql:v1```

* gowebapp:
```docker run -p 9000:80 --net gowebapp -d --name gowebapp --hostname gowebapp gowebapp:v1```

#### Lab 3：佈建程式在Cloud PKS上
1. 預先準備：請準備好Lab1中 所生成的./kube/config
2. 編寫yaml檔，將App/DB連接起來：回到gowebapp的目錄下，開啟