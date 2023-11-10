-- Get record of all bookings of a customer
SELECT session_id AS "Session ID", session_date AS "Date", session_time AS "Time", 
       account_number AS "Account Number", location AS "Location", session_type AS "Session Type", price AS "Price", reason AS "Reason"
FROM PhotoSession
JOIN SessionDateTime ON PhotoSession.date_time_id = SessionDateTime.date_time_id
JOIN SessionLocation ON PhotoSession.location_id = SessionLocation.location_id
JOIN SessionPricing ON PhotoSession.pricing_id = SessionPricing.pricing_id
JOIN SessionReason ON PhotoSession.reason_id = SessionReason.reason_id
WHERE account_number = '&acc_no';

--Get sessions for reason being graduation
SELECT session_id AS "Session ID", session_date AS "Date", session_time AS "Time", 
       account_number AS "Account Number", location AS "Location", session_type AS "Session Type", price AS "Price", reason AS "Reason"
FROM PhotoSession
JOIN SessionDateTime ON PhotoSession.date_time_id = SessionDateTime.date_time_id
JOIN SessionLocation ON PhotoSession.location_id = SessionLocation.location_id
JOIN SessionPricing ON PhotoSession.pricing_id = SessionPricing.pricing_id
JOIN SessionReason ON PhotoSession.reason_id = SessionReason.reason_id
WHERE reason = 'Graduation'
ORDER BY SessionDateTime.session_date;

-- Query 1:

-- Purpose of the query: To prompt the user to enter a session ID, and display the customer's account number and session details for that specific session ID.

SELECT
    session_id AS "Session ID",
    session_date AS "Date",
    session_time AS "Time",
    account_number AS "Account Number",
    location AS "Location",
    session_type AS "Session Type",
    price AS "Price",
    reason AS "Reason"
FROM
    PhotoSession,
    SessionDateTime,
    SessionLocation,
    SessionPricing,
    SessionReason
WHERE
    PhotoSession.date_time_id = SessionDateTime.date_time_id
AND
    PhotoSession.location_id = SessionLocation.location_id
AND
    PhotoSession.pricing_id = SessionPricing.pricing_id
AND
    PhotoSession.reason_id = SessionReason.reason_id
AND
    session_id = '&Enter_Session_ID';

-- Query 2:

-- Purpose of the query: To retrieve the total number of selected photos for each order.

SELECT o.order_no, COUNT(sp.selected_photo_id) AS total_selected_photos
FROM PhotoOrder o
LEFT JOIN SelectedPhoto sp ON o.order_no = sp.order_no
GROUP BY o.order_no;

-- Query 3:

-- Purpose of the query: To retrieve the session details and the number of bookings made for each session date_time_id. 

SELECT s.date_time_id, COUNT(s.session_id) AS total_bookings
FROM PhotoSession s
GROUP BY s.date_time_id;

-- Query 4:

-- Purpose of the query: To retrieve the average quantity of photos ordered for each type of finish.

SELECT sp.photo_finish, AVG(sp.quantity) AS average_quantity
FROM SelectedPhoto sp
GROUP BY sp.photo_finish;

-- Query 5:

-- Purpose of the query: To retrieve the session details and the number of bookings made for each location where the total number of bookings is more than 1.

SELECT l.location_id, l.location, COUNT(s.session_id) AS total_bookings
FROM PhotoSession s
JOIN SessionLocation l ON s.location_id = l.location_id
GROUP BY l.location_id, l.location
HAVING COUNT(s.session_id) > 1;

-- Query 6: 

-- Purpose of the query: To retrieve the average price of each type of finish.

SELECT sp.photo_finish, AVG(sp.pricing) AS average_price
FROM SelectedPhoto sp
GROUP BY sp.photo_finish;

-- Query 7:

-- Purpose of the query: To retrieve the average price and quantity of photos for each type of finish, grouped by the location where the sessions took place. 

SELECT l.location AS Location,
    sp.photo_finish AS Finish,
    AVG(sp.pricing) AS Average_Price,
    AVG(sp.quantity) AS Average_Quantity
FROM PhotoSession s
JOIN SessionLocation l ON s.location_id = l.location_id
JOIN DigitisedPhotograph dp ON s.session_id = dp.session_id
JOIN SelectedPhoto sp ON dp.digitised_photo_id = sp.digitised_photo_id
JOIN PhotoOrder o ON sp.order_no = o.order_no
GROUP BY l.location, sp.photo_finish
ORDER BY l.location;

SELECT l.location AS Location,
    sp.photo_finish AS Finish,
    AVG(sp.pricing) AS Average_Price,
    AVG(sp.quantity) AS Average_Quantity
FROM PhotoSession s, SessionLocation l, DigitisedPhotograph dp, SelectedPhoto sp, PhotoOrder o
WHERE s.location_id = l.location_id
  AND s.session_id = dp.session_id
  AND dp.digitised_photo_id = sp.digitised_photo_id
  AND sp.order_no = o.order_no
GROUP BY l.location, sp.photo_finish
ORDER BY l.location;

-- Query 8:

-- Purpose of the query: To retrieve the count of bookings made by customers in each city, as well as the average price and quantity per city.

SELECT c.city,
    COUNT(*) AS Booking_Count,
    AVG(sp.pricing) AS Average_Price,
    AVG(sp.quantity) AS Average_Quantity
FROM Customer c
JOIN PhotoOrder o ON c.account_number = o.account_number
JOIN SelectedPhoto sp ON o.order_no = sp.order_no
GROUP BY c.city;

-- Query 9:

-- Purpose of the query: To retrieve the total sales amount for each type of finish.

SELECT sp.photo_finish AS Finish,
    SUM(sp.pricing) AS Total_Sales_Amount
FROM SelectedPhoto sp
GROUP BY sp.photo_finish;

-- Query 10:

-- Purpose of the query: To retrieve the average price and quantity per session and the location details.

SELECT s.session_id, s.date_time_id, l.location,
    AVG(sp.pricing) AS Average_Price,
    AVG(sp.quantity) AS Average_Quantity
FROM PhotoSession s
JOIN SessionLocation l ON s.location_id = l.location_id
JOIN DigitisedPhotograph dp ON s.session_id = dp.session_id
JOIN SelectedPhoto sp ON dp.digitised_photo_id = sp.digitised_photo_id
GROUP BY s.session_id, s.date_time_id, l.location;
