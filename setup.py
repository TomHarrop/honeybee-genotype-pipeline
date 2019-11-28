#!/usr/bin/env python3
# -*- coding: utf-8 -*-

from setuptools import setup
from setuptools import find_packages


# load README.rst
def readme():
    with open('README.rst') as file:
        return file.read()


setup(
    name='honeybee_genotype_pipeline',
    version='0.0.3',
    description='python3 wrapper for calling genotypes',
    long_description=readme(),
    url='https://github.com/tomharrop/honeybee-genotype-pipeline',
    author='Tom Harrop',
    author_email='twharrop@gmail.com',
    license='GPL-3',
    packages=find_packages(),
    install_requires=[
        'pandas>=0.25.3',
        'snakemake>=5.8.1'
    ],
    entry_points={
        'console_scripts': [
            'honeybee_genotype_pipeline = honeybee_genotype_pipeline.__main__:main'
            ],
    },
    scripts={
        'honeybee_genotype_pipeline/src/calculate_ldepth_cutoff.R',
        'honeybee_genotype_pipeline/src/plot_frq.R',
        'honeybee_genotype_pipeline/src/plot_idepth.R',
        'honeybee_genotype_pipeline/src/plot_imiss.R',
        'honeybee_genotype_pipeline/src/plot_ldepth.mean.R',
        'honeybee_genotype_pipeline/src/plot_lmiss.R',
        'honeybee_genotype_pipeline/src/plot_lqual.R'
    },
    package_data={
        'honeybee_genotype_pipeline': [
            'Snakefile',
            'README.rst'
        ],
    },
    zip_safe=False)
