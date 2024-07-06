--------------SUBQUERY---------------
--SORGU icinde calisan sorguya subquery (alt sorgu) denir
CREATE TABLE personel(
	id INTEGER,
	isim VARCHAR(50),
	sehir VARCHAR(50),
	maas INTEGER,
	sirket VARCHAR(20)
);

INSERT INTO personel VALUES (123456789, 'Ali Seker','Istanbul',2500,'Honda');
INSERT INTO personel VALUES (234567890, 'Ayse Gul','Istanbul',1500,'Toyota');
INSERT INTO personel VALUES (345678901, 'Veli Yilmaz','Ankara',3000,'Honda');
INSERT INTO personel VALUES (456789012, 'Veli Yilmaz','Izmir',1000,'Ford');
INSERT INTO personel VALUES (567890123, 'Veli Yilmaz','Ankara',7000,'Hyundai');
INSERT INTO personel VALUES (456789012, 'Ayse Gul','Ankara',1500,'Ford');
INSERT INTO personel VALUES (123456789, 'Fatma Yasa','Bursa',2500,'Honda');

CREATE TABLE sirketler(
	sirket_id INTEGER,
	sirket_adi VARCHAR(20),
	personel_sayisi INTEGER
);

INSERT INTO sirketler VALUES (100,'Honda',12000);
INSERT INTO sirketler VALUES (101,'Ford',18000);
INSERT INTO sirketler VALUES (102,'Hyundai',10000);
INSERT INTO sirketler VALUES (103,'Toyota',21000);
INSERT INTO sirketler VALUES (104,'Mazda',17000);

SELECT * FROM sirketler;
SELECT * FROM personel;

--ORNEK1: Personel SAYISI 15000'DEN çok olan şirketlerin isimlerini ve bu sirkete
-- calisan personelin isimlerini ve maaşlarını listeleyin

SELECT isim , maas, sirket FROM personel
WHERE sirket IN (SELECT sirket_adi FROM sirketler WHERE personel_sayisi>15000);

--ORNEK2: sirket_id'si 101'den buyuk olan sirket calisanlarinin isim,mas ve sehirlerini listeleyiniz

SELECT isim , maas , sehir FROM personel
WHERE sirket IN (SELECT sirket_adi FROM sirketler WHERE sirket_id>101 );

--ORNEK3: Ankarada personeli olan şirketlerin şirket id'lerini ve personel sayilarini listeleyiniz

SELECT sirket_id , personel_sayisi, sirket_adi FROM sirketler
WHERE sirket_adi IN (SELECT sirket FROM personel WHERE sehir= 'Ankara');

/*
                       ==========================AGGREGATE METOT KULLANIMI===============================
	Aggregate Metotlari(SUM, COUNT, MIN , MAX, AVG) Subquery için de kullanılabilir
	Ancak, Sorgu tek bir değer döndürüyor olmalıdır
	-- *** SELECT den sonra SUBQUERY yazarsak sorgu sonucunun sadece 1 deger getireceginden emin olmaliyiz
*/

--ORNEK4: Her sirketin ismini,personel sayısını ve o şirkete ait personelin 
-- toplam maaşını listeleyen bir sorgu yazınız

SELECT sirket_adi,personel_sayisi, (SELECT SUM(maas) FROM personel
    									WHERE personel.sirket = sirketler.sirket_adi) AS toplam_maas     
FROM sirketler;

--ORNEK5: Her şirketin ismini, personel sayısını ve o şirkete ait personelin ortalama maaşını listeleyen bir sorgu yazıınız.

SELECT sirket_adi,personel_sayisi, (SELECT ROUND(AVG(maas)) FROM personel
	                                 WHERE sirketler.sirket_adi = personel.sirket) AS ortalama_maas
FROM sirketler;

--ORNEK6: Her şirketin ismini, personel sayısını ve o şirkete ait personelin 
--maksimum ve minimum maaşını listeleyen bir Sorgu yazınız

SELECT sirket_adi , personel_sayisi , (SELECT MAX(maas) FROM personel WHERE sirketler.sirket_adi = personel.sirket) ,
                                      (SELECT MIN(maas) FROM personel WHERE sirketler.sirket_adi = personel.sirket)
FROM sirketler;

--ORNEK7: Her şirketin id'sini, ismini ve toplam kaç şehirde buludugunu listeleyen bir sorgu yazınız

SELECT sirket_id, sirket_adi , (SELECT COUNT(sehir) FROM personel
	                            WHERE sirketler.sirket_adi = personel.sirket ) AS sehir_sayisi
FROM sirketler;

TRUNCATE TABLE tabloismi;         --TRUNCATE içeriği dönmemek şartıyla siler

DROP TABLE messi;

ON DELETE CASCADE -- bu foreign key tablonun sonuna eklenince isteersen önce parenti sil istersen childi demektir
                  -- parent silinince çocuk da silinir ama.

CREATE TABLE mart_satislar(
	urun_id INTEGER,
	musteri_isim VARCHAR(50),
	urun_isim VARCHAR(50)
);

