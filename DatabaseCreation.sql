-- Task 3:

-- Customer
CREATE TABLE Customer 
(
  account_number NUMBER(10) PRIMARY KEY,
  first_name VARCHAR2(50),
  last_name VARCHAR2(50),
  organisation_name VARCHAR2(50),
  phone_number VARCHAR2(20),
  street_address VARCHAR2(100),
  suburb VARCHAR2(50),
  city VARCHAR2(50),
  postcode VARCHAR2(10),
  email VARCHAR2(100)
);

-- SessionDateTime
CREATE TABLE SessionDateTime 
(
  date_time_id NUMBER(10) PRIMARY KEY,
  session_date DATE,
  session_time VARCHAR2(10)
);

-- SessionLocation
CREATE TABLE SessionLocation 
(
  location_id NUMBER(10) PRIMARY KEY,
  location VARCHAR2(50)
);

-- SessionPricing
CREATE TABLE SessionPricing 
(
  pricing_id NUMBER(10) PRIMARY KEY,
  session_type VARCHAR2(50),
  price NUMBER(10),
  effective_date DATE
);

-- SessionReason
CREATE TABLE SessionReason 
(
  reason_id NUMBER(10) PRIMARY KEY,
  reason VARCHAR2(50)
);

-- PhotoSession
CREATE TABLE PhotoSession 
(
  session_id NUMBER(10) PRIMARY KEY,
  date_time_id NUMBER(10),
  account_number NUMBER(10),
  location_id NUMBER(10),
  pricing_id NUMBER(10),
  reason_id NUMBER(10),
  CONSTRAINT PhotoSession_date_time_fk FOREIGN KEY (date_time_id) REFERENCES SessionDateTime (date_time_id),
  CONSTRAINT PhotoSession_customer_fk FOREIGN KEY (account_number) REFERENCES Customer (account_number),
  CONSTRAINT PhotoSession_location_fk FOREIGN KEY (location_id) REFERENCES SessionLocation (location_id),
  CONSTRAINT PhotoSession_pricing_fk FOREIGN KEY (pricing_id) REFERENCES SessionPricing (pricing_id),
  CONSTRAINT PhotoSession_reason_fk FOREIGN KEY (reason_id) REFERENCES SessionReason (reason_id)
);

-- Cancellations
CREATE TABLE Cancellations 
(
  account_number NUMBER(10),
  session_id NUMBER(10),
  date_cancelled DATE,
  CONSTRAINT cancellations_customer_fk FOREIGN KEY (account_number) REFERENCES Customer (account_number),
  CONSTRAINT cancellations_session_fk FOREIGN KEY (session_id) REFERENCES PhotoSession (session_id)
);

-- DigitisedPhotograph
CREATE TABLE DigitisedPhotograph 
(
  digitised_photo_id NUMBER(10) PRIMARY KEY,
  session_id NUMBER(10),
  CONSTRAINT digitised_photograph_session_fk FOREIGN KEY (session_id) REFERENCES PhotoSession (session_id)
);

-- PostalCharge
CREATE TABLE PostalCharge 
(
  postal_charge_id NUMBER(10) PRIMARY KEY,
  charge_description VARCHAR2(50),
  charge_amount NUMBER(10, 2)
);

-- PostalAddress
CREATE TABLE PostalAddress 
(
  postal_address_id NUMBER(10) PRIMARY KEY,
  address VARCHAR2(100),
  suburb VARCHAR2(50),
  city VARCHAR2(50),
  postcode VARCHAR2(10)
);

-- PhotoOrder
CREATE TABLE PhotoOrder 
(
  order_no NUMBER(10) PRIMARY KEY,
  account_number NUMBER(10),
  postal_charge_id NUMBER(10),
  postal_address_id NUMBER(10),
  date_accepted DATE,
  time_accepted VARCHAR2(10),
  CONSTRAINT PhotoOrder_customer_fk FOREIGN KEY (account_number) REFERENCES Customer (account_number),
  CONSTRAINT PhotoOrder_postal_charge_fk FOREIGN KEY (postal_charge_id) REFERENCES PostalCharge (postal_charge_id),
  CONSTRAINT PhotoOrder_postal_address_fk FOREIGN KEY (postal_address_id) REFERENCES PostalAddress (postal_address_id)
);

