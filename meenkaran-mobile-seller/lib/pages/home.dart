import 'dart:async';

import 'package:connectone_meenkaran_seller/view_models/base_view_model.dart';
import 'package:connectone_meenkaran_seller/view_models/user_view_model.dart';
import 'package:connectone_meenkaran_seller/widgets/add_customer_dialog.dart';
import 'package:connectone_meenkaran_seller/widgets/customer_widget.dart';
import 'package:connectone_meenkaran_seller/widgets/dialog_widget.dart';
import 'package:connectone_meenkaran_seller/widgets/drawer_widget.dart';
import 'package:connectone_meenkaran_seller/widgets/header_widget.dart';
import 'package:connectone_meenkaran_seller/widgets/loading_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'launch_screen.dart';

class Home extends StatefulWidget {
  const Home({
    Key key,
  }) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
final formKey = GlobalKey<FormState>();

class _HomeState extends State<Home> {
  UserViewModel _homeViewModel;

  @override
  void initState() {
    super.initState();
    _homeViewModel = Provider.of<UserViewModel>(context, listen: false);
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _homeViewModel.getUser());
    // WidgetsBinding.instance
    //     .addPostFrameCallback((_) => _homeViewModel.getSellerItem());
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        key: scaffoldKey,
        floatingActionButton:
            Consumer<UserViewModel>(builder: (contextModel, model, child) {
          return Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: 50.0,
            child: new RawMaterialButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              fillColor: Colors.amber,
              elevation: 0.0,
              child: Center(
                  child: Text(
                model.isStarted ? "Stop " : "Start ",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              )),
              onPressed: () {
                setState(() {
                  model.isStarted = !model.isStarted;
                });
                if (model.isStarted) {
                  //model.sendNotification();
                  model.timer = Timer.periodic(Duration(seconds: 30), (timer) {
                    model.updateLocation();
                    //model.sendNotification();
                  });
                } else {
                  showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Stop Ride"),
                        content: Text("Would you like to stop your ride?"),
                        actions: [
                          MaterialButton(
                            child: Text("No"),
                            onPressed: () {
                              setState(() {
                                model.isStarted = !model.isStarted;
                              });
                              Navigator.pop(context);
                            },
                          ),
                          MaterialButton(
                            child: Text("Yes"),
                            onPressed: () {
                              Navigator.pop(context);
                              model.timer.cancel();
                            },
                          )
                        ],
                      );
                    },
                  );
                }

