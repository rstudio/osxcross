#!/bin/bash

set -euv

go install mvdan.cc/sh/v3/cmd/shfmt@latest

mkdir ~/.earthly

cp .devcontainer/earthly_config.yml ~/.earthly/config.yml
