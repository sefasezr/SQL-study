-------------------DAY 8 DT-NT-------------

--37- LIKE, ILIKE

SELECT * FROM developers;

SELECT * FROM developers WHERE name='Ayse Gul';

SELECT * FROM developers WHERE name='A...'; --HATA

-- wildcard(joker, %): 0 veya daha fazla karakteri temsil eder

SELECT *
FROM developers
WHERE name LIKE 'A%'; --A, Ab, Abcd, Ali (a% olmaz)

--Küçük/büyük harf duyarlılığı olmasın 

SELECT *
FROM developers
WHERE name ILIKE 'a%';

--Ismi T ile başlayıp n harfi ile biten dev isimlerini ve maaşlarını yazdiran QUERY yazin
--Write QUERY, whose name starts with T and ends with the letter n, to write the names of giants and their salaries

SELECT name, salary
FROM developers
WHERE name LIKE 'T%n' --Tn, Tansu Han

--Ismi soyismi içinde 'an' olan dev isimlerini ve soyisimlerini ve maaşlarını yazdiran QUERY yazin
--Write QUERY with 'an' in the first name, last name and surname and their salaries

SELECT name, salary
FROM developers
WHERE name LIKE '%an%'; --Canana

--Ismi içinde e ve a olan developerlarin tüm bilgilerini yazdiran QUERY yazin
--Write QUERY that prints all the information of developers with e and a in their name

SELECT *
FROM developers
WHERE name LIKE '%e%a%' OR name LIKE '%a%e%';

--alternatif

SELECT *
FROM developers
WHERE name LIKE '%e%' AND name LIKE '%a%';

-- underscore(_)=sadece 1 karakteri temsil eder.

--Isminin ikinci harfi u olan developerlarin tum bilgilerini yazdiran QUERY yazin
--Type QUERY, which prints all the information of developers with the second letter u in their name.

SELECT *
FROM developers
WHERE name LIKE '_u%';

--Kullandığı prog. dili 4 harfli ve üçüncü harfi v olan developerlarin tum bilgilerini yazdiran QUERY yazin
--Write QUERY that prints all the information of developers whose prog. language has 4 letters and the third letter is v

SELECT *
FROM developers
WHERE prog_lang LIKE '__v_';

--ÖDEV : Kullandığı prog. dili en az 5 harfli ve ilk harfi J olan developerlarin tum bilgilerini yazdiran QUERY yazin.
--ÖDEV:  Isminin 2. harfi e,4. harfi y olan developerlarin tum bilgilerini yazdiran QUERY yazin. 
--ÖDEV:  ismi boşluk içeren developerlarin tum bilgilerini yazdiran QUERY yazin.

--HOMEWORK: The program he used. Type QUERY, which prints all the information of developers whose language has at least 5 letters and whose first letter is J.
--HOMEWORK: The 2nd letter of your name is e,4. Type QUERY, which prints all the information of developers whose letter is y.
-- HOMEWORK: type QUERY, which prints all the information of developers whose names contain spaces.

--1. ‘[cb]at' ==> 'cat' veya 'bat' ile eşleşir. Bir kelimenin icinde cat olsa o da eslesir. ascatdat

SELECT 'cat' ~ '[cb]at' AS result; --true

--2. [0-9] ==> 0 ile 9 arası
--Herhangi bir tek rakamı eşleştirmek için:

SELECT 'abc12' ~ '[0-9]' AS result;

--3. [a-zA-Z] ==> A'dan Z'ye veya a'dan z'ye aralığı
--Herhangi bir harfi eşleştirmek için:

SELECT 'm' ~ '[a-zA-Z]' AS result;

--4. [^a-e] ==> a'dan e'ye aralığının dışı
--'a' ile 'e' arasında olmayan karakterleri eşleştirmek için:

SELECT 'z' ~ '[^a-e]' AS result; --true ^ haric demektir

--5. ^ - Satırın Başlangıcı
--Bir metnin "hello" ile başladığını kontrol etmek için:

SELECT 'hello world' ~ '^hello' AS result; --true

--6. $ - Satırın Sonu
--Bir metnin "world" ile bittiğini kontrol etmek için:

SELECT 'hello world' ~ 'world$' AS result; --true

--7. .* - Sıfır veya Daha Fazla Karakter
--Herhangi bir karakter dizisinden sonra "abc" gelip gelmediğini kontrol etmek için:

SELECT '123abc456' ~ '.*abc' AS result; --true

--8. . - Herhangi Bir Tek Karakter
--Tam olarak üç karakter uzunluğunda ve ortasında "a" olan bir kelimeyi eşleştirmek için:

SELECT 'cat' ~ '.a.' AS result; --true

----------------------------------

CREATE TABLE words
( 
  word_id int UNIQUE,
  word varchar(50) NOT NULL,
  number_of_letters int
);

