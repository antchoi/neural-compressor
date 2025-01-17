# Getting Started

1. [Quick Samples](#quick-samples)

    1.1 [Quantization with Python API](#quantization-with-python-api)

    1.2 [Quantization with JupyterLab Extension](#quantization-with-jupyterlab-extension)

2. [Validated Models](#validated-models)

## Quick Samples
### Quantization with Python API

```shell
# Install Intel Neural Compressor and TensorFlow
pip install neural-compressor
pip install tensorflow
# Prepare fp32 model
wget https://storage.googleapis.com/intel-optimized-tensorflow/models/v1_6/mobilenet_v1_1.0_224_frozen.pb
```
```python
from neural_compressor.config import PostTrainingQuantConfig
from neural_compressor.data import DataLoader
from neural_compressor.data import Datasets

dataset = Datasets('tensorflow')['dummy'](shape=(1, 224, 224, 3))
dataloader = DataLoader(framework='tensorflow', dataset=dataset)

from neural_compressor.quantization import fit
config = PostTrainingQuantConfig()
q_model = fit(
    model="./mobilenet_v1_1.0_224_frozen.pb",
    conf=config,
    calib_dataloader=dataloader,
    eval_dataloader=dataloader)
```

### Quantization with [JupyterLab Extension](/neural_coder/extensions/neural_compressor_ext_lab/README.md)

Search for ```jupyter-lab-neural-compressor``` in the Extension Manager in JupyterLab and install with one click:

<a target="_blank" href="/neural_coder/extensions/screenshots/extmanager.png">
  <img src="/neural_coder/extensions/screenshots/extmanager.png" alt="Extension" width="35%" height="35%">
</a>

## Validated Models
Intel® Neural Compressor validated the quantization for 10K+ models from popular model hubs (e.g., HuggingFace Transformers, Torchvision, TensorFlow Model Hub, ONNX Model Zoo). 
Over 30 pruning, knowledge distillation and model export samples are also available. 
More details for validated typical models are available [here](/examples/README.md).
