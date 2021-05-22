---
apiVersion: v1
kind: Namespace
metadata:
  name: MY_NAMESPACE

---
apiVersion: v1
kind: ServiceAccount
metadata:
  name: MY_SVC_ACCOUNT
  namespace: MY_NAMESPACE

---
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: sub-admin
  namespace: MY_NAMESPACE
rules:
- apiGroups: [""] # "" indicates the core API group
  resources: ["pods","services","daemonsets","deployments","replicasets","statefulsets","jobs","configmaps","secrets","ingress"]
  verbs: ["get","list","create","update","patch", "watch","delete","deletecollection"]
- apiGroups: ["apps"]
  resources: ["pods","services","daemonsets","deployments","replicasets","statefulsets","jobs","configmaps","secrets","ingress"]
  verbs: ["*"]

---
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: sub-admin-rb
  namespace: MY_NAMESPACE
subjects:
- kind: Group
  name: system:serviceaccounts:MY_NAMESPACE
  apiGroup: rbac.authorization.k8s.io
roleRef:
  kind: Role
  name: sub-admin
  apiGroup: rbac.authorization.k8s.io
