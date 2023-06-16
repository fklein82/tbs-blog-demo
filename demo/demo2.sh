### Prepare the Desk
Open your command line
go to your registry -> https://registry.fklein.me/

### DEMO 1 --> Accelerate Path to Production

#### Create the OCI image and push to registry
kp image create fkleinblog --tag registry.fklein.me/tbs/fkleinblog:1.0 --git https://github.com/fklein82/tbs-blog-demo.git --git-revision main -n dev

### Show the log
kp build logs fkleinblog -n dev
kp image status fkleinblog -n dev
kp build list fkleinblog -n dev

# Trigger manually
kp image trigger fkleinblog -n dev

### Show the container on registry
https://registry.fklein.me/harbor/projects/23/repositories

### deploy the container on Kubernetes
k create deployment blog --image=registry.fklein.me/tbs/fkleinblog:1.0 --port=8080 -n demotbs

### expose the app
kubectl expose deployment blog --port 80 --type LoadBalancer --target-port=8080 -n demotbs

### check the ip
k get svc -n demotbs

# change the code
Update index.html

# check the change
watch kp build list fkleinblog -n dev

# Update the deployment on Octant
http://127.0.0.1:7777/#/overview/namespace/demotbs/workloads/deployments/blog

### DEMO 2 --> Simplify Day 2 Operations
## check if the image exist
kp image list -n dev

# change the code
Update index.html

# check the change
watch kp build list blog -n dev

# Deploy the app again

k get pod
k delete


### clean demo
kp image delete fkleinblog -n dev && k delete service blog -n demotbs && k delete deployment blog -n demotbs
