import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:gieco_west/DataLayer/Api/firebase_utils.dart';
import 'package:gieco_west/DataLayer/Provider/user_provider.dart';
import 'package:gieco_west/UiLayer/AuthScreens/LoginScreen/login_screen.dart';
import 'package:gieco_west/UiLayer/Drawer/drawer.dart';
import 'package:gieco_west/UiLayer/HomeScreen/widgets/home_item.dart';
import 'package:gieco_west/UiLayer/ShiftScreen/shift_screen.dart';
import 'package:gieco_west/UiLayer/TripScreen/trip_screen.dart';
import 'package:gieco_west/Utils/colors.dart';
import 'package:gieco_west/Utils/const.dart';
import 'package:gieco_west/Utils/dialog_utils.dart';
import 'package:gieco_west/Utils/my_functions.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static String routeName = "HomeScreen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    handleData();
    super.initState();
  }

  Future<void> handleData() async {
    var trainCap = await FirebaseUtils.getTrainCap();
    var trainConductor = await FirebaseUtils.getTrainConductor();
    var trainTypeList = await FirebaseUtils.getTrainTypeList();

    if (trainCap.data() != null) {
      Const.trainCap.addAll(trainCap.data());

      Const.trainCap = MyFunctions.sortMap(Const.trainCap);
    }
    if (trainConductor.data() != null) {
      Const.trainConductor.addAll(trainConductor.data());
      Const.trainConductor = MyFunctions.sortMap(Const.trainConductor);
    }

    if (trainTypeList.data() != null) {
      Const.trainTypeList = [
        ...Const.trainTypeList,
        ...?trainTypeList.data()!["trainTypeList"]
      ];
      Const.trainTypeList.sort(
        (a, b) {
          return a.compareTo(b);
        },
      );
    }

    var snapShots = await FirebaseUtils.fetchAdminTokens();
    if (snapShots.docs.isNotEmpty) {
        Provider.of<UserProvider>(context, listen: false).adminTokens =
            snapShots.docs.map((e) => e.data()).toList();

    }
  }

  DateTime? lastPressedAt;

  bool canPop = false;

  Future<bool> onWillPop() async {
    DateTime now = DateTime.now();
    if (lastPressedAt == null ||
        now.difference(lastPressedAt!) > const Duration(seconds: 2)) {
      // Show toast
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'اضغط رجوع مرة أخرى للخروج',
            style: TextStyle(color: Colors.white),
          ),
          duration: Duration(seconds: 2),
        ),
      ); // Update the last pressed time
      lastPressedAt = now;
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return PopScope(
      canPop: canPop,
      onPopInvoked: (bool value) {
        setState(() {
          canPop = !value;
        });

        if (canPop) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("اضغط رجوع مرة أخرى للخروج"),
              duration: Duration(milliseconds: 1500),
            ),
          );
        }
      },
      child: Scaffold(
        drawer: const MyDrawer(),
        appBar: AppBar(
          centerTitle: true,
          title: const Text("تشغيل البضائع غرب الدلتا"),
          backgroundColor: Colors.transparent,
          actions: [
            IconButton(
                onPressed: () {
                  DialogUtils.showMessage(
                      context: context,
                      content: "تأكيد تسجيل الخروج ؟",
                      isDismissible: false,
                      posActions: "نعم",
                      negActions: "لا",
                      title: "تسجيل الخروج",
                      negFunction: (context) {
                        Navigator.of(context).pop();
                      },
                      posFunction: (context) async {
                        await FirebaseAuth.instance.signOut();
                        Navigator.of(context).pop();
                        Navigator.of(context)
                            .pushReplacementNamed(LoginPage.routeName);
                      });
                },
                icon: const Icon(
                  Icons.logout_outlined,
                  color: MyColors.blueM3LightPrimary,
                ))
          ],
        ),
        body: Theme(
          data: Theme.of(context).copyWith(
              colorScheme: const ColorScheme.light(
                  primary: MyColors.blueM3DarkPrimaryContainer)),
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
            Container(
              padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 10.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // AdManager.bannerAd != null
                  //     ? SizedBox(
                  //         width: size.width,
                  //         height: 100.h,
                  //         child: AdWidget(ad: AdManager.bannerAd!))
                  //     : const SizedBox.shrink(),
                  const Spacer(),
                  Gap(10.h),
                  HomeItem(
                    routeName: TripScreen.routeName,
                  ),
                  Gap(50.h),
                  HomeItem(
                    routeName: ShiftScreen.routeName,
                  ),
                  const Spacer(),
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }
}
