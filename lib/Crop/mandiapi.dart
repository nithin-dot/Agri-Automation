class MyPriceList {
  final List<MyPrice> myList;

  MyPriceList({
    this.myList,
  });

  factory MyPriceList.fromJson(List<dynamic> parsedJson) {
    List<MyPrice> myList = new List<MyPrice>();
    myList = parsedJson.map((i) => MyPrice.fromJson(i)).toList();

    return new MyPriceList(myList: myList);
  }
}

class MyPrice {
  String name;
  String price;
  String quantity;

  MyPrice({this.name, this.price, this.quantity});

  factory MyPrice.fromJson(Map<String, dynamic> json) {
    //print(json);
    return new MyPrice(
      name: json['crop'],
      price: json['price'],
      quantity: json['quantity'],
    );
  }
}
