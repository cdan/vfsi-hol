### 资源申请
* 测试应用的源代码放在github上，所以每人需要提前申请一个github的账号（IT从业人员必备）。
* 构建出来的应用镜像需要有镜像仓库存储。为了方便演示，可以直接使用docker hub存放。每人申请自己的docker hub账号。https://hub.docker.com/
* 实验使用vmware cloud service作为cicd的工具。每人提前申请开通cloud.vmware.com中的cloud automation service 的账号权限。申请时请指明需要绑定“SDDC Playpen”的组织。访问，https://console.cloud.vmware.com， 在相应的服务下面点击“REQUEST ACCESS”
* Kubernetes运行环境。大家如果有自己公有云的Kubernetes环境，可以使用自己的集群。否则我们会使用cloud pks的一个实例，会让各位自己创建namespace。<br>提前安装kubectl。
<br>提前安装vke命令。
   * [mac](https://s3-us-west-2.amazonaws.com/vke-cli-us-west-2/latest/mac/vke) 
   * [windows](https://s3-us-west-2.amazonaws.com/vke-cli-us-west-2/latest/windows64/vke.exe)
   * [linux](https://s3-us-west-2.amazonaws.com/vke-cli-us-west-2/latest/linux64/vke)

* 如果时间允许可以做一个cloud assembly的实验，将通用蓝图通过代码部署到aws或者vsphere。可以提前准备一个能联通公网的vsphere环境。（onecloud也可以）
