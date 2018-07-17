################## BASE IMAGE ######################

FROM biocontainers/biocontainers:latest

ENV VERSION "2.2.2"

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
RUN wget -O longranger-"$VERSION".tar.gz "https://mega.nz/#!HpxXwTbS!INCKJNHD_PFx-lHVKHFDcMaEUdoGavnxb7zXQ5UCTT8"

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
