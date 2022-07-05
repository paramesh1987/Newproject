# dockertomcat
A continous integration project to publish maven wars to a docker tomcat

This project aims at provinding a sample continous integration platform to run web applciations from a dockerized tomcat while still making dynamic changes to app and realizing them on the tomcat server

## Why?
Often times there is a need to just run `mvn clean install` and see your changes reflect in a tomcat server (docker container running tomcat). This projects aims to exactly address that use-case.

## How?
This is done through multiple-touch points.
* POM.xml
    * Uses two plugins `spring-boot-maven-plugin` and `maven-dependency-plugin`. 
    * The former is used to pcakage the application into a war and the latter to copy the artifact(war) to a staging area
    * The staging area is configurable with `war.staging.directory` property in POM
    * It will replace existing war in the staging area and hence the name of the war is always derived from app name itself and not the version
 * Dockerfile
    * The docker file is a standard docker file that imports from tomcat:9 and adds the default user and open up the manager GUI
    * It runs a [script](https://github.com/suchiksagar/dockertomcat/blob/master/docker/wardeployer.sh) that triggers tomcat startup and then starts watching the staging area (shared volume to container) for any file changes.
    * Any new files/modified files are automatically dropped into tomcat webapps which triggers anto-reload there by refreshing the application.

## Run
If you need to run this project, either clone the repo and build the image. Or run the docker image directly from repo: 
`docker run -p 8080:8080 -d --name tom -v <YOUR_VOLUME>:/usr/local/stagingwebapps wintersoldier/tomcat_ci:1.0`
Start running mvn install from any project and make sure to include the dependency plugin copying war to this shared volume as mentioned in the POM section above.

Note: Access tomcat manager UI using UN: admin PWD: admin on <HOST_IP>:<THE_PORT_U_MAPPED>/
    
    
