import 'package:connectone_meenkaran/src/screens/launchScreen.dart';
import 'package:connectone_meenkaran/src/widgets/AddSellerDialog.dart';
import 'package:connectone_meenkaran/src/widgets/drawer_widget.dart';
import 'package:connectone_meenkaran/src/widgets/header_widget.dart';
import 'package:connectone_meenkaran/src/widgets/loading.dart';
import 'package:connectone_meenkaran/src/widgets/seller_widget.dart';
import 'package:connectone_meenkaran/viewModels/base_view_model.dart';
import 'package:connectone_meenkaran/viewModels/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
final formKey = GlobalKey<FormState>();

class _HomeState extends State<Home> {
  UserViewModel _userViewModel;
  @override
  void initState() {
    super.initState();
    _userViewModel = Provider.of<UserViewModel>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => Provider.of<UserViewModel>(context, listen: false).getUser());
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
      body: SingleChildScrollView(
        child: Consumer<UserViewModel>(builder: (context, model, child) {
          return Padding(
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
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 25.0, vertical: 10.0),
                          child: Text('My sellers',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold)),
                        ),
                        Consumer<UserViewModel>(
                            builder: (context, model, child) {
                          return model.response == Response.Success &&
                                  model.sellersList != null &&
                                  model.sellersList.isNotEmpty
                              ? ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  padding: EdgeInsets.all(0),
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: model.sellersList.length,
                                  itemBuilder: (contextList, index) {
                                    return SellerWidget(
                                        sellersList: model.sellersList[index],
                                        index: index);
                                  })
                              : model.response == Response.Success &&
                                      model.sellersList.isEmpty
                                  ? Container(
                                      child: Center(
                                        child: Text("No Sellers"),
                                      ),
                                    )
                                  : Loading();
                        }),
                        SizedBox(height: 30),
                        InkWell(
                          onTap: () {
                            showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (context) {
                                  return AddSellerDialog(
                                    formKey: formKey,
                                  );
                                });
                          },
                          child: Container(
                            margin: EdgeInsets.only(
                                left: 10, right: 10, bottom: 10),
                            child: DottedBorder(
                              dashPattern: [6, 5],
                              strokeWidth: 1,
                              borderType: BorderType.RRect,
                              radius: Radius.circular(12),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 20),
                                // margin: EdgeInsets.only(bottom: 10),
                                decoration:
                                    BoxDecoration(color: Color(0xffECF6FF)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Image.asset('assets/images/user_add.png'),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(left: 15.0),
                                          child: Text('Add Sellers',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 15.0),
                                          child: Text(
                                              'Add Your New Seller’s Number',
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
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
