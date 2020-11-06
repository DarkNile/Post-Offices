import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Map extends StatefulWidget {
  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<Map> {
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
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: FutureBuilder(
            future: _future,
            builder: (context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return CircularProgressIndicator(backgroundColor: Colors.green);
              }
              List<dynamic> parsedJson = jsonDecode(snapshot.data);
              allMarkers = parsedJson.map((office) {
                if (allMarkers != null) {
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
                        title: office['name'],
                        snippet: office['address']
                    )
                  );
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
            }));
  }
}
