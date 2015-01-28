
FROM c3h3/pyenv:deb8-py278

MAINTAINER Chia-Chi Chang <c3h3.tw@gmail.com>

RUN mkdir /tmp/openblas_build && cd /tmp/openblas_build/ && wget https://github.com/xianyi/OpenBLAS/archive/v0.2.12.tar.gz && tar xfzv v0.2.12.tar.gz && cd /tmp/openblas_build/OpenBLAS-0.2.12/ &&  make DYNAMIC_ARCH=1 NO_AFFINITY=1 NUM_THREADS=32 && make install && ldconfig && cd /tmp && rm -rf openblas_build/ && ln -s /opt/OpenBLAS/lib/libopenblas.so /usr/lib/libopenblas.so

ENV LD_LIBRARY_PATH /opt/OpenBLAS/lib/

RUN pip install cython==0.19

ADD numpy-site.cfg /tmp/numpy/site.cfg
ADD scipy-site.cfg /tmp/scipy/site.cfg

RUN git clone -q --branch=v1.8.2 https://github.com/numpy/numpy.git /tmp/numpy && mv /tmp/numpy-site.cfg /tmp/numpy/site.cfg && cd /tmp/numpy && python setup.py config && python setup.py build && python setup.py install && rm -rf /tmp/numpy

RUN git clone -q --branch=v0.14.0 https://github.com/scipy/scipy.git /tmp/scipy && mv /tmp/scipy-site.cfg /tmp/scipy/site.cfg && cd /tmp/scipy && python setup.py config && python setup.py build && python setup.py install && rm -rf /tmp/scipy

