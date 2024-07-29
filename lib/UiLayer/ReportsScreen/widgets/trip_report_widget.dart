import 'package:flutter/material.dart';
import 'package:gieco_west/DataLayer/Api/firebase_utils.dart';
import 'package:gieco_west/DataLayer/Database/hive_services.dart';
import 'package:gieco_west/DataLayer/Provider/user_provider.dart';
import 'package:gieco_west/UiLayer/ReportsScreen/widgets/user_report_item.dart';
import 'package:gieco_west/Utils/colors.dart';
import 'package:gieco_west/Utils/const.dart';
import 'package:gieco_west/Utils/my_functions.dart';
import 'package:gieco_west/Utils/widgets/custom_text_form_field.dart';
import 'package:provider/provider.dart';

class TripReportWidget extends StatefulWidget {
  const TripReportWidget({Key? key}) : super(key: key);

  @override
  State<TripReportWidget> createState() => _TripReportWidgetState();
}

class _TripReportWidgetState extends State<TripReportWidget> {
  TextEditingController reportDateCtrl = TextEditingController(text: " ");

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 17.0),
      child: Stack(children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(Const.scaffoldImage),
              fit: BoxFit.fill,
              colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.05),
                BlendMode.dstATop,
              ),
            ),
          ),
        ),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomTextFormField(
                onTap: () async {
                  var selectedDate = await MyFunctions.selectDate(context);
                  if (selectedDate != null) {
                    reportDateCtrl.text =
                        MyFunctions.formatDateString(selectedDate);
                    setState(() {});
                  } else {}
                },
                labelText: "تاريخ التقرير",
                isReadOnly: true,
                controller: reportDateCtrl,
                inputType: TextInputType.datetime,
                suffixIcon: const Icon(
                  Icons.date_range,
                  color: MyColors.blueM3LightPrimary,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: userProvider.currentUser?.role == "admin"
                  ? FutureBuilder(
                      future: FirebaseUtils.getTripReportCollection(
                              reportDateCtrl.text)
                          .get(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (snapshot.connectionState ==
                            ConnectionState.done) {
                          if (snapshot.data == null ||
                              snapshot.data!.docs.isEmpty) {
                            return const Center(
                                child: Text("عفواً لا توجد تقارير"));
                          } else {
                            var data = snapshot.data!.docs
                                .map((doc) => doc.data())
                                .toList();

                            return ListView.builder(
                              itemBuilder: (context, index) {
                                return UserReportItem(
                                  data: data[index],
                                );
                              },
                              itemCount: data.length,
                            );
                          }
                        } else {
                          return const Center(
                              child: Text(
                            "خطأ",
                            style: TextStyle(color: MyColors.blackColor),
                          ));
                        }
                      },
                    )
                  : FutureBuilder(
                      future: HiveService.getInstance()
                          .getTripData("${reportDateCtrl.text}trip"),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (snapshot.connectionState ==
                            ConnectionState.done) {
                          if (snapshot.data == null) {
                            return const Center(
                                child: Text("عفواً لا توجد تقارير"));
                          } else {
                            return ListView.builder(
                              itemBuilder: (context, index) {
                                return UserReportItem(
                                    data: snapshot.data![index]);
                              },
                              itemCount: snapshot.data!.length,
                            );
                          }
                        } else {
                          return const Center(
                              child: Text(
                            "خطأ",
                            style: TextStyle(fontSize: 100),
                          ));
                        }
                      },
                    ),
            ),
          ],
        ),
      ]),
    );
  }
}
