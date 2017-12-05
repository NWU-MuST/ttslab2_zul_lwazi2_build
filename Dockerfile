############################################################
#### TTSLab2 Lwazi2 IsiZulu build scripts
############################################################
FROM ubuntu:16.04

LABEL Maintainer="Daniel van Niekerk <dvn.demitasse@gmail.com>"
LABEL Description="TTSLab2 Lwazi2 Setswana build scripts"


## INSTALL STANDARD TOOLS FROM UBUNTU REPO
############################################################
RUN apt-get clean all && apt-get update
RUN apt-get install -y --force-yes build-essential git wget #Required to fetch and build source
RUN apt-get install -y --force-yes csh #Required by SPTK
RUN apt-get install -y --force-yes libx11-dev #Required by HTK
RUN apt-get install -y --force-yes gfortran #Required by HTS
RUN apt-get install -y --force-yes cmake cython python-numpy #Required to build TTSLab back-ends
RUN apt-get install -y --force-yes python-cffi python-dateutil python-scipy python-sklearn python-pyicu #Required by TTSLab
#RUN apt-get install -y --force-yes libncurses5-dev #Required by EST
RUN apt-get install -y --force-yes python-setuptools swig #Required to build Sequitur
RUN apt-get install -y --force-yes bc sox normalize-audio tcl-snack #Required tools for voice build scripts

## SETUP USER, LOCAL SOURCE, AND DATA
############################################################
ENV USERNAME=demitasse
ENV USERHOME=/home/$USERNAME
RUN useradd -ms /bin/bash $USERNAME
#external volume to transfer output to host
RUN mkdir /mnt/ext
VOLUME /mnt/ext
ENV OUTDIR=/mnt/ext

COPY src $USERHOME/src
COPY etc $USERHOME/etc
COPY lang $USERHOME/lang
COPY recs $USERHOME/recs
COPY scripts $USERHOME/scripts
COPY local $USERHOME/local
WORKDIR $USERHOME
RUN chown -R $USERNAME:$USERNAME src etc lang recs scripts local
USER $USERNAME
RUN ln -s lang data
ENV PYTHONPATH=$USERHOME/local/lib/python2.7/site-packages:$PYTHONPATH
ENV PATH=$USERHOME/local/bin:$PATH


## FETCH, BUILD AND SETUP SPECIALISED SOFTWARE
############################################################

# ## Build Edinburgh Speech Tools (only needed for unit-selection)
# WORKDIR $USERHOME/src
# RUN tar -xzvf speech_tools-2.4-release.tar.gz
# WORKDIR $USERHOME/src/speech_tools
# RUN ./configure
# RUN make

## Build SPTK
WORKDIR $USERHOME/src
RUN tar -xzvf SPTK-3.8.tar.gz
WORKDIR $USERHOME/src/SPTK-3.8
RUN ./configure; make; mkdir bin/bin;
WORKDIR $USERHOME/src/SPTK-3.8/bin/bin
RUN ln -s `find ../ -type f -executable | grep -v "\.c" | grep -v "\.h"` .

## Build HTS
WORKDIR $USERHOME/src
RUN tar -xzvf HTK-3.4.1.tar.gz; tar -xzvf HDecode-3.4.1.tar.gz; mkdir htk/HTS_patch;
WORKDIR $USERHOME/src/htk/HTS_patch
RUN tar -xjvf ../../HTS-2.3beta_for_HTK-3.4.1.tar.bz2
WORKDIR $USERHOME/src/htk
RUN patch -p1 -d . < HTS_patch/HTS-2.3beta_for_HTK-3.4.1.patch; ./configure; make;

## Build Sequitur
WORKDIR $USERHOME/src
RUN tar -xzvf g2p-r1668-r3.tar.gz
WORKDIR $USERHOME/src/g2p
RUN python setup.py install --prefix=$USERHOME/local
WORKDIR $USERHOME/local/lib/python2.7/site-packages
RUN ln -s $USERHOME/src/g2p/sequitur_.py

