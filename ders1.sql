----------------------DAY 2 DT-----------------------

--yorum satiri
/*Coklu
yorum
satiri*/

--1-Database olusturma - DDL
--kod ile veritabani olusturma

--CREATE DATABASE: Yeni bir veritabanani olusturmak için kullanılır.

CREATE DATABASE ali1_db;     --ali1_db adında bir veritabanı olustu

CREATE DATABASE ali1_db;  --HATA ayni isimli database olusturamazsiniz

--2-database silme -- DDL
--DROP DATABASE: Mevcut bir veritabanını silmek için kullanılır

DROP DATABASE ali1_db;       --ali1_db veritabanını sildik

--3-tablo Oluşturma--DDL
--CREATE TABLE: Yeni bir tablo oluşturmak için kullanılır.

/*
Senaryo: "students" adında bir tablo oluşturun ve şu sütunları ekleyin:

id INTEGER: Öğrencinin benzersiz kimlik numarası.
name VARCHAR(20): Öğrencinin adı (maksimum 20 karaktere kadar değişken uzunluk).
grade REAL: Öğrencinin notu (ondalikli sayı tipinde).
register_date DATE: Öğrencinin kayıt tarihi .
*/
/*
Scenario: Create a table called "students" and add the following columns:

id SERIAL: Unique ID number of the student (starting from 1, auto-incrementing).
name VARCHAR(20): Student's name (variable length up to a maximum of 20 characters).
grade REAL: Student's grade (decimal number type).
register_date DATE: Student's registration date .
*/

CREATE TABLE students(
	id INTEGER,
	name VARCHAR(20),
	grade REAL,
	register_date DATE
);


--4-Mevcut olan bir tablodan yeni tablo oluşturma - DDL
/*Senaryo: students tablosundaki öğrencilerin isimleri ve notları ile grades adında
yeni bir tablo oluşturunuz. Bu yeni tablo yalnızca name ve grade sütunlarını
içersin ve bu sütunlar students tablosundan kopyalansin. Sonrasinda bu tabloyu siliniz*/
/*Scenario: names and grades of students in the table students and grades in the table grades
create a new table. This new table contains only name and grade columns.
and copy these columns from the students table. Then delete this table*/

CREATE TABLE grades AS SELECT name , grade FROM students;  --AS SELECT şuradan al anlamında düşünülebilir 
                                              --ANCAK içindeki değerleri de alır

SELECT * FROM grades;

--5-Tabloyu silme - DDL

DROP TABLE grades;

--6-Tabloya data ekleme—DML

/*Senaryo: students tablosu Ali Can'in bilgilerini giriniz. Sonrada bu datalari 
okuyunuz (cekiniz)*/

/*Scenario: Enter Ali Can's information in the students table. Then enter this data 
read (pull out)*/

--INSERT INTO komutu, bir tabloya yeni kayıtlar eklemek için kullanılır.
--VALUES komutu, INSERT INTO komutu ile birlikte kullanılır. 
--Bu komut, sütunlara eklenecek değerlerin listesini sağlar.

INSERT INTO students VALUES(1001,'Ali Can',85.5,'2023-12-15');

--7- Data Okume / Cekme
--a) Tablodaki tüm dataları görüntüleme - DQL
--SELECT komutu, tablodaki kayıtları sorgulamak(görüntülemek) için kullanılır.
--“*” karakteri, “students” tablosundaki tüm sütunları seçmek için kullanılır.

SELECT * FROM students;

/*Senaryo: students tablosuna Veli Han'in bilgilerini giriniz. Sonrada bu datalari 
okuyunuz(cekiniz)*/

/*Scenario: Enter Veli Han's data in the students table. Then enter this data 
read(pull)*/

--now(), bir fonksiyondur ve şu anki tarihi almak için kullanılır

INSERT INTO students VALUES (1002,'Veli Han',80.2,now());

--b) Tablodan belli field'leri (sutunlari) okuma

SELECT name , grade FROM students;
SELECT name FROM students;

--8-Tabloda Bazi Istedigimiz Field’lara (Sutunlara) Data Ekleme ve Okuma
/*Senaryo: students tablosunda sadece name ve grade field’larina Ayse Kaya ve 97.4 verilerini giriniz. Sonrada bu datalari okuyunuz (cekiniz) */
/*Scenario: In the students table, enter Ayse Kaya and 97.4 data only in the name and grade fields Then read (extract) this data */

SELECT * FROM students;
INSERT INTO students(name , grade) VALUES ('Ayşe Kaya',97.4);

