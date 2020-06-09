#!/bin/bash
# my-linux-shell-scripts set-pipeline.sh

fly -t ci set-pipeline -p my-linux-shell-scripts -c pipeline.yml --load-vars-from ../../../.credentials.yml
