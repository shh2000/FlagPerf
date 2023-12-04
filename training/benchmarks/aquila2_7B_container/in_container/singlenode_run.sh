#!/bin/bash

ifconfig

SCALEHOME=$1

DATADIR=$2
DATASET=$3
TRAININGSAMPLES=$4

TP=$5
PP=$6
MBS=$7
GBS=$8

NODERANK=$9
NNODES=${10}
MASTERADDR=${11}
MASTERPORT=${12}


CUDA_DEVICE_MAX_CONNECTIONS=${13}
NCCL_SOCKET_IFNAME=${14}
NCCL_IB_DISABLE=${15}
NCCL_IB_CUDA_SUPPORT=${16}
NCCL_IB_GID_INDEX=${17}
NCCL_IB_HCA=${18}
NCCL_DEBUG=${19}

export PYTHONPATH=$PYTHONPATH:$SCALEHOME

export CUDA_DEVICE_MAX_CONNECTIONS=$CUDA_DEVICE_MAX_CONNECTIONS
export NCCL_SOCKET_IFNAME=$NCCL_SOCKET_IFNAME
export NCCL_IB_DISABLE=$NCCL_IB_DISABLE
export NCCL_IB_CUDA_SUPPORT=$NCCL_IB_CUDA_SUPPORT
export NCCL_IB_GID_INDEX=$NCCL_IB_GID_INDEX
export NCCL_IB_HCA=$NCCL_IB_HCA
export NCCL_DEBUG=$NCCL_DEBUG

VOCAB_FILE=$SCALEHOME/examples/aquila/tokenizer/vocab.json
MERGE_FILE=$SCALEHOME/examples/aquila/tokenizer/merges.txt
SPECIAL_TOKENS_FILE=$SCALEHOME/examples/aquila/tokenizer/special_tokens.txt

DISTRIBUTED_ARGS="
    --nproc_per_node 8 \
    --nnodes $NNODES \
    --node_rank $NODERANK \
    --master_addr $MASTERADDR \
    --master_port $MASTERPORT
"

TRAINING_ARGS="
    --train-samples $TRAININGSAMPLES \
    --eval-iters 0 \
    --tensor-model-parallel-size $TP \
    --pipeline-model-parallel-size $PP \
    --micro-batch-size $MBS \
    --global-batch-size $GBS \
    --disable-bias-linear \
    --use-distributed-optimizer \
    --use-flash-attn
"

MIXED_PRECISION_ARGS="
    --fp16 \
    --initial-loss-scale 522893 \
    --min-loss-scale 1.0 \
    --embedding-weights-in-fp32 \
    --attention-softmax-in-fp32 \
    --accumulate-allreduce-grads-in-fp32
"

DATA_ARGS="
    --data-path $DATADIR/$DATASET \
    --tokenizer-type AquilaTokenizer \
    --vocab-file $VOCAB_FILE \
    --vocab-size 100008\
    --merge-file $MERGE_FILE \
    --special-tokens-file $SPECIAL_TOKENS_FILE \
    --data-impl mmap \
    --split 1
"

NETWORK_ARGS="
    --num-layers 32 \
    --hidden-size 4096 \
    --num-attention-heads 32 \
    --seq-length 2048 \
    --max-position-embeddings 2048 \
    --layernorm-epsilon 1e-5 \
    --use-rotary-position-embeddings \
    --rotary-position-embeddings-in-fp32 \
    --no-position-embedding \
    --swiglu \
    --multiple-of 256 \
    --apply-layernorm-rms \
    --rotary-interleaved-patch \
    --untie-embeddings-and-output-weights
"

INITIALIZATION_ARGS="
    --init-method-std 0.02 \
    --seed 1234 
"

REGULARIZATION_ARGS="
    --attention-dropout 0.0 \
    --hidden-dropout 0.0 \
    --weight-decay 0.1 \
    --adam-beta1 0.9 \
    --adam-beta2 0.95 \
    --clip-grad 1.0
"

LEARNING_RATE_ARGS="
    --lr 2.0e-5 \
    --min-lr 2.0e-6 \
    --lr-decay-style cosine \
    --lr-warmup-samples 8
"


cmd="torchrun $DISTRIBUTED_ARGS $SCALEHOME/pretrain_gpt.py \
              $TRAINING_ARGS \
              $MIXED_PRECISION_ARGS \
              $DATA_ARGS \
              $NETWORK_ARGS \
              $INITIALIZATION_ARGS \
              $REGULARIZATION_ARGS \
              $LEARNING_RATE_ARGS
    "
echo $cmd
eval $cmd