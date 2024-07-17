----------------------DAY 9 DT-NT-------------------

SELECT * 
FROM employees4

/*Senaryo 3: employees4 tablosunda yas sutununu siliniz.*/
/*Scenario 3: Delete the age column in the employees4 table.*/

ALTER TABLE employees4
DROP COLUMN yas

/*Senaryo 4: employees4 tablosundaki maas sutununun data tipini 
real olarak güncelleyiniz.*/

/*Scenario 4: Set the data type of the salary column in the employees4 table
Update it to real.*/

ALTER TABLE employees4
ALTER COLUMN maas TYPE REAL;

--Arastirma Odevi: Eger ki daha dar bi tip koysaydik hata mi verirdi yoksa verilerden mi kayip olurdu?
--(Integer-smallint)

/*Senaryo 5: employees4 tablosundaki maas sutununun ismini 
gelir olarak güncelleyiniz.*/

/*Scenario 5: Name the salary column in the employees4 table
Update as income.*/

ALTER TABLE employees4
RENAME COLUMN maas TO gelir;

SELECT * 
FROM employees4;

/*Senaryo 6: employees4 tablosunun ismini employees5 olarak güncelleyiniz.*/
/*Scenario 6: Update the name of the employees4 table to employees5.*/

ALTER TABLE employees4
RENAME TO employees5;

SELECT * 
FROM employees5;

/*Senaryo 7: employees5 tablosunda id sütununun data tipini 
varchar(20) olarak güncelleyiniz.*/

/*Scenario 7: Set the data type of the id column in the employees5 table
Update it to varchar(20).*/

ALTER TABLE employees5
ALTER COLUMN id TYPE VARCHAR(20);

SELECT * 
FROM employees5;

/*Senaryo 8: employees5 tablosunda id sütununun data tipini 
int olarak güncelleyiniz.*/

/*Scenario 8: Set the data type of the id column in the employees5 table
Update as int.*/

ALTER TABLE employees5
ALTER COLUMN id TYPE INTEGER USING id::integer

/*Senaryo 9: employees5 tablosunda isim sütununa 
NOT NULL constrainti ekleyiniz.*/

/*Scenario 9: Name column in employees5 table
Add NOT NULL constraint.*/

ALTER TABLE employees5
ALTER COLUMN isim SET NOT NULL;

INSERT INTO employees5(id,sehir) VALUES(123,'Ankara');

--NOT: içinde kayıtlar bulunan bir tablo güncellenirken,
--NOT NULL,PK,FK,UNIQUE,CHECK kısıtlamalarını ekleyebilmek için
--bu sütunun değerleri, ilgili kısıtlamayı sağlıyor olmalıdir

/*Senaryo 1: companies2 tablosunda sirket_id sütununa PRIMARY KEY constraint’i ekleyiniz.*/
/*Scenario 1: Add the PRIMARY KEY constraint to the company_id column in the companies2 table.*/

SELECT * FROM companies2;

ALTER TABLE companies2
ADD /*CONSTRAINT companies2_pk*/ PRIMARY KEY(sirket_id)

/*Senaryo 2: companies2 tablosunda sirket_isim sütununa UNIQUE constrainti ekleyiniz.*/
/*Scenario 2: Add UNIQUE constraint to the company_name column in the companies table.*/

ALTER TABLE companies2
ADD UNIQUE(sirket_isim);

----------------Kisitlamalari kontrol sorgusu
SELECT conname, contype
FROM pg_constraint
WHERE conrelid = 
(SELECT oid FROM pg_class WHERE relname = 'companies2');
----------------

/*Senaryo 3: orders tablosunda sirket_id sütununa FOREIGN KEY constraint’i ekleyiniz.*/
/*Scenario 3: Add FOREIGN KEY constraint to the company_id column in the orders table.*/

ALTER TABLE orders
ADD FOREIGN KEY(sirket_id) REFERENCES companies2(sirket_id);

DELETE FROM orders WHERE sirket_id IN (104, 105);
SELECT * FROM orders;

------------
SELECT conname, contype
FROM pg_constraint
WHERE conrelid = 
(SELECT oid FROM pg_class WHERE relname = 'orders');
------------

/*Senaryo 4: orders tablosundaki FK constraintini kaldırınız.*/
/*Scenario 4: Remove the FK constraint in the orders table.*/

ALTER TABLE orders
DROP CONSTRAINT orders_sirket_id_fkey

/*Senaryo 5: employees5 tablosunda isim sütununda 
NOT NULL constraintini kaldırınız.*/

/*Scenario 5: Name column in employees5 table
Remove the NOT NULL constraint.*/

SELECT * FROM employees5;

ALTER TABLE employees5
ALTER COLUMN isim DROP NOT NULL;

---------------null kontrolu sorgusu

