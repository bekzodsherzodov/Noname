# Daftar — GitHub + Render orqali bepul deploy (eng oson yo'l)

## 1. GitHub'ga yuklash
1. github.com'da ro'yxatdan o'ting (agar hisobingiz bo'lmasa).
2. Yangi repository yarating (masalan "daftar"), **Private** qilib qo'ysangiz bo'ladi.
3. Ushbu papkadagi barcha fayllarni (`.env.example`, `render.yaml` bilan birga) shu repo'ga yuklang:
   - Eng oson: GitHub sahifasida "uploading an existing file" tugmasi orqali papka ichidagi fayllarni drag-drop qiling.
   - Yoki terminal orqali:
     ```
     git init
     git add .
     git commit -m "Daftar - birinchi versiya"
     git branch -M main
     git remote add origin https://github.com/SIZNING_USERNAME/daftar.git
     git push -u origin main
     ```

## 2. Render'da deploy qilish
1. render.com'ga kiring, "Get Started" → GitHub orqali ro'yxatdan o'ting.
2. Dashboard'da **"New +"** → **"Blueprint"** ni tanlang.
3. GitHub'dagi `daftar` repo'ngizni tanlang → Render repo ichidagi `render.yaml` faylini avtomatik topadi va o'qiydi.
4. "Apply" tugmasini bosing — Render Postgres bazani va Node ilovani **o'zi avtomatik yaratadi**.
5. Deploy paytida sizdan quyidagi maxfiy qiymatlarni so'raydi (`sync: false` deb belgilanganlar) — shu yerga kiriting:
   - `PAYMENT_CARD` — to'lov qabul qiladigan karta raqami
   - `PAYMENT_HOLDER` — karta egasining ismi
   - `ADMIN_USERNAME` — admin panel login (masalan: admin)
   - `ADMIN_PASSWORD` — kuchli parol o'ylab toping
6. "Deploy" tugmasini bosing. 2-5 daqiqadan so'ng sayt tayyor bo'ladi.

## 3. Saytga kirish
- Asosiy sayt: `https://daftar-xxxx.onrender.com` (aniq manzilni Render dashboard'da ko'rasiz)
- Admin panel: `https://daftar-xxxx.onrender.com/admin.html`

## Bepul tarifning cheklovlari (bilib qo'ying)
- Ilova 15 daqiqa faoliyatsiz qolsa "uxlab qoladi", keyingi tashrifda 30-50 soniya uyg'onish vaqti ketadi.
- Bepul Postgres baza 90 kundan keyin o'chib ketadi (Render eslatma yuboradi) — shunda yangi baza yaratib, eski ma'lumotni ko'chirish kerak bo'ladi, yoki oyiga ~$7 to'lab doimiy tarifga o'tish mumkin.
- Jiddiy/uzoq muddatli foydalanish uchun pullik tarifga (yoki avvalgi VPS yo'liga) o'tish tavsiya etiladi.

## O'z domeningizni ulash
Render dashboard → Settings → "Custom Domain" → domeningizni kiriting, ko'rsatilgan DNS yozuvini domen provayderingizda sozlang. HTTPS avtomatik qo'shiladi.