## Fetch and build Praat
WORKDIR $USERHOME/src
RUN git clone https://github.com/praat/praat.git
WORKDIR $USERHOME/src/praat
RUN git checkout 5d71e96
RUN cp makefiles/makefile.defs.linux.barren ./makefile.defs
RUN make
WORKDIR $USERHOME/local/bin
RUN ln -s $USERHOME/src/praat/praat

## Fetch and build OpenFST
WORKDIR $USERHOME/src
RUN wget http://openfst.org/twiki/pub/FST/FstDownload/openfst-1.6.5.tar.gz
RUN tar -xzvf openfst-1.6.5.tar.gz
WORKDIR $USERHOME/src/openfst-1.6.5
RUN ./configure --prefix=/home/demitasse/local --enable-bin --enable-far --enable-python
RUN make
RUN make install

## Fetch, build and setup TTSLab and tools
WORKDIR $USERHOME/src
RUN git clone https://github.com/NWU-MuST/ttslab2.git
RUN git clone https://github.com/NWU-MuST/ttslabdev2.git
#ttslab
WORKDIR $USERHOME/src/ttslab2
RUN git checkout 99f61e8
RUN mkdir -p hts_engine/build
WORKDIR $USERHOME/src/ttslab2/hts_engine/build
RUN cmake ..
RUN make
WORKDIR $USERHOME/src/ttslab2/ttslab/synthesizers
RUN bash compile_relp.sh
#ttslabdev
WORKDIR $USERHOME/src/ttslabdev2
RUN git checkout 260802e
WORKDIR $USERHOME/src/ttslabdev2/voicetools
RUN bash compile_dtw.sh
WORKDIR $USERHOME/src/ttslabdev2/voicetools/HTS-template_16k_MELP
RUN mkdir data/utts data/raw data/wav data/questions data/labels
RUN tar -czvf ../HTS-template_16k_MELP.tar.gz .
#paths
ENV PATH=$USERHOME/src/ttslabdev2/scripts:$PATH:$USERHOME/src/ttslab2/ttslab
ENV PYTHONPATH=$USERHOME/src/ttslab2:$USERHOME/src/ttslabdev2/modules:$PYTHONPATH


## FETCH AND SETUP LANGUAGE DATA FOR VOICE FRONTENDS
############################################################

#za_lex
WORKDIR $USERHOME/src
RUN git clone https://github.com/NWU-MuST/za_lex.git
WORKDIR $USERHOME/src/za_lex
RUN git checkout bfc2427
ENV PATH=$USERHOME/src/za_lex/scripts:$PATH
ENV ZALEX=$USERHOME/src/za_lex

#eng g2p
WORKDIR $USERHOME/lang/pronun
RUN ln -s $USERHOME/src/za_lex/data/eng/pronundict.txt eng.main.pronundict
RUN ln -s $USERHOME/src/za_lex/data/eng/phonememap.ipa-hts.tsv eng.phonememap.ipa-hts.tsv
RUN ln -s $USERHOME/src/za_lex/data/eng/phonemeset.json eng.phonemeset.json

#zul g2p
RUN mkdir $USERHOME/lang/pronun/icu
WORKDIR $USERHOME/lang/pronun/icu
RUN ln -s $USERHOME/src/za_lex/data/zul/g2p.translit.txt rules
RUN ln -s $USERHOME/src/za_lex/data/zul/phonemeset.json
RUN python -c "import json, codecs; d = json.load(codecs.open('phonemeset.json', encoding='utf-8')); print u'\n'.join(sorted(d['phones'].keys())).encode('utf-8')" > phones

## BUILD VOICE WITH:
## `docker run -v $TTSLAB2_ZUL_LWAZI2_BUILD/out:/mnt/ext ttslab2_zul_lwazi2_build`
############################################################
WORKDIR $USERHOME
CMD bash $USERHOME/scripts/do_all.sh
