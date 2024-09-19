apiVersion: apps/v1
kind: Deployment
metadata:
  name: ${name}
  namespace: ${namespace}
spec:
  replicas: ${replicas}
  selector:
    matchLabels:
      app: ${app}
  template:
    metadata:
      labels:
        app: ${app}
    spec:
      containers:
      - name: ${container.name}
        image: ${container.image}
        resources:
          requests:
            cpu: ${container.cpu}
            memory: ${container.memory}
          limits:
            cpu: ${container.cpu}
            memory: ${container.memory}
        ports:
        - containerPort: ${container.port.number}
          name: ${container.port.name}