-- SelectedPhoto
CREATE TABLE SelectedPhoto 
(
  selected_photo_id NUMBER(10) PRIMARY KEY,
  digitised_photo_id NUMBER(10),
  order_no NUMBER(10),
  photo_colour VARCHAR2(50),
  photo_finish VARCHAR2(50),
  photo_size VARCHAR2(50),
  quantity NUMBER(10),
  pricing NUMBER(10, 2),
  CONSTRAINT selected_photo_digitised_photo_fk FOREIGN KEY (digitised_photo_id) REFERENCES DigitisedPhotograph (digitised_photo_id),
  CONSTRAINT selected_photo_order_fk FOREIGN KEY (order_no) REFERENCES PhotoOrder (order_no)
);

-- Task 4:

-- Sample data for Customer table
INSERT INTO Customer (account_number, first_name, last_name, organisation_name, phone_number, street_address, suburb, city, postcode, email)
VALUES (1, 'John', 'Doe', NULL, '0210456789', '1 Queen St', 'Ponsonby', 'Auckland', '1234', 'john.doe@gmail.com');

INSERT INTO Customer (account_number, first_name, last_name, organisation_name, phone_number, street_address, suburb, city, postcode, email)
VALUES (2, 'Jane', 'Smith', 'ABC Company', '0223874561', '456 Elm St', 'Mount Eden', 'Auckland', '6546', 'jane.smith@abccompany.com');

INSERT INTO Customer (account_number, first_name, last_name, organisation_name, phone_number, street_address, suburb, city, postcode, email)
VALUES (3, 'Emma', 'Smith', NULL, '0241975326', '789 Oak Ave', 'New Lynn', 'Auckland', '4254', 'emma.smith@gmail.com');

INSERT INTO Customer (account_number, first_name, last_name, organisation_name, phone_number, street_address, suburb, city, postcode, email)
VALUES (4, 'Liam', 'Johnson', NULL, '0278546320', '987 Willow Ln', 'Papakura', 'Auckland', '2543', 'liam.johnson@gmail.com');

INSERT INTO Customer (account_number, first_name, last_name, organisation_name, phone_number, street_address, suburb, city, postcode, email)
VALUES (5, 'Olivia', 'Taylor', NULL, '0206237845', '543 Elm St', 'Albany', 'Auckland', '5365', 'olivia.taylor@gmail.com');

INSERT INTO Customer (account_number, first_name, last_name, organisation_name, phone_number, street_address, suburb, city, postcode, email)
VALUES (6, 'Noah', 'Anderson', NULL, '0217415098', '234 Birch Rd', 'Henderson', 'Auckland', '6478', 'noah.anderson@gmail.com');

INSERT INTO Customer (account_number, first_name, last_name, organisation_name, phone_number, street_address, suburb, city, postcode, email)
VALUES (7, 'Ava', 'Clark', NULL, '0248732165', '876 Pine St', 'Botany Downs', 'Wellington', '4754', 'ava.clark@gmail.com');

INSERT INTO Customer (account_number, first_name, last_name, organisation_name, phone_number, street_address, suburb, city, postcode, email)
VALUES (8, 'Ethan', 'Wright', 'Diamond Company', '0274813569', '567 Maple Dr', 'Manukau', 'Hamilton', '2643', 'ethan.wright@diamondcompany.com');

INSERT INTO Customer (account_number, first_name, last_name, organisation_name, phone_number, street_address, suburb, city, postcode, email)
VALUES (9, 'Sophia', 'Walker', NULL, '0201049782', '987 Willow Ln', 'Parnell', 'Hamilton', '5764', 'sophia.walker@gmail.com');

INSERT INTO Customer (account_number, first_name, last_name, organisation_name, phone_number, street_address, suburb, city, postcode, email)
VALUES (10, 'Lucas', 'Johnson', 'Trading Company', '0210826473', '234 Birch Rd', 'Newmarket', 'Wellington', '5432', 'lucas.johnson@tradingcompany.com');

SELECT * FROM Customer;

-- Sample data for SessionDateTime table
INSERT INTO SessionDateTime (date_time_id, session_date, session_time)
VALUES ('21', TO_DATE('01-JUN-2023', 'DD-MON-YYYY'), '08:30 AM');

