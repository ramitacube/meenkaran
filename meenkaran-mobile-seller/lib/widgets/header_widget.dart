import 'package:connectone_meenkaran_seller/pages/launch_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HeaderWidget extends StatefulWidget {
  final GlobalKey<ScaffoldState> parentScaffold;
  final String name;
  final String mobile;
  final Function onChange;

  const HeaderWidget(
      {Key key, this.parentScaffold, this.name, this.mobile, this.onChange})
      : super(key: key);

  @override
  _HeaderWidgetState createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends State<HeaderWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: () {
            widget.parentScaffold?.currentState?.openDrawer();
          },
          child: Container(
            width: 40,
            height: 40,
            padding: EdgeInsets.only(top: 5),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black12),
              borderRadius: BorderRadius.all(Radius.circular(80)),
            ),
            child: Image(
              image: AssetImage('assets/images/menu.png'),
            ),
          ),
        ),
        SizedBox(
          width: 20,
        ),
        Container(
          width: 40,
          height: 40,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.amber,
            borderRadius: BorderRadius.all(Radius.circular(80)),
          ),
          child: Image(
            image: AssetImage('assets/images/user.png'),
          ),
        ),
        SizedBox(
          width: 20,
        ),
        Container(
          width: MediaQuery.of(context).size.width * .4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.name,
                overflow: TextOverflow.visible,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                widget.mobile,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 25),
          width: 40,
          height: 40,
          child: FloatingActionButton(
            onPressed: () {
              showDialog(
                barrierDismissible: false,
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("Logout"),
                      content: Text("Would you like to continue to logout?"),
                      actions: [
                        MaterialButton(
                          child: Text("Cancel"),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        MaterialButton(
                          child: Text("Continue"),
                          onPressed: () {
                            Navigator.pop(context);
                            widget.onChange();
                          },
                        )
                      ],
                    );
                  });
            },
            backgroundColor: Colors.white,
            child: Container(
                width: 25,
                height: 25,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(100)),
                  image: DecorationImage(
                      image: AssetImage(
                        'assets/images/signin.png',
                      ),
                      fit: BoxFit.fill),
                )),
          ),
        )
      ],
    );
  }
}
