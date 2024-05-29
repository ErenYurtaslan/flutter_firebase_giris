class Kisiler {
  String kisiAd;
  num kisiYas;

  Kisiler(this.kisiAd, this.kisiYas);

  factory Kisiler.fromJson(Map<dynamic,dynamic> json){
    return Kisiler( json["kisi_ad"] as String, json["kisi_yas"] as num);
  }
}