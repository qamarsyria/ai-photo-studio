#!/bin/bash
set -e

WORK_DIR="${WORK_DIR:-/kaggle/working}"
cd "$WORK_DIR/ComfyUI"

echo "🎬 تشغيل ComfyUI..."
python main.py --listen 0.0.0.0 --port 8188 &
COMFY_PID=$!
sleep 12

echo ""
echo "=========================================="
echo "🔗 انسخ الرابط أدناه وافتحه في متصفح جوالك:"
echo "=========================================="
ssh -p 443 -o StrictHostKeyChecking=no -R0:localhost:8188 a.pinggy.io

# عند إغلاق النفق، أوقف ComfyUI
kill $COMFY_PID 2>/dev/null || true
