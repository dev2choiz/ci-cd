#!/usr/bin/env bash

sh ./jenkins/install.sh
cd registry
sh ./generate-credential.sh