INSERT INTO SessionDateTime (date_time_id, session_date, session_time)
VALUES ('22', TO_DATE('01-JUN-2023', 'DD-MON-YYYY'), '10:00 AM');

INSERT INTO SessionDateTime (date_time_id, session_date, session_time)
VALUES ('23', TO_DATE('01-JUN-2023', 'DD-MON-YYYY'), '11:30 AM');

INSERT INTO SessionDateTime (date_time_id, session_date, session_time)
VALUES ('24', TO_DATE('01-JUN-2023', 'DD-MON-YYYY'), '01:30 PM');

INSERT INTO SessionDateTime (date_time_id, session_date, session_time)
VALUES ('25', TO_DATE('01-JUN-2023', 'DD-MON-YYYY'), '05:30 PM');

INSERT INTO SessionDateTime (date_time_id, session_date, session_time)
VALUES ('26', TO_DATE('02-JUN-2023', 'DD-MON-YYYY'), '08:30 AM');

INSERT INTO SessionDateTime (date_time_id, session_date, session_time)
VALUES ('27', TO_DATE('02-JUN-2023', 'DD-MON-YYYY'), '10:00 AM');

INSERT INTO SessionDateTime (date_time_id, session_date, session_time)
VALUES ('28', TO_DATE('02-JUN-2023', 'DD-MON-YYYY'), '11:30 AM');

INSERT INTO SessionDateTime (date_time_id, session_date, session_time)
VALUES ('29', TO_DATE('02-JUN-2023', 'DD-MON-YYYY'), '01:30 PM');

INSERT INTO SessionDateTime (date_time_id, session_date, session_time)
VALUES ('210', TO_DATE('02-JUN-2023', 'DD-MON-YYYY'), '05:30 PM');

INSERT INTO SessionDateTime (date_time_id, session_date, session_time)
VALUES ('220', TO_DATE('02-JULY-2023', 'DD-MON-YYYY'), '08:30 AM');

INSERT INTO SessionDateTime (date_time_id, session_date, session_time)
VALUES ('230', TO_DATE('02-JULY-2023', 'DD-MON-YYYY'), '10:00 AM');

INSERT INTO SessionDateTime (date_time_id, session_date, session_time)
VALUES ('240', TO_DATE('02-JULY-2023', 'DD-MON-YYYY'), '11:30 AM');

SELECT * FROM SessionDateTime;

-- Sample data for SessionLocation table
INSERT INTO SessionLocation (location_id, location)
VALUES ('31', 'Studio A');

INSERT INTO SessionLocation (location_id, location)
VALUES ('32', 'Local Beach');

INSERT INTO SessionLocation (location_id, location)
VALUES ('33', 'Park');

INSERT INTO SessionLocation (location_id, location)
VALUES ('34', 'Café');

INSERT INTO SessionLocation (location_id, location)
VALUES ('35', 'Home');

INSERT INTO SessionLocation (location_id, location)
VALUES ('36', 'Studio B');

INSERT INTO SessionLocation (location_id, location)
VALUES ('37', 'Garden');

INSERT INTO SessionLocation (location_id, location)
VALUES ('38', 'Cityscape');

INSERT INTO SessionLocation (location_id, location)
VALUES ('39', 'Forest');

INSERT INTO SessionLocation (location_id, location)
VALUES ('40', 'Rooftop');

SELECT * FROM SessionLocation;

-- Sample data for SessionPricing table
INSERT INTO SessionPricing (pricing_id, session_type, price, effective_date)
VALUES ('61', 'Studio Daytime', 250.00, TO_DATE('01-JUN-2023', 'DD-MON-YYYY'));

INSERT INTO SessionPricing (pricing_id, session_type, price, effective_date)
VALUES ('62', 'Studio Early Evening', 275.00, TO_DATE('01-JUN-2023', 'DD-MON-YYYY'));

INSERT INTO SessionPricing (pricing_id, session_type, price, effective_date)
VALUES ('63', 'On Location', 400.00, TO_DATE('01-JUN-2023', 'DD-MON-YYYY'));

INSERT INTO SessionPricing (pricing_id, session_type, price, effective_date)
VALUES ('64', 'Home Daytime', 350.00, TO_DATE('01-JUN-2023', 'DD-MON-YYYY'));

