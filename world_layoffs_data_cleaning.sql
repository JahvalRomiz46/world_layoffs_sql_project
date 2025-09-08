-- Data Cleaning of World Layoffs Data
/* JAHVAL ROMIZ SEPTRADA */

-- STEPS
-- 1. REMOVE DUPLICATE
-- 2. STANDARDIZE DATA
-- 3. NULL AND BLANK VALUES 
-- 4. REMOVE UNNECESSARY COLUMNS/ROWS

SELECT *
FROM world_layoffs.layoffs;

-- 1. REMOVE DUPLICATE
# Buat copy tablenya
CREATE TABLE world_layoffs.layoffs_staging
LIKE world_layoffs.layoffs; # Duplicate column yang sama dengan table layoffs

SELECT * FROM world_layoffs.layoffs_staging;

INSERT world_layoffs.layoffs_staging
SELECT * FROM world_layoffs.layoffs;

# Pertama, buat tabel baru ditambah kolom row_num untuk memastikan setiap kolom cuma punya 1 nomor urut
# Jika lebih dari 1 = duplicate
CREATE TABLE `world_layoffs`.`layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

# Copy isi table layoffs_staging / tabel 1 + masukkan value row_num ke tabel layoffs_staging2
INSERT INTO `world_layoffs`.`layoffs_staging2`
SELECT *,
	ROW_NUMBER() OVER(
		PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions
		) AS row_num
	FROM world_layoff.layoffs_staging;

SELECT * FROM world_layoffs.layoffs_staging2;

# Ketiga, cek row yang duplicate
SELECT * 
FROM world_layoffs.layoffs_staging2
WHERE row_num > 1;

# Keempat, DELETE row duplicate
DELETE 
FROM world_layoffs.layoffs_staging2
WHERE row_num > 1;

SELECT * 
FROM world_layoffs.layoffs_staging2;


-- 2. STANDARDIZE DATA (Spelling, dll)
# Trim Whitespace
SELECT company, TRIM(company)
FROM world_layoffs.layoffs_staging2;

UPDATE world_layoffs.layoffs_staging2
SET company = TRIM(company);

# Cek konsistensi penulisan di tiap kolom
/* Location */
SELECT DISTINCT location
FROM world_layoffs.layoffs_staging2
ORDER BY 1;

/* Industry */
SELECT DISTINCT industry
FROM world_layoffs.layoffs_staging2
ORDER BY 1; # Di sini keliatan ada 3 penulisan Crypto yang berbeda (Crypto, Crypto Currency, dan CryptoCurrency)

/* Country */
SELECT DISTINCT country
FROM world_layoffs.layoffs_staging2
ORDER BY 1; # Penulisan United States yang memiliki titik di akhir

# Update table sesuai penamaan yang konsisten
/* Industry */
# Cek penulisan yang benar
SELECT *
FROM world_layoffs.layoffs_staging2
WHERE industry LIKE '%Crypto%'; # Di sini nilai yang benernya adalah Crypto, maka ganti semua nilainya ke Crypto

UPDATE world_layoffs.layoffs_staging2
SET industry = 'Crypto'
WHERE industry LIKE '%Crypto%';

/* Country */
SELECT DISTINCT country
FROM world_layoffs.layoffs_staging2
WHERE country LIKE '%United States%';

UPDATE world_layoffs.layoffs_staging2
SET country = TRIM(TRAILING '.' FROM country) # Solusi alternatif
WHERE country LIKE 'United States%';


# Ubah format kolom `Date` ke format date
SELECT `date`, STR_TO_DATE(`date`, '%m/%d/%Y')
FROM world_layoffs.layoffs_staging2;

UPDATE world_layoffs.layoffs_staging2
SET `date` = STR_TO_DATE(`date`, '%m/%d/%Y'); # Walaupun udah diubah formatnya, di table information date masih format text

ALTER TABLE world_layoffs.layoffs_staging2
MODIFY COLUMN `date` DATE; # Dengan begini `date` sudah menjadi format date

SELECT *
FROM world_layoffs.layoffs_staging2;

-- 3. NULL VALUES AND BLANK
# Pertama, analisa null yang perlu dihapus
SELECT *
FROM world_layoffs.layoffs_staging2;

# Blank dan Null di kolom Industry
SELECT *
FROM world_layoffs.layoffs_staging2
WHERE industry = ''
OR industry IS NULL; 

# Analisa terlebih dahulu tiap baris yang memiliki null masing2
# Apakah ada informasi dari nilai kosong tsb di row lain?
# Misal company Airbnb
SELECT *
FROM world_layoffs.layoffs_staging2
WHERE company = 'Airbnb'; # Ternyata di baris lain memiliki info yang hilang di baris tsb
# Misal lagi company Carvana
SELECT *
FROM world_layoffs.layoffs_staging2
WHERE company = 'Carvana';

# Pengisian nilai NULL
# Pertama, ubah yang blank ke NULL agar works ngubah nilai nya dengan JOIN ke baris lain yang punya informasi kolom industry
UPDATE world_layoffs.layoffs_staging2
SET industry = NULL
WHERE industry = '';

# Kedua, komparasi baris yang null dan tidak null dengan join
SELECT *
FROM world_layoffs.layoffs_staging2 t1
JOIN world_layoffs.layoffs_staging2 t2
	ON t1.company = t2.company # Samain berdasarkan company untuk mencari baris lain yang memiliki info 
WHERE t1.industry IS NULL
AND t2.industry IS NOT NULL;

# Lalu update table nya dengan menimpa isi baris industry yang null dengan baris yang punya info
UPDATE world_layoffs.layoffs_staging2 t1
JOIN world_layoffs.layoffs_staging2 t2
	ON t1.company = t2.company
SET t1.industry = t2.industry
WHERE t1.industry IS NULL
AND t2.industry IS NOT NULL;

# Cek apakah kolom industry yang null tadi sudah terisi semua
SELECT *
FROM world_layoffs.layoffs_staging2
WHERE industry = ''
OR industry IS NULL; # Ternyata company Bally's% masih NULL

SELECT *
FROM world_layoffs.layoffs_staging2
WHERE company LIKE 'Bally%'; # Dan ternyata itu dikarenakan Ballys% tidak punya baris lain yang punya info tipe industrynya

## Untuk kolom 'total_laid_of' dan 'percentage_laid_of', seharusnya bisa dilakukan kalkulasi jika ada kolom total karyawannya, tapi berhubung ga ada, jadi ga bisa
## Untuk kolom 'funds_raised_millions', kalo emg berdasarkan real data, bisa saja scrape data dari web nya, tapi beda kasus dari yang dikerjain di sini, jadi tidak dilakukan
# Maka dari itu, kolom yang belum berguna, akan dihapus

-- 4.REMOVE UNNECESSARY COLUMNS/ROWS
SELECT *
FROM world_layoffs.layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

DELETE
FROM world_layoffs.layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

SELECT *
FROM world_layoffs.layoffs_staging2;

ALTER TABLE world_layoffs.layoffs_staging2
DROP COLUMN row_num;

# Inilah hasil tabel yang sudah dicleaning
SELECT *
FROM world_layoffs.layoffs_staging2;