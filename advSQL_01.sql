--uzun yorumlar icin
/*
uzun yorum satirlari icin kullanılır
*/

-- **************** DEGİSKEN TANIMLAMA *******************
--anonymous(ismi olmayan,genel) bir prosedur uygula diyoruz dolar sign ile
	  --syntax içerisinde kullanılacak (varchar, text gibi) degiskenlerin tirnak isaretlerini pgAdmin ekleyecek demis oluyoruz
      --databaselerde yapacagimiz harekette kullanacagimiz degiskenlerin icinde varchar ya da text gibi degisken ifadeler
	  --var ise $$ isareti koyariz '' sorun olmamasi icin  
	  --counter degisken adi , integer data tipi
	  --raise notice: uyarı not farkındalık gibi bir şey 

do $$
declare
    counter integer :=1;  --counter isminde bir degisken olusturuldu ve 1 deger olar. atandi
	first_name varchar(50) :='Ahmet';
    last_name varchar(50) :='Gok';
	payment numeric(4,2) := 20.5;
begin						--1) Ahmet Gok has paid 20.5
	raise notice '%) % % has paid % USD',
				    counter,
				    first_name,
					last_name,
					payment;
end $$;

--TASK 1:Degiskenler olusturarak ekrana "Ahmet ve Mehmet beyler 120 TL ye bilet aldilar." cumlesini ekrana yazdiriniz

do $$
declare
	first_person varchar(50) :='Ahmet';
	second_person varchar(50) :='Mehmet'; 
	payment numeric(3) :=120;
	birim varchar(4) := 'TL';
begin
	raise notice '% ve % beyler % % ye bilet aldilar.',
					first_person,
					second_person,
					payment,
					birim;
end $$;

--*****************BEKLETME KOMUTU***********************

do $$
declare
		created_at time :=now();  --local /db de olan simdiki zaman degerini created_at degiskenine atama yapar
begin
	raise notice '%',
		created_at;
	perform 
		pg_sleep(5);  --5 saniye bekle diye yazdık
	raise notice '%',
		created_at;
end $$;
		
-- **************** TABLODAN DATA TYPE INI KOPYALAMA ************'

do $$
declare
		film_title film.title%type := (SELECT title FROM film WHERE id=1);
begin
	raise notice '%',
		film_title;
end $$;

-- film_title film.title%type yazarken 
-- film_title = degisken adidir
-- film.title%type ise dinamik şekilde titlein data tipini alır




