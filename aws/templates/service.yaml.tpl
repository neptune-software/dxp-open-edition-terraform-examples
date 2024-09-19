apiVersion: v1
kind: Service
metadata:
  name: ${name}
  namespace: ${namespace}
spec:
  ports:
  - port: ${port}
  selector:
    app: ${app}
  type: ${type}
