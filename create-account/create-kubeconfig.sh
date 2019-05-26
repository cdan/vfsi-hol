
# the name of the secret containing the service account token goes here
name=$(kubectl get secrets -n $namespace | grep $accountname | awk '{print $1}')
# Use the existing kubeconfig server information
server=$(cat ~/.kube/config | grep server | awk '{print $2}')

ca=$(kubectl get secret/$name -n $namespace -o jsonpath='{.data.ca\.crt}')
token=$(kubectl get secret/$name -n $namespace -o jsonpath='{.data.token}' | base64 --decode)

echo "
apiVersion: v1
kind: Config
clusters:
- name: default-cluster
  cluster:
    certificate-authority-data: ${ca}
    server: ${server}
contexts:
- name: default-context
  context:
    cluster: default-cluster
    namespace: $namespace 
    user: default-user
current-context: default-context
users:
- name: default-user
  user:
    token: ${token}
" > kubeconfig
