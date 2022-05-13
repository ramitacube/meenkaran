import 'package:connectone_meenkaran/src/widgets/reminderDialog.dart';
import 'package:connectone_meenkaran/viewModels/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Location extends StatefulWidget {
  const Location({Key key}) : super(key: key);

  @override
  _LocationState createState() => _LocationState();
}

class _LocationState extends State<Location> {
  UserViewModel _userViewModel;
  double remKm = 1.0;
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) =>
        Provider.of<UserViewModel>(context, listen: false).getReminders());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Consumer<UserViewModel>(builder: (contextModel, model, child) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              // height: MediaQuery.of(context).size.height * .14,

              padding: const EdgeInsets.only(left: 0, top: 20, bottom: 25),
              decoration: BoxDecoration(color: Colors.amber),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                          onPressed: () => Navigator.of(context).pop(),
                          icon: Icon(Icons.arrow_back)),
                      Text(
                        "Your Reminders",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 45.0),
                    child: Text("Find Fish at Your Door Step",
                        style: TextStyle(fontSize: 12)),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 22.0),
                  //   child: InkWell(
                  //     onTap: () => print('Get Coordinates'),
                  //     child: Container(
                  //       height: 40,
                  //       width: MediaQuery.of(context).size.width * 08,
                  //       padding:
                  //           EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                  //       margin: EdgeInsets.only(top: 10),
                  //       decoration: BoxDecoration(
                  //           color: Colors.white,
                  //           borderRadius: BorderRadius.all(Radius.circular(5))),
                  //       child: Row(
                  //         children: [
                  //           Icon(Icons.location_on),
                  //           SizedBox(
                  //             width: 10,
                  //           ),
                  //           Container(
                  //             width: MediaQuery.of(context).size.width * 0.65,
                  //             child: Text(
                  //               '',
                  //               overflow: TextOverflow.ellipsis,
                  //               maxLines: 1,
                  //               style:
                  //                   TextStyle(fontSize: 16, color: Colors.grey),
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
            // SizedBox(height: 20),
            Container(
              transform: Matrix4.translationValues(0.0, -10.0, 0.0),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Column(
                children: [
                  model.remindersList.isEmpty
                      ? Container(
                          transform: Matrix4.translationValues(0.0, -10.0, 0.0),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 25.0),
                            child: Center(child: Text('No Reminders')),
                          ),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          itemCount: model.remindersList.length,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (contextModel, index) {
                            return Container(
                              padding: EdgeInsets.symmetric(vertical: 5),
                              margin: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.amber),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.notifications_none, size: 30),
                                    SizedBox(width: 20),
                                    Text('Reminder ${index + 1}',
                                        style: TextStyle(fontSize: 18)),
                                    SizedBox(width: 40),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 5),
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 15),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(25),
                                        border: Border.all(),
                                        color: Colors.white,
                                      ),
                                      child: Text(
                                          '${model.remindersList[index].reminderKm} Km'),
                                    ),
                                    SizedBox(width: 10),
                                    IconButton(
                                        constraints: BoxConstraints(),
                                        iconSize: 26,
                                        onPressed: () {
                                          model.deleteReminders(
                                              model.remindersList[index].id);
                                          // Navigator.pop(context);
                                        },
                                        icon: Icon(Icons.cancel_outlined)),
                                  ]),
                            );
                          }),
                ],
              ),
            ),
            // SizedBox(
            //     height: model.remindersList.length == 1
            //         ? 360
            //         : model.remindersList.length == 2
            //             ? 290
            //             : model.remindersList.length == 3
            //                 ? 215
            //                 : model.remindersList.length == 4
            //                     ? 150
            //                     : 80),
            Spacer(),
            Container(
              margin: EdgeInsets.only(bottom: 15),
              // padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
              // color: Colors.green,
              child: Container(
                // color: Colors.red,
                child: ElevatedButton.icon(
                    icon: Icon(Icons.notifications_none),
                    onPressed: () {
                      showDialog(
                        barrierColor: Colors.transparent,
                        context: context,
                        builder: (context) => ReminderDialog(
                          remKm: remKm,
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 80, vertical: 10),
                      primary: Colors.amber,
                    ),
                    label: Text(
                      "Add Reminder",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    )),
              ),
            ),
          ],
        );
      }),
    );
  }
}