                //model.timer.cancel();
                // model.isStarted ?
                //
                // model.timer =
                //     Timer.periodic(Duration(seconds:1 ), (timer) {
                //   model.updateLocation();
                // })
                // :model.timer.cancel();
              },
            ),
          );
          // Stack(
          //   children: [
          //     Positioned(
          //       left: 40,
          //       bottom: 0,
          //       child: Container(
          //         width: MediaQuery.of(context).size.width * 0.30,
          //         height: 50.0,
          //         child: new RawMaterialButton(
          //           shape: RoundedRectangleBorder(
          //             borderRadius: BorderRadius.circular(12.0),
          //           ),
          //           fillColor: Colors.amber,
          //           elevation: 0.0,
          //           child: Padding(
          //             padding: const EdgeInsets.only(left: 30.0),
          //             child: Row(
          //               children: [
          //                 Text("Route"),
          //                 Icon(
          //                   Icons.location_on,
          //                   size: 20,
          //                 ),
          //               ],
          //             ),
          //           ),
          //           onPressed: () {
          //             Navigator.push(context,
          //                 MaterialPageRoute(builder: (context) => AddRoutes()));
          //           },
          //         ),
          //       ),
          //     ),
          //     Positioned(
          //       left: 160,
          //       bottom: 0,
          //       child: Container(
          //         width: MediaQuery.of(context).size.width * 0.30,
          //         height: 50.0,
          //         child: new RawMaterialButton(
          //           shape: RoundedRectangleBorder(
          //             borderRadius: BorderRadius.circular(12.0),
          //           ),
          //           fillColor: Colors.amber,
          //           elevation: 0.0,
          //           child: Padding(
          //             padding: const EdgeInsets.only(left: 25.0),
          //             child: Row(
          //               children: [
          //                 Text("Fish "),
          //                 Icon(
          //                   Icons.shopping_cart_sharp,
          //                   size: 20,
          //                 ),
          //                 Container(
          //                   transform: Matrix4.translationValues(-8.0, -10.0, 0.0),
          //                   width: 20,
          //                   height: 20,
          //                   decoration: BoxDecoration(
          //                       color: Colors.white,
          //                       borderRadius: BorderRadius.circular(20)
          //                   ),
          //                   child:Center(child: Text(model.sellerItemList.length.toString())),
          //                 ),
          //               ],
          //             ),
          //           ),
          //           onPressed: () {
          //             Navigator.push(context,
          //                 MaterialPageRoute(builder: (context) => AddFish()));
          //           },
          //         ),
          //       ),
          //     ),
          //     Positioned(
          //       left: 280,
          //       bottom: 0,
          //       child: Container(
          //         width: MediaQuery.of(context).size.width * 0.25,
          //         height: 50.0,
          //         child: new RawMaterialButton(
          //           shape: RoundedRectangleBorder(
          //             borderRadius: BorderRadius.circular(12.0),
          //           ),
          //           fillColor: Colors.amber,
          //           elevation: 0.0,
          //           child: Padding(
          //             padding: const EdgeInsets.only(left: 30.0),
          //             child: Row(
          //               children: [
          //                 model.isStarted
          //                     ? Text("Stop ")
          //                     : Text("Start "),
          //               ],
          //             ),
          //           ),
          //           onPressed:(){
          //             !model.isStarted
          //             ? timer=Timer.periodic(Duration(minutes: 5), (timer) {
          //               model.updateLocation();
          //             })
          //             :print("Stops Timer");
          //
          //           },
          //         ),
          //       ),
          //     )
          //   ],
          // );
        }),
        resizeToAvoidBottomInset: false,
        drawer: Consumer<UserViewModel>(builder: (contextModel, model, child) {
          return DrawerWidget(
            name: model.userModel.user.username,
            logOut: () {
              model.logout();
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LaunchScreen()),
                  (Route<dynamic> route) => false);
            },
          );
        }),
        body: Consumer<UserViewModel>(builder: (contextModel, model, child) {
          return Padding(
            padding: const EdgeInsets.only(top: 42, left: 20, right: 20),
            child: model.userModel == null
                ? Loading()
                : Container(
                    height: MediaQuery.of(context).size.height * .85,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          HeaderWidget(
                            parentScaffold: scaffoldKey,
                            name: model.userModel.user.username,
                            mobile: model.userModel.user.email.split("@")[0],
                            onChange: () {
                              model.logout();
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LaunchScreen()),
                                  (Route<dynamic> route) => false);
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 1,
                            height: 1,
                            color: Colors.grey[350],
                          ),
                          SizedBox(
                            height: 24,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "My Customers",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              GestureDetector(
                                onTap: () {
                                  showDialog(
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (context) {
                                        return ShowDialog(
                                          formKey: formKey,
                                          searchList: model.searchCustomerList,
                                          searchCustomer: (String value,
                                              BuildContext
                                                  contextDialog) async {
                                            var search = await model
                                                .getSearchCustomer(value);
                                            if (model.searchCustomerList
                                                .isNotEmpty) {
                                              showDialog(
                                                  barrierDismissible: false,
                                                  context: context,
                                                  builder: (context) {
                                                    return AddCustomerDialog(
                                                      searchList: model
                                                          .searchCustomerList,
                                                    );
                                                  });
                                            } else {}
                                          },
                                        );
                                      });
                                },
                                child: Text(
                                  "Add Customers",
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                            ],
                          ),
                          model.response == Response.Success &&
                                  model.customerList != null &&
                                  model.customerList.isNotEmpty
                              ? ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: model.customerList.length,
                                  itemBuilder: (contextList, index) {
                                    return CustomerWidget(
                                      data: model.customerList[index],
                                      makeCall: (value) {
                                        print("Customer Id" + value.toString());
                                        model.createCall(value);
                                      },
                                    );
                                  })
                              : model.response == Response.Success &&
                                      model.customerList.isEmpty
                                  ? Container(
                                      margin: EdgeInsets.only(top: 30),
                                      child: Center(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.person_add,
                                              color: Colors.grey,
                                            ),
                                            SizedBox(width: 10),
                                            Text("No Customer records found",
                                                style: TextStyle(
                                                    color: Colors.grey)),
                                          ],
                                        ),
                                      ),
                                    )
                                  : Loading()
                        ],
                      ),
                    ),
                  ),
          );
        }),
      ),
    );
  }
}
