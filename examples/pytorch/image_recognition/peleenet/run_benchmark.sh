#!/bin/bash
set -x

function main {

  init_params "$@"
  run_benchmark

}

# init params
function init_params {
  iters=100
  ilit_checkpoint=ilit_workspace/pytorch/peleenet
  batch_size=30
  for var in "$@"
  do
    case $var in
      --topology=*)
          topology=$(echo $var |cut -f2 -d=)
      ;;
      --dataset_location=*)
          dataset_location=$(echo $var |cut -f2 -d=)
      ;;
      --input_model=*)
          input_model=$(echo $var |cut -f2 -d=)
      ;;
      --mode=*)
          mode=$(echo $var |cut -f2 -d=)
      ;;
      --batch_size=*)
          batch_size=$(echo $var |cut -f2 -d=)
      ;;
      --iters=*)
          iters=$(echo ${var} |cut -f2 -d=)
      ;;
      --int8=*)
          int8=$(echo ${var} |cut -f2 -d=)
      ;;
      *)
          echo "Error: No such parameter: ${var}"
          exit 1
      ;;
    esac
  done

}


# run_benchmark
function run_benchmark {
    if [[ ${mode} == "accuracy" ]]; then
        mode_cmd=" --benchmark"
    elif [[ ${mode} == "benchmark" ]]; then
        mode_cmd=" --iter ${iters} --benchmark "
    else
        echo "Error: No such mode: ${mode}"
        exit 1
    fi

    if [[ ${int8} == "true" ]]; then
        extra_cmd="--int8 ${dataset_location}"
    else
        extra_cmd="--pretrained ${dataset_location}"
    fi

    python main.py \
            --ilit_checkpoint ${ilit_checkpoint} \
            -j 1 \
            -b ${batch_size} \
            --weights ${input_model} \
            ${mode_cmd} \
            ${extra_cmd}
}

main "$@"