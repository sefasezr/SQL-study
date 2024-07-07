--*********************************************HOMEWORK-1**************************************************
--1)
CREATE DATABASE sqlpractice_db;

--2)
CREATE TABLE musteri(
	musteri_no SERIAL PRIMARY KEY,
	isim VARCHAR(50) NOT NULL CHECK (isim != ''),
	yas INTEGER CHECK (yas > 18),
	cinsiyet VARCHAR(1),
	gelir REAL,
	meslek VARCHAR(20),
	sehir VARCHAR(20)
);

--3)
INSERT INTO musteri(isim,yas,cinsiyet,gelir,meslek,sehir) VALUES('Ali',     35,'E',  2500, 'MÜHENDİS',    'İSTANBUL');
INSERT INTO musteri(isim,yas,cinsiyet,gelir,meslek,sehir) VALUES('BURAK',   25, 'E', 3500, 'MİMAR',       'İZMİR');
INSERT INTO musteri(isim,yas,cinsiyet,gelir,meslek,sehir) VALUES('CEYHUN',  45, 'E', 2000, 'MÜHENDİS',    'ANKARA');
INSERT INTO musteri(isim,yas,cinsiyet,gelir,meslek,sehir) VALUES('DEMET',   30, 'K', 3000, 'ÖĞRETMEN',    'ANKARA');
INSERT INTO musteri(isim,yas,cinsiyet,gelir,meslek,sehir) VALUES('FERHAT',  40, 'E', 2500, 'MİMAR',       'İZMİR');
INSERT INTO musteri(isim,yas,cinsiyet,gelir,meslek,sehir) VALUES('GALİP',   55, 'E', 4000, 'ÖĞRETMEN',    'İSTANBUL');
INSERT INTO musteri(isim,yas,cinsiyet,gelir,meslek,sehir) VALUES('KÖKSAL',  25, 'E', 2000, 'AVUKAT',      'İZMİR');
INSERT INTO musteri(isim,yas,cinsiyet,gelir,meslek,sehir) VALUES('LEYLA',   60, 'K', 2500, 'MİMAR',       'İSTANBUL');
INSERT INTO musteri(isim,yas,cinsiyet,gelir,meslek,sehir) VALUES('MELEK',   30, 'K', 2500, 'ÖĞRETMEN',    'İSTANBUL');
INSERT INTO musteri(isim,yas,cinsiyet,gelir,meslek,sehir) VALUES('JALE',    40, 'K', 6000, 'İŞLETMECİ',   'ANKARA');
INSERT INTO musteri(isim,yas,cinsiyet,gelir,meslek,sehir) VALUES('TEKİN',   45, 'E', 2000, 'AVUKAT',      'ANKARA');
INSERT INTO musteri(isim,yas,cinsiyet,gelir,meslek,sehir) VALUES('SAMET',   20, 'E', 3000, 'MİMAR',       'İSTANBUL');
INSERT INTO musteri(isim,yas,cinsiyet,gelir,meslek,sehir) VALUES('ŞULE',    20, 'K', 4500, 'ÖĞRETMEN',    'İSTANBUL');
INSERT INTO musteri(isim,yas,cinsiyet,gelir,meslek,sehir) VALUES('VELİ',    40, 'E', 2500, 'ÖĞRETMEN',    'İZMİR');
INSERT INTO musteri(isim,yas,cinsiyet,gelir,meslek,sehir) VALUES('ZEYNEP',  50, 'K', 3500, 'TESİSATÇI',   'İZMİR');
INSERT INTO musteri(isim,yas,cinsiyet,gelir,meslek,sehir) VALUES('ARDA',    55, 'E', 2000, 'KUAFÖR',      'İZMİR');
INSERT INTO musteri(isim,yas,cinsiyet,gelir,meslek,sehir) VALUES('MELİS',   30, 'K', 3000, 'KUAFÖR',      'ANKARA');

