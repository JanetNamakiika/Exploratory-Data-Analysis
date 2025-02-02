## EXPLAROTIRY DATA ANALYSIS

SELECT*
FROM layoffs_staging2;

SELECT MAX(total_laid_off), MAX(percentage_laid_off)
FROM layoffs_staging2;

SELECT*
FROM layoffs_staging2
WHERE percentage_laid_off=1
ORDER BY funds_raised_millions DESC;

SELECT company, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company
ORDER BY 2 DESC;

SELECT MAX(date), MIN(date)
FROM layoffs_staging2;

SELECT MAX(total_laid_off), MAX(percentage_laid_off)
FROM layoffs_staging2;

SELECT industry, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY industry
ORDER BY 2 DESC;

SELECT country, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY country
ORDER BY 2 DESC;

SELECT date, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY date
ORDER BY 2 DESC;

SELECT stage, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY stage
ORDER BY 2 DESC;

SELECT company, AVG(total_laid_off)
FROM layoffs_staging2
GROUP BY company
ORDER BY 2 DESC;

SELECT SUBSTRING(`date` ,1,7) AS `Month`, SUM(total_laid_off)
FROM layoffs_staging2
WHERE SUBSTRING(`date` ,1,7) IS NOT NULL
GROUP BY `Month`
ORDER BY 1 ASC;

SELECT*
FROM layoffs_staging2;

WITH Rolling_Total AS
(SELECT SUBSTRING(`date` ,1,7) AS `Month`, SUM(total_laid_off) AS Tlf
FROM layoffs_staging2
WHERE SUBSTRING(`date` ,1,7) IS NOT NULL
GROUP BY `Month`
ORDER BY 1 ASC)
SELECT `Month`, Tlf,SUM(Tlf) OVER(ORDER BY `MONTH`) AS rt
FROM Rolling_total;

SELECT company, YEAR(date),SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company, YEAR(date)
ORDER BY 3 DESC;

wITH company_year (company, years, total_laid_off) AS(
SELECT company, YEAR(date),SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company, YEAR(date)
), Company_Year_rank AS(
SELECT *, DENSE_RANK() OVER (PARTITION BY years ORDER BY total_laid_off DESC) AS ranking
FROM company_year
WHERE years IS NOT NULL)
SELECT*
FROM Company_Year_rank
WHERE ranking<=5;