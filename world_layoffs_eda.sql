-- Exploratory Data Analysis of World Layoffs Data
/* JAHVAL ROMIZ SEPTRADA */

SELECT *
FROM layoffs_staging2;

SELECT MAX(total_laid_off), MAX(percentage_laid_off)
FROM layoffs_staging2;

# Company yang mem-PHK seluruh karyawannya
SELECT *
FROM layoffs_staging2
WHERE  percentage_laid_off = 1
ORDER BY total_laid_off DESC;

# Rentang tanggal data yang dimiliki dari data ini
SELECT MIN(`date`), MAX(`date`)
FROM layoffs_staging2; # data yang ada berada di rentang masa masa awal pandemic covid hingga 3 tahun kemudian

# Company dengan total laid off tertinggi hingga terendah
SELECT company, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company
ORDER BY 2 DESC;

# Jenis industry dengan laid off tertinggi hingga terendah
SELECT industry, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY industry
ORDER BY 2 DESC;

# Negara dengan laid off tertinggi hingga terendah
SELECT country, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY country
ORDER BY 2 DESC;

# Jumlah PHK berdasarkan tahun
SELECT YEAR(`date`) `year`, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY `year`
ORDER BY 1 DESC;

# Stage dengan laid off tertinggi hingga terendah
SELECT stage, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY stage
ORDER BY 2 DESC;

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

# Ranking Top 5 Most Laid Off Company di setiap tahunnya
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