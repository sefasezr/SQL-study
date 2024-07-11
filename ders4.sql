-----------------DAY 5 DT--------------------

--23-ALIASES:Rumuz/Etiket/takma isim

/*Senaryo: “workers” adinda bir tablo oluşturalim.

1-calisan_id sutun ismini id olarak degistirelim
2-calisan_isim sutun ismini isim olarak degistirelim
3-workers olan tablo ismini w olarak degistirelim*/

/*Scenario: Let's create a table called "workers".

1- Let's change the name of column employee_id to id.
2-employee_name column name should be changed to name.
3- Let's change the table name workers to w*/

CREATE TABLE workers(
calisan_id char(9),
calisan_isim varchar(50),
calisan_dogdugu_sehir varchar(50)
);

INSERT INTO workers VALUES(123456789, 'Ali Can', 'Istanbul'); 
INSERT INTO workers VALUES(234567890, 'Veli Cem', 'Ankara');  
INSERT INTO workers VALUES(345678901, 'Mine Bulut', 'Izmir');


SELECT * FROM workers;

SELECT calisan_id AS id FROM workers;

SELECT calisan_isim AS isim FROM workers;

SELECT calisan_isim isim FROM workers; --AS yazilmadan da calisir

SELECT calisan_isim isim FROM workers AS w; 

SELECT calisan_isim isim FROM workers w; --AS kullanmadan da calisir

--24-SUBQUERY--NESTED QUERY
--24-a-SUBQUERY: WHERE ile kullanımı

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


/*Senaryo 1: marka_id si 100 olan firmada çalışanların bilgilerini listeleyiniz.*/
/*Scenario 1: List the information of the employees of the company with brand_id 100.*/

--1.yol: Dinamik degil

SELECT marka_isim FROM brands WHERE marka_id=100; --Vakko
SELECT * FROM employees3 WHERE isyeri='Vakko'

--2.yol: Dinamik

SELECT * FROM employees3 WHERE isyeri=(SELECT marka_isim FROM brands WHERE marka_id=100);

--------------------------------
/*Senaryo 2: (INTERVIEW QUESTION) employees3 tablosunda max maaşı alan çalışanın tüm fieldlarını listeleyiniz.*/
/*Scenario 2: (INTERVIEW QUESTION) List all fields of the employee receiving the max salary in the employees3 table.*/

SELECT * FROM employees3 WHERE maas = 7000; --calisir ama olmaz cunku max maasi ben yazdim

SELECT * FROM employees3 WHERE maas = (SELECT MAX(maas) FROM employees3);

--Interview Question: employees3 tablosunda ikinci en yüksek maaşı gösteriniz. (ORDER BY kullanmadan cozulecek)
--Interview Question: Show the second highest salary in table employees3. (to be solved without using ORDER BY)

SELECT MAX(maas) FROM employees3 WHERE maas < (SELECT MAX(maas) FROM employees3);


/*Senaryo 3: employees3 tablosunda max veya min maaşı alan çalışanların tüm fieldlarını gösteriniz.*/
/*Scenario 3: Show all fields of employees who receive max or min salary in table employees3.*/

SELECT * 
FROM employees3 
WHERE maas=(SELECT MAX(maas) FROM employees3) OR maas =(SELECT MIN(maas) FROM employees3);

--------------------------------
/*Senaryo 4: Ankara’da calisani olan markalarin marka id'lerini ve calisan sayilarini listeleyiniz.*/
/*Scenario 4: List the brand ids and number of employees of brands with employees in Ankara.*/


SELECT marka_id, calisan_sayisi 
FROM brands 
WHERE marka_isim IN('Pierre Cardin', 'Adidas', 'Vakko');

--subquery ile dinamik cozum

SELECT marka_id, calisan_sayisi 
FROM brands 
WHERE marka_isim IN(SELECT isyeri FROM employees3 WHERE sehir='Ankara');

/*Senaryo 5: marka_id’si 101’den büyük olan marka çalişanlarinin tüm bilgilerini listeleyiniz.*/
/*Scenario 5: list all information of brand employees with brand_id greater than 101.*/

SELECT * 
FROM employees3 
WHERE isyeri IN (SELECT marka_isim FROM brands WHERE marka_id > 101);

/*Senaryo 6: Çalisan sayisi 15.000’den cok olan markalarin isimlerini, calisanlarin isimlerini ve maaşlarini listeleyiniz.*/
/*Scenario 6: List the names of brands with more than 15,000 employees, the names of the employees and their salaries.*/

SELECT isim, maas, isyeri 
FROM employees3 
WHERE isyeri IN(SELECT marka_isim FROM brands WHERE calisan_sayisi > 15000);

-------------------------
--24-b-SUBQUERY: SELECT komutundan sonra kullanımı

