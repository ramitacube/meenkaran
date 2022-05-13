import 'package:connectone_meenkaran/src/screens/viewMap.dart';
import 'package:flutter/material.dart';
import 'package:horizontal_center_date_picker/datepicker_controller.dart';
import 'package:horizontal_center_date_picker/horizontal_date_picker.dart';

class Routes extends StatefulWidget {
  const Routes({Key key}) : super(key: key);

  @override
  _RoutesState createState() => _RoutesState();
}

class _RoutesState extends State<Routes> {
  @override
  Widget build(BuildContext context) {
    var now = DateTime.now();
    DateTime startDate = now.subtract(Duration(days: 15));
    DateTime endDate = now.add(Duration(days: 15));
    print('startDate = $startDate ; endDate = $endDate');
    return Scaffold(
      body: Column(mainAxisSize: MainAxisSize.max, children: [
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
          alignment: Alignment.center,
          child: HorizontalDatePickerWidget(
            startDate: startDate,
            endDate: endDate,
            selectedDate: now,
            normalColor: Colors.orange,
            selectedColor: Colors.transparent,
            selectedTextColor: Colors.black,
            normalTextColor: Colors.grey,
            widgetWidth: MediaQuery.of(context).size.width,
            datePickerController: DatePickerController(),
            onValueSelected: (date) {
              print('selected = ${date.toIso8601String()}');
            },
          ),
        ),
        Container(
          color: Colors.amber,
          // height: double.infinity,
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * .3,
                    child: Center(
                      child: Text("Start From"),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * .2,
                    child: Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * .3,
                          height: 35,
                          decoration: BoxDecoration(
                              color: Colors.amber, shape: BoxShape.circle),
                          child: Center(
                              child: IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.notifications,
                                size: 20, color: Colors.black),
                          )),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * .5,
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        "Vizhinjam",
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * .3,
                    child: Center(
                      child: Text("Itetnary"),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * .2,
                    child: Container(
                      width: MediaQuery.of(context).size.width * .3,
                      height: 35,
                      decoration: BoxDecoration(
                          color: Colors.amber, shape: BoxShape.circle),
                      child: Center(
                          child: IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.shopping_cart_rounded,
                            size: 20, color: Colors.black),
                      )),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * .5,
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        "Fish1, Fish2, fish3, fish4",
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * .3,
                    child: Center(
                      child: Text("Via"),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * .2,
                    child: Container(
                      width: MediaQuery.of(context).size.width * .3,
                      height: 35,
                      decoration: BoxDecoration(
                          color: Colors.amber, shape: BoxShape.circle),
                      child: Center(
                          child: IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.location_on,
                            size: 20, color: Colors.black),
                      )),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * .5,
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        "Balaramapuram, Ooruttambalam, Kandala, Kattakad",
                        overflow: TextOverflow.fade,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () => Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ViewMap())),
                    child: Container(
                      width: MediaQuery.of(context).size.width * .3,
                      child: Center(
                        child: Text("Destination"),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * .2,
                    child: Container(
                      width: MediaQuery.of(context).size.width * .3,
                      height: 35,
                      decoration: BoxDecoration(
                          color: Colors.amber, shape: BoxShape.circle),
                      child: Center(
                          child: IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.shopping_cart_rounded,
                            size: 20, color: Colors.black),
                      )),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * .5,
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        "Vizhinjam",
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
