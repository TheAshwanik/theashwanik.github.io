---
layout: post
title: "Run IBM Datapower Gateway IDG-10.0.0 on Docker"
description: "Run IBM Datapower Gateway IDG-10.0.0 on Docker"
date_formatted: 2020-10-30 22:47
date: 2020-10-30
comments: true
categories: [Technical]
tags: datapower
keywords: datapower, datapower in docker
---

To build your IBM DataPower Docker image, you must develop the application's configuration. The easiest method is in the Docker containers on your workstation.    

### Before you begin
Before you can build and deploy a DataPower Docker application you must create an export package that <!--more--> contains the DataPower configuration for the DataPower Docker image. You create and export the DataPower configuration on a DataPower appliance or virtual DataPower offering.    

You can create the DataPower configuration using the DataPower GUI, CLI, or other management interface, which can be importing an existing export package from a secure server and using a deployment policy with deployment policy variables to modify the configuration in the export package during import. The resultant and exported configuration should be the explicit configuration for your DataPower Docker application.     

The defined and imported configuration is restricted to features supported by DataPower for Docker. If you create an export package from another DataPower offering with features not supported by DataPower Gateway for Docker, these feature will be unavailable. For more information, see Managing add-on features for a DataPower Docker image.    

The easiest way to export and import packages is through the DataPower GUI, but you can use the DataPower backup command to do an export.     

### Procedure
Download the version-specific DataPower firmware image from the read-only IBM Entitled Registry.    
Create a clean working directory with the config, local, and certs subdirectories. These subdirectories will be mounted inside the container to extract the application's configuration. For more information, see Directories in a DataPower Docker image.    
Grant full permission to ensure that everyone can access these subdirectories.     
{{ codeblock }}
chmod -R 777 config local certsCopy code
{{ endcodeblock }}

Start the container. The following snippet is the minimum required set of parameters. For more information, see Environment variables and drouter arguments and a DataPower Docker image.    
{{ codeblock }} 
docker run -it --name name \
-v $(pwd)/config:/opt/ibm/datapower/drouter/config \
-v $(pwd)/local:/opt/ibm/datapower/drouter/local \
-v $(pwd)/certs:/opt/ibm/datapower/root/secure/usrcerts \
-e DATAPOWER_ACCEPT_LICENSE="true" \
-e DATAPOWER_INTERACTIVE="true" \
-p 9090:9090 \
tag
{{ endcodeblock }}

Where name is the name of the container, and tag is generally in the registry-path:version.build-edition format.    

### Configure access to the DataPower GUI.
{{ codeblock }}
$$ configure terminal
$$ web-mgmt
$$ admin-state "enabled"
$$ exit
{{ endcodeblock }}

Access the DataPower Gateway to import the export package that contains your DataPower configuration.   
- To start a GUI session, enter https://localhost:9090 as the URL in your browser.    
- To start a CLI session, use the docker attach command.   

After you write and test your configuration, save everything to your mounted volumes.   
In the GUI, click Save Configuration.     
In the CLI, issue the write memory command.     

Stop the DataPower container, where name is the name of the container.     
{{ codeblock }} 
docker stop -t 300 name 
{{ endcodeblock }}

Change ownership of files owned by root.    
{{ codeblock }} 
chown -R $USER:$USER config local certs 
{{ endcodeblock }} 

Create the Dockerfile for the DataPower Docker image. The following snippet is the most basic Dockerfile that you should require.    
{{ codeblock }} 
FROM tag
COPY config /opt/ibm/datapower/drouter/config
COPY local /opt/ibm/datapower/drouter/local
COPY certs /opt/ibm/datapower/root/secure/usrcerts
USER root
RUN chown -R drouter:drouter /opt/ibm/datapower/drouter/config \
                             /opt/ibm/datapower/drouter/local \
                             /opt/ibm/datapower/root/secure/usrcerts
RUN set-user drouter
USER drouter
{{ endcodeblock }}


With your Dockerfile, build your DataPower Docker image, where my-image is the name that differentiates various DataPower Docker images in your repository.    
{{ codeblock }} 
docker build . -f Dockerfile -t my-imageCopy code
{{ endcodeblock }}

Use the docker push command to upload the DataPower Docker image to your repository.   


### References:    
{{ codeblock }}
https://docs.docker.com/docker-for-windows/    
https://linuxconfig.org/docker-container-backup-and-recovery    
https://hub.docker.com/r/ibmcom/datapower/     
https://logixbubble.wordpress.com/2017/10/30/virtual-datapower-setup/     
https://docs.docker.com/engine/reference/commandline/port/    
https://hub.docker.com/r/middlewareaman/datapower_av     
https://www.ibm.com/support/knowledgecenter/en/SS9H2Y_7.7.0/com.ibm.dp.doc/request-header_metadatafunction.html     
http://index-of.co.uk/Tutorials/XML%20for%20Dummies%204th%20Ed.pdf     
DataPower MPGW Simple Exercise - https://www.youtube.com/watch?v=mz7VBIbyjnI    
https://www.ibm.com/support/knowledgecenter/en/SS9H2Y_10.0/com.ibm.dp.doc/welcome.html     
https://github.com/amanverma-18/datapower_publiccerts     
https://github.com/dan-orangespecs/practical-datapower
http://www.orangespecs.com/category/datapower/    
https://www.ibm.com/support/pages/migration-ssl-proxy-profile     
https://www.youtube.com/watch?v=i0xaZ-iaEbU&list=PLw_7CPUqcdrFMnBmRVQENC_AlcaCCmVtd&index=3     
https://www.ibm.com/support/knowledgecenter/SS9H2Y_10.0/com.ibm.dp.doc/apigw_overview.html      
https://integrationtechies.wordpress.com/topics/       
https://www.ibm.com/support/knowledgecenter/SS9H2Y_10.0/com.ibm.dp.doc/docker_dpapp.html    
{{ endcodeblock }}


### Commands:      
{{ codeblock }}
docker run -it --name dpcontainer02  -v /e/development_work/datapower/datapowerconfig:/drouter/config -v /e/development_work/datapower/datapowerlocal:/drouter/local -e DATAPOWER_ACCEPT_LICENSE=true -e DATAPOWER_INTERACTIVE=true -e DATAPOWER_WORKER_THREADS=4 -p 9090:9090 -p 9022:22  -p 5554:5554  -p 8000-8100:8000-8100 middlewareaman/datapower_av:version10.0
{{ endcodeblock }}


