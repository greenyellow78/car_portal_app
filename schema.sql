--
--CREATE DATABASE car_portal_app;

--
USE car_portal_app;
CREATE TABLE account (
	account_id INT NOT NULL IDENTITY PRIMARY KEY,
	first_name NVARCHAR(30) NOT NULL,
	last_name NVARCHAR(50) NOT NULL,
	email NVARCHAR(100) NOT NULL UNIQUE,
	passwd NVARCHAR(100) NOT NULL,
	
	CHECK (len(passwd)>=8)
);
ALTER TABLE account 
	ADD city varchar(30) DEFAULT 'Izmir';
--
CREATE TABLE account_history (
	account_history_id BIGINT PRIMARY KEY,
	account_id INT NOT NULL REFERENCES account(account_id),
	search_key nvarchar(100) NOT NULL,
	search_date DATE NOT NULL,
	CONSTRAINT UC_account_history UNIQUE (account_id, search_key, search_date)
);
CREATE TABLE seller_account (
	seller_account_id  INT NOT NULL IDENTITY PRIMARY KEY,
	account_id INT NOT NULL REFERENCES account(account_id),
	total_rank FLOAT,
	number_of_advertisement INT,
	street_name nvarchar(100) NOT NULL,
	street_number varchar(20) NOT NULL,
	zip_code varchar(5) NOT NULL,
	city nvarchar(20) NOT NULL
);
CREATE TABLE car_model
(
	car_model_id INT NOT NULL IDENTITY PRIMARY KEY,
	make nvarchar(30),
	model nvarchar(100),
	CONSTRAINT UC_car_model UNIQUE (make, model)
);
CREATE TABLE car (
	car_id INT NOT NULL IDENTITY PRIMARY KEY,
	number_of_owners INT NOT NULL,
	registration_number nvarchar(50) UNIQUE NOT NULL,
	manufacture_year INT NOT NULL,
	number_of_doors INT DEFAULT 5 NOT NULL,
	car_model_id INT NOT NULL REFERENCES car_model (car_model_id),
	mileage INT
);
CREATE TABLE advertisement(
	advertisement_id INT NOT NULL IDENTITY PRIMARY KEY,
	advertisement_date DATETIME NOT  NULL,
	car_id INT NOT NULL REFERENCES car(car_id),
	seller_account_id INT NOT NULL REFERENCES seller_account (seller_account_id)
);
CREATE TABLE advertisement_picture(
	advertisement_picture_id INT NOT NULL IDENTITY PRIMARY KEY,
	advertisement_id INT REFERENCES advertisement(advertisement_id),
	picture_location nvarchar(250) UNIQUE
);
CREATE TABLE advertisement_rating (
	advertisement_rating_id INT NOT NULL IDENTITY PRIMARY KEY,
	advertisement_id INT NOT NULL REFERENCES advertisement(advertisement_id),
	account_id INT NOT NULL REFERENCES account(account_id),
	advertisement_rating_date DATE NOT NULL,
	rank INT NOT NULL,
	review nvarchar(200) NOT NULL,
	CHECK (rank IN (1,2,3,4,5))
);
CREATE TABLE favorite_ads(
	account_id INT NOT NULL REFERENCES account(account_id),
	advertisement_id INT NOT NULL REFERENCES advertisement(advertisement_id),
	CONSTRAINT PK_favorite_ads PRIMARY KEY(account_id,advertisement_id)
);