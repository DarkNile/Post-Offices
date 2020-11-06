import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:io';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> with SingleTickerProviderStateMixin {
  static final GlobalKey<ScaffoldState> scaffoldKey =
      new GlobalKey<ScaffoldState>();

  TextEditingController _searchQuery;
  bool _isSearching = false;
  String searchQuery = "Search query";

  Completer<GoogleMapController> _controller = Completer();
  Future _future;

  Future<String> loadString() async =>
      await rootBundle.loadString('assets/cairo.json');
  List<Marker> allMarkers = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _future = loadString();
    _searchQuery = new TextEditingController();
  }

  void _startSearch() {
    print("open search box");
    ModalRoute.of(context)
        .addLocalHistoryEntry(new LocalHistoryEntry(onRemove: _stopSearching));

    setState(() {
      _isSearching = true;
    });
  }

  void _stopSearching() {
    _clearSearchQuery();

    setState(() {
      _isSearching = false;
    });
  }

  void _clearSearchQuery() {
    print("close search box");
    setState(() {
      _searchQuery.clear();
      updateSearchQuery("Search query");
    });
  }

  Widget _buildTitle(BuildContext context) {
    var horizontalTitleAlignment =
        Platform.isIOS ? CrossAxisAlignment.center : CrossAxisAlignment.start;

    return new InkWell(
      onTap: () => scaffoldKey.currentState.openDrawer(),
      child: new Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: horizontalTitleAlignment,
          children: <Widget>[
            const Text('Pilot App'),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchField() {
    return new TextField(
      controller: _searchQuery,
      autofocus: true,
      decoration: const InputDecoration(
        hintText: 'Search...',
        border: InputBorder.none,
        hintStyle: const TextStyle(color: Colors.white30),
      ),
      style: const TextStyle(color: Colors.white, fontSize: 16.0),
      onChanged: updateSearchQuery,
    );
  }

  //This is the function we need....
  void updateSearchQuery(String newQuery) {
    setState(() {
//      if(newQuery == PostOffice(name: "القاهرة الرئيسى").toString()){
//        print("test done !!");
//      }
      searchQuery = newQuery;
    });
    print("search query " + newQuery);
  }

  List<Widget> _buildActions() {
    if (_isSearching) {
      return <Widget>[
        new IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            if (_searchQuery == null || _searchQuery.text.isEmpty) {
              Navigator.pop(context);
              return;
            }
            _clearSearchQuery();
          },
        ),
      ];
    }

    return <Widget>[
      new IconButton(
        icon: const Icon(Icons.search),
        onPressed: _startSearch,
      ),
    ];
  }

//  void gov (searchQuery) {
//    if (searchQuery == PostOffice(gov: "القاهرة") ){
//      searchQuery = "القاهرة";
//    }
//  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        appBar: new AppBar(
          backgroundColor: Colors.green[700],
          centerTitle: true,
          leading: _isSearching ? const BackButton() : null,
          title: _isSearching ? _buildSearchField() : _buildTitle(context),
          actions: _buildActions(),
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: FutureBuilder(
              future: _future,
              builder: (context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) {
                  return CircularProgressIndicator(
                      backgroundColor: Colors.green);
                }

                List<dynamic> parsedJson = jsonDecode(snapshot.data);
                allMarkers = parsedJson.map((office) {
                  if (allMarkers != null){
                    return Marker(
//                      onTap: () {
//                        showModalBottomSheet(
//                            context: context,
//                            builder: (builder) {
//                              return Container(
//                                color: Colors.white,
//                                child: Column(
//                                  children: <Widget>[
//                                    Padding(padding: EdgeInsets.all(10)),
//                                    Row(
//                                      children: <Widget>[
//                                        Text("مكتب بريد: ", textAlign: TextAlign.center),
//                                        Padding(padding: EdgeInsets.all(10)),
//                                        Text(office['name']),
//                                      ],
//                                    ),
//                                    Padding(padding: EdgeInsets.all(10)),
//                                    Row(
//                                      children: <Widget>[
//                                        Text("العنوان: ", textAlign: TextAlign.center),
//                                        Padding(padding: EdgeInsets.all(10)),
//                                        Text(office['address']),
//                                      ],
//                                    ),
//                                    Padding(padding: EdgeInsets.all(10)),
//                                    Row(
//                                      children: <Widget>[
//                                        Text("الرقم البريدي: ", textAlign: TextAlign.center),
//                                        Padding(padding: EdgeInsets.all(10)),
//                                        Text(office['postal_code']),
//                                      ],
//                                    ),
//                                  ],
//                                ),
//                              );
//                            });
//                      },
                        markerId: MarkerId(office['name']),
                        position: LatLng(double.parse(office['lat']), double.parse(office['long'])),
                        infoWindow: InfoWindow(
                            title: office['name'], snippet: office['address']));
                  }
                  return null;
                }).toList();

                return GoogleMap(
                    mapType: MapType.normal,
                    initialCameraPosition: CameraPosition(
                      target: LatLng(30.1123, 31.3439),
                      zoom: 15,
                    ),
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                    },
                    markers: Set.from(allMarkers));
              }),
        ));
  }
}

/*
body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(
              '$searchQuery',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
*/