INSERT INTO SessionPricing (pricing_id, session_type, price, effective_date)
VALUES ('65', 'Home Early Evening', 375.00, TO_DATE('01-JUN-2023', 'DD-MON-YYYY'));

SELECT * FROM SessionPricing;

-- Sample data for SessionReason table
INSERT INTO SessionReason (reason_id, reason)
VALUES ('81', 'Family Portraits');

INSERT INTO SessionReason (reason_id, reason)
VALUES ('82', 'Engagement Photoshoot');

INSERT INTO SessionReason (reason_id, reason)
VALUES ('83', 'Graduation');

INSERT INTO SessionReason (reason_id, reason)
VALUES ('84', 'Wedding');

INSERT INTO SessionReason (reason_id, reason)
VALUES ('85', 'Baby');

SELECT * FROM SessionReason;

-- Sample data for PhotoSession table

INSERT INTO PhotoSession (session_id, date_time_id, account_number, location_id, pricing_id, reason_id)
VALUES (101, 21, 1, 31, 61, 81);

INSERT INTO PhotoSession (session_id, date_time_id, account_number, location_id, pricing_id, reason_id)
VALUES (102, 22, 1, 32, 62, 82);

INSERT INTO PhotoSession (session_id, date_time_id, account_number, location_id, pricing_id, reason_id)
VALUES (201, 23, 2, 33, 63, 83);

INSERT INTO PhotoSession (session_id, date_time_id, account_number, location_id, pricing_id, reason_id)
VALUES (202, 24, 2, 34, 64, 84);

INSERT INTO PhotoSession (session_id, date_time_id, account_number, location_id, pricing_id, reason_id)
VALUES (301, 26, 3, 35, 65, 85);

INSERT INTO PhotoSession (session_id, date_time_id, account_number, location_id, pricing_id, reason_id)
VALUES (401, 27, 4, 36, 61, 81);

INSERT INTO PhotoSession (session_id, date_time_id, account_number, location_id, pricing_id, reason_id)
VALUES (501, 28, 5, 37, 62, 82);

INSERT INTO PhotoSession (session_id, date_time_id, account_number, location_id, pricing_id, reason_id)
VALUES (601, 29, 6, 38, 63, 83);

INSERT INTO PhotoSession (session_id, date_time_id, account_number, location_id, pricing_id, reason_id)
VALUES (701, 240, 7, 38, 63, 83);

INSERT INTO PhotoSession (session_id, date_time_id, account_number, location_id, pricing_id, reason_id)
VALUES (801, 210, 8, 40, 65, 85);

INSERT INTO PhotoSession (session_id, date_time_id, account_number, location_id, pricing_id, reason_id)
VALUES (902, 230, 9, 31, 61, 81);

INSERT INTO PhotoSession (session_id, date_time_id, account_number, location_id, pricing_id, reason_id)
VALUES (903, 22, 10, 32, 62, 82);

SELECT * FROM PhotoSession;

-- Sample data for Cancellations

INSERT INTO Cancellations (account_number, session_id, date_cancelled)
VALUES (1, 101, TO_DATE('02-APR-2023', 'DD-MON-YYYY'));

INSERT INTO Cancellations (account_number, session_id, date_cancelled)
VALUES (4, 102, TO_DATE('06-APR-2023', 'DD-MON-YYYY'));

INSERT INTO Cancellations (account_number, session_id, date_cancelled)
VALUES (3, 201, TO_DATE('09-APR-2023', 'DD-MON-YYYY'));

INSERT INTO Cancellations (account_number, session_id, date_cancelled)
VALUES (2, 202, TO_DATE('10-APR-2023', 'DD-MON-YYYY'));

INSERT INTO Cancellations (account_number, session_id, date_cancelled)
VALUES (2, 202, TO_DATE('22-APR-2023', 'DD-MON-YYYY'));

INSERT INTO Cancellations (account_number, session_id, date_cancelled)
VALUES (2, 202, TO_DATE('23-APR-2023', 'DD-MON-YYYY'));

INSERT INTO Cancellations (account_number, session_id, date_cancelled)
VALUES (5, 301, TO_DATE('28-APR-2023', 'DD-MON-YYYY'));

INSERT INTO Cancellations (account_number, session_id, date_cancelled)
VALUES (5, 401, TO_DATE('02-MAY-2023', 'DD-MON-YYYY'));

