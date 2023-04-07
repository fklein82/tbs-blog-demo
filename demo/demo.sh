### Prepare the Desk
Open your command line
go to your registry -> https://registry.fklein.me/

### DEMO 1 --> Accelerate Path to Production

#### Create the OCI image and push to registry
kp image create fkleinblog --tag registry.fklein.me/tbs/fkleinblog:1.0 --git https://github.com/fklein82/tbs-blog-demo.git --git-revision main -n dev

### Show the log
kp build logs fkleinblog -n dev

### Show the container on registry
https://registry.fklein.me/harbor/projects/23/repositories

### deploy the container on Kubernetes
k create deployment blog --image=registry.fklein.me/tbs/fkleinblog:1.0 --port=8080

### expose the app
kubectl expose deployment blog --port 80 --type LoadBalancer --target-port=8080

### check the ip
k get svc

### clean demo
kp image delete fkleinblog -n dev && k delete service blog && k delete deployment blog

### DEMO 2 --> Simplify Day 2 Operations