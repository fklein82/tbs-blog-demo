# My blog Demo for TBS and TAP
This repo contains a simple blog that can be deployed as a TAP workload.
This function utilizes the buildpacks provided by VMware's open-source [Function Buildpacks for Knative](https://github.com/vmware-tanzu/function-buildpacks-for-knative) project.
## Getting Started
To begin editing your function, modify `server.js` in the root directory.
Inside this file, you will find a function that serve the index.html in express directory. For example:
```
app.use('/', function(req,res){
    res.sendFile(path.join(__dirname+'/express/index.html'));
    //__dirname : It will resolve to your project folder.
  });
```
You may replace the code inside this default function with your logic.
## Tanzu Application Platform Accelerator
To add the accelerator in Tanzu Application Platform
~~~
tanzu acc create myblog --git-repo https://github.com/fklein82/tbs-blog-demo --git-branch main --interval 5s\n
~~~

# [blog.fklein.me](https://cloud.fklein.me)

This is the source code for fklein's blog : https://blog.fklein.me or https://cloud.fklein.me

 [![test](https://github.com/fklein82/cloud-server/workflows/test/badge.svg)](https://github.com/fklein82/cloud-server/actions?query=workflow%3Atest)

 [![Build-Push-DockerHUB](https://github.com/fklein82/cloud-server/actions/workflows/push-docker-image.yaml/badge.svg)](https://github.com/fklein82/cloud-server/actions/workflows/push-docker-image.yaml)

 [![Deploy to Production](https://github.com/fklein82/cloud-server/actions/workflows/aws-S3-upload.yml/badge.svg)](https://github.com/fklein82/cloud-server/actions/workflows/aws-S3-upload.yml)
