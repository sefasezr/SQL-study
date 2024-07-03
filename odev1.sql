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

CREATE TABLE tedarikciler(
tedarikci_id INTEGER,
tedarikci_ismi VARCHAR(20),
tedarikci_adres TEXT,
ulasim_tarihi DATE
);

CREATE TABLE tedarikci_info 
AS SELECT tedarikci_ismi , ulasim_tarihi 
FROM tedarikciler;

CREATE TABLE ogretmenler(
kimlik_no char(11),
isim varchar(15),
brans varchar(20),
cinsiyet varchar(5)
);

INSERT INTO ogretmenler VALUES('234431223','Ali Guler','Matematik','Kadin');
INSERT INTO ogretmenler VALUES('234431224','Ayse Guler','Fizik','Erkek');

INSERT INTO ogretmenler(kimlik_no,isim) VALUES ('567597624','Veli Guler');

