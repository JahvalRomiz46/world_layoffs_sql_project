



# 📉 World Layoffs Analysis (2020-2023)

<img src="visualization/World Layoffs Trend Dashboard.png" alt="World Layoffs Trend Dashboard" width="1000">

*[Klik di sini](https://public.tableau.com/views/WorldLayoffsTrend2020-2023/Dashboard?:language=en-US&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link) untuk demo dashboard*

## Business Context
Pasca-pandemi, ekonomi global mengalami koreksi besar-besaran yang memicu gelombang pemutusan hubungan kerja (PHK), khususnya di sektor teknologi. Fenomena ini menciptakan ketidakpastian bagi investor dan pencari kerja.

Project ini mensimulasikan peran Data Analyst di firma konsultasi SDM/Investasi. Tujuannya adalah menganalisis dataset *World Layoffs* untuk membedakan antara perusahaan yang melakukan efisiensi vs perusahaan yang mengalami kebangkrutan, serta mengidentifikasi sektor industri mana yang paling rentan terhadap guncangan ekonomi makro.

## Problem Statement & Objectives
Tantangan utama dalam dataset ini adalah data mentah yang tidak terstruktur (duplikat, null values, inkonsistensi nama perusahaan). Project ini bertujuan untuk:
1.  **Data Quality Assurance:** Membersihkan data kotor menggunakan SQL (Cleaning, Standardizing, Null Handling) untuk memastikan akurasi analisis.
2.  **Market Trend Analysis:** Mengidentifikasi kapan "puncak krisis" terjadi.
3.  **Risk Assessment:** Membandingkan profil risiko antara perusahaan Raksasa (Post-IPO) dengan Startup (Seed-Series B).

## Tools & Methodology
-   **Data Processing:** SQL (MySQL) - Menggunakan teknik *CTEs*, *Window Functions*, dan *Staging Tables* untuk pembersihan data tingkat lanjut.
-   **Visualization:** Tableau - Membuat dashboard interaktif untuk monitoring KPI makro.
-   **Workflow:** Raw Data $\rightarrow$ Staging (SQL Cleaning) $\rightarrow$ Final Analysis $\rightarrow$ Tableau Visualization.

## Key Insights (Executive Summary)
Berdasarkan analisis terhadap data [World Layoffs](https://www.kaggle.com/datasets/previnpillay/world-layoffs-2020-2023) 2020-2023, ditemukan pola kritis sebagai berikut:

### 1. Lonjakan Layoff Global (Q4 2022 - Q1 2023)
Grafik *Layoffs Over Time* menunjukkan lonjakan ekstrem pada akhir 2022 hingga awal 2023. Ini mengindikasikan bahwa mayoritas perusahaan melakukan restrukturisasi anggaran secara serentak sebagai respon terhadap isu resesi global, jauh melampaui dampak awal COVID-19 di tahun 2020.

### 2. Big Tech vs. Startup
* **Volume Terbesar (Big Tech):** Perusahaan Post-IPO seperti Amazon, Google, dan Meta menyumbang angka PHK terbesar dengan total PHK >40.000 karyawan. Namun, ini umumnya bersifat *trimming*/pengurangan sebagian.
* **Risiko Kebangkrutan (Startups):** Analisis pada perusahaan yang melakukan **100% Layoffs** (tutup total) didominasi oleh startup tahap awal (*Seed* hingga *Series B*), khususnya di sektor **Food, Retail, dan Education**.

### 3. Sektor Consumer & Retail Paling Terdampak
Dua industri ini memuncaki grafik *Top 5 Industry* dengan total lebih dari 88.000 PHK. Hal ini berkorelasi langsung dengan penurunan daya beli masyarakat (inflasi) yang memaksa perusahaan B2C memangkas operasional secara agresif.

## Recommendations
Berdasarkan data di atas, berikut adalah rekomendasi untuk stakeholders:

* **Untuk Talent Acquisition (Hiring):**
    * Terdapat *talent pool* berkualitas tinggi (eks-Amazon, Google, Meta) yang masuk ke pasar tenaga kerja secara massal di Q1 2023. Ini adalah momen tepat untuk merekrut talenta senior teknologi dengan biaya yang lebih kompetitif.
* **Untuk Investor (Venture Capital):**
    * Hindari investasi agresif pada startup *Seed-Stage* di sektor **Food Delivery** dan **Retail** karena data menunjukkan sektor ini memiliki tingkat mortalitas (100% layoffs) tertinggi. Fokuskan portofolio pada perusahaan *Post-IPO* yang meskipun melakukan PHK, tetap menunjukkan stabilitas operasional.
* **Untuk Job Seekers:**
    * Hindari bergabung dengan startup *Series A/B* di sektor ritel saat ekonomi tidak stabil. Perusahaan korporasi (Post-IPO) lebih aman karena PHK cenderung parsial, bukan penutupan total.

## 📂 Repository Structure
-   `/sql_scripts`: Kumpulan query untuk proses *data cleaning* dan *exploratory data analysis* (EDA).
-   `/visualization`: File Tableau Public dan aset gambar dashboard.
-   `/dataset`: Raw data (csv) sebelum dan sesudah diproses.

---
*Disclaimer: Project ini menggunakan dataset publik 'World Layoffs' sebagai materi latihan Data Analysis & Business Intelligence.*
