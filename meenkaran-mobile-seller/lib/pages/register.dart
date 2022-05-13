import 'package:connectone_meenkaran_seller/pages/add_fish.dart';
import 'package:connectone_meenkaran_seller/view_models/base_view_model.dart';
import 'package:connectone_meenkaran_seller/view_models/register_view_model.dart';
import 'package:connectone_meenkaran_seller/view_models/user_view_model.dart';
import 'package:connectone_meenkaran_seller/widgets/DropDownCus.dart';
import 'package:connectone_meenkaran_seller/widgets/loading_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'home.dart';

class Register extends StatefulWidget {
  const Register({Key key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  RegisterViewModel _registerViewModel;

  final _formKey = GlobalKey<FormState>();
  String _userName="";
  String _mobile="";
  String _password="";
  bool expandFlag=false;


  @override
  void initState() {
    _registerViewModel = Provider.of<RegisterViewModel>(context, listen: false);
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _registerViewModel.getState());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomInset: false,
        body: Consumer<RegisterViewModel>(builder: (context,model,child){
          return SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * .14,
                  decoration: BoxDecoration(color: Colors.amber),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 22, top: 20),
                    child: ListTile(
                      title: Text(
                        "Meenkaran",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: Text("Find Fish at Your Door Step"),
                      ),
                    ),
                  ),
                ),
                Visibility(
                  child: Loading(),
                  visible: _registerViewModel.response == Response.Loading,
                ),
                Visibility(
                  maintainState: true,
                  visible: _registerViewModel.response == Response.Success,
                  child: Container(
                    transform: Matrix4.translationValues(0.0, -10.0, 0.0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Padding(
                      padding:
                      const EdgeInsets.symmetric(vertical: 22.0, horizontal: 20),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 30,
                          ),
                          Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  TextFormField(
                                    onChanged: (value) {
                                      model.onChange("sellername", value);
                                    },
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return "Please enter Shop Name";
                                      } else {
                                        return null;
                                      }
                                    },
                                    decoration: InputDecoration(
                                        labelText: 'Seller Name',
                                        prefixIcon:
                                        Icon(Icons.account_box_outlined),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                            BorderRadius.circular(10.0),
                                            borderSide: BorderSide(
                                                color:
                                                Colors.grey.withOpacity(0.9)))),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  TextFormField(
                                    keyboardType: TextInputType.number,
                                    onChanged: (value) {
                                      model.onChange("phone", value+"@gmail.com");
                                      _userName=value;
                                    },
                                    validator: (value) {
                                      if (value.length != 10) {
                                        return "Invalid Phone Number";
                                      } else {
                                        return null;
                                      }
                                    },
                                      decoration: InputDecoration(
                                          labelText: 'Seller Phone Number',
                                          prefixIcon: Icon(Icons.phone_android),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                              BorderRadius.circular(10.0),
                                              borderSide: BorderSide(
                                                  color:
                                                  Colors.grey.withOpacity(0.9)))),
                                  ),

                                  SizedBox(
                                    height: 15,
                                  ),
                                  TextFormField(
                                    //obscureText: hidePassword,
                                    validator: (value) {
                                      if (value.length < 6) {
                                        return "Atleast 6 charecter needed";
                                      } else {
                                        return null;
                                      }
                                    },
                                    onChanged: (value) {
                                      model.onChange("password", value);
                                      _password=value;
                                    },
                                    decoration: InputDecoration(
                                        labelText: 'Password',
                                        prefixIcon: Icon(Icons.phone_android),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                            BorderRadius.circular(10.0),
                                            borderSide: BorderSide(
                                                color:
                                                Colors.grey.withOpacity(0.9))),
                                    ),

                                  ),

                                  SizedBox(
                                    height: 15,
                                  ),

