CREATE TABLE manav(
	isim VARCHAR(50),
	urun_adi VARCHAR(50),
	urun_miktari INTEGER
);

INSERT INTO manav VALUES ('Ali','Elma',5);
INSERT INTO manav VALUES ('Ayse','Armut',3);
INSERT INTO manav VALUES ('Veli','Elma',2);
INSERT INTO manav VALUES ('Hasan','Uzum',4);
INSERT INTO manav VALUES ('Ali','Armut',2);
INSERT INTO manav VALUES ('Ayşe','Elma',3);
INSERT INTO manav VALUES ('Veli','Uzum',4);
INSERT INTO manav VALUES ('Ali','Armut',2);
INSERT INTO manav VALUES ('Veli','Elma',3);
INSERT INTO manav VALUES ('Ayse','Uzum',4);
INSERT INTO manav VALUES ('Ali','',2);

SELECT * FROM manav;

--ORNEK1: kişi ismine göre satılan toplam meyve miktarlarını gösteren sorguyu
--yazınız. ali => 5+2+2+2 sum= meyve sayılarını toplycak

UPDATE manav
SET urun_adi = null
WHERE urun_adi = '';

SELECT isim, SUM(urun_miktari) AS toplam_urun FROM manav
GROUP BY isim;     --isim isim grupla her ismi bir kere yaz, o isimdeki meyve sayılarını
                   --toplam ilgili ismin satırında göster

--ORNEK2: satilan meyve turune (urun_adi) gore urun alan kişi sayısını gösteren sorguyu yazınız.
--NULL olarak girilen meyveyi listelemesin. count= elma alan kişileri sayacak

SELECT urun_adi, COUNT(isim) FROM manav
WHERE urun_adi IS NOT NULL
GROUP BY urun_adi;

--ORNEK3: satılan meyve turune (urun_adi) göre satilan urun_miktari MIN ve MAX urun miktarlarini,
--MAX urun miktarina gore siralayarak listeleyen sorguyu yazınız

SELECT urun_adi,MAX(urun_miktari),MIN(urun_miktari) FROM manav
WHERE urun_adi IS NOT NULL
GROUP BY urun_adi
ORDER BY MAX(urun_miktari) DESC;

/* ************************SIRALAMA AŞAĞIDAKI GİBİ OLMALI************************************
select from
where
group by
having
order by
*/

--ORNEK4: Kisi ismine ve urun adina (select) gore satlan urunlerin toplamini 
--gruplandıran ve once isme gore sonra urun_adina gore ters sirayla listeleyen sorguyu yazin
--ogren

SELECT isim, urun_adi, SUM(urun_miktari) FROM manav
WHERE urun_adi IS NOT NULL
GROUP BY isim,urun_adi
ORDER BY isim ASC , urun_adi DESC;

--ORNEK5: kisi ısmine ve urun adina gore, satilan urunlerin toplamini bulan ve
--bu toplam degeri 3 ve fazlasi olan kayitlari toplam urun miktarlarina gore ters siralayarak listeleyen sorguyu yaziniz

SELECT isim, urun_adi, SUM(urun_miktari) AS toplam_urun FROM manav
WHERE urun_adi IS NOT NULL
GROUP BY isim, urun_adi
HAVING SUM(urun_miktari) >3
ORDER BY SUM(urun_miktari) DESC;

--ORNEK6: satilan urun_adina gore gruplayip MAX urun sayilarini, (yine max urun sayisine gore)
--siralayarak listeleyen sorguyu yaziniz. NOT: Sorgu, sadece MAKS urun_miktari MIN urun_miktarina
--esit olmayan kayitlari (where gibi koşul var) listelemelidir

SELECT urun_adi , MAX(urun_miktari) FROM manav
WHERE urun_adi IS NOT NULL
GROUP BY urun_adi
HAVING MAX(urun_miktari) != MIN(urun_miktari)
ORDER BY MAX(urun_miktari)

--********************************************DISTINCT*****************************************

--ORNEK1: satilan farkli meyve turlerinin sayisini listeleyen sorguyu yaziniz

SELECT COUNT(DISTINCT urun_miktari) FROM manav;

--ORNEK2: satilan meyve ve isimlerin (totalde ) farkli olanlarını listeleyen sorguyu yaziniz

SELECT DISTINCT urun_adi,isim FROM manav
WHERE urun_adi IS NOT NULL;

--ORNEK3: satilan meyvelerin urun_miktarlarinin benzersiz olanlarinin
--toplamlarini listeleyen sorguyu yaziniz

SELECT urun_adi , SUM(DISTINCT urun_miktari) FROM manav
GROUP BY urun_adi;


