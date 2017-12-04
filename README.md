TTSLab Lwazi2 isiZulu build scripts
===================================

This repository contains pre-setup data and scripts for building a isiZulu TTS voice using [TTSLab][1] and associated [build tools][2]. This repository should be built against TTSLab `commit 5cb979c...`. The recommended way to do this is described in `./HOWTO.md` and involves cloning this repository and running the accompanying [Docker][3] script (`./Dockerfile`). 

The copyright and licence information for scripts in this repository can be found in `./COPYRIGHT`, `./LICENCE-APACHE` and `./LICENCE-MIT`. This repository also contains software and data developed by third parties used under licence in the `./src` and `./recs` directories. Copyright and licence information for third-party components is contained in each individual sub-directory or source file. Summaries of these components including attribution information are briefly presented below.

Since the speech corpus bundled here is specifically released under a licence that prohibits commercial use, this repository can be used as-is for research purposes or to demonstrate how to use the TTSLab toolkit to build voices (__in academic work please cite 1__).


## Speech corpus and language data

#### Lwazi II isiZulu TTS Corpus

The Lwazi 2 isiZulu text-to-speech corpus was originally developed by the CSIR in South Africa and can be used and distributed under the terms of a [Creative Commons Licence][4] which prohibits commercial use. If this corpus is used for research purposes, please refer to the CSIR technical report (__cite 1__).

For more information and links to the original corpus distribution refer to `./recs/README.md`.

#### isiZulu letter-to-sound rules

The letter-to-sound rules used here was enhanced for use in TTS during the NTTS project funded by the Department of Arts and Culture (DAC) of the Government of South Africa and is [available on Github][5] under a Creative Commons licence (__cite 2__). The original pronunciation resources developed for automatic speech recognition (ASR) from which the current version was derived was developed during the NCHLT project ([resources available online][6]) (__cite 3__).

## Software

#### External

The source for the following external pieces of software are fetched automatically and compiled here (please refer to the original Github repositories for copyright and licence conditions):

 1. The [TTSLab toolkit][1] and associated [development tools][2] (please __cite 1__).
 2. The [ZA_lex][7] lexical resources for South African languages.
 3. [Praat][prtrepo] (see also http://www.fon.hum.uva.nl/praat/).

#### Bundled

The following files contain source code from third parties with their own copyright and licence information:

 1. [Edinburgh Speech Tools][8]: `./src/speech_tools-2.4-release.tar.gz`
 2. [Speech Signal Processing Toolkit (SPTK)][9]: `./src/SPTK-3.8.tar.gz`
 3. [HMM-based Speech Synthesis System (HTS)][10]: `./src/HTS-2.3beta_for_HTK-3.4.1.tar.bz2`
 4. [Sequitur G2P][11]: A trainable Grapheme-to-Phoneme converter (__cite 4__): `./src/g2p-r1668-r3.tar.gz`


#### Not included

The source code for the following third-party tools are required but are not included here (this should be downloaded and placed in the correct locations before building as described in `./HOWTO.md`:

 1. [The Hidden Markov Model Toolkit (HTK)][12] version [3.4.1][13]: `./src/HTK-3.4.1.tar.gz`
 2. [HTK HDecode extension][14] version [3.4.1][15]: `./src/HDecode-3.4.1.tar.gz`


## References

 1. K. Calteaux, F. de Wet, C. Moors, D. R. van Niekerk, B. McAlister, A. Sharma Grover, T. Reid, M. Davel, E. Barnard, and C. van Heerden, __"Lwazi II Final Report: Increasing the impact of speech technologies in South Africa,"__ Council for Scientific and Industrial Research, Pretoria, South Africa, Tech. Rep. 12045, Feb. 2013.
```bibtex
@techreport{calteaux2013lwazi2,
	author = {Calteaux, K. and de Wet, F. and Moors, C. and Van Niekerk, D. R. and McAlister, B. and Sharma Grover, A. and Reid, T. and Davel, M. and Barnard, E. and Van Heerden, C.},
	title = {{Lwazi II Final Report: Increasing the impact of speech technologies in South Africa}},
	number = {12045},
	institution = {{Council for Scientific and Industrial Research}},
	address = {Pretoria, South Africa},
	month = feb,
	year = {2013}
}
```

 2. D.R. van Niekerk, __"Final Report: Rapid development of increasingly natural sounding speech synthesis for South African languages,"__ North-West University, Vanderbijlpark, South Africa, Tech. Rep. _Forthcoming._
```bibtex
@techreport{vniekerk2017ntts,
	title = {{Final Report: Rapid development of increasingly natural sounding speech synthesis for South African languages}},
	author = {van Niekerk, D. R.},
	institution = {{North-West University}},
	address = {Vanderbijlpark, South Africa},
	year = {forthcoming},
}
```

 3. E. Barnard, M.H. Davel, C.J. van Heerden, F. de Wet and J.A.C. Badenhorst, __"The NCHLT speech corpus of the South African languages,"__ in _Proceedings of the Workshop on Spoken Language Technologies for Under-resourced languages (SLTU)_, St. Petersburg, Russia, 2014.
```bibtex
@inproceedings{barnard2014nchlt,
	authors = {E. Barnard and M.H Davel and C.J van Heerden and F. de Wet and J.A.C Badenhorst},
	title = {{The NCHLT speech corpus of the South African languages}},
	booktitle = {Proceedings of the Workshop on Spoken Language Technologies for Under-resourced languages (SLTU)},
	address = {St. Petersburg, Russia},
	year = {2014},
	month = may
}
```

 4. M. Bisani and H. Ney, __"Joint-Sequence Models for Grapheme-to-Phoneme Conversion"__. Speech Communication, Volume 50, Issue 5, May 2008, Pages 434-451.
```bibtex
@article{bisani2008jsmg2p,
	title = {{Joint-Sequence Models for Grapheme-to-Phoneme Conversion}},
	volume = {50},
	issn = {0167-6393},
	number = {5},
	journal = {{Speech Communication}},
	author = {Bisani, Maximilian and Ney, Hermann},
	month = may,
	year = {2008},
	pages = {434--451}
}
```
 

[1]: https://github.com/NWU-MuST/ttslab2
[2]: https://github.com/NWU-MuST/ttslabdev2
[3]: https://www.docker.com/
[4]: https://creativecommons.org/licenses/by-nc-nd/3.0/
[5]: https://github.com/NWU-MuST/za_lex/tree/master/data/tsn
[6]: https://sites.google.com/site/nchltspeechcorpus
[7]: https://github.com/NWU-MuST/za_lex
[8]: http://www.cstr.ed.ac.uk/projects/speech_tools/
[9]: http://sp-tk.sourceforge.net/
[10]: http://hts.sp.nitech.ac.jp/
[11]: https://www-i6.informatik.rwth-aachen.de/web/Software/g2p.html
[12]: http://htk.eng.cam.ac.uk/download.shtml
[13]: http://htk.eng.cam.ac.uk/ftp/software/HTK-3.4.1.tar.gz
[14]: http://htk.eng.cam.ac.uk/extensions/index.shtml
[15]: http://htk.eng.cam.ac.uk/prot-docs/hdecode.shtml
[prtrepo]: https://github.com/praat/praat
