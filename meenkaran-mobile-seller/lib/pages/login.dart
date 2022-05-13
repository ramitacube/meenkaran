import 'package:connectone_meenkaran_seller/pages/add_fish.dart';
import 'package:connectone_meenkaran_seller/view_models/user_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'home.dart';

class Login extends StatefulWidget {
  const Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String _username = "";
  String _password = "";
  final _formKey = GlobalKey<FormState>();
  bool hidePassword=true;
  bool remeberMe=false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((_) =>
    //     Provider.of<UserViewModel>(context, listen: false).response =
    //         Response.Success);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          height: double.infinity,
          decoration: BoxDecoration(color: Colors.blue.shade50),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 12),
            child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Form(
                            key: _formKey,
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  Container(
                                      width: 200,
                                      height: 200,
                                      decoration: BoxDecoration(
                                        // borderRadius: BorderRadius.all(
                                        //     Radius.circular(200)),
                                        image: DecorationImage(
                                            image: AssetImage(
                                              'assets/images/meenkaranlogo.png',
                                            ),
                                            fit: BoxFit.fill),
                                      )),
                                  SizedBox(
                                    height: 25,
                                  ),
                                  Container(
                                    height: 60,
                                    child: TextFormField(
                                      keyboardType: TextInputType.number,
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return "Invalid Username";
                                        } else {
                                          return null;
                                        }
                                      },
                                      onChanged: (value) {
                                        _username = value;
                                      },
                                      decoration: InputDecoration(
                                          labelText: 'Phone Number',
                                          prefixIcon:
                                              Icon(Icons.account_box_outlined),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              borderSide: BorderSide(
                                                  color: Colors.grey
                                                      .withOpacity(0.9)))),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Container(
                                    height: 60,
                                    child: TextFormField(
                                      obscureText: hidePassword,
                                      onChanged: (value) {
                                        _password = value;
                                      },
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return "Invalid Password";
                                        } else {
                                          return null;
                                        }
                                      },
                                      decoration: InputDecoration(
                                          labelText: 'Password',
                                          prefixIcon: Icon(Icons.lock_outline),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              borderSide: BorderSide(
                                                  color: Colors.grey
                                                      .withOpacity(0.9))),
                                        suffixIcon: Padding(
                                          padding: const EdgeInsets.only(right: 8.0),
                                          child: IconButton(
                                            onPressed: () {
                                              setState(() {
                                                hidePassword = !hidePassword;
                                              });
                                            },
                                            color: Theme.of(context).focusColor,
                                            icon: Icon(hidePassword
                                                ? Icons.visibility
                                                : Icons.visibility_off),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  CheckboxListTile(
                                    value: remeberMe,
                                    controlAffinity:
                                    ListTileControlAffinity.leading,
                                    title:
                                    Text('Remember me.'),
                                    onChanged:(tr){
                                      setState(() {
                                        remeberMe=!remeberMe;
                                      });
                                    },
                                  ),
                                  // TextFormField(
                                  //
                                  //
                                  //   decoration: InputDecoration(
                                  //     //labelText: S.of(context).password,
                                  //     labelStyle:
                                  //     TextStyle(color: Theme.of(context).accentColor),
                                  //     contentPadding: EdgeInsets.all(12),
                                  //     hintText: '••••••••••••',
                                  //     hintStyle: TextStyle(
                                  //         color: Theme.of(context)
                                  //             .focusColor
                                  //             .withOpacity(0.7)),
                                  //     prefixIcon: Icon(Icons.lock_outline,
                                  //         color: Theme.of(context).accentColor),
                                  //
                                  //     border: OutlineInputBorder(
                                  //         borderSide: BorderSide(
                                  //             color: Theme.of(context)
                                  //                 .focusColor
                                  //                 .withOpacity(0.2))),
                                  //     focusedBorder: OutlineInputBorder(
                                  //         borderSide: BorderSide(
                                  //             color: Theme.of(context)
                                  //                 .focusColor
                                  //                 .withOpacity(0.5))),
                                  //     enabledBorder: OutlineInputBorder(
                                  //         borderSide: BorderSide(
                                  //             color: Theme.of(context)
                                  //                 .focusColor
                                  //                 .withOpacity(0.2))),
                                  //   ),
                                  // ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width * 0.8,
                                    height: 50,
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        if (_formKey.currentState.validate()) {

                                          var result =
                                          await Provider.of<UserViewModel>(
                                              context,
                                              listen: false)
                                              .login(_username, _password);
                                          if (result == true) {
                                            Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        AddFish()));
                                          }

                                        }
                                      },
                                      child: Text("Login",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 19,
                                              fontWeight: FontWeight.bold
                                          )),
                                      style: ElevatedButton.styleFrom(
                                          primary: Colors.amber,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10.0),
                                          )),
                                    ),
                                  ),
                                ],
                              ),
                            )),
                      ),
                    ),
          )),
    );
  }
}

