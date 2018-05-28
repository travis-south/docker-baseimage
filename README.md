# docker-baseimage
Baseimage from phusion/baseimage

## Usage
`docker run --rm -ti -v $PWD:/var/www/app --env PGID=$(id -g) --env PUID=$(id -u) travissouth/baseimage`
