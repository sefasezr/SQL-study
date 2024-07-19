create table ogrenciler(
id int,
isim varchar(50),
sehir varchar(50),
puan int,
bolum varchar(20));

INSERT INTO ogrenciler VALUES (100, 'Ahmet Ümit', 'İstanbul', 546, 'Bilgisayar');
INSERT INTO ogrenciler VALUES (101, 'R.Nuri Güntekin', 'Antalya', 486, 'İşletme');
INSERT INTO ogrenciler VALUES (102,'S.Faik Abasıyanık', 'Bursa', 554, 'Bilgisayar');
INSERT INTO ogrenciler VALUES (103, 'Yaşar Kemal', 'İstanbul', 501, 'Matematik');
INSERT INTO ogrenciler VALUES (104, 'Halide E. Adıvar', 'İzmir', 473, 'Psikoloji');
INSERT INTO ogrenciler VALUES (105,'Nazan Bekiroğlu', 'İzmir', 432, 'Edebiyat');
INSERT INTO ogrenciler VALUES (106,'Peyami Safa', 'Antalya', 535, 'Bilgisayar');
INSERT INTO ogrenciler VALUES (107, 'Sabahattin Ali', 'İstanbul', 492, 'Matematik');

--soru 1: isimleri 'A'harfi ile baslayan ogrencilerin bilgilerini getirin

SELECT * FROM ogrenciler
WHERE isim like 'A%';

SELECT * FROM ogrenciler
WHERE isim ~ '^A';

--Soru 2: İsimleri 'i' harfi ile biten öğrencilerin bilgilerini getirin.

SELECT * FROM ogrenciler
WHERE isim like '%i';

SELECT * FROM ogrenciler
WHERE isim ~ 'i$'

--soru 8 : isminin icinde z veya k harfi gecen ogrencileri getirin

SELECT * FROM ogrenciler
WHERE isim like '%z%' or isim like '%k%';

SELECT * FROM ogrenciler
WHERE isim ~ '[zk]';

--Soru 3: İsimleri 'A' harfi ile başlayan ve 'Bilgisayar bölümünde 
--okuyan öğrencilerin bilgilerini getirin

SELECT * FROM ogrenciler
WHERE isim like 'A%' AND bolum = 'Bilgisayar';

SELECT * FROM ogrenciler
WHERE isim ~ '^A' AND bolum = 'Bilgisayar';

--soru 4: isimleri 'n'harfi iceren ogrencileri getirin

SELECT * FROM ogrenciler
WHERE isim like '%n%';

SELECT * FROM ogrenciler
WHERE isim ~ 'n';

--soru 5: isimleri 'A' harfi ile baslamayan ogrencileri getirin

SELECT * FROM ogrenciler
WHERE isim not like 'A%';

SELECT * FROM ogrenciler
WHERE isim  ~ '^[B-Z]';

--soru 6 : isimleri 12 karakterden daha uzun olan ogrencileri getirin

SELECT * FROM ogrenciler
WHERE length(isim) > 12;

--soru 7 : 4. harfi a olan ogrenci bilgilerini getirin

SELECT * FROM ogrenciler
WHERE isim like '___a%';

SELECT * FROM ogrenciler
WHERE isim ~ '...a.*';

--soru 9 : ismi Y veya N ile baslayan ogrenci bilgilerini getir

SELECT * FROM ogrenciler
WHERE isim like 'Y%' or isim like 'N%';

SELECT * FROM ogrenciler
WHERE isim ~ '^[YN]';

create table arac ( 
id int,
marka varchar (30),
model varchar(30), 
fiyat int,
kilometre int, 
vites varchar(20)
);
insert into arac values (100, 'Citroen', 'C3', 500000, 5000, 'Otomatik' );
insert into arac values (101, 'Mercedes', 'C180', 900000, 10000, 'Otomatik' );
insert into arac values (102, 'Honda', 'Civic', 400000, 15000, 'Manuel' );
insert into arac values (103, 'Wolkswagen', 'Golf', 350000, 20000, 'Manuel' );  
insert into arac values (104, 'Ford', 'Mustang', 750000, 5000, 'Otomatik' );
insert into arac values (105, 'Porsche', 'Panamera', 850000, 5000, 'Otomatik' );
insert into arac values (106, 'Bugatti', 'Veyron', 950008, 5000, 'Otomatik' );

