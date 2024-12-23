from setuptools import setup, find_packages

setup(
    name="MTW", 
    version="0.4.0", 
    packages=find_packages(), 
    include_package_data=True,           # Include non-code files like data, Makefile
    install_requires=[
        'docopt>=0.6.2',
        'pandas>=2.2',
        'numpy>=2.1'
    ],
    package_data={
        'MTW': [
            'Bin/Makefile',              # Include Makefile in package
            'Reference/*.fasta',         # Include all .fasta files from Reference/
        ],
    },
    scripts=[
        'MTW/Bin/process_samples',       
        'MTW/Bin/summarize_samples',     
    ],
    author="James Bullard",
    description="The MTW package provides commands to compute and summarize heteroplasmy from Illumina paired-end sequencing data.",
    python_requires='>=3.10'
)