/*
ÖDEV:)

1) Tablo Oluşturma

"tedarikciler" isminde bir tablo olusturun,
"tedarikci_id", "tedarikci_ismi", "tedarikci_adres"
ve "ulasim_tarihi"	field'lari olsun. 

2) Var olan tablodan yeni tablo olusturmak 
 "tedarikci_info" isminde bir tabloyu  "tedarikciler" tablosundan olusturun.
Icinde "tedarikci_ismi", "ulasim_tarihi" field'lari olsun

3) Data ekleme
" ogretmenler" isminde tablo olusturun.
 Icinde "kimlik_no", "isim", "brans" ve "cinsiyet" field'lari olsun.
"ogretmenler" tablosuna bilgileri asagidaki gibi olan kisileri ekleyin.
kimlik_no: 234431223, isim: Ayse Guler, brans : Matematik, cinsiyet: kadin.
kimlik_no: 234431224, isim: Ali Guler, brans : Fizik, cinsiyet: erkek.

4) bazı fieldları olan kayıt ekleme
"ogretmenler" tablosuna bilgileri asagidaki gibi olan bir kisi ekleyin.
kimlik_no: 567597624, isim: Veli Guler
*/


--Veritabanında bir tablo oluşturduğunda, bu tablodaki bilgilerin doğru ve istediğin şekilde olmasını sağlamak 
--için bazı kurallar koyarsın. İşte bu kurallara “constraint” diyoruz

/*Senaryo: "actors" adında bir tablo oluşturun ve şu sütunları ekleyin:

id INTEGER
name VARCHAR(30) 
email VARCHAR(50) 

Scenario: Create a table called "actors" and add the following columns:

id INTEGER
name VARCHAR(30) 
email VARCHAR(50) 
*/

CREATE TABLE IF NOT EXISTS actors(
id INTEGER,
name VARCHAR(30),
email VARCHAR(50)
);

SELECT * FROM actors;

-- CREATE TABLE IF NOT EXISTS, Tablonun var olup olmadığını kontrol eder.

INSERT INTO actors VALUES(1001, 'Kemal Sunal', 'actor@gmail.com');
INSERT INTO actors VALUES(1002, 'Sener Sen', 'actor@gmail.com');

--INSERT INTO actors VALUES(1001, 'Kemal Sunal', 'actor@gmail.com'),(1002, 'Sener Sen', 'actor@gmail.com'); şeklinde de girilebilir

INSERT INTO actors(name) VALUES('Turkan Soray');

--9-Tabloya UNIQUE constraint'i ekleme
--Bir sütuna tekrarlı verilerin eklenememesi için tablo ve sütunları tanımlanırken UNIQUE kısıtlaması eklenir.

/*Senaryo: "programmers" adında bir tablo oluşturun ve şu sütunları ekleyin:

id SERIAL
name VARCHAR(30) 
email VARCHAR(50)
salary REAL
prog_lang VARCHAR(20)  
ve email'i unique yapin*/

/*Scenario: Create a table named "programmers" and add the following columns:

id SERIAL
name VARCHAR(30) 
email VARCHAR(50)
salary REAL
prog_lang VARCHAR(20)  
and make the email unique*/

CREATE TABLE programmers(
id SERIAL,
name VARCHAR(30) ,
email VARCHAR(50) UNIQUE,
salary REAL,
prog_lang VARCHAR(20) 
)
	
SELECT * FROM programmers;

INSERT INTO programmers (name, email, salary,prog_lang) VALUES ('Tom','mail@gmail.com',5000,'Java');
INSERT INTO programmers (name, email, salary,prog_lang) VALUES ('Jerry','mail@gmail.com',4000,'SQL'); --HATA email tekrarsiz olmaliydi
--unique birden fazla null'i kabul ediyor çünkü değer olarak görmüyor

INSERT INTO programmers (name, email, salary,prog_lang) VALUES ('Jerry','jerry@gmail.com',4000,'SQL');

--10-Tabloya NOT NULL constraint'i ekleme
--Bir sütuna NULL değerlerin  eklenememesi için tablo ve sütunları tanımlanırken NOT NULL kısıtlaması eklenir.

--name bilgisini girmeyelim. null olacak. peki olmasini istemeseydik?

INSERT INTO programmers (email,salary,prog_lang) VALUES ('python@gmail.com',4000,'Python');
-------------------------------
CREATE TABLE programmers1(
id SERIAL,
name VARCHAR(30) NOT NULL ,
email VARCHAR(50) UNIQUE,
salary REAL,
prog_lang VARCHAR(20) 
);

SELECT * FROM programmers1;

INSERT INTO programmers1 (name, email, salary,prog_lang) VALUES ('Tom','mail@gmail.com',5000,'Java');
INSERT INTO programmers1 (name, email, salary,prog_lang) VALUES ('Jerry','jerry@gmail.com',4000,'SQL');
--INSERT INTO programmers1 (email,salary,prog_lang) VALUES ('python@gmail.com',4000,'Python');  --HATA name NOT NULL old icin kabul etmedi
-- name field'i null olamaz 





