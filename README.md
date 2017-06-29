# jenkins-docker-nginx

## About this repo
This is the Git repo of the nginx Dockerfile used in the Jenkins at Your Service (JAYS) architecture.

JAYS is a platform for providing multiple Jenkins instances in a Docker Swarm cluster.

More information about JAYS comming soon.

## usage

### Variable replacement
Out-of-the-box, Nginx doesn't support using environment variables inside most configuration blocks. We will be using [envsubst](http://www.tutorialspoint.com/unix_commands/envsubst.htm) to replace variables within the default.conf.template and index.html.template files.

This is done by using `CMD /wrapper.sh` inside of the Dockerfile. The wrapper.sh is a simple shell script that calls `envsubst` to replace `$DOMAIN` and `$SUB_DOMAIN` with the values of environment variables that you define.

### Example usage
Let's assume that you want to reach Jenkins at `*.jenkins.acme.com` you would use the following configuration:

`$ docker run -e DOMAIN=acme.com -e SUB_DOMAIN=jenkins target/jenkins-docker-nginx`

### Modify configuration files
You can simply modify configuration files via reusing the docker image, for example:

```
FROM target/jenkins-docker-nginx

COPY <my default template> /etc/nginx/conf.d/default.conf.template
```

## Docker Swarm
### Assumptions
* Existing Docker Swarm cluster with version >= `1.13`
* Overlay network named `jenkins`
* Using [Docker secrets](https://docs.docker.com/engine/swarm/secrets/) for ssl certificates

### Deployment
The following steps need to be done on a Docker Swarm manager

1. Create a Docker swarm [overlay network](https://docs.docker.com/engine/reference/commandline/network_create/#options) with:
  ```
  docker network create --driver overlay --subnet <Subnet in CIDR format> jenkins
  ```

1. Create Docker secrets for your ssl certificate
  ```
  docker secret create cert.crt <path to certificate>
  docker secret create cert.key <path to key>
  ```

1. Modify the `docker-compose.yml` file to have company specific settings

1. Create a [docker stack](https://docs.docker.com/engine/reference/commandline/stack_deploy/)
  ```
  $ docker stack deploy -c docker-compose.yml service
  ```

## Contributors

* [Jay Kline](https://github.com/slushpupie)
* [Jordan Sussman](https://github.com/JordanSussman)
* [Sean Quinn](https://github.com/sjqnn)
* [Dax Johnson](https://github.com/delta592)