/*Neden WHERE Yerine SELECT?

İki farklı tablodan değer getirme ve bunları bir hesaplama içinde kullanma ihtiyacı doğduğunda, SELECT kısmında subquery kullanmak genellikle daha anlamlıdır çünkü bu, her bir satır için bir değer üretir ve bu değerlerle çalışmanıza olanak tanır. 

WHERE kısmında subquery kullanımı ise, genellikle var olan değerleri belirli bir koşulla filtrelemek için daha uygun olur. SELECT ifadesinden sonra ve WHERE koşulu içinde kullanılan subquery'ler genellikle farklı amaçlar için kullanılır, ancak bazı durumlarda benzer sonuçlar üretebilirler*/

/*Senaryo 7: Her markanin id’sini, ismini ve toplam kaç şehirde bulunduğunu listeleyen bir SORGU yaziniz.*/
/*Scenario 7: Write a QUERY that lists the id, name and total number of cities each brand is located in.*/

--DISTINCT: (Tekrar eden değerleri kaldırarak sorgu sonucunda yalnızca benzersiz değerleri döndürür.

SELECT marka_id, marka_isim, (SELECT COUNT(DISTINCT(sehir)) FROM employees3 WHERE isyeri=marka_isim) AS sehir_sayisi 
FROM brands;

/*Senaryo 8: Her markanin ismini, calisan sayisini ve o markaya ait calisanlarin maksimum ve minimum maaşini listeleyen bir sorgu yaziniz.*/
/*Scenario 8: Write a query that lists the name of each brand, the number of employees, and the maximum and minimum salary of the employees of that brand.*/

SELECT marka_isim, calisan_sayisi, (SELECT MAX(maas) FROM employees3 WHERE isyeri=marka_isim), (SELECT MIN(maas) FROM employees3 WHERE isyeri=marka_isim) FROM brands;

--25-EXISTS Condition

/*Senaryo 1: “march” ve “april” adlarinda iki tablo oluşturunuz ve Mart ayında 'Toyota' satışı yapılmış ise Nisan ayındaki tüm ürünlerin bilgilerini listeleyiniz.*/
/*Scenario : Create two tables named "march" and "april" and list the information of all products in April if 'Toyota' was sold in March.*/

CREATE TABLE march
(     
urun_id int,      
musteri_isim varchar(50),
urun_isim varchar(50)
);

INSERT INTO march VALUES (10, 'Mark', 'Honda');
INSERT INTO march VALUES (20, 'John', 'Toyota');
INSERT INTO march VALUES (30, 'Amy', 'Ford');
INSERT INTO march VALUES (20, 'Mark', 'Toyota');
INSERT INTO march VALUES (10, 'Adam', 'Honda');
INSERT INTO march VALUES (40, 'John', 'Hyundai');
INSERT INTO march VALUES (20, 'Eddie', 'Toyota');

CREATE TABLE april 
(     
urun_id int ,
musteri_isim varchar(50),
urun_isim varchar(50)
);

INSERT INTO april VALUES (10, 'Hasan', 'Honda');
INSERT INTO april VALUES (10, 'Kemal', 'Honda');
INSERT INTO april VALUES (20, 'Ayse', 'Toyota');
INSERT INTO april VALUES (50, 'Yasar', 'Volvo');
INSERT INTO april VALUES (20, 'Mine', 'Toyota');

SELECT * FROM march;
SELECT * FROM april;

SELECT * FROM april WHERE EXISTS (SELECT * FROM march WHERE urun_isim='Toyota');

/*Senaryo 2: Mart ayında 'Volvo' satışı yapılmışsa, Nisan ayındaki tüm ürünlerin bilgilerini listeleyiniz.*/
/*Scenario 2: If 'Volvo' was sold in March, list the information of all products in April.*/

SELECT * FROM april WHERE EXISTS (SELECT * FROM march WHERE urun_isim='Volvo');

/*Senaryo 3: Mart ayında satılan ürünlerin urun_id ve musteri_isim’lerini, eğer urun(urun_isim) Nisan ayında da satılmışsa, listeleyen bir sorgu yazınız.*/
/*Scenario 3: Write a query that lists the product_id and customer_name of the products sold in March, if the product(urun_isim) was also sold in April.*/

SELECT urun_id, musteri_isim FROM march AS m WHERE EXISTS (SELECT urun_isim FROM april AS n WHERE n.urun_isim = m.urun_isim);

/*Senaryo 4: Her iki ayda birden satılan ürünlerin urun_isim’lerini, bu ürünleri NİSAN ayında satın alan musteri_isim’lerine gore listeleyen bir sorgu yazınız*/
/*Scenario 4: Write a query that lists the product names of the products sold in both months according to the customer names that purchased these products in APRIL*/

SELECT urun_isim, musteri_isim FROM april a WHERE EXISTS (SELECT * FROM march m WHERE m.urun_isim=a.urun_isim);

-- ÖDEV: Martta satılıp Nisanda satilmayan ürünlerin URUN_ISIM'lerini ve bu ürünleri
--MART ayında satın alan musteri isimlerini listeleyen bir sorgu yazınız.
-- HOMEWORK: Identify the product names of the products that were sold in March but not in April and
--Write a query that lists the names of customers who purchased in March.

-------------------------------
--26-UPDATE tablo_adı SET sütunadı=yeni değer 
--WHERE koşul 
-- koşulu sağlayan kayıtlar güncellenir

CREATE TABLE employees4 (
id INT UNIQUE, 
isim VARCHAR(50), 
sehir VARCHAR(50), 
maas INT, 
isyeri VARCHAR(20)
);

INSERT INTO employees4 VALUES(123456789, 'Ali Seker', 'Istanbul', 2500, 'Vakko');
INSERT INTO employees4 VALUES(234567890, 'Ayse Gul', 'Istanbul', 1500, 'LCWaikiki');
INSERT INTO employees4 VALUES(345678901, null, 'Ankara', 3000, 'Vakko');
INSERT INTO employees4 VALUES(456789012, 'Veli Yilmaz', 'Izmir', 1000, 'Pierre Cardin');
INSERT INTO employees4 VALUES(567890123, 'Veli Yilmaz', 'Ankara', 7000, 'Adidas');
INSERT INTO employees4 VALUES(678901234, 'Ayse Gul', 'Ankara', 1500, 'Pierre Cardin');
INSERT INTO employees4 VALUES(789012345, 'Fatma Yasa', null, 2500, 'Vakko');
INSERT INTO employees4 VALUES(890123456, null, 'Bursa', 2500, 'Vakko');
INSERT INTO employees4 VALUES(901234567, 'Ali Han', null, 2500, 'Vakko');

SELECT * FROM employees4;

/*Senaryo 1: employees4 adli bir tablo olusturunuz. id’si 123456789 olan çalışanın isyeri ismini 'Trendyol' olarak güncelleyiniz.*/
/*Scenario 1: Create a table named employees4. update the workplace name of the employee whose id is 123456789 to ‘Trendyol'.*/

UPDATE employees4
SET isyeri='Trendyol'
WHERE id=123456789;

/*Senaryo 2: id’si 567890123 olan çalışanın ismini 'Veli Yıldırım' ve sehrini 'Bursa' olarak güncelleyiniz.*/
/*Scenario 2: Update the name of the employee whose id is 567890123 as 'Veli Yıldırım' and the city as ‘Bursa'.*/

UPDATE employees4
SET isim='Veli Yildirim', sehir='Bursa'
WHERE id=567890123;

SELECT * FROM employees4;

/*Senaryo 3: brands tablosundaki marka_id değeri 102’ye eşit veya büyük olanların marka_id’sini 2 ile çarparak değiştirin.*/
/*Scenario 3: change the marka_id of brands in the brands table with a marka_id greater than or equal to 102 by multiplying by 2.*/

UPDATE brands
SET marka_id=marka_id*2
WHERE marka_id>=102;

SELECT * FROM brands;

/*Senaryo 4: brands tablosundaki tüm markaların calisan_sayisi değerlerini marka_id ile toplayarak güncelleyiniz.*/
/*Scenario 4: Update the calisan_sayisi values of all brands in the brands table by adding them with marka_id.*/

UPDATE brands
SET calisan_sayisi = marka_id + calisan_sayisi;

/*Senaryo 5: employees4 tablosundan Ali Seker’in isyerini, 567890123 id’li çalışanın isyeri ismi ile güncelleyiniz.*/
/*Scenario 5: Update the workplace of Ali Seker from table employees4 with the workplace name of the employee with id 567890123.*/


SELECT * FROM employees4;

UPDATE employees4
SET isyeri = (SELECT isyeri FROM employees4 WHERE id=567890123)
WHERE isim='Ali Seker';

/*Senaryo 6: employees4 tablosunda maasi 1500 olanların isyerini, markalar tablosunda marka_id=100 olan markanın ismi ile değiştiriniz.*/

/*Scenario 6: Replace the workplace of those with salary 1500 in the employees4 table with the name of the brand with marka_id=100 in the brands table.*/

UPDATE employees4
SET isyeri= (SELECT marka_isim FROM brands WHERE marka_id=100)
WHERE maas=1500;

SELECT * FROM employees4;

--employees4 tablosundaki isyeri 'Vakko' olanların sehir bilgisinin sonuna ' Şubesi' ekleyiniz.
--Add ' Şubesi’ at the end of the city information of those whose workplace is 'Vakko' in the employees4 table.