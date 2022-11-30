FROM paperist/alpine-texlive-ja

WORKDIR /work/latex/
RUN apk upgrade && apk add texlive
#latexdiff
