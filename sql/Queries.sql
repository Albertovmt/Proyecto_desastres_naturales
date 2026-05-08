USE Natural_disasters;

-- Pregunta 1
-- ¿Qué regiones del mundo sufren más desastres naturales?

SELECT 
    region,
    COUNT(*) AS total_disasters
FROM Natural_disasters
WHERE region IN ('Asia','Americas','Europe','Africa','Oceania')
GROUP BY region
ORDER BY total_disasters DESC;


-- Pregunta 2
-- Qué desastres causan mayor mortalidad por continente y que porcentaje representa?

WITH ranking AS (
	SELECT 
		region,
        disaster_type, 
        SUM(total_deaths) AS deaths,
        ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (PARTITION BY region)) AS pct_disaster_region,
        ROUND(SUM(total_deaths) * 100.0 / SUM(SUM(total_deaths)) OVER (PARTITION BY region)) AS pct_deaths_region,
        
        RANK() OVER (
			PARTITION BY region
            ORDER BY SUM(total_deaths) DESC
            ) AS rank_region
	
    FROM Natural_disasters
    WHERE region IN ('Asia','Americas','Europe','Africa','Oceania')
    GROUP BY 
		region, 
        disaster_type
        )
SELECT 
	region, 
	disaster_type, 
    pct_disaster_region,
    deaths,
    pct_deaths_region
FROM ranking
WHERE rank_region = 1;


-- Pregunta 3
-- ¿La frecuencia de desastres naturales ha aumentado con el tiempo?

SELECT 
    FLOOR(YEAR(date) / 10) * 10 AS decade,
    COUNT(*) AS total_disasters
FROM Natural_disasters
WHERE date IS NOT NULL
GROUP BY decade
ORDER BY decade;

-- Pregunta 4
-- ¿Existe relación entre magnitud y mortalidad en terremotos?

SELECT region, COUNT(disaster_type) AS total_events,
	CASE
		WHEN magnitude <= 4.9 THEN 'Débiles'
        WHEN magnitude BETWEEN 5.0 AND 6.9 THEN 'Moderado-Fuerte'
        WHEN magnitude > 6.9 THEN 'Muy Fuerte'
        ELSE 'Desconocida'
	END AS Severidad, SUM(total_deaths) AS deaths,ROUND(SUM(total_deaths)/COUNT(disaster_type)) AS ratio
    FROM Natural_disasters
WHERE disaster_type = 'earthquake' AND region IN ('Asia','Americas','Europe','Africa','Oceania')
GROUP BY severidad,region
HAVING severidad IN ('Débiles','Moderado-Fuerte','Muy Fuerte')
ORDER BY severidad,ROUND(SUM(total_deaths)/COUNT(disaster_type)) DESC;

-- Pregunta 5
-- ¿Qué desastres afectan a más personas por continente?


WITH ranked AS (
	SELECT 
		region, 
		disaster_type,
		ROUND(SUM(total_affected) * 100.0 / SUM(SUM(total_affected)) OVER (PARTITION BY region)) AS pct_affected_region,
        SUM(total_affected) AS affected,
        
        RANK() OVER (
			PARTITION BY region
            ORDER BY SUM(total_affected) DESC
            ) AS first
            
	FROM Natural_disasters
	WHERE total_affected > 0
	GROUP BY 
		region, 
        disaster_type
    )
SELECT 
	region, 
	disaster_type,
    affected,
    pct_affected_region
FROM ranked
WHERE first = 1;


-- Pregunta 6
-- Qué desastres tienen mayor incidencia en cada continente?

WITH ranking AS (
	SELECT 
		region,
        disaster_type, 
		ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (PARTITION BY region)) AS pct_region,
        
        RANK() OVER (
			PARTITION BY region
            ORDER BY COUNT(disaster_type) DESC
            ) AS first
	
    FROM Natural_disasters
    WHERE region IN ('Asia','Americas','Europe','Africa','Oceania')
    GROUP BY 
		region, 
        disaster_type
        )
SELECT 
	region,
	disaster_type,
    pct_region
FROM ranking
WHERE first = 1;