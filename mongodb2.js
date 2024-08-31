//*** DAY2 ***/

use('products');
db.electronics.find();

use('shop');
db.electronics.insertMany(
    [
        { name: "Laptop", price: 1000 }, 
        { name: "Smartphone", price: 500 }, 
        { name: "Headphones", price: 150 }, 
        { name: "Smartwatch", price: 200 }, 
        { name: "Camera", price: 800 }, 
        { name: "Tablet", price: 300 }, 
        { name: "Keyboard", price: 80 }, 
        { name: "Mouse", price: 40 }, 
        { name: "Monitor", price: 250 }, 
        { name: "Printer", price: 120 }

    ]
);

use('shop');
db.electronics.insertMany([
    { name: "Smart TV", price: 1200, tax: 100 }, 
    { name: "Bluetooth Speaker", price: 75, tax: 7.5 }, 
    { name: "External Hard Drive", price: 150, tax: 15 }, 
    { name: "Home Theater System", price: 450, tax: 45 }, 
    { name: "Digital Camera Lens", price: 250, tax: 25 }
]);
use('shop');
db.electronics.find();

//========================================================
//            findOneAndUpdate - findOneAndReplace
//========================================================

//A-findOneAndUpdate 
//belirtilen koşullara uygun ilk dokumanı
//getirir ve günceller
//bize dönüş olarak güncellenen değerin eski halini getirir
//({filter},{update},{projection})
//HTTP requestlerden Patch'e benzetilebilir

//B-findOneAndReplace:
//belirtilen kosullara uygun ilk dokumani getirir ve degistirir
//HTTP requestlerden Put'a benzetilebilir


//25-price'i 100den az olan ilk dokumentin name:"mobilPhone
//price:250
//olarak değiştirelim

/*
1. Sorgulama Operatörleri
$eq: Eşitlik operatörü. Belirli bir değere eşit olan belgeleri bulur.
{ age: { $eq: 30 } }
 
$ne: Eşit Olmama operatörü. Belirli bir değere eşit olmayan belgeleri bulur.
{ age: { $ne: 30 } }
 
$gt: Büyükten Büyük operatörü. Belirli bir değerden büyük olan belgeleri bulur.
{ age: { $gt: 30 } }

$lt: Küçükten Küçük operatörü. Belirli bir değerden küçük olan belgeleri bulur.
{ age: { $lt: 30 } }

$gte: Büyük veya Eşit operatörü. Belirli bir değere eşit veya ondan büyük olan belgeleri bulur.
{ age: { $gte: 30 } }

$lte: Küçük veya Eşit operatörü. Belirli bir değere eşit veya ondan küçük olan belgeleri bulur.
{ age: { $lte: 30 } }

$in: İçinde operatörü. Belirli bir dizi içinde bulunan değerleri arar.
{ status: { $in: ["A", "B"] } }

$nin: İçinde Olmama operatörü. Belirli bir dizi içinde bulunmayan değerleri arar.
{ status: { $nin: ["A", "B"] } }
$exists: Alanın mevcut olup olmadığını kontrol eder.
{ age: { $exists: true } }

$regex: Düzenli ifade (regex) kullanarak arama yapar.
{ name: { $regex: /^A/ } }
*/

use('shop');
db.electronics.findOneAndReplace({price:{$lt:100}},{"name":"mobilPhone",price:250});


//26-price'ı 100den kcuuk olan dökümentlerden price'i en büyük olan documenti
//name:"En Pahalı" olarak değitşirelim

use('shop');
db.electronics.findOneAndReplace({price:{$lt:100}},{"name":"En Pahalı"},{sort:{price:-1}});

use('shop');
db.electronics.find();

//27-price'ı 100den buyuk olan dökümentlerden price'i en kucuk olan documenti
//name:"En Ucuz" olarak güncelleyelim

use('shop');
db.electronics.findOneAndUpdate({price:{$gt:100}},{$set:{"name":"En Ucuz"}},{sort:{price:1}});

