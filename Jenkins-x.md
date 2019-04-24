
![Jenkins-X](https://github.com/cdan/vfsi-hol/blob/master/pictures/jx.png)
Jenkins-X是一個高度整合的CI/CD平台。主要透過Jenkins (Kubernetes plugin)、Nexus、Docker Repository、與Helm Chart等整合成一個完整的CI/CD Framework。

1. 安裝方式：
    * 預先準備：
        * 一個Vanilla K8S的環境 (e.g. GKE, VMware Cloud PKS, EKS等）
        * jx會自動生成jx/ jx-staging/ jx-production三個namespaces，所以請確認您有對應的權限。
        * 一個Git-based的源碼庫，可以發送Webhook的。目前JX有整合gitlab/github
        * Docker Repository (optional)：JX在專案生成時，也會自動生成Docker Repository。預設是使用生成的Docker Repository。若需要使用企業內的鏡像庫，需要額外的整合。
    * 安裝一個『Workable』的jx client：目前測試成功的版本為1.3.781
        * 各個OS版本的下載點：https://jenkins-x.io/getting-started/install/ 。請愛用curl而勿使用brew等工具，brew這些工具會安裝最新版本。
    * jx install —provider=kubernetes，這個參數是指該Jenkins-X所執行的環境為kubernetes環境
        * 在安裝流程中，jx會由源代碼庫中，下載（並生成）許多檔案~/.jx 檔案夾中。主要分成
        cloud-environments檔案夾：由github下載來的雲環境變數
        environment檔案夾：裡面包含兩個檔案夾，分別是Staging/Production，這兩個等等會被commit到Git中，作為Staging與Production的Source Code目錄。
        draft檔案夾：裡面含了build時的buildpack
        gitAuth.yaml：git的帳密
        jenkinsAuth.yaml：隨選生成jenkins的帳密
        adminSecrets.yaml: jx自動生成的密碼
        chartMuseumAuth.yaml: 自動生成的chartMusuem密碼

2. 專案設定流程：
    * 通過jx import 或是jx create quickstart -l {language}
    * 若是一個stateless的程式，jx import需要注意和原本專案相同即可。若為Multi-tier的架構，需要額外在Helm Chart裡面，進行連接的設定。底下我們舉兩個例子，來看一下如何透過Quickstart來建置一個空白，但可以快速使用的範本（以js and Python為例）。另一個案例是通過jx import，並整合後端的一個Database來進行rsvp的回覆工作。
    * 整個專案是通過Jenkinsfile來定義的CI/CD的Pipeline管線，http://jenkins.readbook.tw/jenkins/jenkins2/multibranch-pipeline/
    

3. 使用流程：
由開發到測試：
* 開發者提交Source Code
* Git通知Jx Controller
* Jx Controller Build/Test/Push到Chart Museum
* Pipeline 自動提交一張PR給Staging 的Github
    ![From Development to Staging](https://github.com/cdan/vfsi-hol/blob/master/pictures/jx-d-s.png)
由於這個程式

由測試到生產環境：
    ![From Staging to Production](https://github.com/cdan/vfsi-hol/blob/master/pictures/jx-s-p.png)