INSERT INTO words VALUES (1001, 'hot', 3);
INSERT INTO words VALUES (1002, 'hat', 3);
INSERT INTO words VALUES (1003, 'Hit', 3);
INSERT INTO words VALUES (1004, 'hbt', 3);
INSERT INTO words VALUES (1008, 'hct', 3);
INSERT INTO words VALUES (1005, 'adem', 4);
INSERT INTO words VALUES (1006, 'selim', 6);
INSERT INTO words VALUES (1007, 'yusuf', 5);
INSERT INTO words VALUES (1009, 'hAt', 3);
INSERT INTO words VALUES (1010, 'yaf', 5);
INSERT INTO words VALUES (1011, 'ahata', 3);

SELECT * FROM words;

--h harfinden sonra a veya i harfini sonra ise t harfini 
--içeren kelimelerin tum bilgilerini yazdiran QUERY yaziniz.
--put the letter a or i after the letter h and then the letter t
--Write QUERY, which prints all the information of the words containing it.
--hat/hit
--ahata,ahit,hatip

SELECT *
FROM words
WHERE word ~ 'h[ai]t'; 

--case-insensitive -- kucuk buyuk harfe duyarsiz yapalim

SELECT *
FROM words
WHERE word ~* 'h[ai]t';

--h harfinden sonra, a ile k arasindaki harflerden birini, sonra da t harfini
-- içeren kelimelerin tum bilgilerini yazdiran QUERY yaziniz.
--After the letter h, add one of the letters between a and k, then the letter t
--Write QUERY, which prints all the information of the words containing it.

SELECT *
FROM words
WHERE word ~* 'h[a-k]t';

-- (~*) ifadesi kucuk buyuk harfe duyarsiz yapar 

-- Icinde m veya i olan kelimelerin tum bilgilerini yazdiran QUERY yazin
-- Type QUERY, which prints all the information of words containing m or i
--mat,ilk

SELECT *
FROM words
WHERE word ~* '[mi]';

-- ^:kelimenin başlangıcını gösterir
-- $:kelimenin sonunu gösterir 

--a ile baslayan kelimelerin tum bilgilerini yazdiran QUERY yazin
-- type QUERY which prints all information of words starting with a

SELECT *
FROM words
WHERE word ~* '^a';

-- m ile biten kelimelerin tum bilgilerini yazdiran QUERY yazin
-- type QUERY which prints all information of words ending with m

SELECT *
FROM words
WHERE word ~* 'm$'

--a veya s ile baslayan kelimelerin tum bilgilerini yazdiran QUERY yazin
-- type QUERY which prints all information of words starting with a or s

SELECT *
FROM words
WHERE word ~* '^[as]';

-- (.*):0 veya daha fazla karakteri temsil eder. (% gibi)
-- (.):sadece 1 karakteri temsil eder. (_ gibi)

--y ile başlayıp f ile biten kelimelerin tum bilgilerini yazdiran QUERY yazin
-- Type QUERY, which prints all the information of words starting with y and ending with f

SELECT *
FROM words
WHERE word ~* '^y(.*)f$'

--y ile başlayıp f ile biten 3 harfli kelimelerin tum bilgilerini yazdiran QUERY yazin
-- Type QUERY, which prints all the information of 3-letter words starting with y and ending with f

SELECT *
FROM words
WHERE word ~* '^y.f$';

----------------------
CREATE TABLE teachers(
id int,
firstname varchar(50),
lastname varchar(50),
age int,	
city varchar(20),
course_name varchar(20),
salary real	
);

INSERT INTO teachers VALUES(111,'AhmeT  ','  Han',35,'Istanbul','SpringMVC',5000);
INSERT INTO teachers VALUES(112,'Mehmet','Ran ',33,'Van','HTML',4000);
INSERT INTO teachers VALUES(113,' Bilal','Fan ',34,'Bursa','SQL',3000);
INSERT INTO teachers VALUES(114,'Celal',' San',30,'Bursa','Java',3000);
INSERT INTO teachers VALUES(115,'Deniz',' Can',30,'Istanbul','SQL',3500);
INSERT INTO teachers VALUES(116,'ekreM','Demir',36,'Istanbul','Java',4000.5);
INSERT INTO teachers VALUES(117,'Fatma','Celik',38,'Van','SpringBOOT',5550);
INSERT INTO teachers VALUES(118,'Hakan','Cetin',44,'Izmir','Java',3999.5);
INSERT INTO teachers VALUES(119,'mert','Cetin',32,'Izmir','HTML',2999.5);
INSERT INTO teachers VALUES(120,'Nilay','Cetin',32,'Izmir','CSS',2999.5);
INSERT INTO teachers VALUES(121,'Selma','Celik',40,'Ankara','SpringBOOT',5550);
INSERT INTO teachers VALUES(122,'fatiH','Can',32,'Ankara','HTML',2550.22);
INSERT INTO teachers VALUES(123,'Nihat','Keskin',32,'Izmir','CSS',3000.5);
INSERT INTO teachers VALUES(124,'Hasan','Temel',37,'Istanbul','S.Security',3000.5);

