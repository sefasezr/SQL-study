--***Day 1 MongoDB ***
1-Ekrani Temizleme

*cls*



2-shop isminde bir DB olusturalım

*use shop*



3-Hangi DB deyim?

*DB*



4-Tüm DB leri gorelim

*show databases



5-customers adında bir collection olusturalım

*db.createCollection('customers')*




6-tüm collectionlari gorelim

*show collections

YA DA

*db.getCollectionNames()



7-customer isim collection'i silelim

*db.customers.drop()



8-shop DB'yi silelim

*db.dropDatabase()


9-yeni bir DB(products)
ve icine bir collection
ekleyelim:electronics

*use products
*db.createCollection('electronics')


10-electronics isimli collectionimiza
bir document ekleyelim

*db.electronics.insertOne({"name":"TV","price":230})

NOT: olmayan bir collection'a document eklemek
istersem ne olur?
Otomatik olarak bir collection olusuturup documenti ekler



11-bir collection'a birden fazla document ekleyelim

*db.electronics.insertMany([{name:"ipod",price:110},
{name:"Radio",price:70},
{"name":"İphone","price":250.99,"tax":1.2}])

NOT: insertMany parametre olarak document dizisi(array)
aldığı icin [] ile kullanilir



12-tüm documentleri listeleyim.

db.electronics.find()



13-sadece ilk 2 documenti gorelim

db.electronics.find().limit(2)



14-sadece 2-4 arasindaki documentleri gorelim

db.electronics.find().skip(1).limit(2)



15-name'i ipod olan documentleri getir

db.electronics.find({"name":"ipod"})

NOT : find({filter})


16-name'i ipod olan ve 
price'i : 70 olan documentleri gorelim

db.electronics.find({"name":"ipod","price":110})
YA DA
db.electronics.find({$and:[{"name":"ipod"},{"price":110}]})



17-name'i ipod olan veya 
price'i 70 olan documentleri gorelim

db.electronics.find({$or:[{"name":"ipod"},{"price":230}]})



18- 17. sorudaki sorgu ile birlikte
sadece tek bir deger olan price degerini getirelim

db.electronics.find({$or:[{"name":"ipod"},{"price":250.99}]},{"price":1})

NOT : find({filter},{projection})

NOT : projectionda bazi fieldlarimizin deger
0 ve ya 1 olarak verilmistir
burda 0 olarak girdigimiz fieldlar yazdılırmaz
1 olarak girdigimiz zaman sadece o field yazdilir

1-> göster
0-> gösterme


19-tüm documentleri gorentüleyelim 
fakat sadece price ve name bilgileri gelsin.

db.electronics.find({},{name:1,price:1,_id:0})


20-yukaridaki sorguyu price degerine gore siralıyınız?

db.electronics.find({},{name:1,price:1,_id:0}).sort("price")

NOT sort parametrede yazılan fielda gore
siralama islemi yapar bunu default olarak
asc(artan) olarak siralar 

NOT :  ASC icin deger -> 1
      DESC icin deger -> -1



21- yukaridaki sorguyu price degerine gore azalan sıralıyınız?

db.electronics.find({},{name:1,price:1,_id:0}).sort({"price":-1})



22-name:TV olan documentleri price degerine gore azalan siralayınız

db.electronics.find({"name":"TV"},{"name":0}).sort({"price":-1})




23-collectiondaki tüm documenlerden ilkini gorelim

db.electronics.findOne()



24-collectiondaki name:Radio olan documentlerden ilkini gorelim

db.electronics.findOne({name:"Radio"})