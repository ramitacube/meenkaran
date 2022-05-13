import 'package:connectone_meenkaran/src/widgets/drawer_widget.dart';
import 'package:connectone_meenkaran/src/widgets/header_widget.dart';
import 'package:connectone_meenkaran/src/widgets/loading.dart';
import 'package:connectone_meenkaran/src/widgets/member_widget.dart';
import 'package:connectone_meenkaran/viewModels/base_view_model.dart';
import 'package:connectone_meenkaran/viewModels/user_view_model.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'add_member.dart';
import 'launchScreen.dart';

class Profiles extends StatefulWidget {
  const Profiles({Key key}) : super(key: key);

  @override
  _ProfilesState createState() => _ProfilesState();
}

final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

class _ProfilesState extends State<Profiles> {
  UserViewModel _userViewModel;
  @override
  void initState() {
    super.initState();
    _userViewModel = Provider.of<UserViewModel>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => Provider.of<UserViewModel>(context, listen: false).getProfile());
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => Provider.of<UserViewModel>(context, listen: false).getMembers());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: Consumer<UserViewModel>(builder: (contextModel, model, child) {
        return DrawerWidget(
          name: model.userModel.user.username,
          logOut: () {
            model.logout();
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => LaunchScreen()),
                (Route<dynamic> route) => false);
          },
        );
      }),
      body: Consumer<UserViewModel>(builder: (context, model, child) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 42, left: 20, right: 20),
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HeaderWidget(
                    parentScaffold: scaffoldKey,
                    name: model.userModel.user.username,
                    mobile: model.userModel.user.phoneNumber,
                    onChange: () {
                      model.logout();
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LaunchScreen()),
                          (Route<dynamic> route) => false);
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 1,
                    height: 1,
                    color: Colors.grey[350],
                  ),
                  SizedBox(height: 25),
                  Padding(
                    padding: const EdgeInsets.only(left: 2.0, bottom: 10),
                    child: Text('My Profile',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.amber.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 5), // changes position of shadow
                        ),
                      ],
                    ),
                    margin: EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25),
                              topRight: Radius.circular(25),
                            ),
                            color: Colors.amber,
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal: 25, vertical: 25),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset(
                                'assets/images/userBox.png',
                                height: 45,
                                width: 45,
                              ),
                              SizedBox(width: 20),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    child: Text(
                                        model.userModel.user.username ?? "",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                  Container(
                                    child:
                                        Text(model.userModel.user.address ?? "",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                            )),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 25, vertical: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(model.userModel.user.phoneNumber ?? "",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(height: 5),
                              Text('Mobile',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 12))
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 25),
                  Padding(
                    padding: const EdgeInsets.only(left: 2.0, top: 10),
                    child: Text('My Members',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
                  ),
                  model.response == Response.Success &&
                          model.memberList != null &&
                          model.memberList.isNotEmpty
                      ? ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: model.memberList.length,
                          itemBuilder: (contextList, index) {
                            return MemberWidget(
                              data: model.memberList[index],
                            );
                          })
                      : model.response == Response.Success &&
                              model.memberList.isEmpty
                          ? Container(
                              child: Center(
                                child: Text("No Members"),
                              ),
                            )
                          : Loading(),
                  InkWell(
                    onTap: () => Navigator.push(context,
                        MaterialPageRoute(builder: (context) => AddMember())),
                    child: Container(
                      margin: EdgeInsets.fromLTRB(10, 20, 10, 10),
                      child: DottedBorder(
                        dashPattern: [6, 5],
                        strokeWidth: 1,
                        borderType: BorderType.RRect,
                        radius: Radius.circular(12),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 20),
                          decoration: BoxDecoration(color: Color(0xffECF6FF)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Image.asset('assets/images/user_add.png'),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: 15.0),
                                    child: Text('Add Members',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 15.0),
                                    child: Text('Register friends and family',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 12,
                                        )),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