SELECT column_name, is_nullable
FROM information_schema.columns
WHERE table_name = 'employees5' AND column_name = 'isim';

/*
"YES": Sütun NULL değer alabilir.
"NO": Sütun NULL değer alamaz.
*/

/*Senaryo:
1- accounts adında bir tablo oluşturulacak.
2- Tabloya iki kayıt eklenecek.
3- Hesaplar arasında 1000 TL para transferi yapılacaktır.
4- Para transferi sırasında bir hata oluşacaktır.
5- Hata oluştuğunda, ROLLBACK komutu ile transaction iptal edilecek
   ve 1. hesaptan çekilen 1000 TL iade edilecektir.*/

/*Scenario:
1- A table named accounts will be created.
2- Two records will be added to the table.
3- 1000 TL money transfer will be made between accounts.
4- An error will occur during money transfer.
5- When an error occurs, the transaction will be cancelled with the ROLLBACK command
   and the 1000 TL withdrawn from the 1st account will be refunded.*/

-- Tablo Oluşturma
CREATE TABLE accounts
(
hesap_no int UNIQUE,
isim VARCHAR(50),
bakiye real
);

-- Veri Ekleme
INSERT INTO accounts VALUES(1234,'Harry Potter',10000.3);
INSERT INTO accounts VALUES(5678,'Jack Sparrow',5000.5);

SELECT * FROM accounts;

-- Veri Ekleme
INSERT INTO accounts VALUES(1234,'Harry Potter',10000.3);
INSERT INTO accounts VALUES(5678,'Jack Sparrow',5000.5);

SELECT * FROM accounts;

--Harry 1000 TL gondersin
UPDATE accounts SET bakiye=bakiye-1000 WHERE hesap_no=1234;
SELECT * FROM accounts;

--Sistemsel hata oluştu. Jack bu 1000 tl’yi alamadi
--UPDATE accounts SET bakiye=bakiye+1000 WHERE hesap_no=5678; HATA

-----------------------------
--Basarisiz transaction senaryosu

--BEGIN: Transaction başlatmak için kullanılır.

BEGIN;
--1
CREATE TABLE accounts
(
hesap_no int UNIQUE,
isim VARCHAR(50),
bakiye real       
);
--COMMIT: Transaction'ı onaylamak ve değişiklikleri kalıcı hale getirmek için kullanılır.
COMMIT;


BEGIN; --iki ayrı BEGIN kullanımı, işlemlerinizi mantıksal olarak ayırmak istediğinizde mantıklıdır, ancak tüm işlemleri tek bir transaction olarak ele almak istiyorsanız, tek bir BEGIN kullanabilirsiniz. 
--2
INSERT INTO accounts VALUES(1234,'Harry Potter',10000.3);
INSERT INTO accounts VALUES(5678,'Jack Sparrow',5000.5);

SELECT * FROM accounts;

--SAVEPOINT <savepoint_name>: Transaction içinde belirli bir noktada kayıt oluşturmak için kullanılır. Bu, hata durumunda tüm transaction'ı geri almak yerine belirli bir noktaya dönüş yapmayı sağlar.

--3
SAVEPOINT x; --Kaydetme noktasi

--try{ try'da hata yakalanirsa catch'e dallanir, try'da hata yoksa catch calismaz

UPDATE accounts SET bakiye=bakiye-1000 WHERE hesap_no=1234; --Basarili
--UPDATE hesaplar SET bakiye=bakiye+1000 WHERE hesap_no=5678; --HATA, Calismadi
--COMMIT; --Calismadi

--catch(){

--ROLLBACK; --Önemli Not: ROLLBACK komutu, eğer bir savepoint belirtmeden kullanılırsa, geçerli olan tüm işlemi (transaction) geri alır. Bu durumda, BEGIN komutundan itibaren yapılan tüm değişiklikler geri alınır.

ROLLBACK TO x;
COMMIT;
SELECT * FROM accounts;

---------------------
--BASARILI SENARYOSU.

BEGIN;
CREATE TABLE accounts
(
hesap_no int UNIQUE,
isim VARCHAR(50),
bakiye real       
);
COMMIT;

----------
BEGIN;
--1
INSERT INTO accounts VALUES(1234,'Harry Potter',10000.3);
INSERT INTO accounts VALUES(5678,'Jack Sparrow',5000.5);

SELECT * FROM accounts;
--2
SAVEPOINT x;

--try{
UPDATE accounts SET bakiye=bakiye-1000 WHERE hesap_no=1234;--başarılı
UPDATE accounts SET bakiye=bakiye+1000 WHERE hesap_no=5678;--başarılı
COMMIT; --Hersey kalici oldu. islem basarili
--}catch{

ROLLBACK; --try icinde hata yok, burasi calismaz
ROLLBACK TO x; --try icinde hata yok, burasi calismaz

SELECT * FROM accounts;

