import 'package:connectone_meenkaran_seller/view_models/base_view_model.dart';
import 'package:connectone_meenkaran_seller/view_models/user_view_model.dart';
import 'package:connectone_meenkaran_seller/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CallLogs extends StatefulWidget {
  const CallLogs({Key key}) : super(key: key);

  @override
  _CallLogsState createState() => _CallLogsState();
}

class _CallLogsState extends State<CallLogs>
with SingleTickerProviderStateMixin{

  TabController _tabController;
  int _tabIndex = 0;
  UserViewModel _homeViewModel;

  @override
  void initState() {
    super.initState();
    _homeViewModel = Provider.of<UserViewModel>(context, listen: false);
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _homeViewModel.getCallLog());
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _homeViewModel.getCallLogReceived());
    _tabController=TabController(length: 2, initialIndex: _tabIndex, vsync: this);
    _tabController.addListener(_handleTabSelection);
  }

  _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      //_controller.myCat = _controller.getMyCategory();
      setState(() {
        _tabIndex = _tabController.index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * .14,
            decoration: BoxDecoration(color: Colors.amber),
            child: Padding(
              padding: const EdgeInsets.only(top: 42, bottom: 6),
              child: ListTile(
                dense: true,
                title: Text("Call Logs",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold)),
                leading: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back)),
              ),
            ),
          ),

          Expanded(
            child: Container(
              transform:  Matrix4.translationValues(0.0, -10.0, 0.0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TabBar(
                            indicatorColor: Colors.amber,
                            controller: _tabController,
                            isScrollable: false,
                            indicatorSize: TabBarIndicatorSize.tab,
                            labelPadding: EdgeInsets.only(
                                left: _tabIndex == 0 ? 5 : 0,
                                right: _tabIndex == 0 ? 0 : 5),
                            indicatorPadding: EdgeInsets.all(0),
                            indicatorWeight: 0,
                            unselectedLabelColor: Colors.black,
                            labelColor: Colors.black,
                            indicator: BoxDecoration(
                                borderRadius: BorderRadius.circular(40),
                                color: Colors.amber),
                            tabs: [
                              Container(
                                width: MediaQuery.of(context).size.height * .25,
                                height: MediaQuery.of(context).size.height * .05,
                                child: Tab(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Color.fromRGBO(12, 13, 52, 0.05),
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text("Dialed "),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.height * .25,
                                height: MediaQuery.of(context).size.height * .05,
                                child: Tab(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Color.fromRGBO(12, 13, 52, 0.05),
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text("Received"),
                                    ),
                                  ),
                                ),
                              ),
                            ]),
                      ),


                      _tabIndex==0 ?

                      Consumer<UserViewModel>(builder: (contextModel, model, child) {
                return model.callLogList.isNotEmpty
                ? ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: model.callLogList.length,
                    itemBuilder: (contextList, index){
                  return ListTile(
                    leading: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Image.asset('assets/images/call.png'),
                      ),
                    ),
                    title: Text(
                        model.callLogList[index].customerId?.name??"",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold)),
                    subtitle: Text(
                        model.callLogList[index].customerId?.phoneNo?? "",
                      style: TextStyle(
                        color: Colors.black,
                      ),),
                    trailing: Column(
                      children: [
                        SizedBox(height: 10),
                        Text(DateFormat("yyyy-MM-dd").format(DateTime.parse(model.callLogList[index].date)),
                            style: TextStyle(
                              color: Colors.black,
                            )),
                        SizedBox(height: 5),
                        Text(DateFormat.jm().format(DateTime.parse(model.callLogList[index].date)),
                            style: TextStyle(
                              color:Colors.black,
                            )),
                        // Icon(Icons.call_received,
                        // color: Colors.green,)
                      ],
                    ),
                  );
                })
                    :model.callLogList.isEmpty
                    ? Container(
                  margin: EdgeInsets.only(top:20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.phone_disabled),
                          SizedBox(width: 20),
                          Text("No call records found"),
                        ],
                      ),
                    )
                :Loading();
                      })
                          : Consumer<UserViewModel>(builder: (contextModel, model, child) {
                        return model.receivedCallList.isNotEmpty
                        ?ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: model.receivedCallList.length,
                            itemBuilder: (contextList, index){
                              return ListTile(
                                leading: Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.amber,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Center(
                                    child: Image.asset('assets/images/call.png'),
                                  ),
                                ),
                                title: Text(
                                    model.receivedCallList[index].customerId?.name??"",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                                subtitle: Text(
                                  model.receivedCallList[index].customerId?.phoneNo?? "",
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),),
                                trailing: Column(
                                  children: [
                                    Text(DateFormat("yyyy-MM-dd").format(DateTime.parse(model.receivedCallList[index].date)),
                                        style: TextStyle(
                                          color: Colors.black,
                                        )),
                                    Text(DateFormat.jm().format(DateTime.parse(model.receivedCallList[index].date)),
                                        style: TextStyle(
                                          color:Colors.black,
                                        )),
                                    // Icon(Icons.call_received,
                                    // color: Colors.green,)
                                  ],
                                ),
                              );
                            })
                        :model.receivedCallList.isEmpty
                            ?Container(
                          margin: EdgeInsets.only(top:20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.phone_disabled),
                              SizedBox(width: 20),
                              Text("No call records found"),
                            ],
                          ),
                        )
                            :Loading();
                      })
                    ],
                  ),
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }


}
