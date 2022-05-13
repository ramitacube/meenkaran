import 'package:connectone_meenkaran/models/sellerModel.dart';
import 'package:connectone_meenkaran/src/screens/track_seller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

class SellerWidget extends StatefulWidget {
  final SellersData sellersList;
  final int index;

  const SellerWidget({Key key, this.sellersList, this.index}) : super(key: key);

  @override
  _SellerWidgetState createState() => _SellerWidgetState();
}

class _SellerWidgetState extends State<SellerWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(top: 20, bottom: 10),
        margin: EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
            color: Colors.amber, borderRadius: BorderRadius.circular(25)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Image.asset('assets/images/userBox.png'),
                ),
                SizedBox(width: MediaQuery.of(context).size.width * .05),
                Column(
                  children: [
                    ElevatedButton.icon(
                      onPressed: () async {
                        var number =
                            widget.sellersList.userId.phoneNumber != null
                                ? widget.sellersList.userId.phoneNumber
                                : '';
                        await FlutterPhoneDirectCaller.callNumber(number);
                      },
                      icon: Icon(Icons.call),
                      label: Text(widget.sellersList.userId.phoneNumber != null
                          ? widget.sellersList.userId.phoneNumber
                          : ''),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Color(0xffECF6FF)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        )),
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: () async {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TrackSeller(
                                      sellerId: widget.sellersList.userId.id
                                          .toString(),
                                  sellerName: widget.sellersList.userId.username,
                                    )));
                      },
                      icon: Icon(Icons.access_time),
                      label: Text("Track Seller"),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Color(0xffECF6FF)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        )),
                      ),
                    ),
                  ],
                )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 25.0),
                      child: Text(
                          widget.sellersList.userId.username != null
                              ? widget.sellersList.userId.username
                              : "*****",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(left: 25.0),
                  child: Text(
                      widget.sellersList.userId.address != null
                          ? widget.sellersList.userId.address
                          : "*****",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.bold)),
                )
              ],
            ),
          ],
        ));
  }
}
