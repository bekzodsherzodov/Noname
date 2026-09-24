# Daftar — VPS'ga joylash yo'riqnomasi

## 1. VPS va domen
- Har qanday provayderdan VPS oling (Timeweb, Beget, Hetzner, DigitalOcean...). Eng arzon tarif (1-2 GB RAM) yetadi. OS: Ubuntu 22.04/24.04.
- Domeningizning **A-yozuvi**ni VPS IP-manzilga yo'naltiring (provayderning DNS panelida).

## 2. Serverga ulanish va Docker o'rnatish
```bash
ssh root@SIZNING_IP
curl -fsSL https://get.docker.com | sh
```

## 3. Fayllarni serverga yuklash
O'z kompyuteringizdan (zip faylni ochib, `daftar` papkasini yuboring):
```bash
scp -r daftar root@SIZNING_IP:/root/
```

## 4. .env faylini sozlash
```bash
cd /root/daftar
cp .env.example .env
nano .env
```
Quyidagilarni albatta o'zgartiring:
- `DB_PASSWORD` — kuchli, tasodifiy parol
- `ADMIN_PASSWORD` — admin panel uchun kuchli parol
- `ADMIN_USERNAME` — xohlasangiz o'zgartiring
- `PAYMENT_CARD`, `PAYMENT_HOLDER` — to'lov qabul qiladigan karta va egasining ismi

## 5. Domenni Caddyfile'ga yozish
```bash
nano Caddyfile
```
`domeningiz.uz` yozuvini o'z domeningizga almashtiring (masalan `daftar.uz`).

## 6. Ishga tushirish
```bash
docker compose up -d
```
Bir necha soniyadan so'ng:
- Caddy domeningiz uchun avtomatik HTTPS sertifikat oladi (Let's Encrypt).
- `https://domeningiz.uz` — asosiy sayt
- `https://domeningiz.uz/admin.html` — admin panel (login: `.env`dagi `ADMIN_USERNAME`/`ADMIN_PASSWORD`)

## 7. Tekshirish
```bash
docker compose logs -f app
```
Xatolik bo'lmasa, "Daftar running on http://localhost:3000" ko'rinadi.

## Yangilash (kelajakda kod o'zgarsa)
```bash
cd /root/daftar
# yangi fayllarni almashtiring, so'ng:
docker compose up -d --build
```

## Zaxira nusxa (backup)
Ma'lumotlar bazasi `postgres_data` nomli Docker volume'da saqlanadi. Vaqti-vaqti bilan zaxira oling:
```bash
docker compose exec db pg_dump -U daftar daftar > backup-$(date +%F).sql
```

## Muhim eslatmalar
- `.env` faylini hech qachon ochiq joyga (GitHub public repo va h.k.) qo'ymang.
- Firewall'da faqat 22 (SSH), 80, 443 portlarini oching.
- Domen DNS o'zgarishi ba'zan 10-30 daqiqa vaqt olishi mumkin — shuncha kutib qayta urinib ko'ring.
