import 'package:app_links/app_links.dart';
import 'package:fiestapp/core/routing/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await dotenv.load(fileName: '.env');
  await initializeDateFormatting('fr_FR', null);

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  String mapboxToken = dotenv.env['MAPBOX_TOKEN'] ?? '';
  MapboxOptions.setAccessToken(mapboxToken);

  runApp(ProviderScope(child: const MyApp()));
}

void initDeepLinkListener(GoRouter router) {
  AppLinks().uriLinkStream.listen((uri) {
    final path = [uri.host, ...uri.pathSegments].join('/');
    final fullPath = '/$path';
    print('➡️ Navigation vers $fullPath');
    router.go(fullPath);
  });
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    initDeepLinkListener(router);

    FlutterNativeSplash.remove();

    return MaterialApp.router(
      title: 'FiestApp',
      routerConfig: router,
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      supportedLocales: [const Locale('fr')],
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        popupMenuTheme: PopupMenuThemeData(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(color: Color(0xffE15B42), width: 1.5),
          ),
        ),
        textTheme: GoogleFonts.poppinsTextTheme(),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color(0xffE15B42),
          brightness: Brightness.light,
        ),
        timePickerTheme: TimePickerThemeData(
          backgroundColor: Colors.white,
          hourMinuteTextColor: Color(0xffE15B42),
          dialHandColor: Color(0xffE15B42),
          entryModeIconColor: Color(0xffE15B42),
        ),
        dialogTheme: DialogThemeData(backgroundColor: Colors.white),
        bottomSheetTheme: BottomSheetThemeData(backgroundColor: Colors.white),
      ),
    );
  }
}
