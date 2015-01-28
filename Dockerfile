
FROM c3h3/pyenv:u1404-py278

MAINTAINER Chia-Chi Chang <c3h3.tw@gmail.com>

RUN mkdir /tmp/openblas_build && cd /tmp/openblas_build/ && wget https://github.com/xianyi/OpenBLAS/archive/v0.2.12.tar.gz && tar xfzv v0.2.12.tar.gz && cd /tmp/openblas_build/OpenBLAS-0.2.12/ &&  make DYNAMIC_ARCH=1 NO_AFFINITY=1 NUM_THREADS=32 && make install && ldconfig && cd /tmp && rm -rf openblas_build/ && ln -s /opt/OpenBLAS/lib/libopenblas.so /usr/lib/libopenblas.so

ENV LD_LIBRARY_PATH /opt/OpenBLAS/lib/

