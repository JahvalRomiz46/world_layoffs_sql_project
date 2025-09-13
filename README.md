# Analisis Data PHK Global (World Layoffs) dengan SQL 📉

<br>

## Deskripsi Proyek
Proyek ini merupakan **proyek data cleaning dan Exploratory Data Analysis/EDA** dari dataset PHK global `[World Layoffs](https://www.kaggle.com/datasets/previnpillay/world-layoffs-2020-2023)` tahun 2020-2023 menggunakan SQL. Tujuan utamanya adalah untuk membersihkan data, mengidentifikasi trend, dan menemukan insights penting terkait PHK yang terjadi di berbagai perusahaan, industri, dan negara di seluruh dunia. Seluruh proses, mulai dari pembersihan data hingga analisis, dilakukan hanya menggunakan SQL. 

---

## Pertanyaan Bisnis & Analisis
* Bagaimana tren PHK dari tahun ke tahun dan dari bulan ke bulan?
* Sektor industri dan negara mana yang paling terdampak oleh PHK?
* Perusahaan apa saja yang mem-PHK karyawannya dalam jumlah besar?
* Apakah ada perusahaan yang melakukan PHK terhadap seluruh karyawannya?

---

## Teknologi yang Digunakan
* **SQL (MySQL)**: Digunakan untuk seluruh proses pembersihan dan analisis data.
* **MySQL Workbench**: Digunakan sebagai *client* untuk menjalankan *query*.

---

## Struktur Repositori
* `world_layoffs_data_cleaning.sql`: Berisi semua *query* SQL untuk membersihkan dataset.
* `world_layoffs_eda.sql`: Berisi semua *query* SQL untuk analisis eksplorasi data.

---

## Proses Analisis
Proyek ini dibagi menjadi dua tahapan:

### 1. Data Cleaning
* **Penghapusan Duplikat**: Mengidentifikasi dan menghapus baris duplikat yang tidak perlu.
* **Standardisasi Data**: Merapikan inkonsistensi penulisan.
* **Penanganan Nilai Null dan Blank**: Mengisi nilai `NULL` atau blank berdasarkan informasi dari baris lain.
* **Konversi Tipe Data**: Mengubah tipe data kolom `date` dari `TEXT` menjadi `DATE` untuk memudahkan analisis.
* **Penghapusan Baris dan Kolom yang Tidak Relevan**: Menghapus baris yang memiliki nilai null di kedua kolom `total_laid_off` dan `percentage_laid_off` karena tidak memiliki informasi.

### 2. Exploratory Data Analysis (EDA)
* Mencari tahu perusahaan mana yang mem-PHK seluruh karyawannya.
* Mengidentifikasi perusahaan, industri, dan negara dengan jumlah PHK tertinggi.
* Menganalisis total PHK per tahun dan per bulan untuk melihat tren dari waktu ke waktu.
* Membuat analisis *rolling total* untuk melihat akumulasi total PHK dari bulan ke bulan.
* Meranking 5 perusahaan teratas dengan jumlah PHK terbanyak di setiap tahunnya.

---

## Key Insights
* **Tren PHK**: Tren PHK menunjukkan kenaikan signifikan, terutama pada periode awal pandemi dan mencapai puncaknya di tahun 2023.
* **Industri Paling Terdampak**: Sektor industri **Consumer** dan **Retail** menunjukkan jumlah PHK tertinggi secara keseluruhan.
* **Negara Paling Terdampak**: **United States** adalah negara dengan jumlah PHK tertinggi yang jauh melampaui negara lain.
* **Perusahaan Terbesar**: Perusahaan seperti **Amazon**, **Google**, dan **Meta** termasuk dalam 5 perusahaan teratas yang melakukan PHK terbesar di beberapa tahun terakhir dalam rentang tahun data.

---

## Kesimpulan
Proyek ini berhasil melakukan **pembersihan data**  untuk analisis dan **exploratory data analysis** menggunakan SQL. Data yang sudah bersih memungkinkan kita untuk menarik kesimpulan yang akurat tentang tren PHK global dan mengidentifikasi sektor serta perusahaan yang paling terdampak.

Proyek ini dapat dikembangkan lebih lanjut dengan menghubungkan hasil analisis ke *tools* visualisasi data seperti **Tableau** atau **Power BI** untuk menyajikan temuan secara lebih interaktif dan menarik.
