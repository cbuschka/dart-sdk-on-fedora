FROM fedora:34

ARG USER_UID=1000
ARG USER_GID=1000
ARG USER_NAME="build"

RUN yum -y install git subversion make gcc-c++
RUN yum -y install findutils
RUN groupadd -g ${USER_GID} ${USER_NAME} && \
	useradd -u ${USER_UID} -g ${USER_GID} -m ${USER_NAME}

COPY /assets/ /

USER ${USER_NAME}
VOLUME /build
VOLUME /output

CMD "/build.sh"