INSERT INTO Cancellations (account_number, session_id, date_cancelled)
VALUES (7, 501, TO_DATE('04-MAY-2023', 'DD-MON-YYYY'));

INSERT INTO Cancellations (account_number, session_id, date_cancelled)
VALUES (9, 701, TO_DATE('10-MAY-2023', 'DD-MON-YYYY'));

INSERT INTO Cancellations (account_number, session_id, date_cancelled)
VALUES (9, 801, TO_DATE('14-MAY-2023', 'DD-MON-YYYY'));

INSERT INTO Cancellations (account_number, session_id, date_cancelled)
VALUES (10, 902, TO_DATE('17-MAY-2023', 'DD-MON-YYYY'));

SELECT * FROM Cancellations;

-- Sample data for DigitisedPhotograph

INSERT INTO DigitisedPhotograph (digitised_photo_id, session_id)
VALUES (1002, 101);

INSERT INTO DigitisedPhotograph (digitised_photo_id, session_id)
VALUES (1013, 102);

INSERT INTO DigitisedPhotograph (digitised_photo_id, session_id)
VALUES (1022, 201);

INSERT INTO DigitisedPhotograph (digitised_photo_id, session_id)
VALUES (1029, 202);

INSERT INTO DigitisedPhotograph (digitised_photo_id, session_id)
VALUES (3421, 301);

INSERT INTO DigitisedPhotograph (digitised_photo_id, session_id)
VALUES (3671, 401);

INSERT INTO DigitisedPhotograph (digitised_photo_id, session_id)
VALUES (3672, 401);

INSERT INTO DigitisedPhotograph (digitised_photo_id, session_id)
VALUES (3942, 501);

INSERT INTO DigitisedPhotograph (digitised_photo_id, session_id)
VALUES (3951, 501);

INSERT INTO DigitisedPhotograph (digitised_photo_id, session_id)
VALUES (4136, 601);

INSERT INTO DigitisedPhotograph (digitised_photo_id, session_id)
VALUES (4179, 701);

INSERT INTO DigitisedPhotograph (digitised_photo_id, session_id)
VALUES (4198, 801);

SELECT * FROM DigitisedPhotograph;

-- Sample data for PostalCharge

INSERT INTO PostalCharge (postal_charge_id, charge_description, charge_amount)
VALUES (151001, 'Domestic shipping', 5.00);

INSERT INTO PostalCharge (postal_charge_id, charge_description, charge_amount)
VALUES (171002, 'International shipping', 15.50);

INSERT INTO PostalCharge (postal_charge_id, charge_description, charge_amount)
VALUES (171234, 'Domestic shipping', 10.00);

INSERT INTO PostalCharge (postal_charge_id, charge_description, charge_amount)
VALUES (175432, 'Domestic shipping', 15.50);

INSERT INTO PostalCharge (postal_charge_id, charge_description, charge_amount)
VALUES (249016, 'Domestic shipping', 7.50);

INSERT INTO PostalCharge (postal_charge_id, charge_description, charge_amount)
VALUES (271002, 'International shipping', 19.50);

INSERT INTO PostalCharge (postal_charge_id, charge_description, charge_amount)
VALUES (271003, 'Domestic shipping', 8.50);

INSERT INTO PostalCharge (postal_charge_id, charge_description, charge_amount)
VALUES (271004, 'International shipping', 14.50);

INSERT INTO PostalCharge (postal_charge_id, charge_description, charge_amount)
VALUES (271234, 'International shipping', 16.50);

INSERT INTO PostalCharge (postal_charge_id, charge_description, charge_amount)
VALUES (275432, 'Domestic shipping', 9.50);

INSERT INTO PostalCharge (postal_charge_id, charge_description, charge_amount)
VALUES (275234, 'Domestic shipping', 10);

INSERT INTO PostalCharge (postal_charge_id, charge_description, charge_amount)
VALUES (275324, 'Domestic shipping', 7.50);

SELECT * FROM PostalCharge;

-- Sample data for PostalAddress

INSERT INTO PostalAddress (postal_address_id, address, suburb, city, postcode)
VALUES (51, '10 Lincoln St', 'Ponsonby', 'Auckland', '1020');

