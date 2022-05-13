import 'package:flutter/material.dart';

class ViewMap extends StatefulWidget {
  const ViewMap({Key key}) : super(key: key);

  @override
  _ViewMapState createState() => _ViewMapState();
}

class _ViewMapState extends State<ViewMap> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.only(left: 22, top: 20, bottom: 15),
              decoration: BoxDecoration(color: Colors.amber),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  Text(
                    "Steven Francis",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text("Find Fish at Your Door Step",
                      style: TextStyle(fontSize: 12)),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              width: MediaQuery.of(context).size.width,
              color: Colors.amber,
              child: Row(
                children: [
                  Image(image: AssetImage('assets/images/userProfile.png')),
                  SizedBox(width: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            height: 10,
                            width: 10,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Text(
                              'Balaramapuram, Kovil Road.',
                              style: TextStyle(fontSize: 14),
                            ),
                          )
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Row(
                          children: [
                            Container(
                                padding: const EdgeInsets.only(right: 30.0),
                                child: Image.asset('assets/images/timeB.png')),
                            Container(
                                padding: const EdgeInsets.only(right: 30.0),
                                child: Image.asset('assets/images/Call.png')),
                            Container(
                                child:
                                    Image.asset('assets/images/Calendar.png')),
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            )
          ]),
    );
  }
}