/*
MongoDB Güncelleme Operatörleri
$set
Açıklama: Belirli bir alanın değerini ayarlar veya günceller.

$unset
Açıklama: Belirli bir alanı kaldırır.
$inc
Açıklama: Belirli bir alanın değerini artırır veya azaltır.

$mul
Açıklama: Belirli bir alanın değerini çarpar.

$rename
Açıklama: Bir alanın adını değiştirir.

$push
Açıklama: Bir dizinin sonuna bir eleman ekler.

$addToSet
Açıklama: Bir dizinin sonuna yalnızca benzersiz bir eleman ekler.

$pop
Açıklama: Bir diziden son veya ilk elemanı kaldırır.

$pull
Açıklama: Bir diziden belirli bir elemanı kaldırır.

$pullAll
Açıklama: Bir diziden birden fazla elemanı kaldırır.

$each
Açıklama: $push ve $addToSet ile birlikte kullanılarak bir diziye birden fazla eleman ekler.
*/

//28- pricei 200den az olan documentlerden price i en kucuk olan documentin price degerini
//100 artiriniz

use('shop');
db.electronics.findOneAndUpdate({price:{$lt:200}},{$inc:{price:100}},{sort:{price:1}});



use('shop');
db.electronics.find();
//29-birden fazla documenti update edelim. pricei 250 olan documentlerin name : "wooooww "olarak guncelleyelim

use('shop')
db.electronics.updateMany({price:250},{$set:{name:"wooooww"}});

//30-bir documenti silme
//name:"wooooww" olan ilk degeri silelim

use('shop');
db.electronics.findOneAndDelete({name:"wooooww"});
//yada
use('shop');
db.electronics.deleteOne({name:"wooooww"})
//return type
//biri bize bilgi donduruyor digeri ise silinen documenti donduruyor

//31-birden fazla documenti silme
//name : "wooooww" olan tum degerleri silelim

use('shop');
db.electronics.deleteMany({"name":"wooooww"});

//32-tüm documentleri silelim

use('shop');
db.electronics.deleteMany({});

//======================================================
//                       Aggregation
//======================================================
//1) Aggregation, dokumanlardaki verilerin islenmesi ve hesaplanan ////sonuclarin donmesini saglayan islemlerdir.
// 2) Aggregation islemleri, farklı dokumanlardaki degerleri gruplar
// 3) Bu gruplanan veriler uzerinde cesitli islemlerin gereceklestir
//bir sonuc degerinin donmesi saglanabilir.
//
//
//4) MongoDB, 3 farklı yontem ile aggregation gerceklestirmeye izir
//
//A) aggregation pipeline (toplama boru hattı) --> best practic
//b) map-reduce function (map indirgeme)
//C) single-purpose aggregation (tek-amaç toplama)

// 5) Aggregation ile SQL deki Join gibi işlemler yapılabilir.

