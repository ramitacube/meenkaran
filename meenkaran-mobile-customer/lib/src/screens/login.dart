import 'package:connectone_meenkaran/src/screens/home.dart';
import 'package:connectone_meenkaran/viewModels/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  const Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String _username = "";
  String _password = "";
  final _formKey = GlobalKey<FormState>();
  bool hidePassword = false;
  bool rem = false;
  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((_) =>
    //     Provider.of<UserViewModel>(context, listen: false).response =
    //         Response.Success);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                                borderRadius:
                                    BorderRadius.all(Radius.circular(100)),
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
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "Invalid Phone Number";
                                } else {
                                  return null;
                                }
                              },
                              onChanged: (value) {
                                _username = value;
                              },
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  labelText: 'Phone Number',
                                  prefixIcon: Icon(Icons.account_box_outlined),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: BorderSide(
                                          color:
                                              Colors.grey.withOpacity(0.9)))),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            height: 60,
                            child: TextFormField(
                              onChanged: (value) {
                                _password = value;
                              },
                              obscureText: hidePassword,
                              obscuringCharacter: '*',
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
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide(
                                    color: Colors.grey.withOpacity(0.9),
                                  ),
                                ),
                                suffixIcon: Padding(
                                    padding: EdgeInsets.only(right: 8),
                                    child: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            hidePassword = !hidePassword;
                                          });
                                        },
                                        color: Theme.of(context).focusColor,
                                        icon: Icon(hidePassword
                                            ? Icons.visibility_off
                                            : Icons.visibility))),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          CheckboxListTile(
                            value: rem,
                            controlAffinity: ListTileControlAffinity.leading,
                            title: Text('Remember Me'),
                            onChanged: (rem) {
                              setState(() {
                                rem = !rem;
                                print(rem);
                              });
                            },
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                var result = await Provider.of<UserViewModel>(
                                        context,
                                        listen: false)
                                    .login(_username, _password);
                                if (result == true) {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Home()));
                                }
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 50.0, vertical: 12),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                child: Center(
                                  child: Text("Login",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                                ),
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                                primary: Colors.amber,
                                shape: RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(10.0),
                                )),
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
