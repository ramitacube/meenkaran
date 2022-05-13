import 'package:connectone_meenkaran_seller/view_models/base_view_model.dart';
import 'package:connectone_meenkaran_seller/view_models/register_view_model.dart';
import 'package:connectone_meenkaran_seller/view_models/user_view_model.dart';
import 'package:connectone_meenkaran_seller/widgets/fish_widget.dart';
import 'package:connectone_meenkaran_seller/widgets/fabButton.dart';
import 'package:connectone_meenkaran_seller/widgets/loading_widget.dart';
import 'package:connectone_meenkaran_seller/widgets/route_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddRoutes extends StatefulWidget {
  const AddRoutes({Key key}) : super(key: key);

  @override
  _AddRoutesState createState() => _AddRoutesState();
}

class _AddRoutesState extends State<AddRoutes> {
  bool checked = false;
  bool selected = false;
  UserViewModel _userViewModel;
  bool select=false;

  @override
  void initState() {
    super.initState();
    _userViewModel = Provider.of<UserViewModel>(context, listen: false);
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _userViewModel.getAllData());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FabButton(
        title: "Continue",
      ),
      body: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * .12,
            decoration: BoxDecoration(color: Colors.amber),
            child: Padding(
              padding: const EdgeInsets.only(right: 22, top: 30),
              child: ListTile(
                title: Text(
                  "Select Your Routes",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                // leading: IconButton(
                //     onPressed: () {
                //       Navigator.pop(context);
                //     },
                //     icon: Icon(Icons.arrow_back)),
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            transform: Matrix4.translationValues(0.0, -10.0, 0.0),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: Consumer<UserViewModel>(builder: (context, model, child) {
              return model.response == Response.Success &&
                      model.allData != null
                  // &&       model.allData.isNotEmpty
                  ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0, top: 25, bottom: 15),
                          child: Text(
                            "Tap to Select Today's Routes in "+model.allData.talukId.name),
                        ),
                        SizedBox(
                          height: 18,
                        ),
                        GridView.builder(
                            padding: EdgeInsets.only(left: 10,right: 10),
                            shrinkWrap: true,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount:
                                  MediaQuery.of(context).orientation ==
                                          Orientation.landscape
                                      ? 5
                                      : 3,
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 1,
                              childAspectRatio: (5 / 2),
                            ),
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: model.locationList.length,
                            itemBuilder: (contextList, index) {
                              for(int i=0 ; i<model.sellerRoutesList.length ; i++){
                                if(model.sellerRoutesList[i].locationId.id==model.locationList[index].id){
                                  select=true;
                                  break;
                                }else{
                                  select=false;
                                }

                              }
                              return  RouteWidget(
                                selected: select,
                                locationData: model.locationList[index],
                                onSelect: (value) {
                                  print("Checked value:::" + value.toString());
                                  model.addDailyRoute(value);
                                },
                                onDeselect: (value) {
                                  print("Uncheked value:::" + value.toString());
                                },
                              );
                            })
                      ],
                    )
                  : model.response == Response.Success || model.locationList.isEmpty //|| model.locationList==null
                      ? Container(
                          child: Center(
                            child: Text("No Routes"),
                          ),
                        )
                      : Loading();
            }),
          ),
        ],
      ),
    );
  }
}
