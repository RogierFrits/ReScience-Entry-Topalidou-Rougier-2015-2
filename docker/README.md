## Introduction
Docker files and images are available to run this project inside a container.
The following structure is used:
- **base**: libraries and dependencies of the project
- **dev** (builds upon base) : extra dependencies during development (not required)
- **release** (builds upon base) : installed code


## Instructions

> Download and install the latest version of Docker: https://www.docker.com/


#### Pulling the release image from the Docker Hub
The quickest way to run the code of this project is to pull
the release image from the Docker Hub. This way you don't need
to build the image using the Dockerfile.
>This image is not yet registered at the Docker hub!!
```
docker pull rescience/topalidou-rougier-2015
docker run -it rescience/topalidou-rougier-2015
python single-trial.py
exit
```
>This image is not yet registered at the Docker hub!!


#### Building the base image
Open a terminal and go to directory _docker/base_.
The dot in the following command refers to the Dockerfile.
```
docker build -t topalidou-rougier-2015-base .
docker images
```
The image should build successfully and appear in the list with the provided tag.


#### Using the base container (during development)
You can use the base container to run the code during development.
The _code_ directory from this project can be mounted as a data volume
for the base container.

1. Make sure the _code_ directory can be shared in your **Docker Preferences**.
2. `docker images` should include _topalidou-rougier-2015-base_
3. Replace the _/path/to/code/_ and _/path/in/container/_.
These should be absolute paths. Example for _/path/in/container/_ could be
_/usr/src/_

```
docker run –it –d --name rougier –v /path/to/code/:/path/in/container/ topalidou-rougier-2015-base
docker ps
docker exec –it rougier bash
cd path/in/container/
python setup.py build_ext –inplace
python single-trial.py
exit
```
You can open the generated pdf on your computer at _/path/to/code/_.


#### Building the release image
The release image builds upon the base and copies and compiles the
code of the project.
> `docker images` should include _topalidou-rougier-2015-base_

Go to the root directory of the project, the dot in the following
command refers to the Dockerfile.
```
docker build -t topalidou-rougier-2015 .
docker images
```
Docker images should list _ubuntu_, _topalidou-rougier-2015_ and _topalidou-rougier-2015-base_.


#### Using the release container
Once you have build or pulled the release image, you can run the container
to execute the code.

```
docker run -it topalidou-rougier-2015
python single-trial.py
exit
```


## Troubleshooting
- **Problem**: Error when running code. No display name and no $DISPLAY environment variable.

Solution: The files display.py and 250-simulations.py need a
small addition before `import matplotlib.pyplot as plt`.
It required `matplotlib.use('Agg')`.

- **Problem**: `docker images` command has many unknown images in the list. 

Solution: You can remove these images with:
`docker images --quiet --filter=dangling=true | xargs docker rmi –f`

- **Problem**: `FROM ubuntu:latest` gives a timeout when trying to build.

Solution: Restart your docker application.

- **Problem**: Container name already in use,
but it doesn’t show in the list of `docker ps`.

Solution: Stops all containers with
`docker ps -q -a | xargs docker rm`
