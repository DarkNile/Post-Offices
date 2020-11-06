import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'post_offices.dart';

class PostOfficeList extends StatelessWidget {
  final List<PostOffice> postOffice;
  PostOfficeList({Key key, this.postOffice}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: postOffice == null ? 0 : postOffice.length,
        itemBuilder: (BuildContext context, int index) {
          return
            Card(
              child: Container(
                decoration: BoxDecoration(color: Colors.lightGreen[50]),
                child: Center(
                    child: Column(
                      // Stretch the cards in horizontal axis
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Text(
                          // Read the name field value and set it in the Text widget
                          postOffice[index].name,
                          textAlign: TextAlign.center,
                          // set some style to text
                          style: TextStyle(
                              fontSize: 20.0, color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          // Read the name field value and set it in the Text widget
                          "العنوان: " + postOffice[index].address,
                          textAlign: TextAlign.center,
                          // set some style to text
                          style: TextStyle(
                              fontSize: 15.0, color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          // Read the name field value and set it in the Text widget
                          "المحافظة: " + postOffice[index].gov,
                          textAlign: TextAlign.center,
                          // set some style to text
                          style: TextStyle(
                              fontSize: 15.0, color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          // Read the name field value and set it in the Text widget
                          postOffice[index].postal_code,
                          textAlign: TextAlign.center,
                          // set some style to text
                          style: TextStyle(
                              fontSize: 15.0, color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ],
                    )),
                padding: const EdgeInsets.all(15.0),
              ),
            );
        });
  }
}