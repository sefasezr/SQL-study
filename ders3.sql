----------------DAY 4 DT-NT---------------------

/*WHERE ifadesi, belirli koşulları karşılayan kayıtları seçmek için kullanılır. Bir SELECT, UPDATE ya da DELETE sorgusunda, hangi satırların işleme dahil edileceğini belirtmek için WHERE koşulu eklenir.*/

--worker tablosundan ismi 'Donatello' olanların tüm bilgilerini listeleyelim
--Let's list all the information of those whose name is 'Donatello' from the worker table

SELECT * FROM worker WHERE isim='Donatello';

--worker tablosundan maaşı 5000’den fazla olanların tüm bilgilerini listeleyelim
--Let's list all the information of those whose salary is more than 5000 from the worker table

SELECT * FROM worker WHERE maas>5000;

--worker tablosundan maaşı 5000’den fazla olanların isim ve maaşlarını listeleyelim
--Let's list the names and salaries of those whose salary is more than 5000 from the worker table

SELECT isim, maas FROM worker WHERE maas>5000;

--address tablosundan sehri 'Konya' ve 
--adres_id'si 10002 olan kaydın tüm verilerini getirelim
--select the city 'Konya' from the address table and 
--Let's get all the data of the record with address_id 10002

SELECT * FROM address WHERE sehir='Konya' AND adres_id='10002';

--sehri 'Konya' veya 'Bursa' olan adreslerin cadde ve sehir bilgilerini getirelim.
--Let's get the street and city information for addresses whose city is 'Konya' or ‘Bursa'.

SELECT cadde, sehir FROM address WHERE sehir='Konya' OR sehir='Bursa';

/*
DELETE FROM
DML (Data Manipulation Language) Komutu: DELETE FROM bir DML komutudur. DML komutları, veritabanındaki verileri yönetir ve değiştirir.

Rollback İle Geri Alınabilir: DELETE işlemi, bir işlem (transaction) içinde yapıldığında ve işlem henüz COMMIT edilmeden ROLLBACK komutu ile geri alınabilir.COMMIT edilmişse, bu işlem kalıcı hale gelir ve veritabanında yapılan değişiklikler geri alınamaz.

Performans: Büyük tablolarda DELETE komutu yavaş çalışabilir, çünkü her bir satırı tek tek siler ve işlem sırasında log kayıtları tutar. Bu nedenle, büyük miktarlarda veriyi silmek için farklı stratejiler veya komutlar kullanmak performansı iyileştirebilir (örneğin, TRUNCATE komutu veya verileri daha küçük parçalara bölerek silmek).*/

/*Senaryo: “students1” adinda bir tablo oluşturun.

students1 tablosu sütunları: 
id INTEGER, isim VARCHAR(50), veli_isim VARCHAR(50), yazili_notu INTEGER

Tablo uzerinde cesitli silme islemleri yapiniz*/

/*Scenario: Create a table named "students1".

students1 table columns: 
id INTEGER, name VARCHAR(50), parent_name VARCHAR(50), written_note INTEGER

Perform various deletion operations on the table*/

CREATE TABLE students1
(
id int,
isim VARCHAR(50),
veli_isim VARCHAR(50),
yazili_notu int       
);

INSERT INTO students1 VALUES(122, 'Kerem Can', 'Fatma',75),
(123, 'Ali Can', 'Hasan',75),
(124, 'Veli Han', 'Ayse',85),
(125, 'Kemal Tan', 'Hasan',85),
(126, 'Ahmet Ran', 'Ayse',95),
(127, 'Mustafa Bak', 'Can',99),
(128, 'Mustafa Bak', 'Ali', 99),
(129, 'Mehmet Bak', 'Alihan', 89);

SELECT * FROM students1;

--id=123 olan kaydı silelim.
-- Let's delete the record with id=123.

DELETE FROM students1 WHERE id=123;

--ismi Kemal Tan olan kaydı silelim.
-- delete the entry with the name Kemal Tan.

DELETE FROM students1 WHERE isim='Kemal Tan';

--ismi Ahmet Ran veya Veli Han olan kayıtları silelim
-- delete records with the name Ahmet Ran or Veli Han

DELETE FROM students1 WHERE isim='Ahmet Ran' OR isim='Veli Han';

--15-a-tablodaki tüm kayıtları silme:DELETE FROM: DML,rollback ile geri alınabilir

SELECT * FROM students;

--students tablosundan  tüm kayıtları silelim.
-- delete all records from the students table.

DELETE FROM students;

--NOT: DELETE FROM komutu koşulsuz kullanıldığında
--tüm satırları siler ancak tablo kalır.

--satirlari tek tek sildigi icin yavastir. Daha hizlisi var. (TRUNCATE)

--16-Tablodaki tüm kayıtları silme:TRUNCATE TABLE:DDL

CREATE TABLE doctors(
id SERIAL,
name VARCHAR(30) NOT NULL,
salary REAL,
email VARCHAR(50) UNIQUE	
);

SELECT * FROM doctors;

