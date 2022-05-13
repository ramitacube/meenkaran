import 'package:connectone_meenkaran/viewModels/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class AddSellerDialog extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final Function searchCustomer;
  //final List<SearchCustomer> searchList;
  const AddSellerDialog({
    Key key,
    this.formKey,
    this.searchCustomer,
  }) : super(key: key);

  @override
  _AddSellerDialogState createState() => _AddSellerDialogState();
}

class _AddSellerDialogState extends State<AddSellerDialog> {
  TextEditingController _controllerPhone = TextEditingController();
  @override
  Widget build(BuildContext context) {
    print('search: ${widget.searchCustomer}');

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      elevation: 16,
      child: Consumer<UserViewModel>(builder: (contextModel, model, child) {
        return Container(
          decoration: BoxDecoration(
              color: Colors.amber, borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Container(
              child: Form(
                  key: widget.formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topRight,
                          child: InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(30))),
                                  child: Icon(Icons.clear))),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Enter a Valid 10 digit Phone number",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
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
                              prefixIcon: Icon(
                                Icons.account_circle_outlined,
                                size: 40,
                              ),
                              hintText: "Search Your Seller Number",
                              hintStyle: TextStyle(fontSize: 14),
                              border: new OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(36)),
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
                                print("Search for:::" + _controllerPhone.text);
                                await model.searchSeller(_controllerPhone.text);
                                Navigator.pop(context);
                              } else {
                                print("No Seller found");
                                Fluttertoast.showToast(
                                    msg: "No Sellers found !",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                              }
                              // widget.searchCustomer(_controllerPhone.text);
                              // var search= await model.getSearchCustomer(_controllerPhone.text);
                              // if(model.searchCustomerList.isNotEmpty){
                              //   showDialog(
                              //       barrierDismissible: false,
                              //       context: context,
                              //       builder: (context) {
                              //         return AddCustomerDialog(
                              //           searchList: model.searchCustomerList,
                              //           addCustomer: (value) async {
                              //             Navigator.pop(context);
                              //             var result = await model.addCustomer(value);
                              //             model.getCustomer();

                              //           },
                              //         );
                              //       });
                            },
                            child: Text("Submit",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 19,
                                )),
                            style: ElevatedButton.styleFrom(
                                primary: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(10.0),
                                ),
                                padding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 15)),
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
