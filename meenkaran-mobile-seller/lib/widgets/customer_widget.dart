import 'package:connectone_meenkaran_seller/model/customer_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

class CustomerWidget extends StatefulWidget {
  final CustomerData data;
  final Function makeCall;

  const CustomerWidget({Key key, this.data, this.makeCall}) : super(key: key);

  @override
  _CustomerWidgetState createState() => _CustomerWidgetState();
}

class _CustomerWidgetState extends State<CustomerWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: Colors.amber, borderRadius: BorderRadius.circular(10)),
        padding: EdgeInsets.all(10),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              child: Image.asset('assets/images/user.png'),
              decoration: BoxDecoration(
                color: Colors.amber,
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Container(
              width: 200,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.data.customerId.name,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  Text(
                    widget.data.customerId.phoneNo
                        .replaceFirst(RegExp(r'\d{8}'), "********"),
                    style: TextStyle(fontSize: 12),
                  )
                ],
              ),
            ),
            SizedBox(width: 5),
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    backgroundColor: Colors.amber,
                    title: Text("Call not allowed !"),
                    content: Text(
                        "Currently Meenkaran application is not allowed to make customer calls"),
                    actions: <Widget>[
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 15),
                          child: Text("Close",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 19,
                              )),
                        ),
                        style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(10.0),
                            )),
                      ),
                    ],
                  ),
                );
              },
              child: Container(
                  width: 40,
                  height: 40,
                  child: Icon(Icons.call),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  )),
            )
          ],
        ),
      ),
    );
  }
}
