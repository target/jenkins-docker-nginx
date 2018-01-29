# jenkins-docker-nginx

[![license](https://img.shields.io/github/license/mashape/apistatus.svg)](LICENSE)

## Supported tags and respective `Dockerfile` links

- [`latest`, `0.1.0` (*Dockerfile*)](https://github.com/target/jenkins-docker-nginx/blob/master/Dockerfile)

## Quick reference

- **Where to get help**:
  [The Jenkins users google group](https://groups.google.com/forum/?nomobile=true#!forum/jenkinsci-users) or [Stack Overflow](https://stackoverflow.com/search?tab=newest&q=jenkins)

- **Where to get background information**: [The Target tech blog](https://target.github.io/beacon/2018/01/24/jays.html)

- **Where to file issues**:
  [https://github.com/target/jenkins-docker-nginx/issues](https://github.com/target/jenkins-docker-nginx/issues)

- **Maintained by**:
  [The JAYS Maintainers](https://github.com/target/jenkins-docker-nginx/blob/master/MAINTAINERS)

## Usage

### Variable replacement

Out-of-the-box, Nginx doesn't support using environment variables inside most configuration blocks. We will be using [envsubst](http://www.tutorialspoint.com/unix_commands/envsubst.htm) to replace variables within the default.conf.template and index.html.template files.

This is done by using `CMD /wrapper.sh` inside of the Dockerfile. The wrapper.sh is a simple shell script that calls `envsubst` to replace `$DOMAIN` and `$SUB_DOMAIN` with the values of environment variables that you define.

### Modify configuration files

You can simply modify configuration files via reusing the docker image, for example:

```docker
FROM target/jenkins-docker-nginx

COPY <my default template> /etc/nginx/conf.d/default.conf.template
```

### Docker Swarm

#### Assumptions

- Existing Docker Swarm cluster with version >= `1.13`
- Overlay network named `jenkins`
- Using [Docker secrets](https://docs.docker.com/engine/swarm/secrets/) for ssl certificates

#### Deployment

The following steps need to be done on a Docker Swarm manager

1. Create a Docker swarm [overlay network](https://docs.docker.com/engine/reference/commandline/network_create/#options) with:

    ```console
    docker network create --driver overlay --subnet <Subnet in CIDR format> jenkins
    ```

1. Create Docker secrets

    ```console
    docker secret create cert.crt <path to certificate>
    docker secret create cert.key <path to key>
    ```

1. Modify the `docker-compose.yml` file to have company specific settings

1. Create a [docker stack](https://docs.docker.com/engine/reference/commandline/stack_deploy/)

    ```console
    docker stack deploy -c docker-compose.yml service
    ```
