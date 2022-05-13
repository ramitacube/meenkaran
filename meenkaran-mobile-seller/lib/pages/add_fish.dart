import 'dart:async';

import 'package:connectone_meenkaran_seller/model/fish_model.dart';
import 'package:connectone_meenkaran_seller/model/seller_Item_model.dart';
import 'package:connectone_meenkaran_seller/pages/home.dart';
import 'package:connectone_meenkaran_seller/view_models/base_view_model.dart';
import 'package:connectone_meenkaran_seller/view_models/user_view_model.dart';
import 'package:connectone_meenkaran_seller/widgets/fish_widget.dart';
import 'package:connectone_meenkaran_seller/widgets/fabButton.dart';
import 'package:connectone_meenkaran_seller/widgets/loading_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddFish extends StatefulWidget {
  const AddFish({Key key}) : super(key: key);

  @override
  _AddFishState createState() => _AddFishState();
}

class _AddFishState extends State<AddFish> {
UserViewModel _userViewModel;
bool select=false;

  @override
  void initState() {
    super.initState();
    _userViewModel = Provider.of<UserViewModel>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) =>
        Provider.of<UserViewModel>(context,listen: false).getUser());
    WidgetsBinding.instance.addPostFrameCallback((_) =>
    Provider.of<UserViewModel>(context,listen: false).getFish());
    // WidgetsBinding.instance.addPostFrameCallback((_) =>
    //     Provider.of<UserViewModel>(context,listen: false).getSellerItem());


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton:Consumer<UserViewModel>(builder: (context,model,child){
        return Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: 50.0,
        child: new RawMaterialButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          fillColor: Colors.amber,
          elevation: 0.0,
          child:Center(
            child: Text(model.isStarted ? "Stop" :"Start",
              style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),
            ),
          ),
          onPressed: () {
            setState(() {
              model.isStarted=!model.isStarted;
            });
            if(model.isStarted){
              //model.sendNotification();
              model.timer =
                  Timer.periodic(Duration(seconds:30 ), (timer) {
                    model.updateLocation();
                    //model.sendNotification();
                  });
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Home()));
            }else{
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
                        onPressed:  () {
                          setState(() {
                            model.isStarted=!model.isStarted;
                          });
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Home()));
                        },
                      ),
                      MaterialButton(
                        child: Text("Yes"),
                        onPressed:  () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Home()));
                          model.timer.cancel();

                        },
                      )
                    ],
                  );
                },
              );
            }
          },
        ),
      );
      }),
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
                  "Select Your Fishes",
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15.0, top: 25, bottom: 15),
                  child: Text("Tap to Select Today's Items "),
                ),
                SizedBox(
                  height: 18,
                ),
                Consumer<UserViewModel>(builder: (context,model,child){
                  return model.response == Response.Success &&
                  model.fishList !=null && model.fishList.isNotEmpty
                      //&& model.sellerItemList!=null && model.sellerItemList.isNotEmpty
                  ? GridView.builder(
                    padding: EdgeInsets.only(left: 10,right: 10),
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: MediaQuery.of(context).orientation ==
                            Orientation.landscape ? 5: 3,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 1,
                        childAspectRatio: (5 / 2),
                      ),
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: model.fishList.length,
                      itemBuilder: (contextList,index) {
                      print(model.sellerItemList.length);
                        for(int i=0 ; i<model.sellerItemList.length ; i++){
                          if(model.sellerItemList[i].itemId.id==model.fishList[index].id){
                            select=true;
                            break;
                          }else{
                            select=false;
                          }

                        }
                        return  FishWidget(
                          selected: select,
                          sellerItems: model.sellerItemList,
                          fishData: model.fishList[index],
                          onSelect: (value){
                              print("Checked value:::"+value.toString());
                              model.addDailyItems(value);
                        },
                        onDeselect: (value){
                          print("Uncheked value:::"+value.toString());
                        },);
                      }
                  )
                  : model.response == Response.Success &&
                  model.fishList.isEmpty
                      ? Container(
                    child: Center(
                      child: Text("No Fishes"),
                    ),
                  )
                      : Loading();

                }),
              ],
            ),
          ),
        ],
      ),
    );
  }





}


