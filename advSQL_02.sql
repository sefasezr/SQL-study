--aciklama
/*
long comment line
*/
--PL/SQL : Procedurel language DB'deki serve ile db islem yapma kabiliyeti kazandıran kullanışlı dil.
--PL/SQL : DB server ile konusmak/iletisim kurmak icin kullanilan dildir.UI den gonderilen basit/cok komplex olmayan queryleri
--dbdenn alip UI 'e dondurmeye yarayan dildir.

-- **************** TABLODAN DATA TYPE KOPYALAMA ****************
do $$
declare
	film_type film.type%type;
	film_length film.length%type;
	film_title film.title%type;
begin
	--TASK: Name i Shrek olan filmin türünü ve uzunlugunu getirelim
	SELECT title
	FROM film
	into film_title
	WHERE id = 1;
	
	SELECT type
	FROM film
	into film_type
	WHERE id = 1;

	Select length
	FROM film
	into film_length
	WHERE id = 1;

	raise notice 'Adı % olan filmin türü % türüdür ve uzunluğu % dakikadır.',
		film_title,
		film_type,
		film_length;

end $$;

-- *********************ROW TYPE/ (SATIR DATA TYPE) data type KOPYALAMA *********
--ROW TYPE: tüm satırı yani id firstname lastnamei aynı anda alabilen data
--PL/PGSQL bize dbde var olan datalarla aynı bir OOP de oldugu gibi datalarıı snki onlar bir objectmis gibi ve hatta
--bir object'i maplermis gibi istedigimiz islemleri ypmamıza olanak tanır. Arka planda header/column değil row icindeki
--datanin bilgilerini direkt alabiliriz

--TASK: id'si 1 olan actor ile ilgili tum datayı bulunur

do $$
declare
	selected_actor actor%rowtype;
begin
	
	SELECT * FROM actor
	into selected_actor
	WHERE id =1;

	raise notice 'The actor name is: % %',selected_actor.first_name , selected_actor.last_name;


end $$;

--üstte selected_actor.first_name diyerek selected_actor datasının içinden
--firstnamei aldık sonra lastname i aldık aslında Javadaki
--List içine atılan pojo class gibi düşünebiliriz
--Orada da aynı şekilde . koyup alabiliyoruz
--Aşağıda daha farklı şekilde direkt 1 adet % işareti koyarak sadece o listeyi aldım selected_actor yazarak


do $$
declare
	selected_actor actor%rowtype;
begin
	SELECT * FROM actor
	into selected_actor
	WHERE id = 1;

	raise notice 'The actor inform: %',selected_actor;

end $$;

-- ***************** RECORD TYPE (KAYIT/TABLE'daki DATA KISMI) *******************
--RECORD TYPE data type'i declare edildiginde bildirilen tablonun bazı yada butun field data type'lerine uygun veriyi tutabilecek
--bir degisken declare edilmis olur

--TASK: id'si 1 olan filmin title, type ekrana yazdırınız

do $$
declare
	rec record;
	--rec adında record datatype'inda bir data oluşturduk
	
begin

	SELECT title,type
	FROM film
	into rec
	WHERE id = 1;

	raise notice 'Idsi 1 olan filmin adı % ve türü %.',
		rec.title,
		rec.type;

end $$
-- ÇIKTI = Kuzularin Sessizliği - Korku

-- ****************** İC İCE BLOK YAPISI ********************
--Şimdiye kadar 1 bloklu yani 1 do 1 declare 1 begin ve 1 end keywordune sahip ve tek statement ile data queryleri yaptik
--Artık PL/SQL de ic ice girmis bloklar halinde birden fazla action'i db'ye yaptırabiliriz.

do $$
--dış blok /outer blok 
<<outer_blok>>	
declare
		counter integer :=0;
	begin
		counter :=counter +1;
		raise notice 'Counter in degeri: %',counter;

	declare  --iç blok / inner block
		counter2 integer :=0;
	begin
		counter2 := counter2+10;
		raise notice 'Counter2 nin degeri: %',counter2;
		raise notice 'Counter in degeri: %',counter;
	end;
end $$;

do $$
--dış blok /outer blok 
<<outer_blok>>	
declare
		counter integer :=0;
	begin
		counter :=counter +1;
		raise notice 'Counter in degeri: %',counter;

	declare  --iç blok / inner block
		counter integer :=0;
	begin
		counter := counter+10;
		raise notice 'Counter in degeri: %',counter;  --aynı isimlerde degiskenler aynı blok icersiinde kullanılırsa bu degiskenin
														-- hangi blokta oldugunu belirtip onu kullanmamız gerekir.
		raise notice 'Counter in degeri: %',outer_blok.counter;  --timestamp : zaman sayacı
	end;
end $$;


