FROM nvcr.io/nvidia/deepstream:8.0-triton-arm-sbsa

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
    python3-gi python3-dev python3-gst-1.0 python3-venv \
    gstreamer1.0-tools gstreamer1.0-plugins-good gstreamer1.0-plugins-bad \
    libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev \
    libgstrtspserver-1.0-0 gstreamer1.0-rtsp \
    git wget curl && \
    rm -rf /var/lib/apt/lists/*

# Upgrade TensorRT to 10.15.1 for Blackwell / compute capability 12.1 (GB10)
RUN apt-get update && apt-get install -y --no-install-recommends --allow-downgrades \
    libnvinfer-dispatch10=10.15.1.29-1+cuda13.1 \
    libnvinfer-lean10=10.15.1.29-1+cuda13.1 \
    libnvinfer10=10.15.1.29-1+cuda13.1 \
    libnvinfer-plugin10=10.15.1.29-1+cuda13.1 \
    libnvinfer-vc-plugin10=10.15.1.29-1+cuda13.1 \
    libnvinfer-headers-dev=10.15.1.29-1+cuda13.1 \
    libnvinfer-headers-plugin-dev=10.15.1.29-1+cuda13.1 \
    libnvinfer-dispatch-dev=10.15.1.29-1+cuda13.1 \
    libnvinfer-lean-dev=10.15.1.29-1+cuda13.1 \
    libnvinfer-dev=10.15.1.29-1+cuda13.1 \
    libnvinfer-plugin-dev=10.15.1.29-1+cuda13.1 \
    libnvonnxparsers10=10.15.1.29-1+cuda13.1 \
    libnvonnxparsers-dev=10.15.1.29-1+cuda13.1 \
    tensorrt=10.15.1.29-1+cuda13.1 \
    tensorrt-dev=10.15.1.29-1+cuda13.1 \
    tensorrt-libs=10.15.1.29-1+cuda13.1 && \
    rm -rf /var/lib/apt/lists/*

# Create Python venv with system-site-packages (for gi, gst bindings)
RUN python3 -m venv /opt/ds-venv --system-site-packages

# Install Python bindings and Jupyter
RUN /opt/ds-venv/bin/pip install --no-cache-dir \
    pyds \
    jupyter nbconvert ipykernel

# Clone DeepStream Python apps (provides common utilities like bus_call)
RUN cd /opt/nvidia/deepstream/deepstream-8.0/sources && \
    git clone https://github.com/NVIDIA-AI-IOT/deepstream_python_apps.git

# Copy notebooks, configs, and images
RUN mkdir -p /app/notebooks
COPY notebooks/ /app/notebooks/

WORKDIR /app/notebooks

ENV PATH="/opt/ds-venv/bin:${PATH}"
ENV VIRTUAL_ENV="/opt/ds-venv"

CMD ["jupyter", "notebook", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root", "--NotebookApp.token=''"]
