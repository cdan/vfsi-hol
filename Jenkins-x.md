
Jenkins-X是一個高度整合的CI/CD平台。主要透過Jenkins (Kubernetes plugin)、Nexus、Docker Repository、與Helm Chart等整合成一個完整的CI/CD Framework。
1. 安裝方式：
    * 預先準備：
        * 一個Vanilla K8S的環境 (e.g. GKE, VMware Cloud PKS, EKS等）
        * 一個Git-based的源碼庫
    * 安裝一個『Workable』的jx client：目前測試成功的版本為1.3.781
        * 各個OS版本的下載點：https://jenkins-x.io/getting-started/install/ 。請愛用curl而勿使用brew等工具，這些工具會安裝最新版本。
    * jx install —provider=kubernetes
        * 在安裝流程中，jx會由源代碼庫中，下載許多的檔案到~/.jx 檔案夾中。
        *  [to-do]

2. 專案設定流程：
    * 通過jx import 或是jx create quickstart -l {language}
    * 若是一個stateless的程式，jx import需要注意和原本專案相同即可。若為Multi-tier的架構，需要額外在Helm Chart裡面，進行連接的設定
3. 使用流程：
           3-1. Dev->Staging
* 開發者提交Source Code
* Git通知Jx Controller
* Jx Controller Build/Test/Push到Chart Museum
* Pipeline 自動提交一張PR給Staging 的Github

由於這個程式
           3-2. Staging->Production

