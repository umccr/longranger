################## BASE IMAGE ######################

FROM biocontainers/biocontainers:latest

ENV VERSION "2.2.2"
ENV SAMPLE "CHANGEME"
ENV FASTQ_DIR "/data"
ENV REF_DIR "/data" 

################## METADATA ######################
LABEL base_image="biocontainers:latest"
LABEL version="1"
LABEL software="longranger"
LABEL software.version="$VERSION"
LABEL about.summary="10X genomics aligner"
LABEL about.home="https://support.10xgenomics.com/genome-exome/software/pipelines/latest/what-is-long-ranger"
LABEL about.documentation="https://github.com/10XGenomics/longranger"
LABEL about.license_file="https://github.com/10XGenomics/longranger/blob/master/LICENSE"
LABEL about.license="AGPLv2"
LABEL extra.identifiers.biotools="longranger"
LABEL about.tags="Genomics"

################## MAINTAINER ######################
#MAINTAINER Roman Valls Guimera <brainstorm@nopcode.org> # Deprecated syntax, https://biocontainer.pro docs must be updated
LABEL maintainer="brainstorm@nopcode.org"

################## INSTALLATION ######################
USER biodocker

# XXX: Brittle release engineering, since download keys rotate here, please 10X fix this.
RUN wget -O longranger-2.2.2.tar.gz "http://cf.10xgenomics.com/releases/genome/longranger-2.2.2.tar.gz?Expires=1531765855&Policy=eyJTdGF0ZW1lbnQiOlt7IlJlc291cmNlIjoiaHR0cDovL2NmLjEweGdlbm9taWNzLmNvbS9yZWxlYXNlcy9nZW5vbWUvbG9uZ3Jhbmdlci0yLjIuMi50YXIuZ3oiLCJDb25kaXRpb24iOnsiRGF0ZUxlc3NUaGFuIjp7IkFXUzpFcG9jaFRpbWUiOjE1MzE3NjU4NTV9fX1dfQ__&Signature=jwHq~2YjNJ-THQwuraGP8vWZ3rcspRapp2HaPiIzBuP9qCz7UZskixwoZljXeGp-XnVL0SfFLg4D4UG7l4VzLWaFYZlHxhYMmsc4qtZTUMpiZGlxgqjE-avqapojBAEuO3rBdt3Gyvz00ZxSKrOhvMSNlgpSS~ZHZWBOXHuugoqkihTnZhDkn2dTtRnr-68YCRYBIc7C3y0GV0hNcWfHfW92w6MZ76wmmg9PlFlhQ-9Jtlb1WXr7NESofgcsbHXgw-ZEMig0GOsz~zoB1uNLj~HMjx7CxHcK6oWcD3L41WL65XMomVgV4FPk1RLBfvryOyIHnQwkmdI-O0NBohViSA__&Key-Pair-Id=APKAI7S6A5RYOXBWRPDA"

# Untar (spray tarball under $HOME)
ADD longranger-"$VERSION".tar.gz "$HOME"

# Repurpose sourceme.bash so that it acts as a longranger wrapper under $HOME/bin
RUN cp "$HOME"/longranger-"$VERSION"/sourceme.bash $HOME/bin/longranger && \
    echo "$HOME"/longranger-"$VERSION"/longranger '$@' >> $HOME/bin/longranger && \
    chmod +x $HOME/bin/longranger && \
    sed -i '1 i\#\!\/bin\/bash' $HOME/bin/longranger && \
    rm longranger-"$VERSION".tar.gz


WORKDIR /data

ENV PATH "$HOME"/bin:"$PATH"

ENTRYPOINT [ "longranger" ]
