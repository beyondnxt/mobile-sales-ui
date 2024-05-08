import 'package:flutter/material.dart';
import 'package:lingam/const/app_sreen_size.dart';
import 'package:lingam/controller/attendance_provider.dart';
import 'package:lingam/services/location_services.dart';
import 'package:lingam/widget/custom_elevated_button.dart';
import 'package:provider/provider.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    onInitFun();
  }

  Future<dynamic> onInitFun() async {
    Provider.of<AttendanceProvider>(context, listen: false)
        .getLastAttendanceApi();
    LocationServices().determinePosition().then((val) {
      LocationServices().getUserCurrentLOcation().then((value) {
        print(value);
        print("Hello hello");
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AttendanceProvider>(context);
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Container(
        width: ScreenSize.screenSize!.width,
        height: ScreenSize.screenSize!.height,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(15),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              CircleAvatar(
                radius: 60,
                backgroundColor: Colors.green,
              ),
              Text(
                "Test User",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Container(
                  height: ScreenSize.screenSize!.height * 0.2,
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey.shade200),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                          flex: 2,
                          child: Row(
                            children: [
                              Expanded(
                                  flex: 2,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("Casual Leave (CL)"),
                                      Text("1")
                                    ],
                                  )),
                              VerticalDivider(
                                color: Colors.grey,
                                thickness: 1,
                              ),
                              Expanded(
                                  flex: 2,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("Requested Leave Status"),
                                      Text("Processing ")
                                    ],
                                  ))
                            ],
                          )),
                      Divider(
                        color: Colors.grey,
                        thickness: 1,
                      ),
                      Expanded(
                          flex: 2,
                          child: Row(
                            children: [
                              Expanded(
                                  flex: 2,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("Loss of pay (LOP)"),
                                      Text("1")
                                    ],
                                  )),
                              VerticalDivider(
                                color: Colors.grey,
                                thickness: 1,
                              ),
                              Expanded(
                                  flex: 2,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("Requested Leave"),
                                      Text("3")
                                    ],
                                  ))
                            ],
                          ))
                    ],
                  )),
              SizedBox(
                height: ScreenSize.screenSize!.height * 0.11,
              ),
              Container(
                height: ScreenSize.screenSize!.height * 0.08,
                alignment: Alignment.center,
                child: Row(
                  children: [
                    Expanded(
                        flex: 2,
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [Text("Date"), Text(provider.dateTime)],
                          ),
                        )),
                    VerticalDivider(
                      color: Colors.grey,
                      thickness: 1,
                    ),
                    Expanded(
                        flex: 2,
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [Text("Punch In"), Text(provider.punchInTime)],
                          ),
                        )),
                    VerticalDivider(
                      color: Colors.grey,
                      thickness: 1,
                    ),
                    Expanded(
                        flex: 2,
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [Text("Punch Out"), Text(provider.puchOutTime)],
                          ),
                        ))
                  ],
                ),
              ),
              SizedBox(
                height: ScreenSize.screenSize!.height * 0.08,
              ),
              CustomElevatedButton(
                onTap: () {
                  if (provider.userAlreadyPresent) {
                    provider.checkInApi();
                  } else {
                    provider.checkOutApi();
                  }
                },
                title: provider.userAlreadyPresent ? "Punch Out" : "Punch In",
              )
            ],
          ),
        ),
      ),
    );
  }
}
