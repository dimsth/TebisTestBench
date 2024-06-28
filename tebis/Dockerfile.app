FROM tebis-zookeeper:latest

WORKDIR /usr/src/app

# Clone and build commands if needed
RUN git clone https://github.com/CARV-ICS-FORTH/tebis /usr/src/app

RUN mkdir build \
    && cd build \
    && cmake .. -DTEBIS_FORMAT=ON

RUN rm -rf tcp_server/server_handle.c

COPY server_handle.c /usr/src/app/tcp_server/server_handle.c

RUN cd /usr/src/app/build \
    && make