import 'package:flutter/material.dart';
import 'package:pilot_app/map.dart' as prefix0;
import 'post_offices_information.dart';
import 'search.dart';

void main() {
  runApp(MaterialApp(
    title: "Pilot App",
    debugShowCheckedModeBanner: false,
    home: Search()
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pilot App"),
        centerTitle: true,
        backgroundColor: Colors.green[700],
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return Information();
            }));
          },
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                Search();
              }),
        ],
      ),
      body: Stack(
        children: <Widget>[
          prefix0.Map(),
        ],
      ),
    );
  }
}

//  Completer<GoogleMapController> _controller = Completer();
//  static final CameraPosition _myLocation = CameraPosition(target: LatLng(30.044281, 31.340002),);

//  final List<PostOffice> postOffice = [];
//  //Home({Key key, this.postOffice}) : super(key: key);
//
//  final Map<String, Marker> _markers = {};
//    Future<void> _onMapCreated(GoogleMapController controller) async {
//      //final postOffices = await locations.getPostOffices();
//      setState(() {
//        //_markers.clear();
//        for (final office in postOffice){
//          final marker = Marker(
//            markerId: MarkerId(office.name),
//            position: LatLng(double.parse(office.lat), double.parse(office.long)),
//            infoWindow: InfoWindow(
//              title: office.name,
//              snippet: office.address
//            )
//          );
//          _markers[office.name] = marker;
//        }
//      });
//    }
//  Future<void> _onMapCreated(GoogleMapController controller) async {
// final googleOffices = await locations.getGoogleOffices();
//    setState(() {
//      _markers.clear();
//      for (final office in googleOffices.offices) {
//        final marker = Marker(
//          markerId: MarkerId(office.name),
//          position: LatLng(office.lat, office.lng),
//          infoWindow: InfoWindow(
//            title: office.name,
//            snippet: office.address,
//          ),
//        );
//        _markers[office.name] = marker;
//      }
//    });
//  }
//      body: GoogleMap(
//        onMapCreated: _onMapCreated,
//        initialCameraPosition: CameraPosition(
//          target: const LatLng(30.044281, 31.340002),
//          zoom: 11.0,
//        ),
//        markers: _markers.values.toSet(),
//      ),
