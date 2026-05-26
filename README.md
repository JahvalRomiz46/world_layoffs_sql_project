# 📉 World Layoffs Analysis (2020-2023)

<img src="visualization/World Layoffs Trend Dashboard.png" alt="World Layoffs Trend Dashboard" width="1000">

*[Klik di sini](https://public.tableau.com/views/WorldLayoffsTrend2020-2023/Dashboard?:language=en-US&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link) untuk mengakses/demo dashboard dari tableau public*

## 📌 Business Context

Pasca-pandemi, ekonomi global mengalami koreksi besar-besaran yang memicu gelombang pemutusan hubungan kerja (PHK), khususnya di sektor teknologi. Fenomena ini menciptakan ketidakpastian sekaligus peluang bagi investor, tim rekrutmen, dan pencari kerja.

Project ini mensimulasikan peran Data Analyst di firma konsultasi SDM/Investasi. Tujuannya adalah menganalisis dataset **World Layoffs (2020-2023)** untuk membedakan antara perusahaan yang melakukan efisiensi operasional versus perusahaan yang mengalami kegagalan total, serta mengidentifikasi sektor industri dan tahap perkembangan perusahaan mana yang paling rentan terhadap guncangan ekonomi makro.

## 🎯 Pertanyaan Analisis

1. Bagaimana tren keseluruhan PHK berubah dari waktu ke waktu?
2. Perusahaan mana yang memiliki total PHK tertinggi di setiap tahunnya?
3. Industri mana yang paling banyak mengalami PHK selama periode data?
4. Industri dan tahap perusahaan mana yang paling banyak mengalami kegagalan total (100% layoffs)?
5. Di tahap perkembangan perusahaan mana PHK paling sering terjadi?

## 💡 Key Findings (Executive Summary)

| Temuan | Detail |
|---|---|
| **Puncak krisis PHK** | Q4 2022 hingga Q1 2023, jauh melampaui dampak awal COVID-19 |
| **Perusahaan PHK terbesar** | Amazon, Google, Meta (masing-masing >10.000 karyawan) |
| **Industri paling terdampak** | Consumer & Retail dengan total lebih dari 88.000 PHK |
| **Sektor dengan kegagalan total tertinggi** | Food, Retail, dan Education didominasi startup Seed hingga Series B |
| **Negara dengan PHK terbanyak** | Amerika Serikat |

> 🔑 **Insight utama:** Terdapat dua pola PHK yang sangat berbeda. Big Tech seperti Amazon dan Google melakukan PHK parsial sebagai bentuk efisiensi dan tetap beroperasi. Sebaliknya, startup tahap awal di sektor Food dan Retail justru melakukan PHK 100% yang berarti penutupan bisnis secara total. Keduanya tidak bisa dianalisis dengan cara yang sama.

## 📊 Rekomendasi untuk Stakeholders

**Untuk Tim Talent Acquisition:**
Gelombang PHK massal di Q1 2023 dari perusahaan seperti Amazon, Google, dan Meta menghasilkan talent pool berkualitas tinggi di pasar tenaga kerja. Ini adalah momen yang tepat untuk merekrut talenta senior teknologi dengan biaya yang lebih kompetitif sebelum kondisi pasar kembali pulih.

**Untuk Investor (Venture Capital):**
Data menunjukkan tingkat mortalitas (100% layoffs) tertinggi berada pada startup Seed hingga Series B di sektor Food Delivery dan Retail. Hindari investasi agresif pada segmen ini saat kondisi makroekonomi tidak stabil. Perusahaan Post-IPO yang melakukan PHK tetap menunjukkan stabilitas operasional dan lebih aman sebagai aset portofolio jangka menengah.

**Untuk Job Seekers:**
Hindari bergabung dengan startup Series A/B di sektor ritel saat ekonomi sedang tertekan. PHK di perusahaan korporasi besar cenderung bersifat parsial dan operasional tetap berjalan, sedangkan di startup tahap awal, PHK seringkali berarti penutupan bisnis secara total.

## 🛠️ Tech Stack & Metodologi

| Tahap | Tools | Teknik yang Digunakan |
|---|---|---|
| **Data Cleaning** | SQL (MySQL) | Staging Tables, ROW_NUMBER untuk deduplikasi, Self JOIN untuk imputasi null, STR_TO_DATE untuk konversi tipe |
| **Exploratory Data Analysis** | SQL (MySQL) | CTEs, Window Functions (DENSE_RANK, SUM OVER), Rolling Total, Ranking per tahun |
| **Visualisasi** | Tableau Public | Dashboard interaktif dengan KPI makro dan filter dinamis |

**Alur kerja:** Raw Data → Staging Table (SQL Cleaning) → Cleaned Table → EDA & Analysis → Tableau Dashboard

## ⚙️ Proses Analisis

### 1. Data Cleaning (SQL)

Dataset mentah mengandung beberapa masalah kualitas data yang harus diselesaikan sebelum analisis:

**Tahap 1 — Remove Duplicates:** Membuat staging table sebagai salinan data asli agar data mentah tidak termodifikasi. Menggunakan fungsi ROW_NUMBER dengan PARTITION BY seluruh kolom untuk mengidentifikasi dan menghapus baris duplikat.

**Tahap 2 — Standardize Data:** Membersihkan whitespace dengan TRIM, menyatukan penulisan yang tidak konsisten (contoh: "Crypto", "Crypto Currency", dan "CryptoCurrency" disatukan menjadi "Crypto"), serta memperbaiki penulisan "United States." yang memiliki titik di akhir. Kolom tanggal yang masih bertipe text dikonversi ke format DATE menggunakan STR_TO_DATE.

**Tahap 3 — Null & Blank Handling:** Nilai kosong pada kolom industry diisi menggunakan teknik Self JOIN — mencari baris lain milik perusahaan yang sama yang memiliki informasi industri, lalu menggunakannya untuk mengisi baris yang kosong. Baris yang tidak memiliki nilai di kedua kolom kunci (total_laid_off dan percentage_laid_off) dihapus karena tidak dapat digunakan untuk analisis.

**Tahap 4 — Remove Unnecessary Columns:** Kolom row_num yang dibuat khusus untuk proses deduplikasi dihapus dari tabel final setelah tidak lagi dibutuhkan.

### 2. Exploratory Data Analysis (SQL)

Analisis dilakukan dengan 5 pertanyaan utama menggunakan teknik SQL tingkat lanjut:

- **Tren PHK over time:** Menghitung rolling total PHK per bulan menggunakan CTE dan Window Function SUM OVER untuk melihat akumulasi PHK secara beruntun.
- **Ranking perusahaan per tahun:** Menggunakan DENSE_RANK dengan PARTITION BY tahun untuk mengidentifikasi Top 5 perusahaan dengan PHK terbesar di setiap tahunnya secara terpisah.
- **Analisis industri:** Mengidentifikasi industri dengan total PHK tertinggi secara keseluruhan maupun per tahun menggunakan teknik ranking yang sama.
- **Analisis kegagalan total:** Memfilter perusahaan dengan percentage_laid_off = 1 (tutup total), lalu mengelompokkannya berdasarkan industri dan stage untuk mengidentifikasi pola risiko kebangkrutan.
- **Analisis tahap perusahaan:** Membandingkan frekuensi dan volume PHK berdasarkan tahap perkembangan perusahaan (Seed, Series A/B, hingga Post-IPO) per tahunnya.

### 3. Visualisasi (Tableau)

Hasil analisis SQL divisualisasikan dalam sebuah dashboard interaktif di Tableau Public yang menampilkan tren PHK dari waktu ke waktu, perbandingan Top 5 industri, dan distribusi PHK berdasarkan tahap perusahaan.


## 📁 Struktur Repositori

| File / Folder | Keterangan |
|---|---|
| query_table_results | File CSV berisi tabel dari hasil query |
| sql_scripts/world_layoffs_data_cleaning.sql | Query lengkap proses data cleaning 4 tahap |
| sql_scripts/world_layoffs_eda.sql | Query EDA dengan 5 pertanyaan analisis utama |
| visualization/ | File gambar dashboard dan Tableau workbook |
| dataset/ | Raw data (CSV) sebelum dan sesudah diproses |

## 📚 Apa yang Saya Pelajari

- Pentingnya menggunakan **staging table** dalam proses cleaning agar data mentah asli tidak termodifikasi dan tetap bisa dijadikan referensi
- Teknik deduplikasi menggunakan ROW_NUMBER yang efektif dibandingkan hanya menggunakan DISTINCT
- Cara mengisi nilai NULL yang unik dengan menggunakan Self JOIN berdasarkan konteks data yang tersedia di baris lain
- Penggunaan CTEs dan Window Functions untuk analisis tren dan ranking yang tidak bisa dilakukan dengan query sederhana
- Membaca data PHK tidak cukup dari satu sisi saja — volume PHK besar tidak selalu berarti perusahaan dalam bahaya, dan PHK kecil tidak selalu berarti aman

*Disclaimer: Project ini menggunakan dataset publik [World Layoffs 2020-2023](https://www.kaggle.com/datasets/previnpillay/world-layoffs-2020-2023) sebagai materi latihan Data Analysis dan Business Intelligence.*
