# 评测原理

1. 使用computation-bound的算子GEMM来评测芯片FP32算力，避免因为存储、互联等因素导致评测结果偏低

# 适配修改规范

本评测样例配置文件如下：

```yaml
M: "4096"
N: "4096"
K: "4096"
DIST_BACKEND: "mpi"
```

1. M、N、K为GEMM算子的配置。本评测样例以[M,N]矩阵和[N,K]矩阵相乘作为计算内容。厂商可在正整数范围内任意调整此三项配置，发挥自身能力

   例如，英伟达A800-80-SXM芯片采用M=8192、N=8192、K=8192

2. DIST_BACKEND为通讯库。在本评测样例中，仅供初始化使用，无通信算子。厂商可任意调整为适用于自己的通讯库。

   例如，英伟达A800-80-SXM芯片采用DIST_BACKEND="nccl"