INSERT INTO doctors(name,salary,email) VALUES('Dr. Gregory House',6000,'dr@mail.com');
INSERT INTO doctors(salary,email) VALUES(6000,'doctor@mail.com'); --hata, not-null constraint
INSERT INTO doctors(name,salary,email) VALUES('',6000,'doc@mail.com');

--doctors tablosundan tüm kayıtları silelim.
--Delete all records from the doctors table

TRUNCATE TABLE doctors;

--17-parent-child ilişkisi olan tablolardan kayıt silme
--Delete records from tables with parent-child relationship


SELECT * FROM worker; --parent
SELECT * FROM address; --child

--worker tablosundan tüm kayıtları silelim.
-- delete all records from the worker table.

DELETE FROM worker; --hata
--worker tablosunda address tablosu tarafından referans alınan kayıtlar olduğu 
--için silmeye izin yoktur

DELETE FROM worker WHERE id='10002'; --referans alinan bir kaydi silemezsiniz
--Once child'dan silmeliyiz

DELETE FROM address WHERE adres_id='10002'; --child'da referans alan kayit silindi

DELETE FROM worker WHERE id='10002'; 

DELETE FROM address; --tum iliski koparildi
DELETE FROM worker; --artik hicbir kayir referans alinmadigi icin basarili

--18-ON DELETE CASCADE

/*Senaryo: “students2” ve “grades2” adlarinda iki tablo oluşturun.

students2 tablosu sütunları: 
id int, isim VARCHAR(50), veli_isim VARCHAR(50), yazili_notu int

grades2 tablosu sütunları:
talebe_id int, ders_adi varchar(30), yazili_notu int

Tablolari birbirine baglayarak, ON DELETE CASCADE uygulamasi yapiniz*/

/*Scenario: Create two tables named "students2" and "grades2".

students2 table columns: 
id int, name VARCHAR(50), parent_name VARCHAR(50), written_note int

grades2 table columns:
student_id int, course_name varchar(30), written_note int

Apply ON DELETE CASCADE by linking the tables together*/

CREATE TABLE students2
(
id int primary key,  
isim VARCHAR(50),
veli_isim VARCHAR(50),
yazili_notu int
);

CREATE TABLE grades2( 
talebe_id int,
ders_adi varchar(30),
yazili_notu int,
CONSTRAINT notlar_fk FOREIGN KEY (talebe_id) REFERENCES students2(id) ON DELETE CASCADE 	
);

INSERT INTO students2 VALUES
(122, 'Kerem Can', 'Fatma',75),
(123, 'Ali Can', 'Hasan',75),
(124, 'Veli Han', 'Ayse',85),
(125, 'Kemal Tan', 'Hasan',85),
(126, 'Ahmet Ran', 'Ayse',95),
(127, 'Mustafa Bak', 'Can',99),
(128, 'Mustafa Bak', 'Ali', 99),
(129, 'Mehmet Bak', 'Alihan', 89);

INSERT INTO grades2 VALUES 
 ('123','kimya',75),
 ('124', 'fizik',65),
 ('125', 'tarih',90),
 ('126', 'Matematik',90),
 ('127', 'Matematik',90),
 (null, 'tarih',90);

SELECT * FROM students2; --parent/referenced
SELECT * FROM grades2; --child

DELETE FROM grades2 WHERE talebe_id=123; --basarili
DELETE FROM students2 WHERE id=126;
--ON DELETE CASCADE otomatik olarak önce child olan grades2 tablosundan referans verilen kaydi siler
--sonra parent olan students2 den bu kaydi siler

DELETE FROM students2; --once child (grades2) silindi sonra da students2 silindi

DELETE FROM grades2; --null olan kaydi sildik

--19-tabloyu silme

DROP TABLE students2; --hata cunku child'i var

DROP TABLE students2 CASCADE; --cascade baglari koparir. child silinmez

DROP TABLE IF EXISTS students18; --tablo yoksa notice (uyari) verir

--20-IN Condition
--IN: Bir değerin belirli bir değerler listesi içinde olup olmadığını kontrol eder.

/*Senaryo: “customers” adinda bir tablo oluşturun.

customers tablosu sütunları: 
urun_id INTEGER, musteri_isim VARCHAR(50), urun_isim VARCHAR(50)

Tablo uzerinde IN kullanimi yapiniz*/

/*Scenario: Create a table named "customers".

customers table columns: 
product_id INTEGER, customer_name VARCHAR(50), product_name VARCHAR(50)

Use IN on the table */

CREATE TABLE customers  (
urun_id int,  
musteri_isim varchar(50),
urun_isim varchar(50)
);

INSERT INTO customers VALUES (10, 'Mark', 'Orange');
INSERT INTO customers VALUES (10, 'Mark', 'Orange');
INSERT INTO customers VALUES (20, 'John', 'Apple');
INSERT INTO customers VALUES (30, 'Amy', 'Palm');
INSERT INTO customers VALUES (20, 'Mark', 'Apple');
INSERT INTO customers VALUES (10, 'Adem', 'Orange');
INSERT INTO customers VALUES (40, 'John', 'Apricot');
INSERT INTO customers VALUES (20, 'Eddie', 'Apple');

