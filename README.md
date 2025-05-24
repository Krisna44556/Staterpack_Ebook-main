
---

## 📚 Staterpack Ebook – Sungokong Book App

**Staterpack Ebook** adalah aplikasi mobile digital library (perpustakaan digital) berbasis **Flutter** dengan backend **Laravel API**, yang mendukung autentikasi user, manajemen buku, peminjaman, rating, dan dashboard admin.

---

### 🚀 Fitur Utama

#### 👤 Autentikasi

* Register dan login dengan Laravel Sanctum
* Logout dengan token revocation

#### 📚 Buku

* List semua buku
* Buku berdasarkan kategori
* Detail buku + rating + review
* Pencarian buku (opsional)

#### 📦 Peminjaman

* Peminjaman dan pengembalian buku
* Riwayat pinjam

#### 🌟 Review & Rating

* User dapat memberi rating dan ulasan buku

#### 🧑‍💼 Admin & Staff (via Web Laravel)

* CRUD Buku
* CRUD Kategori
* Kelola User
* Statistik Peminjaman

---

### 🛠️ Teknologi Digunakan

| Layer      | Teknologi                           |
| ---------- | ----------------------------------- |
| Frontend   | Flutter 3.x                         |
| State Mgmt | Riverpod                            |
| HTTP       | Dio                                 |
| Storage    | Flutter Secure Storage / SharedPref |
| Backend    | Laravel 11                          |
| Auth       | Laravel Sanctum                     |
| DB         | MySQL                               |

---

### 💻 Instalasi Lokal

#### 1. Clone Repository

```bash
git clone https://github.com/dhiljaa/Staterpack_Ebook.git
cd Staterpack_Ebook
```

---

#### 2. Setup Backend (Laravel)

```bash
cd backend  # jika folder backend Laravel ada
composer install
cp .env.example .env
php artisan key:generate

# Setup database (MySQL)
php artisan migrate --seed

# Jalankan server lokal
php artisan serve
```

> ⚠️ Gunakan Laravel Sanctum. Pastikan konfigurasi CORS & `sanctum` middleware aktif.

---

#### 3. Setup Frontend (Flutter)

```bash
cd flutter  # jika ada folder khusus frontend, atau langsung di root
flutter pub get

# Jalankan aplikasi
flutter run
```

> Uji di Android, iOS, atau Web sesuai kebutuhan.

---

### 🔐 Konfigurasi Token

* Login API akan memberikan `token`
* Token disimpan secara lokal di Flutter menggunakan `SharedPreferences`
* Disertakan di header Authorization untuk setiap request:

```http
Authorization: Bearer <token>
```

---

### 📁 Struktur Folder (Flutter)

```bash
lib/
├── core/
│   ├── constants/
│   ├── services/
│   └── utils/
├── features/
│   ├── auth/
│   ├── books/
│   └── profile/
├── models/
├── widgets/
└── main.dart
```

---

### 🧪 Testing

**Laravel API**:

```bash
php artisan test
```

**Flutter**:

```bash
flutter test
```

---

### 📸 Screenshot

*(Tambahkan screenshot aplikasi jika ada)*

---

### 📄 Lisensi

Proyek ini menggunakan lisensi MIT — silakan gunakan dan modifikasi sesuai kebutuhan.

---

Jika kamu ingin, saya bisa bantu **generate badge GitHub**, buat logo sederhana, atau tambahkan **preview gambar/screenshot**.

Apakah struktur folder Laravel dan Flutter kamu dipisah (`/backend` dan `/frontend`) atau satu folder saja?
>>>>>>> 89a7b97933f1b6c6eed7e9d6f46f9842296dcdd2
