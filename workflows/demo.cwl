#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: Workflow

# Inspired by
# https://github.com/InSilicoDB/pipeline-kallisto/blob/develop/main.nf

hints:
 DockerRequirement:
  dockerPull: insilicodb/kallisto

inputs:
  transcripciones: File[]
  lecturas: File[]

steps:
  indexing:
    run: ../tools/kallisto-index.cwl
    in:
      fasta-files: transcripciones
    out:
     - index
  quantifying:
    run: ../tools/kallisto-quant.cwl
    in:
      index: indexing/index
      fastqs: lecturas
    out:
      - quantification

outputs:
  resultados:
    type: File
    outputSource: quantifying/quantification