--4)
SELECT * FROM musteri;

--5)
SELECT isim,meslek FROM musteri;


--6)
CREATE TABLE sehirler(
	alan_kodu VARCHAR(3) PRIMARY KEY,
	isim VARCHAR(20) NOT NULL,
	nufus INTEGER
);

--7-a)
CREATE TABLE tedarikciler3(
	tedarikci_id VARCHAR(9) PRIMARY KEY,
	tedarikci_ismi VARCHAR(20),
	iletisim_isim VARCHAR(30) UNIQUE
);

--7-b)
CREATE TABLE urunler(
	tedarikci_id VARCHAR(9),
	urun_id VARCHAR(4),
	FOREIGN KEY (tedarikci_id) REFERENCES tedarikciler3 (tedarikci_id)
);


--*********************************************HOMEWORK-2**************************************************
--1)
CREATE TABLE filmler(
	film_isim VARCHAR(50),
	tur VARCHAR(20),
	sure REAL,
	imdb NUMERIC(2,1)
);

--2-a)
INSERT INTO filmler VALUES ('Hızlı ve Ofkeli','Aksiyon',135, 7.2);
INSERT INTO filmler VALUES ('Yüzüklerin Efendisi','Fantastik',120, 7.4);
INSERT INTO filmler VALUES ('Harry Potter','Fantastik',155, 7.1);

--2-b)
CREATE TABLE ogretmenler(
	kimlik_no VARCHAR(9),
	isim VARCHAR(40),
	brans VARCHAR (20),
	cinsiyet VARCHAR(5)
);

INSERT INTO ogretmenler VALUES ('234431223','Ayse Guler','Matematik','kadin');
INSERT INTO ogretmenler VALUES ('234431224','Ali Guler','Fizik','erkek');

--3)
CREATE TABLE film_imdb AS SELECT film_isim,imdb FROM filmler;

--4-a)
INSERT INTO filmler (film_isim, imdb) VALUES ('Ayla', 9.87);
INSERT INTO filmler (film_isim, imdb) VALUES ('Shrek', 9.83);

--4-b)
INSERT INTO ogretmenler (kimlik_no,isim) VALUES ('567597624','Veli Guler');

--*********************************************HOMEWORK-3**************************************************

--1)
SELECT * FROM musteri;
--2)
SELECT sehir FROM musteri
WHERE meslek = 'AVUKAT';
--3)
SELECT * FROM musteri
WHERE cinsiyet='K';
--4)
SELECT sehir FROM musteri
WHERE cinsiyet = 'K';
--5)
SELECT * FROM musteri
WHERE yas BETWEEN 40 AND 50;
--6)
SELECT meslek FROM musteri
WHERE cinsiyet='E';
--7)
SELECT * FROM musteri
WHERE yas NOT BETWEEN 40 AND 50;
--8)
SELECT * FROM musteri
WHERE (yas BETWEEN 30 AND 40) AND meslek= 'ÖĞRETMEN' AND cinsiyet='K';
--9)
SELECT * FROM musteri
WHERE (yas NOT BETWEEN 30 AND 40) AND cinsiyet ='E' AND meslek !='AVUKAT';
--10)
SELECT * FROM musteri
WHERE gelir BETWEEN 3000 AND 5000;
--11)
DELETE FROM musteri
WHERE isim = 'Ali';
--12)
DELETE FROM musteri
WHERE yas = 60;
--13)
DELETE FROM musteri
WHERE cinsiyet='K' AND meslek = 'KUAFÖR';
--14)
DELETE FROM musteri
WHERE gelir =6000 AND meslek = 'TESİSATÇI';
--15)
DELETE FROM musteri;
--16)
DROP TABLE tedarikciler3;  -- bunu silebilmem için önce çocuğunu silmeliyim
--17)
DROP TABLE urunler;  -- şimdi tedarikçiler3'ü silebilirim 








