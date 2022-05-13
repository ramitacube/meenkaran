import 'package:connectone_meenkaran_seller/pages/home.dart';
import 'package:connectone_meenkaran_seller/pages/launch_screen.dart';
import 'package:connectone_meenkaran_seller/view_models/register_view_model.dart';
import 'package:connectone_meenkaran_seller/view_models/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
      MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => RegisterViewModel()),
            ChangeNotifierProvider(create: (_) => UserViewModel())
          ],
        child: MyApp(),
      ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ShowSplash(),
    );
  }
}

class ShowSplash extends StatefulWidget {
  const ShowSplash({ Key key}) : super(key: key);

  @override
  _ShowSplashState createState() => _ShowSplashState();
}

class _ShowSplashState extends State<ShowSplash> {
  UserViewModel _homeViewModel;
  @override
  void initState() {
    super.initState();

    _homeViewModel = Provider.of<UserViewModel>(context, listen: false);
    Future.delayed(Duration(seconds: 3)).then((value) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LaunchScreen()));
      _homeViewModel.isLoggedIn().then((value) {
        if (value == true) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Home()));
        } else {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => LaunchScreen()));
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: CircularProgressIndicator(),
      ),
      decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage(
              "assets/images/splash.png",
            ),
          )),
    );
  }
}
final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

