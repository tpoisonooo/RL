NVIDIA_HOME=/fs-computility/ai4agr/konghuanjun/RL/.venv/lib/python3.12/site-packages/nvidia/
export CPLUS_INCLUDE_PATH=$NVIDIA_HOME/cudnn/include:$CPLUS_INCLUDE_PATH
export C_INLUCDE_PATH=$NVIDIA_HOME/cudnn/include:$C_INLUCDE_PATH
export LD_LIBRARY_PATH="/fs-computility/ai4agr/konghuanjun/RL/.venv/lib/python3.12/site-packages/nvidia/cudnn/lib":${LD_LIBRARY_PATH}

export NRL_VLLM_ASYNC_TIMEOUT_SECONDS=1800
export UV_PYTHON_INSTALL_MIRROR="https://mirror.nju.edu.cn/github-release/indygreg/python-build-standalone"

uv python install 3.12.11
uv sync --extra mcore --verbose

NRL_FORCE_REBUILD_VENVS=true uv run examples/run_grpo.py ...

NVCC_APPEND_FLAGS="--threads 56" uv pip install -v \
    --disable-pip-version-check \
    --no-cache-dir \
    --no-build-isolation \
    --verbose \
    --config-setting '"--build-option=--cpp_ext --cuda_ext --parallel 56"' \
    git+http://ghfast.top/https://github.com/NVIDIA/apex.git@master


NVCC_APPEND_FLAGS="--threads 32" uv pip install -v \
    --disable-pip-version-check \
    --no-cache-dir \
    --no-build-isolation \
    --config-setting '"--build-option=--cpp_ext --cuda_ext --parallel 32"' \
    git+file:///fs-computility/ai4agr/konghuanjun/RL/3rdparty/apex

NVCC_APPEND_FLAGS="--threads 32" uv pip install -v \
    --disable-pip-version-check \
    --no-cache-dir \
    --no-build-isolation \
    --config-setting '"--build-option=--cpp_ext --cuda_ext --parallel 32"' \
    git+file:///fs-computility/ai4agr/konghuanjun/RL/3rdparty/apex