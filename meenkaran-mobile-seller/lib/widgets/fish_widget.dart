import 'package:connectone_meenkaran_seller/model/fish_model.dart';
import 'package:connectone_meenkaran_seller/model/seller_Item_model.dart';
import 'package:flutter/material.dart';

class FishWidget extends StatefulWidget {
  final FishData fishData;
  final Function onSelect;
  final Function onDeselect;
  final List<SellerItem> sellerItems;
  bool selected;
  FishWidget({Key key, this.fishData,this.onSelect,this.onDeselect,this.sellerItems,this.selected}) : super(key: key);

  @override
  _FishWidgetState createState() => _FishWidgetState();
}


bool selected;
class _FishWidgetState extends State<FishWidget> {


  @override
  void initState() {
    super.initState();
    //getSelected();

  }
  // getSelected(){
  //   widget.sellerItems.forEach((element) {
  //     if(element.itemId.id==widget.fishData.id){
  //       setState(() {
  //         selected=true;
  //       });
  //     }
  //   });
  // }

  @override
  build(BuildContext context)  {
    return Container(
        alignment: Alignment.topCenter,
        margin: EdgeInsets.symmetric(vertical: 8),
        child: ChoiceChip(
          label: Container(
            width: MediaQuery.of(context).size.width * .4,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Center(
                  child: Text(widget.fishData.name,
                    overflow: TextOverflow.clip,
                      style: TextStyle(fontSize: 14,color: Colors.black),)
              ),
            )
          ),
          selectedShadowColor: Colors.black54,
          selected: widget.selected,
          onSelected: (bool value){
            widget.selected = value;
            setState(() {
              if(value){
                widget.onSelect(widget.fishData.id);
              }else{
                widget.onDeselect(widget.fishData.id);
              }
            });
          },
          pressElevation: 15,
          selectedColor: Colors.amber,
        )
    );
  }

}