INSERT INTO PostalAddress (postal_address_id, address, suburb, city, postcode)
VALUES (52, '456 Elm St', 'Mount Eden', 'Auckland', '1341');

INSERT INTO PostalAddress (postal_address_id, address, suburb, city, postcode)
VALUES (53, '1 Queen St', 'Ponsonby', 'Auckland', '1234');

INSERT INTO PostalAddress (postal_address_id, address, suburb, city, postcode)
VALUES (54, '789 Oak Ave', 'New Lynn', 'Auckland', '5432');

INSERT INTO PostalAddress (postal_address_id, address, suburb, city, postcode)
VALUES (55, '987 Willow Ln', 'Papakura', 'Auckland', '7891');

INSERT INTO PostalAddress (postal_address_id, address, suburb, city, postcode)
VALUES (56, '543 Elm St', 'Albany', 'Auckland', '5321');

INSERT INTO PostalAddress (postal_address_id, address, suburb, city, postcode)
VALUES (57, '234 Birch Rd', 'Henderson', 'Auckland', '5652');

INSERT INTO PostalAddress (postal_address_id, address, suburb, city, postcode)
VALUES (58, '876 Pine St', 'Botany Downs', 'Auckland', '5432');

INSERT INTO PostalAddress (postal_address_id, address, suburb, city, postcode)
VALUES (59, '567 Maple Dr', 'Manukau', 'Auckland', '5431');

INSERT INTO PostalAddress (postal_address_id, address, suburb, city, postcode)
VALUES (60, '987 City Rd', 'Parnell', 'Auckland', '5170');

INSERT INTO PostalAddress (postal_address_id, address, suburb, city, postcode)
VALUES (61, '234 Albany Rd', 'Ponsonby', 'Auckland', '4510');

INSERT INTO PostalAddress (postal_address_id, address, suburb, city, postcode)
VALUES (62, '456 Swanson Rd', 'Henderson', 'Auckland', '1510');

SELECT * FROM PostalAddress;

-- Sample Data for PhotoOrder
INSERT INTO PhotoOrder (order_no, account_number, postal_charge_id, postal_address_id, date_accepted, time_accepted)
VALUES (91001, 1, 151001, 51, TO_DATE('02-MAY-2023', 'DD-MON-YYYY'), '10:30 AM');

INSERT INTO PhotoOrder (order_no, account_number, postal_charge_id, postal_address_id, date_accepted, time_accepted)
VALUES (91002, 2, 171234, 52, TO_DATE('04-MAY-2023', 'DD-MON-YYYY'), '02:30 PM');

INSERT INTO PhotoOrder (order_no, account_number, postal_charge_id, postal_address_id, date_accepted, time_accepted)
VALUES (91003, 2, 175432, 53, TO_DATE('04-MAY-2023', 'DD-MON-YYYY'), '06:30 PM');

INSERT INTO PhotoOrder (order_no, account_number, postal_charge_id, postal_address_id, date_accepted, time_accepted)
VALUES (91004, 3, 171002, 54, TO_DATE('12-MAY-2023', 'DD-MON-YYYY'), '11:30 AM');

INSERT INTO PhotoOrder (order_no, account_number, postal_charge_id, postal_address_id, date_accepted, time_accepted)
VALUES (91005, 4, 249016, 55, TO_DATE('13-MAY-2023', 'DD-MON-YYYY'), '04:00 PM');

INSERT INTO PhotoOrder (order_no, account_number, postal_charge_id, postal_address_id, date_accepted, time_accepted)
VALUES (91006, 5, 271002, 56, TO_DATE('14-MAY-2023', 'DD-MON-YYYY'), '08:30 PM');

INSERT INTO PhotoOrder (order_no, account_number, postal_charge_id, postal_address_id, date_accepted, time_accepted)
VALUES (91007, 6, 271003, 57, TO_DATE('15-MAY-2023', 'DD-MON-YYYY'), '03:30 PM');

INSERT INTO PhotoOrder (order_no, account_number, postal_charge_id, postal_address_id, date_accepted, time_accepted)
VALUES (91008, 7, 271004, 58, TO_DATE('15-MAY-2023', 'DD-MON-YYYY'), '04:00 PM');

