#!/bin/bash
# my-linux-shell-scripts destroy-pipeline.sh

fly -t ci destroy-pipeline --pipeline my-linux-shell-scripts
