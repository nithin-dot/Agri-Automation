class MyAniList {
  final List<MyAni> myList;

  MyAniList({
    this.myList,
  });

  factory MyAniList.fromJson(List<dynamic> parsedJson) {
    List<MyAni> myList = new List<MyAni>();
    myList = parsedJson.map((i) => MyAni.fromJson(i)).toList();

    return new MyAniList(myList: myList);
  }
}

class MyAni {
  final String name;
  final int yiel;
  final int quality;
  final int health;
  final int temp;

  MyAni({
    this.name,
    this.yiel,
    this.quality,
    this.health,
    this.temp,
  });

  factory MyAni.fromJson(Map<String, dynamic> json) {
    //print(json);
    return new MyAni(
      name: json['name'],
      yiel: json['yield'],
      quality: json["quality"],
      health: json["health"],
      temp: json["temp"],
    );
  }
}
