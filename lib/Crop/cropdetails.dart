class MyCropList {
  final List<MyCrop> myList;

  MyCropList({
    this.myList,
  });

  factory MyCropList.fromJson(List<dynamic> parsedJson) {
    List<MyCrop> myList = new List<MyCrop>();
    myList = parsedJson.map((i) => MyCrop.fromJson(i)).toList();

    return new MyCropList(myList: myList);
  }
}

class MyCrop {
  final String cropName;
  final int humidity;
  final int landId;
  final int waterFlow;

  MyCrop({this.cropName, this.landId, this.waterFlow, this.humidity});

  factory MyCrop.fromJson(Map<String, dynamic> json) {
    //print(json);
    return new MyCrop(
        cropName: json['cropName'],
        landId: json['landId'],
        waterFlow: json['waterFlow'],
        humidity: json['humidity']);
  }
}
