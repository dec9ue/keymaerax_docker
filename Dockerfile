FROM ubuntu:22.04

ARG USER_NAME
RUN apt-get update
RUN apt-get install apt-transport-https curl gnupg xz-utils apt-utils zip -yqq
RUN echo "deb https://repo.scala-sbt.org/scalasbt/debian all main" | tee /etc/apt/sources.list.d/sbt.list
RUN echo "deb https://repo.scala-sbt.org/scalasbt/debian /" | tee /etc/apt/sources.list.d/sbt_old.list
RUN curl -sL "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x2EE0EA64E40A89B84B2DF73499E82A75642AC823" | gpg --no-default-keyring --keyring gnupg-ring:/etc/apt/trusted.gpg.d/scalasbt-release.gpg --import
RUN chmod 644 /etc/apt/trusted.gpg.d/scalasbt-release.gpg
RUN apt-get update
RUN apt-get -y install python3
RUN apt-get -y install openjdk-11-jdk
RUN apt-get -y install sbt
COPY WolframEngine_13.1.0_LINUX.sh /tmp
RUN chmod 655 /tmp/WolframEngine_13.1.0_LINUX.sh
RUN /tmp/WolframEngine_13.1.0_LINUX.sh

WORKDIR /home/${USER_NAME}/

ADD https://keymaerax.org/keymaerax.jar .
COPY default.conf .
RUN zip -u keymaerax.jar default.conf
RUN bash -l -c "echo \"mathematica.jlink.path=${WOLFRAM_ENGINE_PATH}/"'$(<weversion.txt)/SystemFiles/Links/JLink/JLink.jar" > local.properties'
#RUN bash -l -c "echo \"mathematica.jlink.path=${WOLFRAM_ENGINE_PATH}/"'$(<weversion.txt)/SystemFiles/Links/JLink/JLink.jar" > local.properties'

#ENTRYPOINT ["java","-jar","/home/${USER_NAME}/keymaerax.jar"]

ENTRYPOINT ["sleep","infinity"]



