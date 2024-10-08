# 参评AI芯片信息

* 厂商：Metax


* 产品名称：C550
* 产品型号：曦云®C550 64G
* TDP：450W

# 所用服务器配置

* 服务器数量：2


* 单服务器内使用卡数：8
* 服务器型号：OAM C550-1500
* 操作系统版本：Ubuntu 20.04.6 LTS
* 操作系统内核：linux5.15.0-58-generic
* CPU：Inter(R) Xeon(R) Plattinum 8480+
* docker版本：24.0.7
* 内存：2TiB
* 服务器间AI芯片直连规格及带宽：此评测样例无需服务器间通信

# 指标选型

The following are the three performance metrics commonly used
    1. samples/s (algbw): This metric measures the number of samples processed per second, indicating the algorithmic bandwidth. It reflects the computational efficiency of the algorithm.
    2. busbw: This metric represents the bus bandwidth, which measures the data transfer rate across the system's bus. It is crucial for understanding the communication efficiency between different parts of the system.
    3. busbw * 2: This metric is an extension of busbw, accounting for bidirectional data transfer. It doubles the bus bandwidth to reflect the full duplex capability of the system.
The second metric, busbw, is chosen for the following reasons:
    1. This number is obtained applying a formula to the algorithm bandwidth to reflect the speed of the inter-GPU communication. Using this bus bandwidth, we can compare it with the hardware peak bandwidth, independently of the number of ranks used.
    2. We can horizontally compare the MPI of different patterns such as all-gather/all-reduce/reduce-scatter.

# 评测结果

## 核心评测结果

| 评测项  | 服务器间多卡的MPI互联带宽测试值(16卡平均) | 服务器间多卡的MPI互联带宽标定值(16卡平均) | 测试标定比例(16卡平均) |
| ---- | -------------- | -------------- | ------------ |
| 评测结果 | /    | /       | /    |


## 能耗监控结果

| 监控项  | 系统平均功耗  | 系统最大功耗  | 系统功耗标准差 | 单机TDP | 单卡平均功耗(16卡平均) | 单卡最大功耗(16卡最大) | 单卡功耗标准差(16卡最大) | 单卡TDP |
| ---- | ------- | ------- | ------- | ----- | ------------ | ------------ | ------------- | ----- |
| 监控结果 | 4335.0W | 4488.0W | 153.0W    | /     | 136.5W       | 173.0W       | 36.5W        | 450W  |

## 其他重要监控结果

| 监控项  | 系统平均CPU占用 | 系统平均内存占用 | 单卡平均温度(16卡平均) | 单卡平均显存占用(16卡平均) |
| ---- | --------- | -------- | ------------ | -------------- |
| 监控结果 | 1.059%    |0.957%   | 36.5°C      | 11.253%        |

使用torch.all_reduce，进行多机多卡的MPI互联操作，计算服务器内MPI互联带宽

* 注：如镜像启动时ssh并未随命令开启，请切换至[容器内启动](https://github.com/FlagOpen/FlagPerf/blob/main/docs/utils/definitions/IN_CONTAINER_LAUNCH.md)