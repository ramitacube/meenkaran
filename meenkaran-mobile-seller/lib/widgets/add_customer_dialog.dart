import 'package:connectone_meenkaran_seller/model/search_customer_model.dart';
import 'package:flutter/material.dart';

class AddCustomerDialog extends StatefulWidget {

  final Function addCustomer;
  final List<SearchCustomer> searchList;
  const AddCustomerDialog({Key key,this.searchList,this.addCustomer}) : super(key: key);

  @override
  _AddCustomerDialogState createState() => _AddCustomerDialogState();
}

class _AddCustomerDialogState extends State<AddCustomerDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      elevation: 16,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.amber,
            borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 20),
          child: Container(
            height: 200,
            child:Column(
              crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: InkWell(
                            onTap: (){
                              Navigator.pop(context);
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(Radius.circular(30))
                                ),
                                child: Icon(Icons.clear))),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                          "Do you want to add this Customer ?",
                          style: TextStyle(
                              fontSize: 16
                          ),
                        ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(widget.searchList[0].name,style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20
                      ),),
                      SizedBox(
                        height: 10,
                      ),
                      Text(widget.searchList[0].phoneNo,style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20
                      ),),




                      SizedBox(
                        height: 15,
                      ),

                      Align(
                        alignment: Alignment.centerRight,
                        child: ElevatedButton(
                          onPressed: () async {
                              print("USER ADDED SUCCESS FULLY");
                              widget.addCustomer(widget.searchList[0].id);
                              Navigator.pop(context);

                            },
                          child:Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            child: Text("Continue",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 19,
                                )),
                          ),


                          style: ElevatedButton.styleFrom(
                              primary: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                new BorderRadius.circular(10.0),
                              )),
                        ),
                      ),
                    ],
                  ),
                )),
          )
    );

  }
}
