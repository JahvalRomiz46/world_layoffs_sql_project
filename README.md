# Analisis Data PHK Global (World Layoffs) 📉

## Deskripsi Proyek
Proyek ini merupakan proyek analisis data PHK Global dari dataset [World Layoffs](https://www.kaggle.com/datasets/previnpillay/world-layoffs-2020-2023) tahun 2020-2023. Tujuan utamanya adalah untuk membersihkan data, mengidentifikasi trend, dan menemukan insights penting terkait PHK yang terjadi di berbagai perusahaan, industri, dan negara di seluruh dunia. Seluruh proses, mulai dari pembersihan data hingga analisis, dilakukan menggunakan SQL, dan visualisasi menggunakan Tableau. 

---

## Teknologi yang Digunakan
* **SQL (MySQL)**: Digunakan untuk seluruh proses pembersihan dan analisis data.
* **MySQL Workbench**: Digunakan sebagai *client* untuk menjalankan *query*.
* **Tableau**: Digunakan untuk visualisasi hasil query dalam bentuk dashboard.

---

## Folders
* `sql_scripts`: Berisi semua *query* SQL untuk membersihkan & menganalisis dataset.
* `visualization`: Berisi file Tableau & Gambar dashboard hasil visualisasi insight.
* `query_table_results` : Berisi file csv hasil output tabel dari query SQL. 

---

## Proses Analisis
Proyek ini dibagi menjadi dua tahapan:

### 1. Data Cleaning
* **Penghapusan Duplikat**: Mengidentifikasi dan menghapus baris duplikat yang tidak perlu.
* **Standardisasi Data**: Merapikan inkonsistensi penulisan.
* **Penanganan Nilai Null dan Blank**: Mengisi nilai `NULL` atau blank berdasarkan informasi dari baris lain.
* **Konversi Tipe Data**: Mengubah tipe data kolom `date` dari `TEXT` menjadi `DATE` untuk memudahkan analisis.
* **Penghapusan Baris dan Kolom yang Tidak Relevan**: Menghapus baris yang memiliki nilai null di kedua kolom `total_laid_off` dan `percentage_laid_off` karena tidak memiliki informasi.

### 2. Data Analysis
* Membuat analisis *rolling total* untuk melihat akumulasi total PHK dari bulan ke bulan.
* Mengidentifikasi perusahaan, industri, negara, dan stage dengan jumlah PHK tertinggi.
* Mengidentifikasi industri & stage yang banyak mengalami kegagalan total yang mem-PHK seluruh karyawannya. 

---

## Dashboard
Dashboard ini juga bisa diakses di: [Tableau Public](https://www.kaggle.com/datasets/previnpillay/world-layoffs-2020-2023)
<img src="visualization/World Layoffs Trend Dashboard.png" alt="World Layoffs Trend Dashboard" width="1000">

---

## Key Insights
* Dari grafik Layoffs Over Time ditemukan Tren PHK yang menunjukkan kenaikan signifikan pada Q4 tahun 2022 yang mengindikasikan fenomena pasar sebagai respos terhadap kondisi ekonomi makro.
* Dari Map persebaran data PHK Global ditemukan bahwa tren PHK ini terjadi di banyak belahan dunia, dengan volume tertinggi terlihat di negara United States.
* Dari rentang tahun 2020 hingga 2023, Amazon, Google, Meta, Microsoft, dan Salesforce merupakan 5 perusahaan teratas dengan total karyawan yang di-PHK terbanyak.
* Industri Consumer dan Retail menjadi penyumbang volume PHK total tertinggi secara keseluruhan.
* Perusahaan dengan stage Post-IPO memiliki frekuensi lebih banyak dibanding stage lain. Ini menunjukkan bahwa perusahaan dengan tahap Post IPO cenderung lebih sering melakukan PHK terhadap karyawannya.
* Grafik Treemap menunjukkan bahwa sektor industri yang melakukan PHK terhadap seluruh karyawannya didominasi oleh perusahaan dengan tahap pendanaan awal (Seed hingga Series B), yang umumnya memiliki risiko kegagalan usaha lebih tinggi.

---

## Conclusion
Proyek World Layoffs Analysis ini memberikan pemahaman menyeluruh tentang bagaimana tren PHK global berkembang dari tahun 2020 hingga 2023 di berbagai belahan dunia, sektor industri, dan tahap pendanaan perusahaan. Melalui proses ini, saya berhasil mempraktikkan keterampilan analisis data end-to-end menggunakan SQL dan Tableau.

Dari sisi teknis, proyek ini memperkuat kemampuan saya dalam:
* Advanced SQL Querying, termasuk data cleaning, aggregation, window functions, dan CTE (Common Table Expressions) untuk eksplorasi data mendalam.
* Data Cleaning & Transformation, seperti penghapusan duplikat, penanganan nilai NULL, dan konversi tipe data untuk memastikan kualitas dataset.
* Data Visualization dengan Tableau, dalam membangun dashboard yang menampilkan insight dari hasil analisis SQL.

Dari sisi analitis, proyek ini mengajarkan saya pentingnya:
* Memahami konteks bisnis di balik data, seperti keterkaitan antara tahap pendanaan dan risiko PHK.
* Menerjemahkan analisis data menjadi insight yang bermakna.
* Membuat visualisasi yang informatif dan dapat dipahami oleh audiens non-teknis.
