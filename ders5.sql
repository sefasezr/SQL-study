------------------DAY 6 DT---------------------

/*Senaryo 6: employees4 tablosunda maasi 1500 olanların isyerini, markalar tablosunda marka_id=100 olan markanın ismi ile değiştiriniz.*/

/*Scenario 6: Replace the workplace of those with salary 1500 in the employees4 table with the name of the brand with marka_id=100 in the brands table.*/

UPDATE employees4
SET isyeri=(SELECT marka_isim FROM brands WHERE marka_id=100)
WHERE maas=1500;

SELECT * FROM employees4;

--employees4 tablosundaki isyeri 'Vakko' olanların sehir bilgisinin sonuna ' Şubesi' ekleyiniz.
--Add ' Şubesi’ at the end of the city information of those whose workplace is 'Vakko' in the employees4 table.

--|| operatörü, SQL'de dizeleri birleştirmek (concatenate) için kullanılır. Java'daki + operatörü ile benzer işlevi görür.

UPDATE employees4
SET sehir=sehir || ' Subesi' --null olanlarda null dondurur. ekleme yapmaz
WHERE isyeri='Vakko'

--alternatif- null'i algilamasi icin

UPDATE employees4
SET sehir=CONCAT(sehir,' Subesi') --null'i algilar
WHERE isyeri='Vakko'

-------------------------------
--27-IS NULL condition 
 
--Ornek 1: employees4 tablosunda isim sütunu null olanları listeleyiniz.
--Example 1: List those whose name column is null in the employees4 table.

SELECT * FROM employees4
WHERE isim IS NULL

--Ornek 2: employees4 tablosunda isim sütunu null olmayanları listeleyiniz.
--Example 2: List those whose name column is not null in the employees4 table.

SELECT * FROM employees4
WHERE isim IS NOT NULL

--Ornek 3: employees4 tablosunda isim sütunu null olanların isim değerini 'isimsiz' olarak güncelleyiniz.
--Example 3: Update the name value of those whose name column is null in the employees4 table to ‘isimsiz'.

UPDATE employees4
SET isim='isimsiz'
WHERE isim IS NULL

-------------------------

--28-ORDER BY:kayıtları belirli bir field’e göre azalan/artan şekilde sıralamamızı sağlar.
--VARSAYILAN olarak ASC(natural-artan-doğal) olarak sıralar

/*ORDER BY komutu yalnızca SELECT sorgularıyla birlikte kullanılır çünkü amacı, bir sorgunun sonuç setini belirli kriterlere göre sıralamaktır.  INSERT, UPDATE ve DELETE komutlarıyla kullanılamaz. Bu komutlar, veritabanında veri eklemek, güncellemek veya silmek için kullanılır ve sonuç seti döndürmezler.*/

DROP TABLE person;

CREATE TABLE person
(
ssn char(9),
isim varchar(50),
soyisim varchar(50),  
adres varchar(50)
);

INSERT INTO person VALUES(123456789, 'Ali','Can', 'Istanbul');
INSERT INTO person VALUES(234567890, 'Veli','Cem', 'Ankara');  
INSERT INTO person VALUES(345678901, 'Mine','Bulut', 'Ankara');  
INSERT INTO person VALUES(256789012, 'Mahmut','Bulut', 'Istanbul'); 
INSERT INTO person VALUES (344678901, 'Mine','Yasa', 'Ankara');  
INSERT INTO person VALUES (345678901, 'Veli','Yilmaz', 'Istanbul');
INSERT INTO person VALUES(256789018, 'Samet','Bulut', 'Izmir'); 
INSERT INTO person VALUES(256789013, 'Veli','Cem', 'Bursa'); 
INSERT INTO person VALUES(256789010, 'Samet','Bulut', 'Ankara'); 

SELECT * FROM person;

/*Senaryo 1: person tablosundaki tüm kayıtları adrese göre (artan sirada) sıralayarak listeleyiniz.*/
/*Scenario 1: List all records in the person table sorted by address (in ascending order).*/

SELECT * 
FROM person
ORDER BY adres

SELECT * 
FROM person
ORDER BY adres ASC --ASC'yi gorunur yaptik

/*Senaryo 2: person tablosundaki tüm kayıtları soyisime göre (azalan) sıralayarak listeleyiniz.*/
/*Scenario 2: List all records in the person table sorted by surname (descending).*/

SELECT * 
FROM person
ORDER BY soyisim DESC

--person tablosundaki soyismi Bulut olanları isme göre (azalan) sıralayarak listeleyiniz.
--List the people whose surname is Bulut in the person table in descending order by name.

SELECT *
FROM person
WHERE soyisim='Bulut'
ORDER BY isim DESC

--alternatif

SELECT *
FROM person
WHERE soyisim='Bulut'
ORDER BY 2 DESC; --ikinci sutuna gore siralama yapti. tavsiye edilmez

-------------------------
/*Senaryo 3: person tablosundaki tüm kayıtları isme göre azalan, soyisme göre artan sekilde sıralayarak listeleyiniz.*/
/*Scenario 3: List all records in the person table in descending order by first name and ascending order by surname.*/

