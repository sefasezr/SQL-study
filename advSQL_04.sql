-- **************** Case Statement *************************
--syntax:

case search-expression
	 when expression_1 [, expression_2...] then
	 statement
	 when expression then
	 statement

	 else
		statement
end case;


--Task: id'si 0 olan Filmin turune gore cocuklar icin uygun olup olmadigini ekrana yazdiriniz

do $$
declare
	film_turu film.type%type;
	uyarı_mesajı varchar(50);

begin

	select type from film
	into film_turu
	where id = 0;

	if found then

		case film_turu
			when 'Korku' then 
				uyarı_mesajı := 'Çocuklar için uygun değil';
			when 'Animasyon' then
				uyarı_mesajı := 'Çocuklar için uygun';
			when 'Macera' then
				uyarı_mesajı := 'Çocuklar için uygun';
			when 'Aksiyon' then
				uyarı_mesajı := 'Çocuklar için uygun değil';

	else

		uyarı_mesajı := 'Tanımlanamadı';
	
	end case;

	raise notice '%', uyarı_mesajı;

	end if;

	if not found then
		uyarı_mesajı :='Gecersiz film id';
		raise notice '%', uyarı_mesajı;
	end if;

end $$;

-- ********************** LOOP ************************************

--tekrarlı data islenmesini istediğimizde loop kullanılır

<<label>>
loop

statement -- bu sekilde yazarsak infinite/sonsuz loop riski vardır.

end loop;

--loopu sonlandırmak icin loopun icine if yapısını kullanabiliriz

loop

	if condition then 
	statement

	end if;
	exit; --loop scope ının dışında kullanmamalıyız içinde olması gerekli. loopdan çıkmayı sağlayan keyword

end loop;

--ic ice yapılar/nested loop

<<outer>>
loop

<<inner>>
loop
statement
end <<inner>> loop;

end <<outer>> loop;

-- Fibonacci Sayıları: 0dan başlandıgı düşünülür. Kendisinden bir sonraki gelen rakam ile toplanır
-- 0+1=1
-- 1+2=3
-- 2+3=5
-- 3+5=8

--Task: n sayıda integer icin Fibonacci sayılarını ekrana yazdırınız
--burada toplama baslangıc degeri olarak 1 icin bir degisken
--

do $$
declare
	n integer :=3;
	counter integer :=0;
	ilk_sayi integer :=0;
	sonraki_sayi integer :=1;
	fibonacci integer;
	

begin
	for counter in 1..8 loop
	fibonacci := ilk_sayi;
	ilk_sayi :=sonraki_sayi;
	sonraki_sayi :=sonraki_sayi + fibonacci;
	raise notice '%.adim: %',counter, fibonacci;

	end loop;
end $$;

--başka yol 

do $$
declare
	n integer :=0;
	counter integer :=0;
	ilk_sayi integer :=0;
	sonraki_sayi integer :=1;
	fibonacci integer;
	
begin
	if(n<1) then 
	fibonacci = 0;
	raise notice 'Girilen deger gecerli degil: %',fibonacci;
	end if;

 	loop 
		exit when counter=n;
		counter := counter+1;
		fibonacci := ilk_sayi;
		ilk_sayi :=sonraki_sayi;
		sonraki_sayi :=sonraki_sayi + fibonacci;
		raise notice '%.adim: %',counter, fibonacci;

	end loop;

end $$;


-- **************************** For Loop ********************************

--Ornek: (in) 1den 5e kadar ekrana yazdırınız

do $$
begin

for counter in 1..5 loop
	
raise notice 'counter: %',counter;

end loop;

end $$;

--Ornek: (in) ve by ile for loop kullanımı

do $$
begin

for counter in 0..1000 by 5 loop
	
raise notice 'counter: %',counter;

end loop;

end $$;

--Ornek: (reverse) --ters

do $$

begin

for counter in reverse 1000..0 by 5 loop
raise notice 'counter: %',counter;
end loop;

end $$;


--ORNEK

do $$
begin
for harf in 65..90 loop
raise notice '%', CHR(harf);
end loop;

end $$

--DB'den data alırken loop kullanımı

for target in query loop

statement

end loop;


--Task Filmleri süresine göre sıraladığımızda en uzun 2 filmi gösterelim

do $$
declare 
	film_length record;
begin
	  for film_length in SELECT title, length FROM film order by length desc limit 2 loop

	raise notice '% isimli filmin uzunlugu % dakikadir', film_length.title, film_length.length;    

	end loop;
end $$;

-----------------------
/*
do $$
declare 
	film_length record;
begin
	  for counter in 1..2 loop

	SELECT title, length FROM film
	order by length desc
	into film_length
	
	raise notice '% isimli filmin uzunlugu % dakikadir', film_length.title, film_length.length;    

	end loop;
end $$;
*/


