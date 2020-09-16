graph: graph.svg

readme: README.rst

graph.svg: honeybee_genotype_pipeline/Snakefile samples_head.csv
	snakemake \
	-n \
	-s honeybee_genotype_pipeline/Snakefile \
	--cores 8 \
	--dag \
	--forceall \
	--config ref=data/ref.fa \
	outdir=out \
	threads=8 \
	samples_csv=data/sample_info.example.csv \
	ploidy=2 \
	cnv_map=False \
	csd=True \
	| grep -v "^[[:space:]+]0" | grep -v "\->[[:space:]]0" \
	| dot -Tsvg \
	> graph.svg

README.rst: README.md
	 pandoc -f markdown -t rst README.md > README.rst
