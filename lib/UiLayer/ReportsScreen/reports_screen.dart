import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:gieco_west/UiLayer/ReportsScreen/widgets/shift_report_widget.dart';
import 'package:gieco_west/UiLayer/ReportsScreen/widgets/trip_report_widget.dart';
import 'package:gieco_west/Utils/widgets/custom_text_wgt.dart';

import '../../Utils/colors.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  static String routeName = 'ReportsScreen';

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  int selectedIndex = 0;
  late PageController pageController;

  List<Widget> reportWidgets = const [
    TripReportWidget(),
    ShiftReportWidget(),
  ];

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: selectedIndex);
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('التقارير'),
        backgroundColor: MyColors.whiteColor,
        elevation: 0,
      ),
      body: reportWidgets[selectedIndex],
      bottomNavigationBar: CurvedNavigationBar(
        color: MyColors.blueM3LightSecondary,
        backgroundColor: Colors.transparent,
        buttonBackgroundColor: MyColors.blueM3LightSecondary,
        items: const <Widget>[
          CircleAvatar(
            backgroundColor: Colors.transparent,
            child: CustomTextWgt(data: "سفرية", color: MyColors.whiteColor),
          ),
          CircleAvatar(
            backgroundColor: Colors.transparent,
            child: CustomTextWgt(data: "وردية", color: MyColors.whiteColor),
          ),
        ],
        onTap: (index) {
          //Handle button tap
          setState(() {
            selectedIndex = index;
          });
        },
      ),
    );
  }
}
