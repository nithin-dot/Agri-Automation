class MyListList {
  final List<MyList> myList;

  MyListList({
    this.myList,
  });

  factory MyListList.fromJson(List<dynamic> parsedJson) {
    List<MyList> myList = new List<MyList>();
    myList = parsedJson.map((i) => MyList.fromJson(i)).toList();

    return new MyListList(myList: myList);
  }
}

class MyList {
  String name;
  int color;
  int price;
  int per;
  String status;
  int charts;

  MyList(
      {this.name, this.color, this.price, this.per, this.status, this.charts});

  factory MyList.fromJson(Map<String, dynamic> json) {
    //print(json);
    return new MyList(
      name: json['name'],
      color: json['colordata'],
      per: json['per'],
      status: json['status'],
      charts: json['charts'],
      price: json['price'],
    );
  }
}
