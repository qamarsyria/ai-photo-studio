# 🎨 استوديو الصور الشخصي بالذكاء الاصطناعي

مستودع مفتوح المصدر لتشغيل ComfyUI مع أدوات:
- وضع وجهك في مشاهد جديدة (IP-Adapter)
- ترجمة تلقائية من العربية (Hy-MT2)
- تحريك الصور لاحقاً (SVD)

## 🚀 طريقة التشغيل (على Kaggle أو أي سيرفر GPU)

### 1. على Kaggle:
- أنشئ Notebook جديد
- فعّل GPU T4 x2 + Internet On
- الصق في خلية:

\`\`\`bash
!git clone https://github.com/USERNAME/ai-photo-studio.git
!bash ai-photo-studio/setup.sh
\`\`\`

### 2. لتشغيل الواجهة:
في خلية جديدة:

\`\`\`bash
!bash ai-photo-studio/run.sh
\`\`\`

انسخ رابط Pinggy وافتحه في متصفح جوالك.

## 📦 ما يثبته المشروع
- ComfyUI
- IP-Adapter Plus (SD1.5)
- Hy-MT2 (ترجمة 38 لغة منها العربية)
- عقد SVD المبسطة

## ⚠️ ملاحظات
- نموذج SVD كبير (~9GB) ولا يُحمّل افتراضياً. لتحميله:
  \`DOWNLOAD_SVD=yes bash setup.sh\`
- احفظ أعمالك قبل انتهاء جلسة Kaggle.
