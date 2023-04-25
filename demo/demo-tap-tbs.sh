#### Clean DEMO & check
kubectx tap-demo1-3

tanzu apps workload list -n dev
tanzu apps workload delete inclusion-backend-api -n dev && tanzu apps workload delete inclusion-frontend-web -n dev && tanzu apps workload delete blog -n dev
helm delete emoji -n dev && k delete pvc/data-emoji-postgresql-0 -n dev
k apply -f /Users/kfrederic/Documents/GitHub/TAP/Demo/secret-emoji-azuredb.yaml

kp image list -n demotbs
kp image delete fkleinblog -n demotbs
k delete deployment blog -n demotbs
k delete service blog -n demotbs

### Debug TAP UI
k get pod -n tap-gui
k delete pod server-677d6c9d6b-8wcv9 -n tap-gui

#############################################################################################
### Demo1 Blog on TAP :
http://tap-gui.tanzu.fklein.me/

# Open Visual Studio Code #

### APP  Start Code Frontend -> Accelerateur
# Generate Accelerator & Deploy
cd /Users/kfrederic/Desktop/myblog
tanzu apps workload create -f config/workload.yaml -n dev

### APP Blog -> Ready
http://blog.dev.tanzu.fklein.me/


#############################################################################################
### Demo2 Blog on TBS :
Open your command line
go to your registry -> https://registry.fklein.me/

#### Create the OCI image and push to registry
kp image create fkleinblog --tag registry.fklein.me/tbs/fkleinblog:1.0 --git https://github.com/fklein82/tbs-blog-demo.git --git-revision main -n demotbs

### Show the log
kp build logs fkleinblog -n demotbs

### Show the container on registry
https://registry.fklein.me/harbor/projects/23/repositories

### deploy the container on Kubernetes
k create deployment blog --image=registry.fklein.me/tbs/fkleinblog:1.0 --port=8080 -n demotbs

### expose the app
kubectl expose deployment blog --port 80 --type LoadBalancer --target-port=8080 -n demotbs

### check the ip
k get svc -n demotbs

### Update index.html

## Check the build
watch kp build list -n demotbs

## Edit deployment 
k edit deployment blog -n demotbs

## check the pod update
watch kubectl get pod -n demotbs

## check the result
k get svc -n demotbs

#############################################################################################
### Demo3 TAP :

https://tap-gui.tanzu.fklein.me/
http://api-portal.tanzu.fklein.me/apis


### APP 01 Start Code Backend -> Accelerateur
# Generate Accelerator & Deploy
cd /Users/kfrederic/Desktop/Inclusion
tanzu apps workload create -f config/workload.yaml -n dev

## APP 01 -> Ready
http://inclusion-frontend-web.dev.tanzu.fklein.me/

### APP 02 Start Code Frontend -> Accelerateur
# Generate Accelerator & Deploy
cd /Users/kfrederic/Desktop/inclusion-node-front
tanzu apps workload create -f config/workload.yaml -n dev

## APP 02 EP -> Ready
http://inclusion-frontend-web.dev.tanzu.fklein.me/

### Demo Sécurité
https://tap-gui.emea.end2end.link/security-analysis

#############################################################################################
### MultiCloud Demo AKS & GKE

## deploy Front-End on GKE
kubectx tap-demo1-3
k get deliverable inclusion-frontend-web -n dev -o yaml > inclusion-frontend-web.yaml
kubectl-neat < inclusion-frontend-web.yaml > inclusion-frontend-web-clean.yaml

kubectx gke_kfrederic_europe-west1_tap142-gke-run
k apply -f inclusion-frontend-web-clean.yaml

k get deliverable -n dev


#############################################################################################
### Service Binding Demo on TAP
## add the code to APP01 worklaod.yaml:

  serviceClaims:
    - name: db
      ref:
        apiVersion: services.apps.tanzu.vmware.com/v1alpha1
        kind: ResourceClaim
        name: db-binding-compatible

## Apply modification
cd /Users/kfrederic/Desktop/inclusion
tanzu apps workload apply -f config/workload.yaml -n dev

# GO To Azure
https://portal.azure.com/#view/HubsExtension/BrowseResource/resourceType/Microsoft.DBforPostgreSQL%2Fservers

## Query DB Azure
psql "host=emoji-posgres.postgres.database.azure.com port=5432 dbname=emoji user=postgres@emoji-posgres password=password1! sslmode=require"
\d
select * from emoji ;


# check secret DB
k get secret db-binding-compatible -n dev
k describe secret db-binding-compatible -n dev

# check service claim
tanzu service resource-claim list -n dev

# show front
http://inclusion-frontend-web.dev.tanzu.fklein.me/

### Aperçu VAC
# Pitch PV
https://app-catalog.vmware.com/apps

# DB Deploy
helm install emoji bitnami/postgresql --set global.postgresql.auth.postgresPassword=password \
  --set global.postgresql.auth.database=emoji -n dev

## Migrate to OSS DB
cat /Users/kfrederic/Documents/GitHub/TAP/Demo/secret-emoji-ossDB.yaml
k apply -f /Users/kfrederic/Documents/GitHub/TAP/Demo/secret-emoji-ossDB.yaml

## Connect App to OSS DB
k delete pod --all -n dev
