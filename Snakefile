#!/usr/bin/env python3

import multiprocessing      # use entry point script to get threads
import pathlib
import pandas


###########
# GLOBALS #
###########

configfile: 'config.yaml' # get path from entry point
ref = config['ref']
outdir = config['outdir']

########
# MAIN #
########

# get a list of individuals from the csv


#########
# RULES #
#########


