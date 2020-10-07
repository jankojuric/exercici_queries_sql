/* 1. Quantitat de registres de la taula de vols */
SELECT COUNT(*) FROM flights;

/* 2. Retard promig de sortida i arribada segons l’aeroport origen. */
SELECT Origin, AVG(ArrDelay) AS 'prom_arribades', AVG(DepDelay) AS 'prom_sortides'
FROM flights
GROUP BY Origin;

/* 3. Retard promig d’arribada dels vols, per mesos, anys i segons l’aeroport origen. */
SELECT Origin, colYear, colMonth, AVG(ArrDelay) as 'prom_arribades'
FROM flights
GROUP BY Origin, colYear, colMonth
ORDER BY Origin, colYear, colMonth;

/* 4. Retard promig d’arribada dels vols, per mesos, anys i segons la ciutat. */
SELECT City, colYear, colMonth, AVG(ArrDelay)
FROM flights
INNER JOIN usairports ON flights.Origin = usairports.IATA
GROUP BY City, colYear, colMonth
ORDER BY City, colYear, colMonth;

/* 5. Les companyies amb més vols cancelats, per mesos i any. */
SELECT UniqueCarrier, colYear, colMonth, SUM(Cancelled) AS total_cancelled
FROM flights
GROUP BY UniqueCarrier, colYear, colMonth
ORDER BY total_cancelled DESC;

/* 6. L’identificador dels 10 avions que més distància han recorregut fent vols. */
SELECT TailNum, SUM(Distance) AS 'totalDistance'
FROM flights
WHERE TailNum NOT LIKE ''
GROUP BY TailNum
ORDER BY SUM(Distance) DESC
LIMIT 10;

/* Companyies amb el seu retard promig només d’aquelles les quals els seus vols arriben al seu destí amb un retràs promig major de 10 minuts. */
SELECT UniqueCarrier, AVG(ArrDelay) AS avgDelay
FROM flights
GROUP BY UniqueCarrier
HAVING AVG(ArrDelay) > 10
ORDER BY AVG(ArrDelay) DESC;