/*Senaryo: “actors1” adında bir tablo oluşturun ve şu sütunları ekleyin:
id INTEGER
name VARCHAR(30)
surname VARCHAR(30)
film VARCHAR(50)
Not: Id’yi primary key olarak belirleyin*/
/*Scenario: Create a table called “actors1" and add the following columns:
id INTEGER
name VARCHAR(30)
surname VARCHAR(30)
film VARCHAR(50)
Note: Set Id as primary key*/

CREATE TABLE actors1(
	
	id INTEGER PRIMARY KEY,
	name varchar(30),
	surname VARCHAR(30),
	film VARCHAR(50)
);

SELECT * FROM actors1;

--2.yol: Ayri bir sutun gibi ekleme

/*Senaryo: "actors2" adında bir tablo oluşturun ve şu sütunları ekleyin:
id INTEGER
name VARCHAR(30) 
surname VARCHAR(30)
film VARCHAR(50)
Not: Id'yi primary key olarak belirleyin*/

/*Scenario: Create a table called "actors2" and add the following columns:
id INTEGER
name VARCHAR(30) 
surname VARCHAR(30)
film VARCHAR(50)
Note: Set Id as primary key*/

CREATE TABLE actors2(
	id INTEGER ,
	name varchar(30),
	surname VARCHAR(30),
	film VARCHAR(50),
	CONSTRAINT act_pk PRIMARY KEY(id)
);

SELECT * FROM actors2;

--composite KEY

CREATE TABLE company(
	job_id INTEGER, --PRIMARY KEY
	name VARCHAR(30), --PRIMARY KEY
	company VARCHAR(30),
	CONSTRAINT com_pk PRIMARY KEY(job_id,name)
	
);  --job_id ve name'i birleştirip tek primary key yaptık

SELECT * FROM company;

--Not 1: "Parent Table"da olmayan bir id'ye sahip datayi "Child Table"'a ekleyemezsiniz
--Not 2: Child Table'i silmeden Parent Table'i silemezsiniz. Once "Child Table" silinir, 
---sonra  "Parent Table" silinir.


--12-Tabloya FK constraint’i ekleme
/*Senaryo: “companies” ve “employees” adlarinda iki tablo oluşturun.
companies tablosu sütunları:
sirket_id INTEGER, sirket VARCHAR(50), personel_sayisi INTEGER
employees tablosu sütunları:
id INTEGER, isim VARCHAR(50), sehir VARCHAR(50), maas REAL, sirket VARCHAR(50)*/
/*Scenario: Create two tables named “companies” and “employees”.
Companies table columns:
company_id INTEGER, company VARCHAR(50), number_of_employees INTEGER
employees table columns:
id INTEGER, name VARCHAR(50), city VARCHAR(50), salary REAL, company VARCHAR(50)*/


CREATE TABLE companies(
	sirket_id INTEGER,
	sirket VARCHAR(50) PRIMARY KEY,
	personel_sayisi INTEGER
);

SELECT * FROM companies;

CREATE TABLE employees(
	id INTEGER,
	isim VARCHAR(50),
	sehir VARCHAR(50),
	maas REAL,
	sirket VARCHAR(50),
	CONSTRAINT per_fk FOREIGN KEY (sirket) REFERENCES companies (sirket)
);

SELECT * FROM employees;

--13-Tabloya CHECK constraint'i ekleme

--CHECK ile bir alana girilebilecek değerleri sınırlayabiliriz.

CREATE TABLE person(
	id INTEGER,
	name VARCHAR(50),
	salary REAL CHECK(salary>5000), --5000'den az kabul etmez
	age INTEGER CHECK(age>0) -- negatif kabul etmez
);

SELECT * FROM person;

INSERT INTO person VALUES(11,'Ali Can',6000,35);
INSERT INTO person VALUES(12,'Ali Can',6000,-3);  --person_age_check
INSERT INTO person VALUES(12,'Ali Can',4000,45);  --person_salary_check

/*Senaryo: "worker" ve "address" adlarinda iki tablo oluşturun.

worker tablosu sütunları: 
id CHAR(5), isim VARCHAR(50), maas INT, ise_baslama DATE

address tablosu sütunları:
adres_id CHAR(5), sokak VARCHAR(30), cadde VARCHAR(30), sehir VARCHAR(30)

Tablolari birbirine baglayarak, UNIQUE, NOT NULL uygulamasi yapiniz*/

/*Scenario: Create two tables named "worker" and "address".

worker table columns: 
id CHAR(5), name VARCHAR(50), salary INT, job_start DATE

address table columns:
address_id CHAR(5), street VARCHAR(30), street VARCHAR(30), city VARCHAR(30)

Apply UNIQUE, NOT NULL by linking tables together*/

CREATE TABLE worker(
	id char(5) PRIMARY KEY,
	name VARCHAR(50) UNIQUE,
	salary int NOT NULL,
	ise_baslama date

); --parent referans alinan, referenced

CREATE TABLE address(
	adres_id char(5),
	sokak varchar(30),
	cadde varchar(30),
	sehir varchar(30),

	FOREIGN KEY (adres_id) REFERENCES worker(id)
	
); --child

SELECT * FROM worker;
SELECT * FROM address;

INSERT INTO worker VALUES ('10002','Donatello',12000,'2018-04-14'); -- BASARILI
INSERT INTO worker VALUES ('10003',null,5000,'2018-04-14');      --basarili unique null kabul eder
INSERT INTO worker VALUES ('10004','Donatello',5000,'2018-04-14');  --hata cunku isim unique
INSERT INTO worker VALUES ('10005','Michelangelo',5000,'2018-04-14') --basarili
INSERT INTO worker VALUES ('10005','Michelangelo',null,'2018-04-14');   --hata maas null olamaz
INSERT INTO worker VALUES ('10006','Raphael','','2018-04-14');    --hata integer'a '' göönderemeyiz
INSERT INTO worker VALUES ('','April',2000,'2018-04-14');  --char empty kabul eder
INSERT INTO worker VALUES ('','Ms.April',2000,'2018-04-14');  --hata id primary key eşsiz olmalı
INSERT INTO worker VALUES ('10002','Splinter',12000,'2018-04-14');  --hata cunku 10002 daga once gonderildi
INSERT INTO worker VALUES (null,'Fred',12000,'2018-04-14');   --primary key null kabul etmez
INSERT INTO worker VALUES ('10008','Barnie',10000,'2018-04-14'); --basarili
INSERT INTO worker VALUES('10009','Wilma',11000,'2018-04-14');   --basarili
INSERT INTO worker VALUES('10010','Betty',12000,'2018-04-14');   --basarili

INSERT INTO address VALUES('10003','Ninja Sok','40.Cad.','IST');
INSERT INTO address VALUES('10003','Kaya Sok','50.Cad.','Ankara');
INSERT INTO address VALUES('10002','Taş Sok','30.Cad.','Konya');
INSERT INTO address VALUES('10012','Taş Sok','30.Cad.','Konya');  --hata cunku adres_id referansi olan worker(id)'de 12 degeri yok
INSERT INTO address VALUES(null,'Taş Sok','23.Cad.','Konya'); --basarili
INSERT INTO address VALUES(null,'Taş Sok','23.Cad.','Konya');


)



