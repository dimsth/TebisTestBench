FROM tebis-base:latest

WORKDIR /usr/src/app

# Clone and build commands if needed
RUN git clone https://github.com/CARV-ICS-FORTH/tebis /usr/src/app \
    && mkdir build \
    && cd build \
    && cmake .. -DTEBIS_FORMAT=ON \
    && make