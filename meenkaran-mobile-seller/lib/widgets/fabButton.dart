import 'package:connectone_meenkaran_seller/pages/home.dart';
import 'package:flutter/material.dart';

class FabButton extends StatelessWidget {

  final String title;
  const FabButton({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(left: 30.0),
        child: Container(
          width: 350,
          height: 50.0,
          child: new RawMaterialButton(
            shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
            fillColor: Colors.amber,
            elevation: 0.0,
            child: Text(title,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20)),
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Home()));
            },
          ),
        ),
      ),
    );
  }
}
