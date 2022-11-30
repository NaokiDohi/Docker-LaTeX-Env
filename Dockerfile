FROM paperist/alpine-texlive-ja:2018

WORKDIR /work/latex/
RUN apk upgrade && apk add texlive
#latexdiff
