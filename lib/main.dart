import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:severingthing/bloc/language_bloc.dart';
//import 'package:severingthing/common/notification_service.dart';

import 'package:severingthing/common/routes.dart';
import 'package:severingthing/ui/common/color.dart';
import 'package:severingthing/ui/pages/home.page.dart';
import 'package:severingthing/ui/pages/login.page.dart';
import 'package:severingthing/ui/pages/login_biometric.page.dart';
import 'package:severingthing/ui/pages/login_passcode.page.dart';
import 'package:severingthing/ui/widget_tree.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();

    // NotificationService.getInstance().init();
    languageBloc.getLanguage();
  }

  @override
  void dispose() {
    languageBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Locale?>(
        stream: languageBloc.localeStream,
        builder: (_, snapshot) {
          return MaterialApp(
            theme: ThemeData(
                scaffoldBackgroundColor: CustomColors.purpleDark,
                primarySwatch: Colors.blue,
                canvasColor: CustomColors.purpleLight),
            locale: snapshot.data,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            initialRoute: Routes.home,
            localeResolutionCallback: (locale, supportedLocales) {
              print('Locale: $locale . Locales: $supportedLocales');
              if (locale == null) return supportedLocales.first;

              for (final currentLocale in supportedLocales) {
                final isLang =
                    currentLocale.languageCode == locale.languageCode;
                if (isLang) return currentLocale;
              }
              return supportedLocales.first;
            },
            onGenerateTitle: (context) => AppLocalizations.of(context)!.appName,
            routes: {
              Routes.home: (_) =>
                  const WidgetTree(), //const HomePage(screen: Routes.home),
              Routes.index: (_) => const HomePage(screen: Routes.index),
              Routes.chat: (_) => const HomePage(screen: Routes.chat),
              Routes.control: (_) => const HomePage(screen: Routes.control),
              Routes.setting: (_) => const HomePage(screen: Routes.setting),
              Routes.report: (_) => const HomePage(screen: Routes.report),
              Routes.login: (_) => const LoginPage(),
              Routes.signInPasscode: (_) => const LoginPassCodePage(),
              Routes.signInBiometric: (_) => const LoginBiometric(),
            },
          );
        });
  }
}
