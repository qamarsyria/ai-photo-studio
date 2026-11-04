#!/bin/bash
set -e

echo "🚀 بدء تجهيز استوديو الصور..."

WORK_DIR="${WORK_DIR:-/kaggle/working}"
cd "$WORK_DIR"

# 1. تثبيت ComfyUI
if [ ! -d "ComfyUI" ]; then
    echo "⬇️ تثبيت ComfyUI..."
    git clone https://github.com/comfyanonymous/ComfyUI.git
fi
cd ComfyUI
pip install -r requirements.txt -q

# 2. تثبيت العقد الإضافية
cd custom_nodes
[ ! -d "ComfyUI_IPAdapter_plus" ] && echo "📦 IP-Adapter..." && git clone https://github.com/cubiq/ComfyUI_IPAdapter_plus.git
[ ! -d "ComfyUI-Hy-MT2" ] && echo "📦 مترجم عربي..." && git clone https://github.com/1038lab/ComfyUI-Hy-MT2.git
[ ! -d "ComfyUI-Easy-Use" ] && echo "📦 عقد SVD المبسطة..." && git clone https://github.com/yolain/ComfyUI-Easy-Use.git
cd ..

# 3. تحميل النماذج
mkdir -p models/checkpoints models/ipadapter models/clip_vision models/svd

# نموذج SD1.5 الأساسي
if [ ! -f "models/checkpoints/v1-5-pruned-emaonly.safetensors" ]; then
    echo "⬇️ تحميل SD1.5 (~4GB)..."
    wget -q --show-progress -O models/checkpoints/v1-5-pruned-emaonly.safetensors \
    "https://huggingface.co/runwayml/stable-diffusion-v1-5/resolve/main/v1-5-pruned-emaonly.safetensors"
fi

# نموذج IP-Adapter
if [ ! -f "models/ipadapter/ip-adapter-plus_sd15.safetensors" ]; then
    echo "⬇️ تحميل IP-Adapter..."
    wget -q --show-progress -O models/ipadapter/ip-adapter-plus_sd15.safetensors \
    "https://huggingface.co/h94/IP-Adapter/resolve/main/models/ip-adapter-plus_sd15.safetensors"
fi

# CLIP Vision (ضروري لعمل IP-Adapter)
if [ ! -f "models/clip_vision/CLIP-ViT-H-14.safetensors" ]; then
    echo "⬇️ تحميل CLIP Vision..."
    wget -q --show-progress -O models/clip_vision/CLIP-ViT-H-14.safetensors \
    "https://huggingface.co/h94/IP-Adapter/resolve/main/models/image_encoder/model.safetensors"
fi

# نموذج SVD لتحريك الصور (اختياري، حجمه كبير ~9GB)
if [ "${DOWNLOAD_SVD:-no}" = "yes" ]; then
    if [ ! -f "models/svd/svd_xt.safetensors" ]; then
        echo "⬇️ تحميل SVD (~9GB، قد يأخذ وقتاً)..."
        wget -q --show-progress -O models/svd/svd_xt.safetensors \
        "https://huggingface.co/stabilityai/stable-video-diffusion-img2vid-xt/resolve/main/svd_xt.safetensors"
    fi
fi

echo "✅ اكتمل التجهيز بنجاح!"
