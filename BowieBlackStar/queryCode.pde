/*

// &&&&&&&&&&&&&&&&&&   query: title type for CD and book &&&&&&&&&&&&&&&&&&&&

SELECT distinct
    itemType, title
FROM
    spl.title,
    spl.itemType,
    spl.itemToBib
WHERE
    spl.itemType.itemNumber = spl.itemToBib.itemNumber
        AND spl.itemToBib.bibNumber = spl.title.bibNumber
        AND (spl.title.bibNumber = '1836438'
        OR spl.title.bibNumber = '1965047'
        OR spl.title.bibNumber = '2277690'
        OR spl.title.bibNumber = '1823619'
        OR spl.title.bibNumber = '2613601'
        OR spl.title.bibNumber = '2707908'
        OR spl.title.bibNumber = '2723037'
        OR spl.title.bibNumber = '2815071'
        OR spl.title.bibNumber = '2917442'
        OR spl.title.bibNumber = '2941304'
        OR spl.title.bibNumber = '3029321'
        OR spl.title.bibNumber = '1952906'
        OR spl.title.bibNumber = '2148651'
        OR spl.title.bibNumber = '2023159'
        OR spl.title.bibNumber = '2362135'
        OR spl.title.bibNumber = '3029080'
        OR spl.title.bibNumber = '2023157'
        OR spl.title.bibNumber = '2299335'
        OR spl.title.bibNumber = '1954184'
        OR spl.title.bibNumber = '1736211'
        OR spl.title.bibNumber = '2627462'
        OR spl.title.bibNumber = '2128387'
        OR spl.title.bibNumber = '3061214'
        OR spl.title.bibNumber = '1959048'
        OR spl.title.bibNumber = '1950899'
        OR spl.title.bibNumber = '2444123'
        OR spl.title.bibNumber = '2515298'
        OR spl.title.bibNumber = '1976192'
        OR spl.title.bibNumber = '2086964'
        OR spl.title.bibNumber = '1953017'
        OR spl.title.bibNumber = '2867039'
        OR spl.title.bibNumber = '3057303'
        OR spl.title.bibNumber = '1639110'
        OR spl.title.bibNumber = '2363644'
        OR spl.title.bibNumber = '2567243'
        OR spl.title.bibNumber = '2211550'
        OR spl.title.bibNumber = '3067034'
        OR spl.title.bibNumber = '2631168'
        OR spl.title.bibNumber = '1954182'
        OR spl.title.bibNumber = '1880152'
        OR spl.title.bibNumber = '2412531'
        OR spl.title.bibNumber = '1976321'
        OR spl.title.bibNumber = '2296937'
        OR spl.title.bibNumber = '1972971'
        OR spl.title.bibNumber = '2448150'
        OR spl.title.bibNumber = '2612658'
        OR spl.title.bibNumber = '1953009')
ORDER BY itemType , title


// &&&&&&&&&&&&&&&&&&   query: checkout event per day per title for CD and book &&&&&&&&&&&&&&&&&&&&

SELECT 
    itemType,
    title,
    DATE_FORMAT(checkOut, '20%y-%m-%d') AS date,
    COUNT(checkOut) AS checkOutTimes,
    #DATE_FORMAT(checkOut, '20%y-%m-%d')  AS coutDate,
    #DATE_FORMAT(checkInFirst, '20%y-%m-%d') AS cinDate,
    AVG(TIMESTAMPDIFF(DAY,
        checkOut,
        checkIn)) AS checkOutDuration
FROM
    spl.itemType,
    spl.title,
    spl._transactionsExploded
WHERE
    spl.itemType.itemNumber = spl._transactionsExploded.itemNumber
        AND spl.title.bibNumber = spl._transactionsExploded.bibNumber
        AND (spl.title.bibNumber = '1836438'
        OR spl.title.bibNumber = '1965047'
        OR spl.title.bibNumber = '2277690'
        OR spl.title.bibNumber = '1823619'
        OR spl.title.bibNumber = '2613601'
        OR spl.title.bibNumber = '2707908'
        OR spl.title.bibNumber = '2723037'
        OR spl.title.bibNumber = '2815071'
        OR spl.title.bibNumber = '2917442'
        OR spl.title.bibNumber = '2941304'
        OR spl.title.bibNumber = '3029321'
        
        OR spl.title.bibNumber = '1952906'
        OR spl.title.bibNumber = '2148651'
        OR spl.title.bibNumber = '2023159'
        OR spl.title.bibNumber = '2362135'
        OR spl.title.bibNumber = '3029080'
        OR spl.title.bibNumber = '2023157'
        OR spl.title.bibNumber = '2299335'
        OR spl.title.bibNumber = '1954184'
        OR spl.title.bibNumber = '1736211'
        OR spl.title.bibNumber = '2627462'
        OR spl.title.bibNumber = '2128387'
        OR spl.title.bibNumber = '3061214'
        OR spl.title.bibNumber = '1959048'
        OR spl.title.bibNumber = '1950899'
        OR spl.title.bibNumber = '2444123'
        OR spl.title.bibNumber = '2515298'
        OR spl.title.bibNumber = '1976192'
        OR spl.title.bibNumber = '2086964'
        OR spl.title.bibNumber = '1953017'
        OR spl.title.bibNumber = '2867039'
        OR spl.title.bibNumber = '3057303'
        OR spl.title.bibNumber = '1639110'
        OR spl.title.bibNumber = '2363644'
        OR spl.title.bibNumber = '2567243'
        OR spl.title.bibNumber = '2211550'
        OR spl.title.bibNumber = '3067034'
        OR spl.title.bibNumber = '2631168'
        OR spl.title.bibNumber = '1954182'
        OR spl.title.bibNumber = '1880152'
        OR spl.title.bibNumber = '2412531'
        OR spl.title.bibNumber = '1976321'
        OR spl.title.bibNumber = '2296937'
        OR spl.title.bibNumber = '1972971'
        OR spl.title.bibNumber = '2448150'
        OR spl.title.bibNumber = '2612658'
        OR spl.title.bibNumber = '1953009')
GROUP BY title , date
ORDER BY itemType, date , title

*/