#!/bin/bash

cd $HOME
LANG=zulu

if [ ! -e frontend.voice.pickle ]; then
    #Make `englishZA` pronun resources
    ##setup
    pushd data/pronun
    ln -s eng.addendum.pronundict addendum.pronundict
    ln -s eng.main.pronundict main.pronundict
    ln -s eng.phonememap.ipa-hts.tsv phonememap.ipa-hts.tsv
    ln -s eng.phonemeset.json phonemeset.json
    popd
    ##make
    ###phoneset
    ttslab_make_phoneset.py englishZA
    ###g2p
    if [ ! -e data/pronun/englishZA_g2p.pickle ]; then
        bash $HOME/scripts/do_jsm-g2p_train.sh;
        mv data/pronun/jsm_train data/pronun/eng.jsm_train
        mv data/pronun/g2p_jsm.pickle englishZA_g2p.pickle
    fi
    ln -s data/pronun/englishZA_g2p.pickle
    ###pronundicts
    ttslab_make_pronundicts.py
    mv main_phoneset.pickle englishZA_phoneset.pickle
    mv main_pronundict.pickle englishZA_pronundict.pickle
    mv main_pronunaddendum.pickle englishZA_pronunaddendum.pickle
    ##cleanup
    pushd data/pronun
    rm addendum.pronundict
    rm main.pronundict
    rm phonememap.ipa-hts.tsv
    rm phonemeset.json
    popd
     
    #Setup `main` pronun resources
    pushd data/pronun
    ln -s zul.addendum.pronundict addendum.pronundict
    ln -s zul.main.pronundict main.pronundict
    popd
     
    #Make `main` pronun resources
    ttslab_make_phoneset.py $LANG
    ttslab_make_g2p.py icu
    ttslab_make_pronundicts.py
     
    ttslab_make_voice.py frontend $LANG englishZA
fi

ttslab_make_synthesizer_hts.py
ttslab_make_voice.py main_synthesizer.pickle $LANG englishZA
mv voice.pickle hts_voice.pickle