                                  _getExpandable(model),
                                  SizedBox(
                                    height: 10,
                                  ),
                                ],
                              )),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () async {
                                if (_formKey.currentState.validate()) {
                                  var result = await model.register();
                                  if (result) {
                                    var details = await model.registerSellerDetails();
                                      if(details){
                                        var login=await Provider.of<UserViewModel>(context, listen: false,)
                                            .login(_userName, _password);
                                        if(login){
                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => AddFish()));}
                                      }
                                  }
                                }
                              },
                              child:Text("Register ",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold
                                  )),
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.amber,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: new BorderRadius.circular(15.0),
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        }),
      );
  }
  _getExpandable(RegisterViewModel model) {
    return Container(
      margin: new EdgeInsets.symmetric(vertical: 1.0),
      child: new Column(
        children: <Widget>[
          new Container(
            padding: new EdgeInsets.symmetric(horizontal: 5.0),
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                new IconButton(
                    icon: new Container(
                      height: 50.0,
                      width: 50.0,
                      decoration: new BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: new Center(
                        child: new Icon(
                          expandFlag
                              ? Icons.keyboard_arrow_up
                              : Icons.keyboard_arrow_down,
                          size: 30.0,
                        ),
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        expandFlag = !expandFlag;
                      });
                    }),
                new Text(
                  "Advanced Fields",
                  style: new TextStyle(

                  ),
                )
              ],
            ),
          ),
          new ExpandableContainer(
              expanded: expandFlag,
              child: new ExpandableContainer(
                  expanded: expandFlag,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      SizedBox(height: 20),
                      TextFormField(
                        keyboardType: TextInputType.multiline,
                        maxLines: 2,
                        onChanged: (value) {
                          model.onChange("address", value);
                        },
                        // validator: (value) {
                        //   if (value.isEmpty) {
                        //     return "Invalid Shop Address";
                        //   } else {
                        //     return null;
                        //   }
                        // },
                        decoration: InputDecoration(
                            labelText: 'Shop Address',
                            prefixIcon:
                            Icon(Icons.view_compact_outlined),
                            border: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                    color:
                                    Colors.grey.withOpacity(0.9)))),
                      ),
                      SizedBox(height: 20),
                      Stack(
                        children: [
                          Positioned(
                              top: 16,
                              left: 10,
                              child: Icon(
                                Icons.account_balance_wallet_outlined,
                                color: Colors.grey,
                              )),
                          Container(
                            height: 60,
                            padding:
                            EdgeInsets.only(left: 15, right: 15),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.grey, width: 1),
                                borderRadius:
                                BorderRadius.circular(10)),
                            child: DropDownWidget(
                              value: model.selectedState,
                              onchange: (value) {
                                model.onChange("state", value);
                              },
                              hint: "Select State",
                              list:
                              _registerViewModel.stateList ?? [],
                              type: DropdownType.STATE,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      _registerViewModel.districtList != null
                          ? Stack(
                        children: [
                          Positioned(
                              top: 16,
                              left: 10,
                              child: Icon(
                                Icons
                                    .account_balance_wallet_outlined,
                                color: Colors.grey,
                              )),
                          Container(
                            height: 60,
                            padding: EdgeInsets.only(
                                left: 15, right: 15),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.grey, width: 1),
                                borderRadius:
                                BorderRadius.circular(10)),
                            child: DropDownWidget(
                              value: model.selectedDistrict,
                              onchange: (value) {
                                model.onChange("district", value);
                              },
                              hint: "Select District",
                              list: _registerViewModel.districtList,
                              type: DropdownType.DISTRICT,
                            ),
                          ),
                        ],
                      )
                          : SizedBox(),
                      SizedBox(
                        height: 8,
                      ),
                      _registerViewModel.talukList != null
                          ? Stack(
                        children: [
                          Positioned(
                              top: 16,
                              left: 10,
                              child: Icon(
                                Icons
                                    .account_balance_wallet_outlined,
                                color: Colors.grey,
                              )),
                          Container(
                            height: 60,
                            padding: EdgeInsets.only(
                                left: 15, right: 15),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.grey, width: 1),
                                borderRadius:
                                BorderRadius.circular(10)),
                            child: DropDownWidget(
                              value: model.selectedTalluk,
                              onchange: (value) {
                                model.onChange("taluk", value);
                              },
                              hint: "Select Taluk",
                              list: _registerViewModel.talukList,
                              type: DropdownType.TALUK,
                            ),
                          ),
                        ],
                      )
                          : SizedBox(),
                      SizedBox(
                        height: 8,
                      ),
                      _registerViewModel.locationList != null
                          ? Stack(
                        children: [
                          Positioned(
                              top: 16,
                              left: 10,
                              child: Icon(
                                Icons
                                    .account_balance_wallet_outlined,
                                color: Colors.grey,
                              )),
                          Container(
                            height: 60,
                            padding: EdgeInsets.only(
                                left: 15, right: 15),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.grey, width: 1),
                                borderRadius:
                                BorderRadius.circular(10)),
                            child: DropDownWidget(
                              value: model.selectedLocation,
                              onchange: (value) {
                                model.onChange("location", value);
                              },
                              hint: "Select Location",
                              list: _registerViewModel.locationList,
                              type: DropdownType.LOCATION,
                            ),
                          ),
                        ],
                      )
                          : SizedBox(),

                    ],
                  )))
        ],
      ),
    );
  }
}

class ExpandableContainer extends StatelessWidget {
  final bool expanded;
  final double collapsedHeight;
  final double expandedHeight;
  final Widget child;

  ExpandableContainer({
    @required this.child,
    this.collapsedHeight = 0.0,
    this.expandedHeight = 300.0,
    this.expanded = true,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return new AnimatedContainer(
      duration: new Duration(milliseconds: 00),
      curve: Curves.easeInOut,
      width: screenWidth,
      height: expanded ? null : collapsedHeight,
      child: new Container(
        child: child,
//        decoration: new BoxDecoration(border: new Border.all(width: 1.0, color: Colors.blue)),
      ),
    );
  }
}
