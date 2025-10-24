-- Exploratory Data Analysis of World Layoffs Data
/* JAHVAL ROMIZ SEPTRADA */


/* ------- FIRST ANALYSIS -------- */
SELECT *
FROM layoffs_staging2;

# Max total laid off & percentage laid off
SELECT MAX(total_laid_off), MAX(percentage_laid_off)
FROM layoffs_staging2;

# Rentang tanggal data yang dimiliki dari data ini
SELECT MIN(`date`), MAX(`date`)
FROM layoffs_staging2; # data yang ada berada di rentang masa masa awal pandemic covid hingga 3 tahun kemudian


/* ------- MAIN ANALYSIS -------- */

/* 
(1) Bagaimana tren keseluruhan PHK berubah seiring waktu? Apakah tingkat PHK melambat atau meningkat secara eksponensial?
*/
# Analisis Rolling Total dari total laid off setiap bulan
WITH Rolling_total AS
(
SELECT SUBSTRING(`date`,1,7) AS `month`, SUM(total_laid_off) total_off
FROM layoffs_staging2
WHERE  SUBSTRING(`date`,1,7) IS NOT NULL
GROUP BY `month`
ORDER BY  1 ASC
)
SELECT `month`, total_off, SUM(total_off) OVER(ORDER BY `MONTH`) rolling_total
FROM Rolling_total;


/*
(2) Perusahaan mana yang memiliki total PHK tertinggi dalam setiap tahun?
*/
# Query 1 - Company laid off tertinggi
SELECT company, SUM(total_laid_off) AS total_laid_off
FROM layoffs_staging2
GROUP BY company
ORDER BY total_laid_off DESC;

# Query 2 - Ranking Top 5 Most Laid Off Company di setiap tahunnya
WITH Company_year AS
(
SELECT company, YEAR(`date`) years, SUM(total_laid_off) total_off
FROM layoffs_staging2
GROUP BY company, years
), Company_year_rank AS
(
SELECT *, DENSE_RANK() OVER(PARTITION BY years ORDER BY total_off DESC) ranking
FROM Company_year
WHERE years IS NOT NULL
)
SELECT *
FROM Company_year_rank
WHERE ranking <= 5;


/* 
(3) Industri mana yang paling banyak mengalami PHK selama periode data?
*/
# Query 1 - Jenis industry dengan laid off tertinggi
SELECT industry, SUM(total_laid_off) AS total_laid_off
FROM layoffs_staging2
GROUP BY industry
ORDER BY total_laid_off DESC;

# Query 2 - Top 5 Industry di tiap tahunnya
WITH Industry_year AS
(
SELECT industry, YEAR(`date`) years, SUM(total_laid_off) total_off
FROM layoffs_staging2
WHERE industry != 'Other' # Tidak menyertakan Industry Other karena tidak informatif
GROUP BY industry, years
), Industry_year_rank AS
(
SELECT *, DENSE_RANK() OVER(PARTITION BY years ORDER BY total_off DESC) ranking
FROM Industry_year
WHERE years IS NOT NULL
)
SELECT *
FROM Industry_year_rank
WHERE ranking <= 5;


/* 
(4) Di industri apa yang banyak mengalami kegagalan dengan mem-PHK seluruh karyawannya?
*/
# Top 10 Industry + Stage yang mem-PHK seluruh karyawannya
SELECT
    industry,
    stage,
    COUNT(company) AS total_companies_failed,
    SUM(total_laid_off) AS total_laid_off,
    ROUND(AVG(funds_raised_millions)) AS avg_funds_raised_millions
FROM
    layoffs_staging2
WHERE
    percentage_laid_off = 1
GROUP BY
    industry,
    stage
HAVING stage != 'Unknown'
ORDER BY
    total_companies_failed DESC, 
    total_laid_off DESC
LIMIT 10;


/*
(5) Di tahap perkembangan perusahaan mana PHK paling sering terjadi?
*/
# Query 1 - Stage dengan laid off tertinggi
SELECT stage, COUNT(stage) AS count_stage
FROM layoffs_staging2
WHERE stage IS NOT NULL
GROUP BY stage
ORDER BY 2 DESC;

# Query 2 - Top 5 Stage di tiap tahunnya
WITH Stage_year AS
(
SELECT stage, YEAR(`date`) years, SUM(total_laid_off) total_off
FROM layoffs_staging2
WHERE stage != 'Unknown'
GROUP BY stage, years
), Stage_year_rank AS
(
SELECT *, DENSE_RANK() OVER(PARTITION BY years ORDER BY total_off DESC) ranking
FROM Stage_year
WHERE years IS NOT NULL
)
SELECT *
FROM Stage_year_rank
WHERE ranking <= 5;

/* ------- MORE ANALYSIS -------- */
# Negara dengan laid off tertinggi
SELECT country, SUM(total_laid_off) AS total_laid_offs
FROM layoffs_staging2
GROUP BY country
HAVING total_laid_offs IS NOT NULL 
ORDER BY 2 DESC;

# Jumlah PHK berdasarkan tahun
SELECT YEAR(`date`) `year`, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY `year`
HAVING `year` IS NOT NULL
ORDER BY 1 DESC;