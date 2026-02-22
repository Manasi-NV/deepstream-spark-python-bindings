# DeepStream 8.0 Python Bindings — NVIDIA DGX Spark

Jupyter notebooks for building DeepStream 8.0 video analytics pipelines with Python on the **NVIDIA DGX Spark**.

## Getting Started

### Pre-built image

```bash
docker pull manasi1096/deepstream8-python:gb10
docker run --gpus all -it --rm -p 8888:8888 manasi1096/deepstream8-python:gb10 \
  bash -c "source /opt/ds-venv/bin/activate && jupyter notebook --ip=0.0.0.0 --port=8888 --no-browser --allow-root --NotebookApp.token='' --notebook-dir=/app/notebooks"
```

Open http://localhost:8888 in your browser.

### Build from source

```bash
git clone https://github.com/Manasi-NV/deepstream-spark-python-bindings.git
cd deepstream-spark-python-bindings
docker build -t deepstream-spark-python .
docker run --gpus all -it --rm -p 8888:8888 deepstream-spark-python
```

> TensorRT engines are built automatically on first run (~5 min) and cached for subsequent runs.

## Notebooks

| Notebook | Description |
|----------|-------------|
| `Introduction_to_Deepstream_and_Gstreamer.ipynb` | DeepStream SDK overview and GStreamer foundation concepts |
| `Getting_started_with_Deepstream_Pipeline.ipynb` | Plugin walkthrough and building a 4-class detection pipeline |
| `object_detection.ipynb` | Single-stream object detection with H.264 hardware encoding |
| `object_detection_and_tracking_classification.ipynb` | Detection + tracking + secondary classifiers (vehicle make & type) |
| `object_detection_multistream.ipynb` | Multi-stream (2x) detection with tiled side-by-side output |

## License

Creative Commons Attribution 4.0 International (CC BY 4.0)
