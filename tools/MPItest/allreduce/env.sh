export CUDA_DEVICE_MAX_CONNECTIONS=1;
export NCCL_SOCKET_IFNAME=eth0;
export NCCL_IB_DISABLE=0;
export NCCL_IB_CUDA_SUPPORT=1;
export NCCL_IB_GID_INDEX=0;
export NCCL_IB_HCA=mlx5_101,mlx5_102,mlx5_103,mlx5_104,mlx5_105,mlx5_106,mlx5_107,mlx5_108;