SELECT * FROM customers;

--customers tablosundan ürün ismi 'Orange', 'Apple' veya 'Apricot' olan verileri listeleyiniz.
-- List the data from the customers table with product name 'Orange', 'Apple' or 'Apricot'.

--1.yol:
SELECT * FROM customers WHERE urun_isim='Orange' OR urun_isim='Apple' OR urun_isim='Apricot';

--2.yol:
SELECT * FROM customers WHERE urun_isim IN('Orange','Apple','Apricot');

--customers tablosundan ürün ismi 'Orange', 'Apple' ve 'Apricot' olmayan verileri listeleyiniz.
--List the data from the customers table that do not have the product names 'Orange', 'Apple' and ‘Apricot'.

SELECT * FROM customers WHERE urun_isim NOT IN('Orange','Apple','Apricot');

--21-BETWEEN .. AND ...
--customers tablosunda urun_id 20(dahil) ile 30(dahil) arasinda olan urunlerin tum bilgilerini listeleyiniz
--List all the information of the products with product_id between 20(inclusive) and 30(inclusive) in the customers table

----20+++++++++++30------

--1.yol:
SELECT * FROM customers WHERE urun_id>=20 AND urun_id<=30;

--2.yol:
SELECT * FROM customers WHERE urun_id BETWEEN 20 AND 30;

--customers tablosunda urun_id degeri 20’den küçük veya 30’dan büyük olan urunlerin tum bilgilerini listeleyiniz.(yani 20 ve 30 dahil değil)
--List all the information of the products whose product_id value is less than 20 or greater than 30 in the customers table (ie 20 and 30 are not included).

+++++++20-------------30+++++++++
SELECT * FROM customers WHERE urun_id NOT BETWEEN 20 AND 30;

--22-AGGREGATE Fonk.

/*COUNT(): Belirtilen sütunda kaç adet değer olduğunu sayar.
SUM(): Sayısal bir sütundaki tüm değerlerin toplamını hesaplar.
AVG(): Sayısal bir sütundaki tüm değerlerin ortalamasını hesaplar.
MIN(): Bir sütundaki en küçük değeri bulur.
MAX(): Bir sütundaki en büyük değeri bulur.*/

/*Senaryo: “brands” ve “employees3” adinda iki tablo oluşturun.*/
/*Scenario: Create two tables named "brands" and "employees3".*/

CREATE TABLE brands
(
marka_id int, 
marka_isim VARCHAR(20), 
calisan_sayisi int
);

INSERT INTO brands VALUES(100, 'Vakko', 12000);
INSERT INTO brands VALUES(101, 'Pierre Cardin', 18000);
INSERT INTO brands VALUES(102, 'Adidas', 10000);
INSERT INTO brands VALUES(103, 'LCWaikiki', 21000);

CREATE TABLE employees3 (
id int, 
isim VARCHAR(50), 
sehir VARCHAR(50), 
maas int, 
isyeri VARCHAR(20)
);

INSERT INTO employees3 VALUES(123456789, 'Ali Seker', 'Istanbul', 2500, 'Vakko');
INSERT INTO employees3 VALUES(234567890, 'Ayse Gul', 'Istanbul', 1500, 'LCWaikiki');
INSERT INTO employees3 VALUES(345678901, 'Veli Yilmaz', 'Ankara', 3000, 'Vakko');
INSERT INTO employees3 VALUES(456789012, 'Veli Yilmaz', 'Izmir', 1000, 'Pierre Cardin');
INSERT INTO employees3 VALUES(567890123, 'Veli Yilmaz', 'Ankara', 7000, 'Adidas');
INSERT INTO employees3 VALUES(456789012, 'Ayse Gul', 'Ankara', 1500, 'Pierre Cardin');
INSERT INTO employees3 VALUES(123456710, 'Fatma Yasa', 'Bursa', 2500, 'Vakko');

SELECT * FROM brands;
SELECT * FROM employees3;

--employees3 tablosunda max maaş değerini bulunuz.
--Find the max salary value in the employees3 table.

SELECT MAX(maas) FROM employees3; --7000

--employees3 tablosunda min maaş değerini bulunuz.
--Find the min salary value in the employees3 table.

SELECT MIN(maas) FROM employees3; --1000

--employees3 tablosunda toplam maaş değerini bulunuz.
--Find the total salary value in the employees3 table.

SELECT SUM(maas) FROM employees3; --19000

--employees3 tablosunda ortalama maaş değerini bulunuz.
--Find the average salary value in the employees3 table.

SELECT AVG(maas) FROM employees3; --2714.2857142857142857

SELECT ROUND(AVG(maas), 2) FROM employees3; --2714.29

--employees3 tablosundaki kayıt sayısını bulunuz.
--Find the number of records in the employees3 table.

SELECT COUNT(id) FROM employees3;

--employees3 tablosunda maaşı 2500 olanların kayıt sayısını bulunuz.
--Find the number of records of those whose salary is 2500 in the employees3 table.

SELECT COUNT(*) FROM employees3 WHERE maas=2500; --2