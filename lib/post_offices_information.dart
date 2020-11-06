import 'package:flutter/material.dart';
import 'dart:convert';
import 'post_offices.dart';
import 'post_offices_list.dart';

class Information extends StatefulWidget {
  @override
  _InformationState createState() => _InformationState();
}

class _InformationState extends State<Information> {
  List data;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.red,
          title: Text("Post Offices"),
        ),
        body: Container(
          child: Center(
            // Use future builder and DefaultAssetBundle to load the local JSON file
            child: FutureBuilder(
                future: DefaultAssetBundle.of(context)
                    .loadString('assets/cairo.json'),
                builder: (context, snapshot) {
                  List<PostOffice> postOffices =
                  parseJson(snapshot.data.toString());
                  return postOffices.isNotEmpty
                      ? PostOfficeList(postOffice: postOffices)
                      : Center(child: CircularProgressIndicator(backgroundColor: Colors.red,));
                }),
          ),
        ));
  }

  List<PostOffice> parseJson(String response) {
    if(response==null){
      return [];
    }
    final parsed = json.decode(response.toString()).cast<Map<String, dynamic>>();
    return parsed.map<PostOffice>((json) => PostOffice.fromJson(json)).toList();
  }
}