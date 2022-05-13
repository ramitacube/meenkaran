import 'package:connectone_meenkaran/viewModels/register_view_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'src/screens/launchScreen.dart';
import 'src/screens/home.dart';
import 'viewModels/user_view_model.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    flutterLocalNotificationsPlugin.show(
      0,
      message.notification.title,
      message.notification.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
            channel.id, channel.name, channel.description,
            importance: Importance.max,
            color: Colors.amber,
            sound: RawResourceAndroidNotificationSound('notification'),
            // RawResourceAndroidNotificationSound(sound.split('.').first),
            playSound: true,
            enableVibration: true,
            priority: Priority.high,
            icon: '@mipmap/ic_launcher'),
      ),
    );
  });
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true, badge: true, sound: true);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserViewModel()),
        ChangeNotifierProvider(create: (_) => RegisterViewModel()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'Meenkaran',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: ShowSplash(),
    );
  }
}

class ShowSplash extends StatefulWidget {
  const ShowSplash({Key key}) : super(key: key);

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
      _homeViewModel.isLogIn().then((value) {
        if (value == true) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Home()));
        } else {
          Navigator.pushReplacement(
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
        fit: BoxFit.cover,
        image: AssetImage(
          "assets/images/splash.png",
        ),
      )),
    );
  }
}

final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();
const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel',
    'High Important Notifications',
    'This channel is used for important notifications',
    importance: Importance.high,
    sound: RawResourceAndroidNotificationSound('notification'),
    playSound: true);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("BG message just showed up: ${message.messageId}");
}
