# TenfoldLit: Read and Explore 📚

## 👥 Nama Anggota Kelompok A10 👥 : 
* [Rumintang Jessica Hutagaol](https://github.com/Rumintangjsi) (2206083180)
* [Vico Adli Narindra](https://github.com/VicoAdli) (2206083016)
* [Nadhira Raihana Hafez](https://github.com/nadriha) (2206082000)
* [Caressa Putri Yuliantoro](https://github.com/caressaputri) (2206081742)
* [Muhammad Nabiel Subhan](https://github.com/nabielsubhan) (2206081553)

## 📔 Latar Belakang TenfoldLit 📔 :
Gita adalah seorang anak yang sangat mencintai dunia literatur. Ia sering menghabiskan waktu di perpustakaan sekolahnya, membaca buku-buku berbagai genre, dan selalu mencari rekomendasi buku baru. Namun, Gita merasa kesulitan untuk menemukan ulasan buku yang akurat dan komentar dari para pembaca yang dapat membantu dalam memilih buku untuk dibaca. Itulah sampai akhirnya dia menemukan TenfoldLit, sebuah web aplikasi Django yang menyediakan semua yang ia butuhkan. <br>

TenfoldLit memungkinkan pengguna untuk melihat ulasan buku dari berbagai genre, serta membaca komentar dari pembaca lainnya. Gita dapat menjadi anggota dan memberikan review serta komentar, dan yang lebih penting, dia dapat memberikan rating kepada buku-buku yang telah dia baca. Ia juga senang bahwa web ini memungkinkan pengguna untuk meminjam buku, melihat stok buku, dan menyimpan buku favoritnya dalam daftar favorit sehingga ia mampu menyusun daftar bacaan selanjutnya dengan lebih mudah. Dengan TenfoldLit, Gita merasa lebih terhubung dengan komunitas pembaca yang sama-sama bersemangat tentang literatur, dan pengalaman membacanya menjadi lebih menyenangkan.

Tidak hanya itu, Gita juga menemukan kepraktisan TenfoldLit karena sudah dapat diakses melalui aplikasi mobile. Dengan begitu, Gita bisa tetap terhubung dengan dunia literatur favoritnya di mana saja dan kapan saja tanpa perlu membuka komputer. Dengan akses yang lebih mudah dan cepat, Gita merasa semakin terintegrasikan dengan komunitas pembaca TenfoldLit, menjadikan pengalaman literaturnya semakin dinamis dan menyenangkan.

## 🗂️ Daftar Modul 🗂️ 
Berikut ini beberapa fitur yang disediakan pada aplikasi TenfoldLit:
### 🏠 Homepage (Caressa Putri Yuliantoro) :
* Tampilan beranda yang menampilkan daftar buku.
* Ditampilkan opsi pencarian buku.
* Filter berdasarkan rating, yang paling banyak dicari, atau yang baru diunggah.

### 👤 Login Page (Muhammad Nabiel Subhan):
* Halaman login yang memungkinkan pengguna masuk ke akun mereka.
* Halaman registrasi bagi pengguna yang belum memiliki akun.

### 🔎 Search and Filters (Rumintang Jessica Hutagaol):
* Halaman pencarian yang menampilkan hasil pencarian buku berdasarkan kata kunci, judul, penulis, atau kategori.
* Filter untuk mengurutkan berdasarkan yang paling banyak dicari, atau yang baru diunggah.
* Form pencarian untuk mencari buku berdasarkan kata kunci atau kriteria lainnya.

### 📱 Catalog and Favorites (Vico Adli Narindra):
* Menampilkan halaman katalog buku yang dapat diakses oleh semua pengguna.
* Menandai buku agar masuk dalam kategori favorit pengguna dan menampilkan halaman untuk menampilkan buku favorit
* Form untuk menambah dan menghapus buku favorit dari katalog pribadi pengguna.

### ⭐️ Review and Ratings (Vico Adli Narindra):
* Halaman untuk menampilkan ulasan dan peringkat yang diberikan oleh pengguna pada buku tertentu.
* Form untuk pengguna memberikan ulasan dan peringkat pada buku.

### 📒 My Books (Nadhira Raihana Hafez):
* Halaman User Library untuk menampilkan buku yang dipinjam oleh user.
* Halaman User Favorite untuk menampilkan buku yang di favorite oleh user
* Menampilkan halaman katalog pribadi (My Library) yang memungkinkan pengguna menyusun katalog buku pribadi mereka sendiri.
* Form untuk menambah dan menghapus buku yang dipinjam dari katalog pribadi pengguna.

### 👫 Friends (Muhammad Nabiel Subhan):
* Halaman untuk untuk menampilkan friends yang dimiliki oleh user.
* Berfungsi untuk membuat hubungan dengan user lain sehingga bisa melihat buku favorit dan buku yang sedang dipinjam oleh user tersebut.
* Dapat mencari nama suatu user untuk mem-follow mereka.

## 📂 Sumber Dataset:
https://www.kaggle.com/datasets/mdhamani/goodreads-books-100k

## 👩🏻👱🏻‍♂️ Role atau peran pengguna beserta deskripsinya: 
* Admin
    * Pengguna dapat menambah, menghapus, dan mengupdate data buku pada aplikasi.
* End User
    * Pengguna yang telah mendaftarkan diri dapat menggunakan semua fitur pada aplikasi, seperti meminjam buku, menambahkan buku ke daftar favorit pengguna, memberikan review dan ratings, dan mengakses halaman katalog pribadi.
* Guest
    * Pengguna yang belum mendaftarkan diri hanya bisa melihat daftar buku dan review yang ada pada buku tersebut tanpa bisa mengakses fitur lain yang tersedia.

## 📑 Berita Acara 📑
[Berita Acara A10](https://docs.google.com/spreadsheets/d/1azkHBVeqnpd1yoqG0f9LsqfLRf2LzaDq/edit#gid=2120975129)

## 🔃 Alur Pengintegrasian 🔃
* Menambahkan dependensi http ke proyek yang akan digunakan untuk bertukar HTTP request.
* Membuat model pada Flutter yang sesuai dengan struktur data yang dikirim oleh API.
* Membuat http request ke web service menggunakan dependensi http.
* Mengonversikan data dari JSON ke objek model Flutter yang telah dibuat pada tahap ke dua.
* Menggunakan widget seperti `FutureBuilder`untuk menampilkan data yang diterima dari API 

[![Build status](https://build.appcenter.ms/v0.1/apps/4f741de7-dd1d-49b5-98a5-886ae6f8b4df/branches/main/badge)](https://appcenter.ms)
