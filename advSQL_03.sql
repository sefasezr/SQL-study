--******************** CONSTANT VARİABLES/ Daimi Degisken(Degeri Sabit Degiskenler) **********************
-- final --> OOP de bir object final olarak declare edildiginde degeri degistirilemez.

--selling_price := net_price * 0.1;  0.1'in degerini bir degiskene atarsak kodumuz daha dinamik olur
--vat (kdv) constant := 0.1;
--vat degerini constant olarak belirttigimiz icin sabit deger olarak tanimlamis oluruz
-- yani degistirilemez final değişken denir aslında javada buna

do $$
declare
		vat constant numeric := 0.1;
		gross_price numeric := 20.5;
	  
	
begin

raise notice 'Satis fiyatı : %', gross_price *(1+vat);
	--vat :=0.55; --variable "vat" is declared constant
end $$;

do $$
declare
		start_at constant time := now();
begin

	raise notice 'Blokun calisma saati: %',start_at;


end $$


-- ////////////////////// CONTROL STRUCTURES/KONTROL YAPI BLOKLARI ///////////////////

-- If Statements

If condition then  --kosul dogru ise
	
	 statement  --calısmasını istedigimiz kodlar
	
end if;

--Task: 0 id li filmi bulunuz yoksa ekrana uyarı yazısı yazdırınız

do $$
declare
		selected_film film%rowtype;
		input_film_id film.id%type := 0;

begin

	select * from film
	into selected_film
	where id= input_film_id;

	if found then
	raise notice 'Girdiginiz % id li filmin detayları: % %',input_film_id , selected_film.title, selected_film.type;
	end if;
	
	if not found then
	raise notice 'Girdiginiz id ile ilgili film bulunamadı: %',input_film_id; --film bulunmazsa bu mesaj verilecek
	end if;

end $$



-------------------------
do $$
declare
		selected_film film%rowtype;
		input_film_id film.id%type := 0;

begin

	select * from film
	into selected_film
	where id= input_film_id;

	if found then
	raise notice 'Girdiginiz % id li filmin detayları: % %',input_film_id , selected_film.title, selected_film.type;
	
	
	else
	raise notice 'Girdiginiz id ile ilgili film bulunamadı: %',input_film_id; --film bulunmazsa bu mesaj verilecek
	end if;

end $$

-- ***********************If .... then else***********************

/*
if condition then

			statements;
else
	 		alternative statements;
end if;
	
*/
--TASK: id si verilen filmi var ise ekrana yazdırınız yoksa kullanıcıya geçersiz film idsi diye uyarı veriniz
	
	
do $$
declare
	input_film_id film.id%type :=7;
	selected_movie film%rowtype;

begin
	select * from film
	into selected_movie
	where id = input_film_id;

if not found then 
	raise notice 'Girmis oldugunuz id li film bulunamadı : %',input_film_id;
else
	raise notice 'Filmin ismi % ve türü %. ', selected_movie.title , selected_movie.type;
end if;
end $$

-- ****************** If then - else if ******************************
--syntax :

if condition_1 then
			statement_1;
	else if condition_2 then
			statement_2;
	else if condition_n then
			statement_n
	else
		else_statement;
	end if;

/*  Task: id si 1 olan film varsa;
	suresi 50 dakinkanın altında ise Short,
    50>length<120 ise Medium,
	length>120 ise Long uyarısı veriniz
*/

do $$
declare
		selected_film film%rowtype;
		len_description varchar(20);
		input_film_id film.id%type =1;
	
begin
SELECT * FROM film
into selected_film
WHERE id = input_film_id;

if not found then
	raise notice 'Film bulunamadı.';

else if 
	selected_film.length>0 and selected_film.length <=50 then
	len_description :='Short';
elseif selected_film.length>50 and selected_film.length <=120 then
	len_description :='Medium';
elseif selected_film.length>120 then
	len_description :='Long';
else 
	len_description :='Tanımlanamadı/Undefined';
end if; --nested else if yapısı icin bloku kapatma komutu

raise notice '% filminin süresi: %',selected_film.title,len_description;

end if; --outer/ilk yazılan if ile baslayan blokun kapatılması icin yazılan kapatma komutudur
	
end $$;

