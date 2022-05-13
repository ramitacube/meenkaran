import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DropDownWidget extends StatelessWidget {
  final String hint;
  final dynamic value;

  final DropdownType type;
  final List<dynamic> list;
  final Function onchange;
  DropDownWidget(
      { this.hint, this.value,  this.list,  this.type, this.onchange});
  @override
  Widget build(BuildContext context) {
    var enableSearch = list.length > 10;

    return Container(
      // color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 8),
      // decoration: BoxDecoration(
      //   borderRadius: BorderRadius.all(Radius.circular(5)),
      //   border: Border.all(color: Colors.grey),
      //   color: Colors.white,
      // ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<dynamic>(
          isExpanded: true,
          icon: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Icons.arrow_drop_down,
              color: Colors.black,
              size: 20,
            ),
          ),
          hint: Padding(
            padding:
                const EdgeInsets.only(left: 26, right: 8, top: 8, bottom: 8),
            child: Text(
              hint,
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
          value: value,
          onChanged: onchange,
          items: list.map((dynamic data) {
            return DropdownMenuItem(
              value: data,
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 26, right: 8, top: 8, bottom: 8),
                child: Text(getText(data)),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  String getText(dynamic data) {
    switch (type) {
      case DropdownType.STRING:
        return "State";
        break;
      case DropdownType.STATE:
      case DropdownType.DISTRICT:
      case DropdownType.TALUK:
      case DropdownType.LOCATION:
      case DropdownType.CATEGORY:
        return data.name;
        break;

      default:
        return data;
    }
  }
}

enum DropdownType { STATE,DISTRICT, STRING, TALUK, LOCATION, CATEGORY }
