class MyDataList {
  final List<MyData> myList;

  MyDataList({
    this.myList,
  });

  factory MyDataList.fromJson(List<dynamic> parsedJson) {
    List<MyData> myList = new List<MyData>();
    myList = parsedJson.map((i) => MyData.fromJson(i)).toList();

    return new MyDataList(myList: myList);
  }
}

class MyData {
  String name;
  String nutrient;
  String percentage;
  int waterlevel;

  MyData({this.name, this.nutrient, this.percentage, this.waterlevel});

  factory MyData.fromJson(Map<String, dynamic> json) {
    //print(json);
    return new MyData(
        name: json['name'],
        nutrient: json['nutrient'],
        percentage: json['percentage'],
        waterlevel: json['waterlevel']);
  }
}