CREATE TABLE nisan_satislar(
	urun_id INTEGER,
	musteri_isim VARCHAR(50),
	urun_isim VARCHAR(50)
);

INSERT INTO mart_satislar VALUES (10,'Mark','Honda');
INSERT INTO mart_satislar VALUES (10,'Mark','Honda');
INSERT INTO mart_satislar VALUES (20,'John','Toyota');
INSERT INTO mart_satislar VALUES (30,'Amy','Ford');
INSERT INTO mart_satislar VALUES (20,'Mark','Toyota');
INSERT INTO mart_satislar VALUES (10,'Adem','Honda');
INSERT INTO mart_satislar VALUES (40,'John','Hyundai');
INSERT INTO mart_satislar VALUES (20,'Eddie','Toyota');

INSERT INTO nisan_satislar VALUES (10,'Hasan','Honda');
INSERT INTO nisan_satislar VALUES (10,'Kemal','Honda');
INSERT INTO nisan_satislar VALUES (20,'Ayse','Toyota');
INSERT INTO nisan_satislar VALUES (50,'Yasar','Volvo');
INSERT INTO nisan_satislar VALUES (20,'Mine','Toyota');

SELECT * FROM mart_satislar;
SELECT * FROM nisan_satislar;

--ORNEK1: MART VE NİSAN aylarında aynı URUN_ID ile satılan ürünlerin URUN_IDlerini listeleyen ve aynı
--zamanda bu ürünleri MART ayında alan MUSTERI_ISIM'lerini listeleyen bir sorgu yazınız.

SELECT urun_id , musteri_isim FROM mart_satislar
WHERE urun_id IN (SELECT urun_id from nisan_satislar
	              WHERE mart_satislar.urun_id = nisan_satislar.urun_id); 

--urun_id IN YERINE EXISTS de olur EXISTS DAHA HIZLIDIR BİR BAKTIGINA DAHA BAKMAZ

--ORNEK2: Her iki ayda da satılan ürünlerin urun_isim'lerini ve bu ürünleri
--Nisan ayında satın alan musteri_isimlerini listeleyen bir sorgu yazınız

SELECT musteri_isim,urun_isim FROM nisan_satislar
WHERE urun_isim IN (SELECT urun_isim FROM mart_satislar
	                WHERE urun_isim = urun_isim);

--ORNEK3: Her iki ayda da ortak olarak satılmayan urunlerin URUN_isimlerini 
--ve bu ürünleri NİSAN ayında satın alan Musteriisimlerini listeleyiniz

SELECT urun_isim,musteri_isim FROM nisan_satislar n
WHERE NOT EXISTS (SELECT urun_isim FROM mart_satislar m
	              WHERE n.urun_isim=m.urun_isim)  

/* ====================================IS NULL, IS NOT NULL, COALESCE(kulesk=birleşmek) ====================================

 IS NULL VE IS NOT NULL BOOLEAN operatörleridir. Bir ifadenin NULL olup olmadığını kontrol ederler

*/

CREATE TABLE insanlar(
	ssn CHAR(9),
	isim VARCHAR(50),
	adres VARCHAR(50)
);

INSERT INTO insanlar VALUES('123456789','Ali Can','Istanbul');
INSERT INTO insanlar VALUES('234567890','Veli Cem','Ankara');
INSERT INTO insanlar VALUES('345678901','Mine Bulut','Izmir');
INSERT INTO insanlar (ssn, adres) VALUES ('456789012','Bursa');
INSERT INTO insanlar (ssn, adres) VALUES ('567890123','Denizli');
INSERT INTO insanlar (adres) VALUES ('Sakarya');
INSERT INTO insanlar (ssn) VALUES ('999111222');

SELECT * FROM insanlar;

--ORNEK1: isim'i null olanları sorgulayınız.

SELECT * FROM insanlar
WHERE isim IS NULL;

SELECT * FROM insanlar
WHERE isim IS NOT NULL;

--ORNEK3: isim'i null olan kişilerin isim'ine NO NAME atayın

UPDATE insanlar
SET isim = 'NO NAME'
WHERE isim IS NULL;


UPDATE insanlar 
SET isim = null
WHERE isim = 'NO NAME';

SELECT COALESCE (isim,ssn,adres) FROM insanlar;  --isimden başlayarak satır satır tarayacak ancak örneğin isim null ise ssn'ye bakar 
                                                 --ssn null değilse onu yazdırır bir alt satıra iner tekrar isme bakar null ise ssn'ye
                                                 --bakar o da null ise adrese bakar öyle en alt satıra kadar isimden kontrolle bakıp yazdırır
                                                 --tabloda null terimler var ise karma bir yapı çıkar.

--ORNEK4: tablodaki butun null verileri guzel birer cumlecikle degistirin

UPDATE insanlar
SET isim = COALESCE (isim,'henuz isim girilmedi'),   --COALESCE iki parametreli de kullanılır ilk parametre null ise ikinciyi yerine yaz
    adres = COALESCE (adres,'henuz adres girilmedi'),
    ssn = COALESCE (ssn,'No SSN');

SELECT * FROM insanlar;
