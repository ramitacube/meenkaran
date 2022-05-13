import 'package:connectone_meenkaran/src/screens/home.dart';
import 'package:connectone_meenkaran/src/widgets/loading.dart';
import 'package:connectone_meenkaran/viewModels/base_view_model.dart';
import 'package:connectone_meenkaran/viewModels/register_view_model.dart';
import 'package:connectone_meenkaran/viewModels/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

// import 'home.dart';

class Register extends StatefulWidget {
  const Register({Key key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  RegisterViewModel _registerViewModel;

  final _formKey = GlobalKey<FormState>();
  bool hideStatus = false;
  bool hidePassword = false;

  void initState() {
    super.initState();
    _registerViewModel = Provider.of<RegisterViewModel>(context, listen: false);
    // WidgetsBinding.instance
    //     .addPostFrameCallback((_) => _registerViewModel.register());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
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
          Expanded(
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
                    Text(
                        "Add your name and phone number to get the road map and alerts at this number."),
                    SizedBox(
                      height: 30,
                    ),
                    Form(
                      key: _formKey,
                      child: Consumer<RegisterViewModel>(
                        builder: (context, model, child) {
                          return (model.response != Response.Success ||
                                  model.response == Response.Success)
                              ? Column(
                                  children: [
                                    TextFormField(
                                      onChanged: (value) {
                                        _registerViewModel.user.username =
                                            value;
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
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(36)),
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
                                        _registerViewModel.user.phoneNumber =
                                            value;
                                        _registerViewModel.user.email =
                                            '$value@customer.com';
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
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(36)),
                                            borderSide: new BorderSide(
                                                color: Colors.black45)),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 12,
                                    ),
                                    TextFormField(
                                      onChanged: (value) {
                                        _registerViewModel.user.password =
                                            value;
                                      },
                                      validator: (value) {
                                        if (value.length < 3) {
                                          return "Invalid Password";
                                        } else {
                                          return null;
                                        }
                                      },
                                      obscureText: hidePassword,
                                      obscuringCharacter: '*',
                                      decoration: InputDecoration(
                                        prefixIcon: Icon(Icons.account_circle),
                                        suffixIcon: Padding(
                                            padding: EdgeInsets.only(right: 8),
                                            child: IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    hidePassword =
                                                        !hidePassword;
                                                  });
                                                },
                                                color: Theme.of(context)
                                                    .focusColor,
                                                icon: Icon(hidePassword
                                                    ? Icons.visibility_off
                                                    : Icons.visibility))),
                                        hintText: "Please Enter Your Password",
                                        border: new OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(36)),
                                            borderSide: new BorderSide(
                                                color: Colors.black45)),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 12,
                                    ),
                                    TextFormField(
                                      onChanged: (value) {
                                        _registerViewModel.user.address = value;
                                      },
                                      decoration: InputDecoration(
                                        prefixIcon: Icon(Icons.account_circle),
                                        hintText: "Please Enter Your Address",
                                        border: new OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(36)),
                                            borderSide: new BorderSide(
                                                color: Colors.black45)),
                                      ),
                                      maxLines: 3,
                                    ),
                                    SizedBox(
                                      height: 12,
                                    ),
                                    CheckboxListTile(
                                      value: model.hidePhone,
                                      controlAffinity:
                                          ListTileControlAffinity.leading,
                                      title:
                                          Text('Hide my number from sellers.'),
                                      onChanged: model.changeHide,
                                    ),
                                    SizedBox(
                                      height: 50,
                                    ),
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: ConstrainedBox(
                                        constraints: BoxConstraints.tightFor(
                                            height: 52, width: double.infinity),
                                        child: ElevatedButton(
                                            onPressed: () async {
                                              print("RegisterPressed");
                                              // print(model.isLoggedIn);
                                              if (_formKey.currentState
                                                  .validate()) {
                                                var result =
                                                    await model.register();
                                                if (result) {
                                                  var details = await model
                                                      .registerUser();
                                                  if (details) {
                                                    var login = await Provider
                                                        .of<UserViewModel>(
                                                      context,
                                                      listen: false,
                                                    ).login(
                                                        _registerViewModel
                                                            .user.phoneNumber,
                                                        _registerViewModel
                                                            .user.password);
                                                    if (login) {
                                                      var initRem =
                                                          await Provider.of<
                                                              UserViewModel>(
                                                        context,
                                                        listen: false,
                                                      ).getInitialReminders();
                                                      if (initRem) {
                                                        Navigator.pushReplacement(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        Home()));
                                                      }
                                                    }
                                                  }
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
                                              "Register",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                            )),
                                      ),
                                    )
                                  ],
                                )
                              : Loading();
                        },
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
  }
}
