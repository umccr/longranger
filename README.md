### Long Ranger OSS release

This repo is the open-source release of Long Ranger 2.2.0. This release is provided for reference and review purposes. It is not yet in a fully buildable state & we are not currently providing support for building and running this code. 
To run Long Ranger, please use the release binaries available at https://support.10xgenomics.com/genome-exome/software/downloads/latest

### Running with docker

Here is an example running [Longranger 2.2.2 at UMCCR](https://hub.docker.com/r/umccr/longranger/) with an Amazon AWS `m5.24xlarge` instance (345 ECUs, 96 vCPUs, 2.5 GHz, Intel Xeon Platinum 8175, 384 GiB memory, EBS only) with an attached 2TB ST1 volume:

```bash
time docker run --privileged -v $PWD/COLO829BL:/data/COLO829BL -v $PWD/refdata-GRCh38-2.1.0:/data/refdata-GRCh38-2.1.0 -v $PWD/pre-called.vcf:/data/pre-called.vcf -v $PWD/output:/data/output -c 95 umccr/longranger:2.2.2 wgs --id="output" --fastqs=/data/COLO829BL --reference=/data/refdata-GRCh38-2.1.0 --jobmode=local --precalled=/data/pre-called.vcf --disable-ui --localcores=95 --localmem=350
```

YMMV, so please adjust the commandline to your machine characteristics.
