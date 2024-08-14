# 参评AI芯片信息

* 厂商：ILUVATAR

* 产品名称：BI150
* 产品型号：BI150
* TDP：W

# 所用服务器配置

* 服务器数量：1


* 单服务器内使用卡数：1
* 服务器型号：
* 操作系统版本：Ubuntu 20.04.6 LTS
* 操作系统内核：linux5.4.0-148-generic
* CPU：
* docker版本：20.10.25
* 内存：
* 服务器间AI芯片直连规格及带宽：此评测项不涉及服务期间AI芯片直连

# 算子库版本
FlagGems:>联系邮箱: contact-us@iluvatar.com获取版本(FlagGems-0710_pointwise_use_tid)

# 评测结果

## 核心评测结果

| 评测项  | 平均相对误差(with FP64-CPU) | TFLOPS(cpu wall clock) | TFLOPS(kernel clock) | FU(FLOPS Utilization)-cputime | FU-kerneltime |
| ---- | -------------- | -------------- | ------------ | ------ | ----- |
| flaggems | 0.00E+00    | 0.12TFLOPS       | 0.12TFLOPS        | 0.47% | 0.47% |
| nativetorch | 0.00E+00    | 0.14TFLOPS      | 0.14TFLOPS      | 0.56%      | 0.56%    |

## 其他评测结果

| 评测项  | 相对误差(with FP64-CPU)标准差 | cputime | kerneltime | cputime吞吐 | kerneltime吞吐 | 无预热时延 | 预热后时延 |
| ---- | -------------- | -------------- | ------------ | ------------ | -------------- | -------------- | ------------ |
| flaggems | 0.00E+00    | 9258.69us       | 9268.42us        | 108.01op/s | 107.89op/s | 273463.87us | 9801.39us |
| nativetorch | 0.00E+00    | 7843.88us       | 7866.95us        | 127.49op/s | 127.11op/s | 8136.55us | 8127.15us |

## 能耗监控结果

| 监控项  | 系统平均功耗  | 系统最大功耗  | 系统功耗标准差 | 单机TDP | 单卡平均功耗 | 单卡最大功耗 | 单卡功耗标准差 | 单卡TDP |
| ---- | ------- | ------- | ------- | ----- | ------------ | ------------ | ------------- | ----- |
| nativetorch监控结果 | 2085.25W | 2109.0W | 41.14W   | /     | 167.9W       | 168.0W      | 0.31W        | 350W  |
| flaggems监控结果 | 2078.6W | 2109.0W | 37.23W   | /     | 163.97W       | 164.0W      | 0.18W        | 350W  |

## 其他重要监控结果

| 监控项  | 系统平均CPU占用 | 系统平均内存占用 | 单卡平均温度 | 单卡最大显存占用 |
| ---- | --------- | -------- | ------------ | -------------- |
| nativetorch监控结果 | 48.364%    | 2.393%   | 48.79°C       | 16.364%        |
| flaggems监控结果 | 46.779%    | 2.394%   | 48.03°C       | 17.926%        |