INSERT INTO PhotoOrder (order_no, account_number, postal_charge_id, postal_address_id, date_accepted, time_accepted)
VALUES (91009, 8, 271234, 59, TO_DATE('16-MAY-2023', 'DD-MON-YYYY'), '09:30 AM');

INSERT INTO PhotoOrder (order_no, account_number, postal_charge_id, postal_address_id, date_accepted, time_accepted)
VALUES (91010, 9, 275432, 60, TO_DATE('16-MAY-2023', 'DD-MON-YYYY'), '12:00 PM');

INSERT INTO PhotoOrder (order_no, account_number, postal_charge_id, postal_address_id, date_accepted, time_accepted)
VALUES (91011, 10, 275234, 61, TO_DATE('17-MAY-2023', 'DD-MON-YYYY'), '01:30 PM');

INSERT INTO PhotoOrder (order_no, account_number, postal_charge_id, postal_address_id, date_accepted, time_accepted)
VALUES (91012, 10, 275324, 62, TO_DATE('19-MAY-2023', 'DD-MON-YYYY'), '10:30 AM');

SELECT * FROM PhotoOrder;

-- Sample Data for SelectedPhoto

INSERT INTO SelectedPhoto (selected_photo_id, digitised_photo_id, order_no, photo_colour, photo_finish, photo_size, quantity, pricing)
VALUES (9901, 1002, 91001, 'Green', 'Matte', '10x15', 10, 4.75);

INSERT INTO SelectedPhoto (selected_photo_id, digitised_photo_id, order_no, photo_colour, photo_finish, photo_size, quantity, pricing)
VALUES (9902, 1013, 91002, 'Blue', 'Glossy', '15x20', 15, 7.95);

INSERT INTO SelectedPhoto (selected_photo_id, digitised_photo_id, order_no, photo_colour, photo_finish, photo_size, quantity, pricing)
VALUES (9903, 1022, 91003, 'White', 'Matte', '20x25', 10, 9.95);

INSERT INTO SelectedPhoto (selected_photo_id, digitised_photo_id, order_no, photo_colour, photo_finish, photo_size, quantity, pricing)
VALUES (9904, 1029, 91004, 'Black', 'Glossy', '15x20', 15, 7.95);

INSERT INTO SelectedPhoto (selected_photo_id, digitised_photo_id, order_no, photo_colour, photo_finish, photo_size, quantity, pricing)
VALUES (9905, 3421, 91005, 'Orange', 'Matte', '30x40', 10, 14.95);

INSERT INTO SelectedPhoto (selected_photo_id, digitised_photo_id, order_no, photo_colour, photo_finish, photo_size, quantity, pricing)
VALUES (9906, 3671, 91006, 'Yellow', 'Matte', '10x15', 10, 4.75);

INSERT INTO SelectedPhoto (selected_photo_id, digitised_photo_id, order_no, photo_colour, photo_finish, photo_size, quantity, pricing)
VALUES (9907, 3672, 91007, 'Green', 'Glossy', '20x25', 10, 9.95);

INSERT INTO SelectedPhoto (selected_photo_id, digitised_photo_id, order_no, photo_colour, photo_finish, photo_size, quantity, pricing)
VALUES (9908, 3942, 91008, 'Blue', 'Matte', '10x15', 10, 4.75);

INSERT INTO SelectedPhoto (selected_photo_id, digitised_photo_id, order_no, photo_colour, photo_finish, photo_size, quantity, pricing)
VALUES (9909, 3951, 91009, 'Orange', 'Glossy', '15x20', 25, 13.25);

INSERT INTO SelectedPhoto (selected_photo_id, digitised_photo_id, order_no, photo_colour, photo_finish, photo_size, quantity, pricing)
VALUES (9910, 4136, 91010, 'Blue', 'Matte', '20x25', 10, 9.95);

INSERT INTO SelectedPhoto (selected_photo_id, digitised_photo_id, order_no, photo_colour, photo_finish, photo_size, quantity, pricing)
VALUES (9911, 4179, 91011, 'Green', 'Glossy', '10x15', 10, 4.75);

INSERT INTO SelectedPhoto (selected_photo_id, digitised_photo_id, order_no, photo_colour, photo_finish, photo_size, quantity, pricing)
VALUES (9912, 4198, 91012, 'Orange', 'Matte', '15x20', 10, 5.95);

SELECT * FROM SelectedPhoto;

COMMIT;