SELECT *
FROM person
ORDER BY isim DESC, soyisim ASC;

----------------------
/*Senaryo 4: person tablosunda isim ve soyisim değerlerini, soyisim kelime uzunluklarına göre sıralayarak listeleyiniz.*/
/*Scenario 4: List the name and surname values in the person table, sorted by surname word lengths.*/

SELECT isim, soyisim
FROM person
ORDER BY LENGTH(soyisim)

--3.sutun ile uzunluklari da yazdiralim. length’e isim de verelim

SELECT isim, soyisim, LENGTH(soyisim) AS karakter_sayisi
FROM person
ORDER BY LENGTH(soyisim)

SELECT isim, soyisim, LENGTH(soyisim) AS karakter_sayisi
FROM person
ORDER BY karakter_sayisi --ORDER BY takma ismi tanir

----------------
/*Senaryo 5: person tablosunda, tüm isim ve soyisim değerlerini aralarında bir boşluk ile aynı sutunda çağırarak, her bir isim ve soyisim değerinin toplam uzunluğuna göre sıralayınız.*/

/*Scenario 5: In the person table, call all first and last name values in the same column with a space between them and sort by the total length of each first and last name value.*/

SELECT CONCAT(isim, ' ', soyisim) AS isim_soyisim
FROM person
ORDER BY LENGTH(isim) + LENGTH(soyisim);

-------------------
SELECT CONCAT(isim, ' ', soyisim) AS isim_soyisim,
LENGTH(CONCAT(isim,soyisim)) +1 karakter_sayisi --+1 ile boslugu da saydik
FROM person
ORDER BY LENGTH(CONCAT(isim,soyisim));

----------------
/*Senaryo 6: employees4 tablosunda maaşı ortalama maaştan yüksek olan çalışanların isim,şehir ve maaşlarını maaşa göre artan sekilde sıralayarak listeleyiniz.*/

/*Scenario 6: In table employees4, list the names, cities and salaries of employees whose salaries are higher than the average salary in ascending order by salary.*/

SELECT * FROM employees4;

SELECT AVG(maas) FROM employees4; --2666.66

SELECT isim, sehir, maas 
FROM employees4
WHERE maas > (SELECT AVG(maas) FROM employees4)
ORDER BY maas ASC;

--29-Group BY

CREATE TABLE greengrocer
(
isim varchar(50),
urun_adi varchar(50),
urun_miktar int
);

INSERT INTO greengrocer VALUES( 'Ali', 'Elma', 5);
INSERT INTO greengrocer VALUES( 'Ayse', 'Armut', 3);
INSERT INTO greengrocer VALUES( 'Veli', 'Elma', 2);  
INSERT INTO greengrocer VALUES( 'Hasan', 'Uzum', 4);  
INSERT INTO greengrocer VALUES( 'Ali', 'Armut', 2);  
INSERT INTO greengrocer VALUES( 'Ayse', 'Elma', 3);  
INSERT INTO greengrocer VALUES( 'Veli', 'Uzum', 5);  
INSERT INTO greengrocer VALUES( 'Ali', 'Armut', 2);  
INSERT INTO greengrocer VALUES( 'Veli', 'Elma', 3);  
INSERT INTO greengrocer VALUES( 'Ayse', 'Uzum', 2);

SELECT * FROM greengrocer;

/*Senaryo 1: greengrocer tablosundaki tüm isimleri ve her bir isim için, toplam ürün miktarını görüntüleyiniz.*/
/*Scenario 1: Display all names in the greengrocer table and, for each name, the total quantity of products.*/

SELECT isim, SUM(urun_miktar) AS toplam_kg --toplam_kg alias'tir
FROM greengrocer
GROUP BY isim;

------------------
/*Senaryo 2: greengrocer tablosundaki tüm isimleri ve her bir isim için toplam ürün miktarını görüntüleyiniz.
Toplam ürün miktarına göre azalan olarak sıralayınız.*/

/*Scenario 2: Display all names in the greengrocer table and the total product quantity for each name.
Sort in descending order by total product quantity.*/

SELECT isim, SUM(urun_miktar) AS toplam_kg --toplam_kg alias'tir
FROM greengrocer
GROUP BY isim
ORDER BY toplam_kg DESC;

/*Senaryo 3: Her bir ismin aldığı, her bir ürünün toplam miktarını, isme göre sıralı görüntüleyiniz.*/
/*Scenario 3: Display the total amount of each product purchased by each name, ordered by name.*/

SELECT isim, urun_adi, SUM(urun_miktar) toplam_kg
FROM greengrocer
GROUP BY isim, urun_adi
ORDER BY isim

/*Senaryo 4: ürün adina göre, her bir ürünü alan toplam kişi sayısını gösteriniz.*/
/*Scenario 4: by product name, show the total number of people who bought each product.*/

SELECT urun_adi, COUNT(DISTINCT isim) kisi_sayisi
FROM greengrocer
GROUP BY urun_adi;

/*Senaryo 5: Isme göre, alınan toplam ürün miktarı ve ürün çeşit miktarını bulunuz*/
/*Scenario 5: According to the name, find the total quantity of products received and the quantity of product types*/

