import 'package:connectone_meenkaran_seller/model/search_customer_model.dart';
import 'package:connectone_meenkaran_seller/view_models/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import 'add_customer_dialog.dart';

class ShowDialog extends StatefulWidget {

  final  GlobalKey<FormState>  formKey ;
  final Function searchCustomer;
  final List<SearchCustomer> searchList;
  const ShowDialog({Key key, this.formKey,this.searchCustomer,this.searchList}) : super(key: key);

  @override
  _ShowDialogState createState() => _ShowDialogState();
}

class _ShowDialogState extends State<ShowDialog> {
  TextEditingController _controllerPhone=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      elevation: 16,
      child: Consumer<UserViewModel>(builder: (contextModel,model,child){
        return Container(
          decoration: BoxDecoration(
              color: Colors.amber,
              borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 20),
            child: Container(
              child: Form(
                  key: widget.formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topRight,
                          child: InkWell(
                              onTap: (){
                                Navigator.pop(context);
                              },
                              child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(Radius.circular(30))
                                  ),
                                  child: Icon(Icons.clear))),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Enter a Valid 10 digit Phone number",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16
                          ),
                        ),

                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 60,
                          child: TextFormField(
                            controller: _controllerPhone,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            onChanged: (value) {
                              print(value);
                              setState(() {
//_controllerPhone.text=value;
                              });
                            },
                            validator: (value) {
                              if (value.length != 10) {
                                return "Invalid Mobile";
                              } else {
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              prefixIcon: Icon(Icons.account_circle_outlined,size: 40,),
                              hintText: "Search Your Customer Number",
                              hintStyle: TextStyle(fontSize: 14),
                              border: new OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                                  borderSide:
                                  new BorderSide(color: Colors.black45)),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: ElevatedButton(
                            onPressed: () async {
                              if (widget.formKey.currentState.validate()) {
                                print("Search for:::"+_controllerPhone.text);
                                // widget.searchCustomer(_controllerPhone.text,context);
                                var search= await model.getSearchCustomer(_controllerPhone.text);
                                if(model.searchCustomerList.isNotEmpty){
                                  showDialog(
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (context) {
                                        return AddCustomerDialog(
                                          searchList: model.searchCustomerList,
                                          addCustomer: (value) async {
                                            Navigator.pop(context);
                                            var result = await model.addCustomer(value);
                                            model.getCustomer();

                                          },
                                        );
                                      });
                                }else{
                                  print("No Customer found");
                                  Fluttertoast.showToast(
                                      msg: "No Customer found !",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                }

                              }
                            },
                            child:Padding(
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              child: Text("Submit",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 19,
                                  )),
                            ),


                            style: ElevatedButton.styleFrom(
                                primary: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                  new BorderRadius.circular(10.0),
                                )),
                          ),
                        ),
                      ],
                    ),
                  )),
            ),
          ),
        );
      }),
    );
  }
}

