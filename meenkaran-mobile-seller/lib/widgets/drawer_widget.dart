import 'package:connectone_meenkaran_seller/pages/add_fish.dart';
import 'package:connectone_meenkaran_seller/pages/add_routes.dart';
import 'package:connectone_meenkaran_seller/pages/call_logs.dart';
import 'package:connectone_meenkaran_seller/pages/launch_screen.dart';
import 'package:connectone_meenkaran_seller/pages/route_report.dart';
import 'package:flutter/material.dart';

class DrawerWidget extends StatefulWidget {

  //final GlobalKey<ScaffoldState> parentScaffoldKey;
  final String name;
  final Function logOut;
  DrawerWidget({Key key, this.name,this.logOut}) : super(key: key);

  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

GlobalKey<ScaffoldState> scaffoldKey=new GlobalKey<ScaffoldState>();

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              Positioned(
                top: MediaQuery.of(context).size.height * .01,
                left: MediaQuery.of(context).size.height * .02,
                right: MediaQuery.of(context).size.height * .015,
                child: Padding(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.height * .02),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        width: 50,
                        height: 50,
                        child: Image.asset('assets/images/user_box.png'),
                        decoration: BoxDecoration(
                          color: Colors.amber,
                            borderRadius: BorderRadius.all(Radius.circular(30))
                        ),
                      ),
                      SizedBox(width: 10,),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              width: MediaQuery.of(context).size.height * .24,
                              child: RichText(
                                overflow: TextOverflow.visible,
                                softWrap: true,
                                strutStyle: StrutStyle(fontSize: 12.0),
                                text: TextSpan(
                                    style: TextStyle(
                                        color: Theme.of(context).indicatorColor,
                                        fontSize: MediaQuery.of(context)
                                            .size
                                            .height *
                                            .025,
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.w600),
                                    text:
                                    "Hello ${widget.name}"),
                              ),
                            ),
                            Text(
                              "Find Fish at Your Door Step",
                              style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize:
                                MediaQuery.of(context).size.height * .015,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * .15,
                left: 0,
                right: 0,
                child: Padding(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.height * .015,
                      right: MediaQuery.of(context).size.height * .015),
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width * 1,
                        height: 1,
                        color: Colors.grey[350],
                      ),
                      ListTile(
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AddRoutes()));
                          },
                          leading: Container(
                            width: 35,
                            height: 35,
                            decoration: BoxDecoration(
                                color: Colors.amber,
                                shape: BoxShape.circle),
                            child: Center(
                                child: IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.location_on_outlined,
                                      size: 20,
                                      color: Colors.black),
                                )),
                          ),
                          title: Text(
                            "Add Daily Routes",
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 16),
                          )),
                      ListTile(
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AddFish()));
                          },
                          leading: Container(
                            width: 35,
                            height: 35,
                            decoration: BoxDecoration(
                                color: Colors.amber,
                                shape: BoxShape.circle),
                            child: Center(
                                child: IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.shopping_cart_sharp,
                                      size: 20,
                                      color: Colors.black),
                                )),
                          ),
                          title: Text(
                            "Add Daily Fish",
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 16),
                          )
                      ),
                      ListTile(
                          onTap: () {
                            Navigator.of(context).pop();
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>RouteReport()));
                          },
                          leading: Container(
                            width: 35,
                            height: 35,
                            decoration: BoxDecoration(
                                color: Colors.amber,
                                shape: BoxShape.circle),
                            child: Center(
                                child: IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.alt_route_outlined,
                                      size: 20,
                                      color: Colors.black),
                                )),
                          ),
                          title: Text(
                            "Route Report",
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 16),
                          )
                      ),
                      ListTile(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          leading: Container(
                            width: 35,
                            height: 35,
                            decoration: BoxDecoration(
                                color: Colors.amber,
                                shape: BoxShape.circle),
                            child: Center(
                                child: IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.supervised_user_circle_rounded,
                                      size: 20,
                                      color: Colors.black),
                                )),
                          ),
                          title: Text(
                            "My Customers",
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 16),
                          )),
                      ListTile(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CallLogs()));
                          },
                          leading: Container(
                            width: 35,
                            height: 35,
                            decoration: BoxDecoration(
                                color: Colors.amber,
                                shape: BoxShape.circle),
                            child: Center(
                                child: IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.call,
                                      size: 20,
                                      color: Colors.black),
                                )),
                          ),
                          title: Text(
                            "Call Logs",
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 16),
                          )),
                      ListTile(
                          onTap: () {
                            showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text("Logout"),
                                    content: Text("Would you like to continue to logout?"),
                                    actions: [
                                      MaterialButton(
                                        child: Text("Cancel"),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                      MaterialButton(
                                        child: Text("Continue"),
                                        onPressed: () {
                                          Navigator.pop(context);
                                          widget.logOut();
                                        },
                                      )
                                    ],
                                  );
                                });
                          },
                          leading: Container(
                            width: 35,
                            height: 35,
                            decoration: BoxDecoration(
                                color: Colors.amber,
                                shape: BoxShape.circle),
                            child: Center(
                                child: IconButton(
                                  onPressed: () {
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => LaunchScreen()),
                                            (Route<dynamic> route) => false);
                                  },
                                  icon: Icon(Icons.logout,
                                      size: 20,
                                      color: Colors.black),
                                )),
                          ),
                          title: Text(
                            "Logout",
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 16),
                          )),

                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
