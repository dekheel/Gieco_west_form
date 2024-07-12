import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gieco_west/DataLayer/Provider/user_provider.dart';
import 'package:gieco_west/DataLayer/SharedPreferences/shared_preferences.dart';
import 'package:gieco_west/UiLayer/AuthScreens/AuthChecker/auth_checker.dart';
import 'package:gieco_west/UiLayer/AuthScreens/LoginScreen/login_screen.dart';
import 'package:gieco_west/UiLayer/AuthScreens/SignUpScreen/signup_screen.dart';
import 'package:gieco_west/UiLayer/HomeScreen/home_screen.dart';
import 'package:gieco_west/UiLayer/ShiftScreen/shift_screen.dart';
import 'package:gieco_west/UiLayer/SplashScreen/splash_screen.dart';
import 'package:gieco_west/UiLayer/TripScreen/trip_screen.dart';
import 'package:gieco_west/UiLayer/UsersScreen/users_screen.dart';
import 'package:gieco_west/Utils/FireBase/access_firebase_token.dart';
import 'package:gieco_west/Utils/FireBase/firebase_options.dart';
import 'package:gieco_west/Utils/colors.dart';
import 'package:gieco_west/Utils/const.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() async {
  // when we use async in main function to enforce main to wait until future code is done
  WidgetsFlutterBinding.ensureInitialized();
  // await MobileAds.instance.initialize();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseFirestore.instance.settings = const Settings(
    persistenceEnabled: true,
  );

  await FirebaseMessaging.instance.requestPermission();
  await PushNotificationService.requestPermission();
  await PushNotificationService.localNotificationInitialize();

  Provider.debugCheckInvalidValueType = null;

  var user = await SharedPreference.readUserData();

  runApp(Provider(
      create: (_) => UserProvider(newUser: user), child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  initState() {
    notificationHandler();
    super.initState();
  }

  void notificationHandler() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      PushNotificationService.showNotification(message);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.sizeOf(context);
    return ScreenUtilInit(
      minTextAdapt: true,
      designSize: screenSize,
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: Const.appName,
        locale: const Locale("ar"),
        initialRoute: SplashScreen.routeName,
        routes: {
          SplashScreen.routeName: (context) => const SplashScreen(),
          AuthChecker.routeName: (context) => const AuthChecker(),
          LoginPage.routeName: (context) => const LoginPage(),
          SignUpPage.routeName: (context) => const SignUpPage(),
          HomeScreen.routeName: (context) => const HomeScreen(),
          TripScreen.routeName: (context) => const TripScreen(),
          ShiftScreen.routeName: (context) => const ShiftScreen(),
          UsersScreen.routeName: (context) => UsersScreen()
        },
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: const [
          Locale('ar'), // English
        ],
        theme: FlexThemeData.light(
          scaffoldBackground: MyColors.whiteColor,
          scheme: FlexScheme.blueM3,
          textTheme: TextTheme(
              bodyLarge: GoogleFonts.elMessiri(
                textStyle: TextStyle(letterSpacing: .5, fontSize: 16.sp),
              ),
              bodySmall: GoogleFonts.elMessiri(
                textStyle: TextStyle(
                    letterSpacing: .5,
                    fontSize: 14.sp,
                    color: MyColors.whiteColor),
              )),
          // surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
          blendLevel: 7,
          subThemesData: const FlexSubThemesData(
            blendOnLevel: 10,
            blendOnColors: false,
            useTextTheme: true,
            useM2StyleDividerInM3: true,
            alignedDropdown: true,
            useInputDecoratorThemeInDialogs: true,
          ),
          keyColors: const FlexKeyColors(),
          visualDensity: FlexColorScheme.comfortablePlatformDensity,
          useMaterial3: true,
          swapLegacyOnMaterial3: true,
          fontFamily: GoogleFonts.elMessiri().fontFamily,
        ),
        themeMode: ThemeMode.light,
        builder: EasyLoading.init(),
      ),
    );
  }
}
