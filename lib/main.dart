import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:fiestapp/core/routing/router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';

import 'core/services/deep_link_service.dart';
import 'core/services/notification_service.dart';

StreamSubscription<Uri>? _deepLinkSub;

Future<void> main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  final notificationService = NotificationService();
  await notificationService.init();
  notificationService.listenForeground();

  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await dotenv.load(fileName: '.env');
  await initializeDateFormatting('fr_FR', null);

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  final mapboxToken = dotenv.env['MAPBOX_TOKEN'] ?? '';
  MapboxOptions.setAccessToken(mapboxToken);

  await initDeepLinkListener();

  runApp(const ProviderScope(child: MyApp()));
}

Future<void> initDeepLinkListener() async {
  final appLinks = AppLinks();

  final initialUri = await appLinks.getInitialLink();
  if (initialUri != null) {
    pendingDeepLinkUri = initialUri;
  }

  _deepLinkSub?.cancel();
  _deepLinkSub = appLinks.uriLinkStream.listen((uri) {
    pendingDeepLinkUri = uri;

    final fullPath = mapDeepLinkToRoute(uri);
    if (fullPath != null) {
      AppRouter.router.go(fullPath);
    }
  });
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  void dispose() {
    _deepLinkSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();

    return MaterialApp.router(
      title: 'FiestApp',
      routerConfig: AppRouter.router,
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      supportedLocales: const [Locale('fr')],
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        popupMenuTheme: PopupMenuThemeData(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: const BorderSide(color: Color(0xffE15B42), width: 1.5),
          ),
        ),
        textTheme: GoogleFonts.poppinsTextTheme(),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xffE15B42),
          brightness: Brightness.light,
        ),
        timePickerTheme: const TimePickerThemeData(
          backgroundColor: Colors.white,
          hourMinuteTextColor: Color(0xffE15B42),
          dialHandColor: Color(0xffE15B42),
          entryModeIconColor: Color(0xffE15B42),
        ),
        dialogTheme: const DialogThemeData(backgroundColor: Colors.white),
        bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor: Colors.white,
        ),
      ),
    );
  }
}