SELECT isim, SUM(urun_miktar) toplam_kg, COUNT(DISTINCT urun_adi) cesit_sayisi
FROM greengrocer
GROUP BY isim

--ÖDEV: Alinan ürün miktarina gore musteri sayisinı görüntüleyiniz.
--musteri sayisina göre artan sirada sıralayınız.

-------------------
--30-HAVING ifadesi
--where kayitlari filtreler, having ise sonuclari

CREATE TABLE personel  (
id int,
isim varchar(50),
sehir varchar(50), 
maas int,  
sirket varchar(20)
);

INSERT INTO personel VALUES(123456789, 'Ali Yilmaz', 'Istanbul', 5500, 'Honda'); 
INSERT INTO personel VALUES(234567890, 'Veli Sahin', 'Istanbul', 4500, 'Toyota'); 
INSERT INTO personel VALUES(345678901, 'Mehmet Ozturk', 'Ankara', 3500, 'Honda');
INSERT INTO personel VALUES(456789012, 'Mehmet Ozturk', 'Izmir', 6000, 'Ford'); 
INSERT INTO personel VALUES(567890123, 'Mehmet Ozturk', 'Ankara', 7000, 'Tofas');
INSERT INTO personel VALUES(678901245, 'Veli Sahin', 'Ankara', 4500, 'Ford');  
INSERT INTO personel VALUES(123456710, 'Hatice Sahin', 'Bursa', 4500, 'Honda');

SELECT * FROM personel;

----------------------
/*Senaryo 1: Her bir şirketin MIN maas bilgisini, bu bilgi eğer 4000 den fazla ise görüntüleyiniz.*/
/*Scenario 1: Display the MIN salary information for each company, if this information is more than 4000 */

SELECT sirket, MIN(maas) min_maas
FROM personel
GROUP BY sirket
HAVING MIN(maas) > 4000

/*Senaryo 2: Maaşı 4000 den fazla olan çalışanlarin sirketlerini bulduktan sonra, bu sinirin ustunde olan MIN maas bilgisini her sirket icin görüntüleyiniz.*/

/*Scenario 2: After finding the companies of employees with salaries over 4000, display the MIN salary information for each company above this limit.*/

SELECT sirket, MIN(maas) min_maas
FROM personel
WHERE maas>4000
GROUP BY sirket

--NOT: GROUP BY ile gruplamadan sonra elde ettiğimiz hesaplama sonucuna göre koşul belirtmek için
--HAVING GROUP BY dan SONRA ,
--tablodaki mevcut olan kayıtları mevcut sütuna göre filtrelemek için WHERE GROUP BY dan ÖNCE 
--kullanılır.

/*Senaryo 3: Her bir ismin aldığı toplam gelir 10000 liradan fazla ise ismi ve toplam maasi gösteren sorgu yaziniz.*/
/*Scenario 3: If the total income received by each name is more than 10000 liras, write a query showing the name and total salary.*/

SELECT isim, SUM(maas) toplam_gelir
FROM personel
GROUP BY isim
HAVING SUM(maas) > 10000;

/*Senaryo 4: Eğer bir şehirde çalışan personel(id) sayısı 1’den çoksa, sehir 
ismini ve personel sayısını veren sorgu yazınız*/

/*Scenario 4: If the number of personnel(id) working in a city is more than 1, city 
Write a query that gives the name and number of personnel */

SELECT sehir, COUNT(DISTINCT id) kisi_sayisi
FROM personel
GROUP BY sehir
HAVING COUNT(DISTINCT id) > 1;

--ÖDEV: Eğer bir şehirde alınan MAX maas 5000’den düşükse sehir ismini ve MAX maasi veren sorgu yazınız.

--------------------------------
--31- UNION - UNION ALL ifadesi

CREATE TABLE developers(
id SERIAL PRIMARY KEY,
name varchar(50),
email varchar(50) UNIQUE,
salary real,
prog_lang varchar(20),
city varchar(50),
age int	
);

INSERT INTO developers(name,email,salary,prog_lang,city,age) VALUES('Abdullah Berk','abdullah@mail.com',4000,'Java','Ankara',28);
INSERT INTO developers(name,email,salary,prog_lang,city,age) VALUES('Mehmet Cenk','mehmet@mail.com',5000,'JavaScript','Istanbul',35);
INSERT INTO developers(name,email,salary,prog_lang,city,age) VALUES('Ayşenur Han ','aysenur@mail.com',5000,'Java','Izmir',38);
INSERT INTO developers(name,email,salary,prog_lang,city,age) VALUES('Kübra Han','kubra@mail.com',4000,'JavaScript','Istanbul',32);
INSERT INTO developers(name,email,salary,prog_lang,city,age) VALUES('Muhammed Demir','muhammed@mail.com',6000,'Java','Izmir',25);
INSERT INTO developers(name,email,salary,prog_lang,city,age) VALUES('Fevzi Kaya','fevzi@mail.com',6000,'Html','Istanbul',28);
INSERT INTO developers(name,email,salary,prog_lang,city,age) VALUES('Enes Can','enes@mail.com',5500,'Css','Ankara',28...