import 'package:connectone_meenkaran/src/widgets/loading.dart';
import 'package:connectone_meenkaran/viewModels/base_view_model.dart';
import 'package:connectone_meenkaran/viewModels/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:horizontal_center_date_picker/datepicker_controller.dart';
import 'package:horizontal_center_date_picker/horizontal_date_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'dart:math' show cos, sqrt, asin;

class TrackSeller extends StatefulWidget {
  final String sellerId;
  final String sellerName;
  const TrackSeller({Key key,this.sellerId,this.sellerName}) : super(key: key);

  @override
  _TrackSellerState createState() => _TrackSellerState();
}

class _TrackSellerState extends State<TrackSeller> {

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
        .addPostFrameCallback((_) =>
        _homeViewModel.getDailyReport(
            DateFormat("yyyy-MM-dd").format(DateTime.now()), widget.sellerId));
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
            width: MediaQuery
                .of(context)
                .size
                .width,
            height: MediaQuery
                .of(context)
                .size
                .height * .12,
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

          Consumer<UserViewModel>(builder: (contextModel, model, child) {
            return model.response == Response.Success
                ?
            Container(
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
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
                      widgetWidth: MediaQuery
                          .of(context)
                          .size
                          .width,
                      datePickerController: DatePickerController(),
                      onValueSelected: (date) {
                        print('selected = ${DateFormat("yyyy-MM-dd").format(
                            date)}');
                        now = date;
                        model.getDailyReport(
                            DateFormat("yyyy-MM-dd").format(date),
                            widget.sellerId);
                      },
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  model.dailyReportData.dailyItem.isNotEmpty
                      ? Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: MediaQuery
                                .of(context)
                                .size
                                .width * .4,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: MediaQuery
                                      .of(context)
                                      .size
                                      .height * .13,
                                  child: Text("Start From"),

                                ),
                                Container(
                                  height: MediaQuery
                                      .of(context)
                                      .size
                                      .height * .09,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("Itetnary"),
                                  ),

                                ),
                                Container(
                                  height: MediaQuery
                                      .of(context)
                                      .size
                                      .height * .15,
                                  child: Center(
                                    child: Text("Via"),
                                  ),
                                ),
                                Container(
                                  height: MediaQuery
                                      .of(context)
                                      .size
                                      .height * .09,
                                  child: Center(
                                    child: Text("Destination"),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Container(
                            width: MediaQuery
                                .of(context)
                                .size
                                .width * .1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  //height: MediaQuery.of(context).size.height * .1,
                                  child: Container(
                                    width: MediaQuery
                                        .of(context)
                                        .size
                                        .width * .09,
                                    height: 35,
                                    decoration: BoxDecoration(
                                        color: Colors.amber,
                                        shape: BoxShape.circle),
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
                                  length: 70,
                                  dashLength: 5,
                                ),
                                Container(
                                  // height: MediaQuery.of(context).size.height * .1,
                                  child: Container(
                                    width: MediaQuery
                                        .of(context)
                                        .size
                                        .width * .09,
                                    height: 35,
                                    decoration: BoxDecoration(
                                        color: Colors.amber,
                                        shape: BoxShape.circle),
                                    child: Center(
                                        child: IconButton(
                                          onPressed: () {},
                                          icon: Icon(
                                              Icons.shopping_cart_rounded,
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
                                    width: MediaQuery
                                        .of(context)
                                        .size
                                        .width * .09,
                                    height: 35,
                                    decoration: BoxDecoration(
                                        color: Colors.amber,
                                        shape: BoxShape.circle),
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
                                  length: 70,
                                  dashLength: 5,
                                ),
                                Container(
                                  height: MediaQuery
                                      .of(context)
                                      .size
                                      .height * .04,
                                  child: Container(
                                    width: MediaQuery
                                        .of(context)
                                        .size
                                        .width * .09,
                                    height: 35,
                                    decoration: BoxDecoration(
                                        color: Colors.amber,
                                        shape: BoxShape.circle),
                                    child: Center(
                                        child: IconButton(
                                          onPressed: () {},
                                          icon: Icon(
                                              Icons.shopping_cart_rounded,
                                              size: 20, color: Colors.black),
                                        )),
                                  ),
                                ),
                              ],
                            ),
                          ),


                          Container(
                            width: MediaQuery
                                .of(context)
                                .size
                                .width * .5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: MediaQuery
                                      .of(context)
                                      .size
                                      .height * .09,
                                  width: MediaQuery
                                      .of(context)
                                      .size
                                      .width * .4,
                                  child: Text(model.dailyReportData.dailyRoute.isNotEmpty
                                      ? model.dailyReportData.dailyRoute[0]
                                      .locationName
                                      : "Not Found"),

                                ),
                                Container(
                                    height: MediaQuery
                                        .of(context)
                                        .size
                                        .height * .15,
                                    width: MediaQuery
                                        .of(context)
                                        .size
                                        .width * .4,
                                    child:model.dailyReportData.dailyItem.isNotEmpty
                                        ? ListView.builder(
                                        itemCount: model.dailyReportData
                                            .dailyItem.length,
                                        itemBuilder: (context, index) {
                                          return  Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(model.dailyReportData
                                                .dailyItem[index].itemName +
                                                ",",
                                              overflow: TextOverflow.visible,),
                                          );

                                        }): Text("Not Found")


                                ),
                                Container(
                                    height: MediaQuery
                                        .of(context)
                                        .size
                                        .height * .15,
                                    width: MediaQuery
                                        .of(context)
                                        .size
                                        .width * .4,
                                    child: model.dailyReportData
                                        .dailyRoute.isNotEmpty
                                        ? ListView.builder(
                                        itemCount: model.dailyReportData
                                            .dailyRoute.length,
                                        itemBuilder: (context, index) {
                                          return Text(model.dailyReportData
                                              .dailyRoute[index].locationName +
                                              ",",
                                            overflow: TextOverflow.visible,);
                                        }): Padding(
                                          padding: const EdgeInsets.only(top: 30.0),
                                          child: Text("Not Found"),
                                        )
                                ),
                                Container(
                                  height: MediaQuery
                                      .of(context)
                                      .size
                                      .height * .15,
                                  width: MediaQuery
                                      .of(context)
                                      .size
                                      .width * .4,
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 14.0),
                                    child: Text(model.dailyReportData.dailyRoute.isNotEmpty
                                        //!=null
                                        ? model.dailyReportData.dailyRoute[0]
                                        .locationName
                                        : "Not Found"),
                                  ),

                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * .8,
                        height: MediaQuery
                            .of(context)
                            .size
                            .height * .15,
                        decoration: BoxDecoration(
                            color: Colors.amber,
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Column(
                            children: [
                              Text(getDistance(
                                model.allData.last.longitude,
                                model.allData.last.latitude,
                                model.customerDetailsList1[0].custLong,//"10.1974661",
                                model.customerDetailsList1[0].custLat,//"76.4745638"
                              )+" KM",
                                style: TextStyle(fontSize: 22,
                                    fontWeight: FontWeight.w500),),
                              SizedBox(
                                height: MediaQuery
                                    .of(context)
                                    .size
                                    .height * .01,
                              ),
                              Text("Last updated on"),
                              Text(DateFormat('yyyy-MM-dd').format(DateTime.parse(model.allData[model.allData.length-1].dateTime))),
                              Text(DateFormat.jm().format(DateTime.parse(model.allData[model.allData.length-1].dateTime))),
                            ],
                          ),
                        ),
                      )
                    ],
                  )
                      : model.response == Response.Success &&
                      model.dailyReportData.dailyItem.isEmpty
                      ? Container(
                    child: Column(
                      children: [
                        Center(
                          child: Text("No Data Found"),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 50.0),
                          child: Container(
                            width: MediaQuery
                                .of(context)
                                .size
                                .width * .35,
                            height: MediaQuery
                                .of(context)
                                .size
                                .height * .15,
                            decoration: BoxDecoration(
                                color: Colors.amber,
                                borderRadius: BorderRadius.circular(70)),
                            child: Center(
                              child: Text(getDistance(
                                model.allData.last.longitude,
                                model.allData.last.latitude,
                                model.customerDetailsList1[0].custLong,//"10.1974661",
                                model.customerDetailsList1[0].custLat,//"76.4745638"
                              )+" KM",
                                style: TextStyle(fontSize: 22,
                                    fontWeight: FontWeight.w500),),
                            ),
                          ),

                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .04,
                        ),
                        Text("${widget.sellerName} is ${getDistance(
                          model.allData.last.longitude,
                          model.allData.last.latitude,
                          model.customerDetailsList1[0].custLong,//"10.1974661",
                          model.customerDetailsList1[0].custLat,//"76.4745638"
                        )} KM away from you",
                        style: TextStyle(fontSize: 20,
                            fontWeight: FontWeight.w500),)
                      ],
                    ),
                  )
                      : Loading()
                ],
              ),
            )
                : model.response == Response.Success &&
                model.dailyReportData == null
                ? Container(
              child: Center(
                child: Text("No Fishes"),
              ),
            )
                : Loading();
          })
        ],
      ),
    );
  }

  String getDistance(String lat1, String long1, String lat2, String long2) {
    var lt1 = double.parse(lat1);
    var lt2 = double.parse(lat2);
    var ln1 = double.parse(long1);
    var ln2 = double.parse(long2);

    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 - c((lt2 - lt1) * p) / 2 +
        c(lt1 * p) * c(lt2 * p) *
            (1 - c((ln2 - ln1) * p)) / 2;
    var distance=12742 * asin(sqrt(a));

    print("Distance::"+distance.toString());

    return distance.toStringAsFixed(0);
  }
}