import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_firebase_giris/Siniflar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});



  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

 // var refTest = FirebaseDatabase.instance.ref().child("test");


  var refKisiler = FirebaseDatabase.instance.ref().child("kisiler_tablosu");


  Future<void> kayitEkle(String a, num b) async{
    var bilgi = HashMap<String,dynamic>();

    bilgi["kisi_ad"]=a;
    bilgi["kisi_yas"]=b;

    refKisiler.push().set(bilgi);
  }

  Future<void> tumKisileriOku() async{
    refKisiler.onValue.listen((event) {
      var gelenValue = event.snapshot.value as dynamic;
      if(gelenValue!=null){
        gelenValue.forEach( (key, nesne) {
          var gelenKayit = Kisiler.fromJson(nesne);
          print("*/*/*/*/*/*/*/*/*");
          print("Kayıt adı : ${gelenKayit.kisiAd}\nKayıt yaşı : ${gelenKayit.kisiYas}}\nKayıt id : $key}");
        });
      }
    });
  }

  Future<void> dinlemesizTumKisileriOku() async{
    refKisiler.once().then((value) {
      var gelenValue = value.snapshot.value as dynamic;
      if(gelenValue!=null){
        gelenValue.forEach( (key, nesne) {
          var gelenKayit = Kisiler.fromJson(nesne);
          print("*/*/*/*/*/*/*/*/*");
          print("Kayıt adı : ${gelenKayit.kisiAd}\nKayıt yaşı : ${gelenKayit.kisiYas}}\nKayıt id : $key}");
        });
      }
    });
  }

  Future<void> ayniIsimdeOlaniGetir(String ad) async{

    var query = refKisiler.orderByChild("kisi_ad").equalTo(ad);

    query.onValue.listen((event) {
      var gelenValue = event.snapshot.value as dynamic;
      if(gelenValue!=null){
        gelenValue.forEach( (key, nesne) {
          var gelenKayit = Kisiler.fromJson(nesne);
          print("*/*/*/*/*/*/*/*/*");
          print("Kayıt adı : ${gelenKayit.kisiAd}\nKayıt yaşı : ${gelenKayit.kisiYas}}\nKayıt id : $key}");
        });
      }
    });
  }


  Future<void> ayniYastaOlaniGetir(num yas) async{

    var query = refKisiler.orderByChild("kisi_yas").equalTo(yas);

    query.onValue.listen((event) {
      var gelenValue = event.snapshot.value as dynamic;
      if(gelenValue!=null){
        gelenValue.forEach( (key, nesne) {
          var gelenKayit = Kisiler.fromJson(nesne);
          print("*/*/*/*/*/*/*/*/*");
          print("Kayıt adı : ${gelenKayit.kisiAd}\nKayıt yaşı : ${gelenKayit.kisiYas}}\nKayıt id : $key}");
        });
      }
    });
  }


  Future<void> limitliVeriler(int limit) async{

    var query = refKisiler.limitToFirst(limit);

    query.onValue.listen((event) {
      var gelenValue = event.snapshot.value as dynamic;
      if(gelenValue!=null){
        gelenValue.forEach( (key, nesne) {
          var gelenKayit = Kisiler.fromJson(nesne);
          print("*/*/*/*/*/*/*/*/*");
          print("Kayıt adı : ${gelenKayit.kisiAd}\nKayıt yaşı : ${gelenKayit.kisiYas}}\nKayıt id : $key}");
        });
      }
    });
  }

  Future<void> sondakiLimitliVeriler(int limit) async{

    var query = refKisiler.limitToLast(limit);

    query.onValue.listen((event) {
      var gelenValue = event.snapshot.value as dynamic;
      if(gelenValue!=null){
        gelenValue.forEach( (key, nesne) {
          var gelenKayit = Kisiler.fromJson(nesne);
          print("*/*/*/*/*/*/*/*/*");
          print("Kayıt adı : ${gelenKayit.kisiAd}\nKayıt yaşı : ${gelenKayit.kisiYas}}\nKayıt id : $key}");
        });
      }
    });
  }


  Future<void> yasAraligindakiVerileriGetir(num s, num e) async{

    var query = refKisiler.orderByChild("kisi_yas").startAt(s).endAt(e);

    query.onValue.listen((event) {
      var gelenValue = event.snapshot.value as dynamic;
      if(gelenValue!=null){
        gelenValue.forEach( (key, nesne) {
          var gelenKayit = Kisiler.fromJson(nesne);
          print("*/*/*/*/*/*/*/*/*");
          print("Kayıt adı : ${gelenKayit.kisiAd}\nKayıt yaşı : ${gelenKayit.kisiYas}}\nKayıt id : $key}");
        });
      }
    });
  }

  Future<void> kayitSil(String path) async{
    refKisiler.child(path).remove();
  }


  Future<void> kayitGuncelle(String path, String a, num b) async{
    var bilgi = HashMap<String,dynamic>();

    bilgi["kisi_ad"]=a;
    bilgi["kisi_yas"]=b;

    refKisiler.child(path).update(bilgi);
  }

    @override
  void initState() {
    // TODO: implement initState
    super.initState();

   // var bilgi = HashMap<String,dynamic>();
    //bilgi["mesaj"]="merhaba";
    //bilgi["msj"]="merhaba1";
    //refTest.push().set(bilgi);

   //kayitEkle("Abuzer",31.5);
   // kayitSil("-NeONqBM9IGa144NjDgl");
     // kayitGuncelle("-NeObNa8x3JKNTPAZZkQ","Asuman",29.79867);

      /*tumKisileriOku();*/  //firebase sitesinde güncelleme ekleme silme yapınca, bu metodun içindeki foreach döngüsü yine çalışır ve anlık olarak verileri konsoldan okumuş oluruz.
      /*dinlemesizTumKisileriOku();*/ //firebase'de değişiklik olsa bile konsolda anlık değişim görmeyiz.

      //esitOlaniGetir("François Marie");

      /*kayitEkle("François Marie", 75.5);
      kayitEkle("Eren", 23.25);*/

    /*ayniIsimdeOlaniGetir("François Marie");*/  //ismi böyle olan tüm kayıtları getirir. ayrıca konsol açıkken firebasede isim değişiklği yapılırsa konsolda anında değişme olur.
     // ayniYastaOlaniGetir(23);

      //limitliVeriler(4);
     /* sondakiLimitliVeriler(1);*/   //sondaki x kadar veriyi SONDAN DEĞİL SIRASIYLA GETİRİR.

      yasAraligindakiVerileriGetir(25, 55);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

          ],
        ),
      ),

    );
  }
}
