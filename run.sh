#/bin/sh

docker build . -t keymaera_run
docker stop keymaera_container
docker rm keymaera_container


#docker run -d -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix -p 8090:8090 --name keymaera_container keymaera_run
#docker network create --subnet=192.168.5.0/24 my_network
#docker run -d --net my_network --ip 192.168.5.5 -p 8090:8090 --name keymaera_container keymaera_run
docker run -d -p 8090:8090 --name keymaera_container keymaera_run
docker exec keymaera_container java -jar keymaerax.jar 

