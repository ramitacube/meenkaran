import 'package:connectone_meenkaran/viewModels/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class ReminderDialog extends StatefulWidget {
  double remKm;
  ReminderDialog({Key key, this.remKm}) : super(key: key);

  @override
  _ReminderDialogState createState() => _ReminderDialogState();
}

class _ReminderDialogState extends State<ReminderDialog> {
  @override
  Widget build(BuildContext context) {
    // UserViewModel userViewModel;
    return Consumer<UserViewModel>(builder: (contextModel, model, child) {
      return Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          child: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10)),
                    color: Colors.amber,
                  ),
                  padding: EdgeInsets.only(bottom: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.notifications_none_outlined),
                      SizedBox(width: 20),
                      Text(
                        'Setup Reminder',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                Container(
                  transform: Matrix4.translationValues(0.0, -10.0, 0.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Text('When Seller reaches')),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 25,
                            width: 25,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              border: Border.all(),
                              color: Colors.amber,
                            ),
                            child: IconButton(
                              onPressed: () {
                                setState(() {
                                  if (widget.remKm > 0) {
                                    widget.remKm -= 1.0;
                                  }
                                });
                              },
                              icon: Icon(Icons.remove),
                              iconSize: 18,
                              padding: EdgeInsets.all(0),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 5),
                            margin: EdgeInsets.symmetric(horizontal: 15),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              border: Border.all(),
                              color: Colors.white,
                            ),
                            child: Text('${widget.remKm}'),
                          ),
                          Container(
                            height: 25,
                            width: 25,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              border: Border.all(),
                              color: Colors.amber,
                            ),
                            child: IconButton(
                              onPressed: () {
                                setState(() {
                                  widget.remKm += 1.0;
                                });
                              },
                              icon: Icon(Icons.add),
                              iconSize: 16,
                              padding: EdgeInsets.all(0),
                            ),
                          ),
                        ],
                      ),
                      Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Text('before reaching location')),
                      ElevatedButton(
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ))),
                          onPressed: () {
                            model.postReminders(widget.remKm);
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            '  Save  ',
                            style: TextStyle(fontSize: 20),
                          ))
                    ],
                  ),
                )
              ],
            ),
          ));
    });
  }
}
