# Daftar Production v4

Bu versiyada frontend mavjud dizaynni saqlaydi, backend esa Node.js + Express + PostgreSQL bilan ishlaydi.

## Arxitektura
- Frontend: `daftar.html`
- Admin: `admin.html`
- Backend: `server.js`
- Database schema: `schema.sql`
- Migration: `migrate.js`
- Admin yaratish: `seed-admin.js`
- Uploadlar: `uploads/`

## Local ishga tushirish
1. Node.js 20+ va PostgreSQL 15+ o‘rnating.
2. `.env.example` nusxasidan `.env` yarating.
3. `DATABASE_URL` ni PostgreSQL manzilingizga moslang.
4. Terminal:

```bash
npm install
npm run migrate
npm run seed-admin
npm start
```

5. Brauzerda `http://localhost:3000` ni oching.
6. Admin panel: `http://localhost:3000/admin.html`

## Docker
```bash
docker compose up
```

Birinchi ishga tushishda database schema va admin avtomatik yaratiladi.

## Muhim
- `daftar.html` ni telefon Files ilovasidan alohida ochsangiz, backend API ishlamaydi. To‘liq sayt server orqali `http://server:3000` manzilidan ochiladi.
- Production'da HTTPS ishlating.
- `ADMIN_PASSWORD`, `PAYMENT_CARD`, `PAYMENT_HOLDER` qiymatlarini `.env` orqali almashtiring.
- To‘lov foydalanuvchi yuborganidan keyin `pending`; obuna faqat admin tasdiqlagach faollashadi.
- Chek rasmi hisob-kitob manbasi emas; attachment sifatida saqlanadi.
- Sotuv tasdiqlanganda ombor qoldig‘i transaction ichida kamayadi.
- Parollar Argon2id bilan hash qilinadi.
- Login sessiyasi HttpOnly cookie orqali ishlaydi.
