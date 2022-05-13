import 'package:connectone_meenkaran/viewModels/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class AddMember extends StatefulWidget {
  const AddMember({Key key}) : super(key: key);

  @override
  _AddMemberState createState() => _AddMemberState();
}

class _AddMemberState extends State<AddMember> {
  final _formKey = GlobalKey<FormState>();
  bool hideStatus = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Consumer<UserViewModel>(
        builder: (context, model, child) {
          return Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * .14,
                decoration: BoxDecoration(color: Colors.amber),
                child: Padding(
                  padding: const EdgeInsets.only(right: 22, top: 20),
                  child: ListTile(
                    leading: IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: Icon(Icons.arrow_back)),
                    title: Text(
                      "Meenkaran",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Text("Find Fish at Your Door Step"),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  transform: Matrix4.translationValues(0.0, -10.0, 0.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 22.0, horizontal: 20),
                    child: Column(
                      children: [
                        Text(
                            "Add name and phone number to get the road map and alerts at this number."),
                        SizedBox(
                          height: 30,
                        ),
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              TextFormField(
                                // controller: TextEditingController(
                                //       text:
                                //           ""),
                                onChanged: (value) {
                                  model.memberData.name = value;
                                },
                                validator: (value) {
                                  if (value.length < 3) {
                                    return "Invalid Name";
                                  } else {
                                    return null;
                                  }
                                },
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.account_circle),
                                  hintText: "Please Enter Your Name",
                                  border: new OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(36)),
                                      borderSide: new BorderSide(
                                          color: Colors.black45)),
                                ),
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              TextFormField(
                                // controller: TextEditingController(
                                //     text: model?.userModel?.user
                                //         ?.phoneNumber ??
                                //         ""),
                                // enabled: !model.isLoggedIn,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                onChanged: (value) {
                                  model.memberData.phoneNo = value;
                                },
                                validator: (value) {
                                  if (value.length != 10) {
                                    return "Invalid Mobile";
                                  } else {
                                    return null;
                                  }
                                },
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.phone),
                                  hintText: "Please Enter Your Mobile",
                                  border: new OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(36)),
                                      borderSide: new BorderSide(
                                          color: Colors.black45)),
                                ),
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              CheckboxListTile(
                                value: model.hidePhone,
                                controlAffinity:
                                    ListTileControlAffinity.leading,
                                title: Text('Hide my number from sellers.'),
                                onChanged: model.changeHide,
                              ),
                              SizedBox(
                                height: 200,
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: ConstrainedBox(
                                  constraints: BoxConstraints.tightFor(
                                      height: 52, width: double.infinity),
                                  child: ElevatedButton(
                                      onPressed: () async {
                                        print("loginPressed");

                                        if (_formKey.currentState.validate()) {
                                          var result = await model.addMember();
                                          if (result) {
                                            model.getMembers();
                                            Navigator.pop(context);
                                          }
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(36.0),
                                        ),
                                        primary: Colors.amber,
                                      ),
                                      child: Text(
                                        "Add Member",
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      )),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