/*
MongoDB Aggregation
$match
Açıklama: Belirli bir koşula uyan belgeleri filtreler. Bu adım genellikle pipeline'ın başında gelir ve sorgulama işlemi yapar.
$group
Açıklama: Belgeleri belirli bir alana göre gruplayarak toplama, ortalama alma gibi işlemleri yapar. Her grup için bir agregat sonucu hesaplar.
$sort
Açıklama: Belgeleri belirli bir alana göre sıralar. Artan veya azalan sıralama yapabilir.
$project
Açıklama: Belgelerin yalnızca belirli alanlarını seçer veya yeni alanlar oluşturur. Verilerin yapısını dönüştürür.
$limit
Açıklama: Belirtilen sayıda belge döndürür. Sonuç kümesinin boyutunu sınırlamak için kullanılır.
$skip
Açıklama: Belirtilen sayıda belgeyi atlar. Sayfalandırma veya belirli bir pozisyondan itibaren veri almak için kullanılır.
$lookup
Açıklama: Bir başka koleksiyondan veri birleştirmek için kullanılır. SQL'deki JOIN işlemini gerçekleştirir.
$unwind
Açıklama: Bir diziyi açar ve her bir elemanı ayrı bir belge olarak döndürür. Dizileri düzleştirmek için kullanılır.
$replaceRoot
Açıklama: Mevcut belgeyi belirtilen alan ile değiştirir. Yeni bir kök belge oluşturur.
$addFields
Açıklama: Belgelerin mevcut alanlarına yeni alanlar ekler veya mevcut alanların değerlerini değiştirir.
$count
Açıklama: Belge sayısını döndürür. Sonuç kümesindeki belge sayısını hesaplar.
$facet
Açıklama: Birden fazla alt-pipeline'ı aynı anda çalıştırarak çoklu aggregasyon sonuçlarını elde eder. Paralel işlemler yapar.
$bucket
Açıklama: Verileri belirli aralıklara göre gruplar. Her aralık için belge sayısını hesaplar.
$bucketAuto
Açıklama: Verileri otomatik olarak en iyi aralıklara böler. Belirli sayıda grup oluşturur.
$merge
Açıklama: Aggregation sonucunu bir koleksiyona yazar veya günceller.
$geoNear
Açıklama: Coğrafi konum verilerine göre belgeleri sıralar. Belirli bir noktaya yakın belgeleri bulur.
$sample
Açıklama: Koleksiyondan rastgele bir örnekleme yapar. Belirli sayıda rastgele belge döndürür.

*/

use ('okul')
db.grades.insertMany([ { _id: 11, name: "Liam Scott", assignment: 101, points: 88 }, { _id: 12, name: "Emma Adams", assignment: 102, points: 91 }, { _id: 13, name: "Noah Martinez", assignment: 103, points: 76 }, { _id: 14, name: "Olivia Carter", assignment: 104, points: 85 }, { _id: 15, name: "James Lee", assignment: 105, points: 90 } ]);

db.grades.insertMany([
  { _id: 1, name: "John Doe", assignment: 101, points: 85 },
  { _id: 2, name: "Jane Smith", assignment: 102, points: 90 },
  { _id: 3, name: "Alice Johnson", assignment: 103, points: 78 },
  { _id: 4, name: "Bob Brown", assignment: 104, points: 88 },
  { _id: 5, name: "Charlie Davis", assignment: 105, points: 92 },
  { _id: 6, name: "David Wilson", assignment: 106, points: 81 },
  { _id: 7, name: "Eve Clark", assignment: 107, points: 87 },
  { _id: 8, name: "Frank Harris", assignment: 108, points: 79 },
  { _id: 9, name: "Grace Lewis", assignment: 109, points: 94 },
  { _id: 10, name: "Hannah Walker", assignment: 110, points: 83 }
]);



use('okul')
db.grades.find();

//her bir assingment için toplam puanları hesaplayalım

//1. aşama(stage):gruplama ve toplama

use('okul')
db.grades.aggregate({$group:{"_id":"$assignment","total_points":{$sum:"$points"}}})

//2. assignment degeri 104ten kucuk olan her bir assignment için max pointleri hesaplayıp
//azalan sekilde sıralayınız
//1.aşama filtreleme
//2.aşama gruplama ve max
//3.aşama sıralama

use('okul');
var pipeline=[
    {$match:{"assignment":{$lt:104}}},
    {$group:{"_id":"$assignment","max_point":{$max:"$points"}}},
    {$sort:{max_point:-1}}
        ]
db.grades.aggregate(pipeline);

//3. ismi a ile başlayan documentlerin toplam puanlarini hesaplayip listele

use('okul')
var pipeline=[
    {$match:{"name":{$regex:"^A"}}},
    {$group:{"_id":null,"total_point":{$sum:"$points"}}}];
db.grades.aggregate(pipeline)

use('okul')
var pipeline = [
    {$match:{"points":{$lt:80}}},
    {$count:"sonuc"}

]
db.grades.aggregate(pipeline)

