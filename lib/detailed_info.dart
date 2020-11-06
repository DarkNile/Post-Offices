import 'package:flutter/material.dart';
import 'package:pilot_app/post_offices.dart';

class Details extends StatelessWidget {
  final PostOffice office;
  Details(this.office);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(office.name),
      ),
      body: Container(
        child: Center(
          child: Text(office.address),
        ),
      ),
    );
  }
}
