-- ****************************** WHILE LOOP ********************************
-- syntax:

while condition loop
	
statements;

end loop;

--Task: 0 dan 4 e kadara counter degerlerini ekrana yazdırınız

do $$
declare
	counter integer:=0;

begin

	loop
		EXIT WHEN counter = 5;

	raise notice 'counter: %',counter;

	counter := counter + 1 ;

	end loop;

end $$;

----------------------------------------
do $$
declare 
	counter integer :=0;

begin

	while counter < 5 loop

	raise notice 'counter : %',counter;

	counter := counter +1;

	end loop;

end $$;


-- ******************************* EXIT KEYWORD *****************************
-- loop dan belli bir kosul true oldugunda loop dan cıkılmasını saglar. Java daki "break" keyword gibi
--1.syntax:
exit when counter>10;   --best practice cunku az kelime cok fonksiyon yaptırabiliriz

--2.syntax:
if counter > 10 then
	exit;

end if;

-- Ornek:

do $$

begin
	<<inner_block>>
	begin
		exit inner_block;
		raise notice 'inner block calisti';

	end;

	raise notice 'outer block calisti';

end $$;

-- ************************ CONTINUE (DEVAM ET/BEKLEME YAPMA) **************************
--verilen kod satırından atlanılmasını istediğimiz kısımları belirtmek için kullanılır
--0dan 10 a kadar cift sayilari atlayarak yazdırınız

DO $$
begin

for counter in 1..10 loop
	
	if counter % 2 != 0 then
		raise notice '%',counter;
	end if;

end loop;

end $$;

--üstte continue kullanmadan

DO $$
declare

counter integer:=0;

begin
	
	loop
	counter:=counter+1;
	
	exit when counter > 10;

	

	continue when mod(counter,2)=0;

	raise notice 'counter: %',counter;

	end loop;


end $$;

CREATE TABLE bank(
	client_id integer PRIMARY KEY,
	client_name varchar(50),
	monthly_expense integer,
	mes_req varchar(80),
	membership varchar(20)
);

INSERT INTO bank VALUES (456456456, 'Tom Hanks' ,6000);
INSERT INTO bank VALUES (456456457, 'Brad Pitt',3000);
INSERT INTO bank VALUES (456456458,'Hug Grant',2000);
INSERT INTO bank VALUES (456456459,'Tom Junior',45000);
INSERT INTO bank VALUES (456456453,'John Walker',2500);

SELECT * FROM bank;

--Task: bir banka uygulamasında; aylık expense 5000 üzerinde olan musteriler icin membership field bilgisini
-- Premium Membership olarak güncelle
-- ve mes_req fieldini Premium Membership mesaj göndermek gerekli olarak güncelleyiniz ve bu guncelleme islenmis olan musterilerin isimlerini
--ve aylık harcamalarını ekrana yazdırınız

do $$ 
declare
	
	client record;
	mes_required varchar(80):='Premium Membership mesaj göndermek gerekli';
	membership_value varchar(50):= 'Premium Membership';
	counter integer:=0;
	

begin
	
	update bank
	set membership = membership_value,
		mes_req = mes_required
	where monthly_expense > 5000;

	for client in 
				select client_name , monthly_expense
				from bank
				where mes_req = mes_required AND membership = membership_value
	loop

	raise notice 'Client details: %, %',client.client_name, client.monthly_expense;

	end loop;
end $$;

--Actor tablosundan gelen first_name ve last_name degerlerini birarada olacak sekilde yazdırın

do $$
declare
selected_actor record;

begin

	for selected_actor in SELECT first_name, last_name FROM actor loop
	raise notice '%, % ', selected_actor.first_name, selected_actor.last_name;

	end loop;

end $$;

-------------------------- böyle yapılır aşağıdaki gibi

do $$
declare
		full_name record;
begin
	for full_name in select first_name ||' '|| last_name from actor loop
	
	raise notice 'Actor name: %', full_name;

	end loop;
end $$;

/*
Cinsiyet "Erkek" ise ve yaş 13'ten küçükse "Erkek Cocuk" yazdır, aksi takdirde "Erkek" yazdır
		Cinsiyet "Kadın" ise ve yaş 13ten küçükse Kız yazın, aksi halde Kadın yazın
	Cinsiyet erkek ve kadından farklıysa bilgi yok yazdırın

*/

do $$
declare
cinsiyet varchar(10):='Erkek';
yas integer :=15;
bilgi varchar(50);
begin

	if(cinsiyet = 'Erkek' AND yas < 13 ) then
		bilgi = 'Erkek Çocuk';
	else if (cinsiyet = 'Erkek' AND yas > 13 ) then
		bilgi = 'Erkek';
	elseif (cinsiyet = 'Kadın' AND yas < 13 ) then
		bilgi = 'Kız';
	elseif (cinsiyet = 'Kadın' AND yas > 13 ) then
		bilgi = 'Kadın';
	else
		bilgi = 'Bilgi yok';
	end if;

	end if;

raise notice '%', bilgi;
	
	
end $$;
			
	

