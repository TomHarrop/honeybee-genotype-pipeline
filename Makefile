graph: graph.svg

readme: README.rst

graph.svg: honeybee_genotype_pipeline/Snakefile samples_head.csv
	snakemake \
	-n \
	-s honeybee_genotype_pipeline/Snakefile \
	--cores 8 \
	--rulegraph \
	--forceall \
	--config ref=data/GCF_003254395.2_Amel_HAv3.1_genomic.fna \
	outdir=test \
	threads=8 \
	samples_csv=samples_head.csv \
	ploidy=2 \
	| dot -Tsvg \
	> graph.svg

README.rst: README.md
	 pandoc -f markdown -t rst README.md > README.rst