--SORU-1: arac tablosundaki en yüksek fiyat'ı listele
SELECT MAX(fiyat) FROM arac;

--Soru-2: arac tablosundaki araçların toplam fiyatını bulunuz
SELECT SUM(fiyat) FROM arac;

--Soru-3: arac tablosundaki fiyat ortalamalarını bulunuz
SELECT AVG(fiyat) FROM arac;

--Soru-4:arac tablosunda kaç tane araç olduğunu bulunuz
SELECT COUNT(*) FROM arac;

--Soru-5:ortalama arac fiyatindan dusuk olan araclari getirin 
SELECT * FROM arac
WHERE fiyat < (SELECT AVG(fiyat) FROM arac);

--Soru-6:arac tablosundaki fiyatı en yuksek 3. araci getirin
SELECT * FROM arac
WHERE fiyat < (SELECT MAX(fiyat) FROM arac)
ORDER BY fiyat DESC
OFFSET 1
LIMIT 1;

CREATE TABLE meslekler
(
id int PRIMARY KEY, 
isim VARCHAR(50), 
soyisin VARCHAR(50), 
meslek CHAR(9), 
maas int
);

INSERT INTO meslekler VALUES (1, 'Ali', 'Can', 'Doktor', '20000' ); 
INSERT INTO meslekler VALUES (2, 'Veli', 'Cem', 'Mühendis', '18000'); 
INSERT INTO meslekler VALUES (3, 'Mine', 'Bulut', 'Avukat', '17008'); 
INSERT INTO meslekler VALUES (4, 'Mahmut', 'Bulut', 'Ögretmen', '15000'); 
INSERT INTO meslekler VALUES (5, 'Mine', 'Yasa', 'Teknisyen', '13008'); 
INSERT INTO meslekler VALUES (6, 'Veli', 'Yilmaz', 'Hemşire', '12000'); 
INSERT INTO meslekler VALUES (7, 'Ali', 'Can', 'Marangoz', '10000' ); 
INSERT INTO meslekler VALUES (8, 'Veli', 'Cem', 'Tekniker', '14000');
insert into meslekler values (9,'Ümit','Can','Mühendis','25000');

--Soru-7: meslekler tablosunu isime göre sıralayınız
SELECT * FROM meslekler
ORDER BY isim;

--Soru-8: meslekler tablosunda maaşı büyükten küçüğe doğru sıralayınız
SELECT maas FROM meslekler
ORDER BY maas DESC;

--Soru-9: meslekler tablosunda ismi Ali olanların maaşıni büyükten küçüğe doğru sıralayınız
SELECT maas FROM meslekler
WHERE isim = 'Ali'
ORDER BY maas DESC;

--Soru-10: meslekler tablosunda id değeri 5 ten büyük olan ilk iki veriyi listeleyiniz
SELECT * FROM meslekler
WHERE id>5
LIMIT 2;

--Soru-11: meslekler tablosunda maaşı en yüksek 3 kişinin bilgilerini getiriniz
SELECT * FROM meslekler
ORDER BY maas DESC
LIMIT 3;


create table musteriler(
id int primary key,
isim varchar(50),
sehir varchar(50),
yas int 
);

insert into musteriler values(100, 'Ahmet Umit', 'Istanbul', 54);
insert into musteriler values(101, 'R.Nuri Guntekin', 'Antalya', 18);
insert into musteriler values(102, 'S.Faik Abasiyanik', 'Bursa', 14);
insert into musteriler values(103, 'Yasar Kemal', 'Istanbul', 26);
insert into musteriler values(104, 'Halide E. Adivar', 'Izmir', 35);
insert into musteriler values(105, 'Nazan Bekiroğlu', 'Izmir', 42);
insert into musteriler values(106, 'Peyami Safa', 'Antalya', 33);
insert into musteriler values(107, 'Sabahattin Ali', 'Istanbul', 41);
insert into musteriler values(108, 'Oguz Atay', 'Istanbul', 28);
insert into musteriler values(109, 'Orhan Pamuk', 'Ankara', 30);
insert into musteriler values(110, 'Elif Safak', 'Bursa',27);
insert into musteriler values(111, 'Kemal Tahir', 'Izmir', 29);


