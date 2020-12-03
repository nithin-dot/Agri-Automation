import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:neuomorphic_container/neuomorphic_container.dart';
import 'package:url_launcher/url_launcher.dart';

class Guide extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return NeumorphicApp(
      debugShowCheckedModeBanner: false,
      // title: 'dEMO',

      home: SearchList(),
    );
  }
}

class Building {
  String id;
  String name;
  String place;
  String duration;

  Building({this.id, this.name, this.place, this.duration});
}

class SearchList extends StatefulWidget {
  SearchList({Key key}) : super(key: key);
  @override
  _SearchListState createState() => _SearchListState();
}

class _SearchListState extends State<SearchList> {
  Widget appBarTitle = Text(
    "Guide",
    style: TextStyle(color: Colors.black),
  );
  Icon actionIcon = Icon(
    Icons.search,
    color: Colors.white,
  );
  final key = GlobalKey<ScaffoldState>();
  final TextEditingController _searchQuery = TextEditingController();
  List<Building> _list;
  List<Building> _searchList = List();

  String _searchText = "";
  _SearchListState() {
    _searchQuery.addListener(() {
      if (_searchQuery.text.isEmpty) {
        setState(() {
          _searchText = "";
          _buildSearchList();
        });
      } else {
        setState(() {
          _searchText = _searchQuery.text;
          _buildSearchList();
        });
      }
    });
  }
  @override
  void initState() {
    super.initState();
    init();
  }

  void init() {
    _list = List();
    _list.add(
      Building(
        id: "1",
        name: "Wheat",
        place: "Red Soil",
        duration: " 60 - 150 days ",
      ),
    );
    _list.add(
      Building(
        id: "2",
        name: "Corn",
        place: "Black Soil",
        duration: " 60 - 100 days ",
      ),
    );
    _list.add(
      Building(
        id: "3",
        name: "paddy",
        place: "Sandy Soil",
        duration: "5 - 6 months",
      ),
    );
    _list.add(
      Building(
        id: "4",
        name: "Sugarcane",
        place: "loamy soil",
        duration: "9-24 months",
      ),
    );
    _list.add(
      Building(
        id: "5",
        name: "Ground nuts",
        place: "sandy loam",
        duration: "40 - 100 days",
      ),
    );
    _list.add(
      Building(
          id: "6",
          name: "Cassava",
          place: "loamy sands",
          duration: "12 - 24months"),
    );
    _list.add(
      Building(
          id: "7",
          name: "Banana Tree",
          place: "drained soil",
          duration: "8 - 9 months"),
    );
    _list.add(
      Building(
          id: "8",
          name: "coconut",
          place: "drained soil",
          duration: "15 - 20 years"),
    );
    _searchList = _list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      appBar: buildBar(context),
      body: OrientationBuilder(
          builder: (BuildContext context, Orientation orientation) {
        return GridView.builder(
            itemCount: _searchList.length,
            itemBuilder: (context, index) {
              return Uiitem(_searchList[index]);
            },
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: orientation == Orientation.portrait ? 2 : 3,
            ));
      }),
    );
  }

  List<Building> _buildSearchList() {
    if (_searchText.isEmpty) {
      return _searchList = _list;
    } else {
      _searchList = _list
          .where((element) =>
              element.name.toLowerCase().contains(_searchText.toLowerCase()) ||
              element.place.toLowerCase().contains(_searchText.toLowerCase()))
          .toList();
      print('${_searchList.length}');
      return _searchList; //_searchList.map((contact) =>  Uiitem(contact)).toList();
    }
  }

  Widget buildBar(BuildContext context) {
    return NeumorphicAppBar(
        centerTitle: true,
        title: appBarTitle,
        actions: <Widget>[
          InkWell(
            onTap: () {
              setState(() {
                if (this.actionIcon.icon == Icons.search) {
                  this.actionIcon = Icon(
                    Icons.close,
                    color: Colors.white,
                  );
                  this.appBarTitle = TextField(
                    controller: _searchQuery,
                    style: TextStyle(
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                        hintText: "Search here..",
                        hintStyle: TextStyle(color: Colors.black)),
                  );
                  _handleSearchStart();
                } else {
                  _handleSearchEnd();
                }
              });
            },
            child: NeuomorphicContainer(
              shape: BoxShape.circle,
              child: Icon(Icons.search),
              color: Colors.white,
            ),
          ),
        ]);
  }

  void _handleSearchStart() {
    setState(() {});
  }

  void _handleSearchEnd() {
    setState(() {
      this.actionIcon = Icon(
        Icons.search,
        color: Colors.white,
      );
      this.appBarTitle = Text(
        "Guide",
        style: TextStyle(color: Colors.black),
      );
      _searchQuery.clear();
    });
  }
}

class Uiitem extends StatelessWidget {
  final Building building;
  Uiitem(this.building);
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: Container(
        margin: EdgeInsets.fromLTRB(15, 5, 5, 7),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              offset: Offset(3, 3),
              color: Colors.black12,
              blurRadius: 3,
            ),
            // BoxShadow(
            //   offset: Offset(-3, -3),
            //   color: Colors.white,
            //   blurRadius: 3,
            // ),
          ],
        ),
        child: InkWell(
          splashColor: Colors.white,
          onTap: () {
            // print(building.id);
            String url =
                'https://www.chicagobotanic.org/search/google/${building.name}';
            launchURL(url);
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(height: 15.0),
                  Center(
                    child: Container(child: Icon(Icons.assessment)),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 0.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Center(
                      child: Text(
                        this.building.name,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18.0),
                      ),
                    ),
                    SizedBox(height: 5.0),
                    Center(
                      child: Text(
                        building.place,
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    SizedBox(height: 5.0),
                    Center(
                      child: Text(
                        building.duration,
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
