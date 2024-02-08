import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:friend_flow/conts/app_colors.dart';
import 'package:friend_flow/providers/auth_provider.dart';
import 'package:friend_flow/providers/chat_provider.dart';
import 'package:friend_flow/providers/user_provider.dart';
import 'package:friend_flow/views/onboarding_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

import 'conts/app_sizes.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    Logger().i('User granted permission');
  } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
    Logger().i('User granted provisional permission');
  } else {
    Logger().i('User declined or has not accepted permission');
  }
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => AuthProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => UserProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => ChatProvider(),
      )
    ],
    child: const MyApp(),
  ));
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();

  Logger().f("Handling a background message: ${message.messageId}");
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Friend Flow',
      theme: customThemeData,
      home: const OnboardingScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

final ThemeData customThemeData = _buildTheme();

ThemeData _buildTheme() {
  final base = ThemeData.light();
  final baseTextTheme = GoogleFonts.poppinsTextTheme(base.textTheme);
  return base.copyWith(
      scaffoldBackgroundColor: AppColor.kWhite,
      appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          scrolledUnderElevation: 0),
      textTheme: baseTextTheme.copyWith(
        displayLarge: baseTextTheme.displayLarge!.copyWith(
          fontSize: Sizes.title,
          color: AppColor.kBlack,
          fontWeight: FontWeight.w900,
        ),
        displayMedium: baseTextTheme.displayMedium!.copyWith(
          fontSize: Sizes.h1,
          color: AppColor.kBlack,
          fontWeight: FontWeight.w700,
        ),
        displaySmall: baseTextTheme.displaySmall!.copyWith(
          fontSize: Sizes.h2,
          color: AppColor.kBlack,
          fontWeight: FontWeight.w400,
        ),
        headlineSmall: baseTextTheme.headlineSmall!.copyWith(
          fontSize: Sizes.h3,
          color: AppColor.kBlack,
          fontWeight: FontWeight.w500,
        ),
        bodyLarge: baseTextTheme.bodyLarge!.copyWith(
          fontSize: Sizes.bodyLarge,
          fontWeight: FontWeight.w400,
          color: AppColor.kBlack,
        ),
        bodySmall: baseTextTheme.bodySmall!.copyWith(
          fontSize: Sizes.bodySmall,
          fontWeight: FontWeight.w400,
          color: AppColor.kBlack,
        ),
        labelSmall: baseTextTheme.labelSmall!.copyWith(
          height: 19.2 / 12.8,
          fontSize: 12.8,
          color: AppColor.subText,
          fontWeight: FontWeight.w400,
        ),
      ));
}
