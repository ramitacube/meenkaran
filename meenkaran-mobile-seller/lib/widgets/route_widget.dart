import 'package:connectone_meenkaran_seller/model/fish_model.dart';
import 'package:connectone_meenkaran_seller/model/location_model.dart';
import 'package:flutter/material.dart';

class RouteWidget extends StatefulWidget {
  final LocationData locationData;
  final Function onSelect;
  final Function onDeselect;
  bool selected;
  RouteWidget({Key key, this.locationData,this.onSelect,this.onDeselect,this.selected}) : super(key: key);

  @override
  _RouteWidgetState createState() => _RouteWidgetState();
}


class _RouteWidgetState extends State<RouteWidget> {


  @override
  void initState() {
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.topCenter,
        margin: EdgeInsets.symmetric(vertical:8),
        child: ChoiceChip(
          label: Container(
            width: MediaQuery.of(context).size.width * .4,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Center(child: Text(widget.locationData.name,
                overflow: TextOverflow.clip,
                style: TextStyle(fontSize: 14,color: Colors.black),)),
            ),),

          selected: widget.selected,
          onSelected: (bool value){
            widget.selected = value;
            setState(() {
              if(value){
                widget.onSelect(widget.locationData.id);
              }else{
                widget.onDeselect(widget.locationData.id);
              }
            });
          },
          pressElevation: 15,
          selectedColor: Colors.amber,
        )
    );
  }

}
