#!/bin/bash -e

for date in "${@}"; do
    mkdir -p assets/log/${date}

    aws s3 cp --recursive \
        ${S3_LOG_DIR}/${date}/ \
        assets/log/${date}/

    for file in assets/log/${date}/*.log.gz; do
        gzip -df ${file}
    done
done
