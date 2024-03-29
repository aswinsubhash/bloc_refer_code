import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:norq_ecom/firebase_options.dart';
import 'package:norq_ecom/services/hive_services/hive_services.dart';
import 'package:norq_ecom/services/navigation_services/navigation.dart';
import 'package:norq_ecom/services/navigation_services/route_names.dart';
import 'package:norq_ecom/utils/console_log.dart';
import 'package:norq_ecom/utils/state_change_observer.dart';

void main() {
  runZonedGuarded<void>(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform);
      await HiveService().initHive();
      await SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

      runApp(const EcomApp());

      if (kDebugMode) {
        Bloc.observer = DebuggableBlocObserver(describeStateChanges: false);
      }
    },
    (error, stack) {
      consoleLog("ECOM_APP_ERROR", error: error.toString(), stackTrace: stack);
    },
  );
}

class EcomApp extends StatelessWidget {
  const EcomApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Ecom App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0XFF2381AA),
          ),
          useMaterial3: true,
        ),
        initialRoute: RouteNames.splash,
        onGenerateRoute: onGenerateAppRoute(
          AppRoutesFactory(),
        ),
      ),
    );
  }
}
