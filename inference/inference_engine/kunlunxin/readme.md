## model url
resnet50 onnx url : https://baidu-kunlun-public.su.bcebos.com/XTCL/kunlunxin_flagperf_resnet50.tar.gz

## config example

### host.yaml
VENDOR: "kunlunxin"

### configurations.yaml
compiler: xtcl
no_validation: true
exist_onnx_path: /home/zhoujiamin01/workspace/FlagPerf/inference/onnxs/kunlunxin_flagperf_resnet50/resnet50_pytorch.onnx

