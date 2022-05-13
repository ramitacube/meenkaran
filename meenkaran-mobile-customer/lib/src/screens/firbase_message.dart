import 'package:connectone_meenkaran/main.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class MessageWidget extends StatefulWidget {
  const MessageWidget({Key key}) : super(key: key);

  @override
  _MessageWidgetState createState() => _MessageWidgetState();
}

class _MessageWidgetState extends State<MessageWidget> {

  @override
  void initState() {
    super.initState();
    FirebaseMessaging.onMessage.listen((RemoteMessage message){
      RemoteNotification notification=message.notification;
      AndroidNotification android=message.notification?.android;
      if(notification != null && android !=null){
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channel.description,
              color: Colors.blue,
              playSound: true,
              icon: '@mipmap/ic_launcher'
            )
          )
        );
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("A new open message event done");
      RemoteNotification notification=message.notification;
      AndroidNotification android=message.notification?.android;
      if(notification != null && android !=null){
        showDialog(context: context, builder: (_){
          return AlertDialog(
            title: Text(notification.title),
            content: Text(
              notification.body
            ),
          );
        });
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RawMaterialButton(
          child: Center(child: Text("Click")),
          onPressed: (){
            flutterLocalNotificationsPlugin.show(
                0,
                "Testingg",
                "How u doing",
                NotificationDetails(
                    android: AndroidNotificationDetails(
                        channel.id,
                        channel.name,
                        channel.description,
                        importance: Importance.high,
                        color: Colors.blue,
                        playSound: true,
                        icon: '@mipmap/ic_launcher'
                    )
                )
            );
          }),
    );
  }


}
