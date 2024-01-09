
### Nvidia GPU配置与运行信息参考
#### 环境配置
- ##### 硬件环境
    - 机器型号: NVIDIA H800(80G)
    - 加速卡型号: NVIDIA_H800-80GB
    - CPU型号: Intel(R) Xeon(R) Platinum 8462Y+
    - 多机网络类型、带宽: InfiniBand, 200Gb/s

- ##### 软件环境
   - OS版本：Ubuntu 22.04 LTS
   - OS kernel版本: 5.15.0-25-generic     
   - 加速卡驱动版本：535.129.03
   - Docker 版本：24.0.7
   - 训练框架版本：FlagScale.git@6fc099c
   - 依赖软件版本：sentencepiece

- ##### 并行策略

   - 并行技术：张量、流水、数据混合并行，具体并行方案见“运行情况”章节
   - 实施者：FlagScale
   - 实施细节：/

- ##### 优化策略

   - flash attention 2

### 运行情况

* 输入批尺寸
  1. local_batchsize(micro_batchsize)，简写为LBS，即实际进入模型的张量批尺寸，为config_H100x4x8.py中所写，在本case中默认为1
  2. seqlength(max_position_embedding)，简写为MPE，即实际进入模型的序列长度，为config_H100x4x8.py中所写，在本case中默认为4096
  3. gradient_accumulate_steps，简写为GAS，即梯度累加步数，为ds_config.json中所写，在本case中默认为44
  4. global_batchsize恒等于local_batchsize\*gradient_accumulate_steps\*data_parallel_size。在本case中，data_parallel_size=world_size/TPsize/PPsize。

* 通用指标

| 指标名称     | 指标值                     | 特殊说明                           |
| ------------ | -------------------------- | ---------------------------------- |
| 任务类别     | 自然语言理解               |                                    |
| 模型         | llama2_70b                  |                                    |
| 数据集       | pile wikipedia   |                                    |
| 数据精度     | amp                        |                                    |
| 超参修改     | parallel,见“性能指标” | 格式为TPxPPyDPz，例如TP2PP1DP4 |
| 超参修改     | fix_hp,见“性能指标”        | 跑满硬件设备评测吞吐量所需特殊超参 |
| 硬件设备简称 | nvidia H800                |                                    |
| 硬件存储使用 | mem,见“性能指标”           | 通常称为“显存”,单位为GiB           |
| 计算使用率 | MFU,见“性能指标”           | 参见PaLM论文定义 |
| **吞吐量**   | **token/p/s,见“性能指标”** | 平均单卡每秒处理的token数          |

* 性能指标

| 配置                | parallel |  fix_hp           | token/p/s | loss | mem       | MFU       |
| ------------------- | ------ | ---------------- | ------ | ------- | --------- | --------- |
| H800单机8卡（4x8）  | TP8PP4DP1 |  /                | 3936.8 | 4.70 | 74/80 | 53.0% |
| H800单机8卡（4x8）  | TP4PP8DP1 |  LBS=8            | 2866.3 | 4.71 | 55/80 | 38.6% |
| H800单机8卡（4x8）  | TP4PP4DP2 |  LBS=4       | 2093.5 | 4.02 | 57/80 | 28.2% |