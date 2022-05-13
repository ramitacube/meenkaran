import 'package:connectone_meenkaran_seller/view_models/base_view_model.dart';
import 'package:connectone_meenkaran_seller/view_models/user_view_model.dart';
import 'package:connectone_meenkaran_seller/widgets/loading_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:horizontal_center_date_picker/datepicker_controller.dart';
import 'package:horizontal_center_date_picker/horizontal_date_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class RouteReport extends StatefulWidget {
  const RouteReport({Key key}) : super(key: key);

  @override
  _RouteReportState createState() => _RouteReportState();
}

class _RouteReportState extends State<RouteReport> {
  DateTime _selectedValue = DateTime.now();
  var now = DateTime.now();
  DateTime startDate;
  DateTime endDate;
  UserViewModel _homeViewModel;


  @override
  void initState() {
    super.initState();

     _homeViewModel = Provider.of<UserViewModel>(context, listen: false);
      WidgetsBinding.instance
         .addPostFrameCallback((_) => _homeViewModel.getDailyReport(DateFormat("yyyy-MM-dd").format(DateTime.now())));
  }

  @override
  Widget build(BuildContext context) {
    startDate = now.subtract(Duration(days: 3));
    endDate = now.add(Duration(days: 3));
    print('startDate = $startDate ; endDate = $endDate');
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * .12,
            decoration: BoxDecoration(color: Colors.amber),
            child: Padding(
              padding: const EdgeInsets.only(right: 22, top: 22),
              child: ListTile(
                  title: Text(
                    "Daily Reports",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  leading: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.arrow_back))),
            ),
          ),
          Expanded(child:
              Consumer<UserViewModel>(builder: (contextModel, model, child) {
            return model.response == Response.Success
                ?
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: HorizontalDatePickerWidget(
                      startDate: startDate,
                      endDate: endDate,
                      selectedDate: now,
                      normalColor: Colors.grey.shade100,
                      selectedColor: Colors.amber,
                      selectedTextColor: Colors.black,
                      normalTextColor: Colors.black,
                      widgetWidth: MediaQuery.of(context).size.width,
                      datePickerController: DatePickerController(),
                      onValueSelected: (date) {
                        print('selected = ${DateFormat("yyyy-MM-dd").format(date)}');
                        now=date;
                        model.getDailyReport(DateFormat("yyyy-MM-dd").format(date));
                      },
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  model.dailyReportData.dailyItem.isNotEmpty
                      ?Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width:MediaQuery.of(context).size.width * .4,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: MediaQuery.of(context).size.height * .15,
                                child:Text("Start From"),

                              ),
                              Container(
                                height: MediaQuery.of(context).size.height * .1,
                                child:Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("Itetnary"),
                                ),

                              ),
                              Container(
                                height: MediaQuery.of(context).size.height * .15,
                                child: Center(
                                  child: Text("Via"),
                                ),
                              ),
                              Container(
                                height: MediaQuery.of(context).size.height * .15,
                                child: Center(
                                  child: Text("Destination"),
                                ),
                              ),
                            ],
                          ),
                      ),

                      Container(
                        width:MediaQuery.of(context).size.width * .1,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                //height: MediaQuery.of(context).size.height * .1,
                                child:Container(
                                      width: MediaQuery.of(context).size.width * .09,
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
                              ),
                              Dash(
                                  direction: Axis.vertical,
                                  length: 90,
                                  dashLength: 5,
                              ),
                              Container(
                                // height: MediaQuery.of(context).size.height * .1,
                                child: Container(
                                  width: MediaQuery.of(context).size.width * .09,
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
                              Dash(
                                direction: Axis.vertical,
                                length: 90,
                                dashLength: 5,
                              ),
                              Container(
                                //height: MediaQuery.of(context).size.height * .15,
                                child: Container(
                                  width: MediaQuery.of(context).size.width * .09,
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
                              Dash(
                                direction: Axis.vertical,
                                length: 100,
                                dashLength: 5,
                              ),
                              Container(
                                //height: MediaQuery.of(context).size.height * .1,
                                child: Container(
                                  width: MediaQuery.of(context).size.width * .09,
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
                            ],
                          ),
                      ),


                      Container(
                        width:MediaQuery.of(context).size.width * .5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height * .1,
                              width: MediaQuery.of(context).size.width * .4,
                              child: Text(model.dailyReportData.dailyRoute.isNotEmpty
                                  ?model.dailyReportData.dailyRoute[0].locationName
                                  :"Not Found"),

                            ),
                            Container(
                              height: MediaQuery.of(context).size.height * .15,
                              width: MediaQuery.of(context).size.width * .4,
                              child: ListView.builder(
                                  itemCount: model.dailyReportData.dailyItem.length,
                                  itemBuilder: (context,index){
                                return model.dailyReportData.dailyItem.isNotEmpty
                                    ?Text(model.dailyReportData.dailyItem[index].itemName+",",overflow: TextOverflow.visible,)
                                :Text("Not Found");
                              })


                            ),
                            Container(
                              height: MediaQuery.of(context).size.height * .2,
                              width: MediaQuery.of(context).size.width * .4,
                              child: ListView.builder(
                                  itemCount: model.dailyReportData.dailyRoute.length,
                                  itemBuilder: (context,index){
                                    return model.dailyReportData.dailyRoute.isNotEmpty
                                        ?Text(model.dailyReportData.dailyRoute[index].locationName+",",overflow: TextOverflow.visible,)
                                        :Text("Not Found");
                                  })
                            ),
                            Container(
                              height: MediaQuery.of(context).size.height * .15,
                              width: MediaQuery.of(context).size.width * .4,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 14.0),
                                child: Text(model.dailyReportData.dailyRoute.isNotEmpty
                                    ?model.dailyReportData.dailyRoute[0].locationName
                                    :"Not Found"),
                              ),

                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                    :model.response == Response.Success &&
                model.dailyReportData.dailyItem.isEmpty
                ? Container(
                child: Center(
                child: Text("No Data Found"),
                ),
                )
                    : Loading()
                ],
              ),
            )
            :model.response == Response.Success &&
                model.dailyReportData==null
                ? Container(
              child: Center(
                child: Text("No Fishes"),
              ),
            )
                : Loading();
          }))
        ],
      ),
    );
  }
}