SELECT * FROM teachers;

--teachers tablosundaki tüm kayıtların 
--firstname değerlerini büyük harfe, 
-- lastname değerlerini küçük harfe çevirerek, 
--uzunlukları ile birlikte listeleyiniz.

--all records in the teachers table
--firstname values to uppercase,
-- converting lastname values to lowercase,
--list them with their lengths.


SELECT UPPER(firstname) AS fname, LENGTH(firstname), LOWER(lastname) AS lname, LENGTH(lastname)
FROM teachers

--teachers tablosunda firstname ve lastname değerlerindeki 
--başlangıç ve sondaki boşlukları kaldırınız.

--in the firstname and lastname values in the teachers table
--remove the starting and trailing spaces.

UPDATE teachers
SET firstname=TRIM(firstname), lastname=TRIM(lastname);

--teachers tablosunda tüm kayıtların firstname değerlerini
-- ilk harfini büyük diğerleri küçük harfe çevirerek görüntüleyiniz.

--get the firstname values of all records in the teachers table
-- display by changing the first letter to uppercase and the rest to lowercase.

SELECT INITCAP(firstname)
FROM teachers;

--teachers tablosunda firstname değerlerinde 'Celal' kelimesini 'Cemal' ile değiştiriniz.
--Replace the word 'Celal' with 'Cemal' in the firstname values in the teachers table.

UPDATE teachers
SET firstname=REPLACE(firstname, 'Celal', 'Cemal')

SELECT * FROM teachers;

---------------------
SELECT * FROM employees4;

--employees4 tablosunda isyeri='Vakko' olan kayıtlarda 
--son ' Şubesi' ifadesini siliniz.

--in records with workplace='Vakko' in the employees4 table
--end Delete the ‘ Şubesi' statement.

--------
SELECT SUBSTRING('sqlders', 1, 3); --sql, 1 den basla 3.e kadar say ve o bolumu al.
--------

UPDATE employees4
SET sehir=SUBSTRING(sehir, 1, LENGTH(sehir) -7)
WHERE isyeri='Vakko';

--words tablosunda tüm kelimeleri ve tüm kelimelerin(word) ilk 2 harfini görüntüleyiniz.
--Display all words and the first 2 letters of all words in the words table.

SELECT * FROM words;

SELECT word, SUBSTRING(word,1,2)
FROM words;

---------------------

--40- LIMIT / OFFSET - FETCH NEXT n ROW ONLY

--Senaryo 1: developers tablosundan ekleme sırasına göre ilk 3 kaydı getiriniz.
--Scenario 1: Get the first 3 records from the developers table in order of insertion.

SELECT * 
FROM developers
FETCH NEXT 3 ROW ONLY;

--limit

SELECT *
FROM developers
LIMIT 3;

/*Senaryo 2: developers tablosundan ekleme sırasına göre ilk 2 kayıttan sonraki ilk 3 kaydı getiriniz.*/
/*Scenario 2: Fetch the first 3 records after the first 2 records from the developers table in order of insertion.*/

SELECT *
FROM developers
OFFSET 2 ROW --ROW yazmak zorunlu degil
LIMIT 3

SELECT *
FROM developers
OFFSET 2
LIMIT 3

/*Senaryo 3: developers tablosundan maaşı en düşük ilk 3 kaydı getiriniz.*/
/*Scenario 3: Bring the first 3 records with the lowest salaries from the developers table.*/

SELECT *
FROM developers
ORDER BY salary
LIMIT 3;

/*Senaryo 4: developers tablosundan maaşı en yüksek 2. developer’ın tüm 
bilgilerini getiriniz.*/

/*Scenario 4: From the developers table, the developer with the 2nd highest salary
Please bring your information.*/

SELECT *
FROM developers
ORDER BY salary DESC
OFFSET 1
LIMIT 1

--41- ALTER TABLE ifadesi-DDL

--NOT: UPDATE verileri degistirmek, ALTER tablo yapisini degistirmek icin kullanilir.

/*Senaryo 1: employees4 tablosuna yas (int) seklinde yeni sutun ekleyiniz.*/
/*Scenario 1: Add a new column in the form of age (int) to the employees4 table.*/

ALTER TABLE employees4
ADD COLUMN yas INTEGER

SELECT * 
FROM employees4

/*Senaryo 2: employees4 tablosuna remote (boolean) seklinde yeni sutun ekleyiniz.
varsayılan olarak remote değeri TRUE olsun*/

/*Scenario 2: Add a new column as remote (boolean) to the employees4 table.
By default, the remote value is TRUE */

ALTER TABLE employees4
ADD COLUMN remote BOOLEAN DEFAULT TRUE;

/*Senaryo 3 -ODEV: employees4 tablosunda yas sutununu siliniz.*/
/*Scenario 3: Delete the age column in the employees4 table.*/

ALTER TABLE employees4
DROP COLUMN yas;