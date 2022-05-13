import 'package:connectone_meenkaran/models/member_mode.dart';
import 'package:flutter/material.dart';

class MemberWidget extends StatefulWidget {

  final MemberData data;
  const MemberWidget({Key key,this.data}) : super(key: key);

  @override
  _MemberWidgetState createState() => _MemberWidgetState();
}

class _MemberWidgetState extends State<MemberWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 5), // changes position of shadow
            ),
          ],
        ),
        margin: EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
                color: Colors.amber,
              ),
              padding: EdgeInsets.symmetric(
                  horizontal: 25, vertical: 18),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    'assets/images/userBox.png',
                    height: 45,
                    width: 45,
                  ),
                  SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.data?.name ??"",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold)),
                      SizedBox(height: 5),
                      Text("Latitude: "+widget.data?.custLat??" ",
                          style: TextStyle(
                              color: Colors.black, fontSize: 12)),
                      Text("Longitude: "+widget.data?.custLong??" ",
                          style: TextStyle(
                              color: Colors.black, fontSize: 12))
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 25, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.data?.phoneNo??"",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold)),
                  SizedBox(height: 5),
                  Text('Mobile',
                      style: TextStyle(
                          color: Colors.black, fontSize: 12))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