create table siparisler(
id int,
musteri_id int,
urun_adi varchar(50),
tutar int);



insert into siparisler values(3002, 101,'roman', 230);
insert into siparisler values(3004, 102,'tukenmez kalem', 80);
insert into siparisler values(3006, 109,'sirt cantasi', 440);
insert into siparisler values(3008, 103,'kursun kalem', 75);
insert into siparisler values(3009, 105,'cizgili defter', 250);
insert into siparisler values(3010, 108,'kol cantasi', 300);
insert into siparisler values(3011, 106,'masal kitabi', 175);
insert into siparisler values(3013, 107,'kareli defter', 145);
insert into siparisler values(3001, 111,'matematik kitabi',500);
insert into siparisler values(3003, 130,'cizgisiz defter', 145);

--SORU1: musteriler tablosunda sehir'i Istanbul olan veriler ya da yasi 
--30dan buyuk olan verilerin isimlerini listeleyiniz
SELECT isim FROM musteriler
WHERE sehir = 'Istanbul' OR yas > 30;

--SORU2: musteriler tablosunda id degeri 105ten kucuk olan verilerin isimlerini 
--ya da yası 20 ile 30 arasında olan verilerin sehirlerini listeleyiniz
SELECT sehir FROM musteriler
WHERE id<105 OR (yas BETWEEN 20 AND 30);

--SORU3: siparisler tablosundaki k ile baslayan urunlerin
--urun adi ve musteri_idleri ile
--musteriler tablosundaki ismi O ile baslayan verilerin
--isim ve id lerini listeleyiniz
SELECT urun_adi , musteri_id FROM siparisler WHERE urun_adi ILIKE 'k%'
UNION
SELECT isim, id FROM musteriler WHERE isim ILIKE 'O%';

--SORU4: musteriler tablosundaki verilerden yası en buyuk 
--3. ve 6. verilerin tum bilgilerini listeleyin
(SELECT * FROM musteriler ORDER BY yas DESC OFFSET 2 LIMIT 1)
UNION
SELECT * FROM musteriler ORDER BY yas DESC OFFSET 5 LIMIT 1

--SORU5:ÖDEV!!! musteriler tablosundan yası 30dan kucuk 
--olan verilerin id ve sehirleri ile
--siparisler tablosundan tutarı 250den buyuk 
--olan verilerin id ve urun_adi'larini listeleyiniz
SELECT id,sehir FROM musteriler WHERE yas<30
UNION
SELECT id,urun_adi FROM siparisler WHERE tutar >250;



--SORU6: musteriler tablosundaki sehir ismi I ile baslayan verilerin isimlerini ve 
--yas degeri 30dan cok olan verilerin isimlerini tekrarlı olacak sekilde listeleyiniz 
--tekrarli bir cıktı istiyor isek union all kullanıcaz

SELECT isim FROM musteriler WHERE sehir LIKE 'I%'
UNION ALL
SELECT isim FROM musteriler WHERE yas > 30;

--SORU7: musteriler tablosundaki sehir'i Izmır olan verilerin id leri ile
--siparisler tablosundaki urun_adi cizgili defter olan verilerin musteri_idlerinin
--kesişimini(ortak olanları) bulunuz
SELECT id FROM musteriler WHERE sehir = 'Izmir'
INTERSECT
SELECT musteri_id FROM siparisler WHERE urun_adi ='cizgili defter';

--SORU8: musteriler tablosundan sehri Istanbul veya Ankara olan verilerin idlerinin
--siparisler tablosundaki id'si 3010dan buyuk olan verilerin 
--musteri_idlerinden farklı olanları listeleyiniz
--except (a/b)

SELECT id FROM musteriler WHERE sehir = 'Istanbul' or sehir = 'Ankara'
EXCEPT
SELECT musteri_id FROM siparisler WHERE id > 3010;

