import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:severingthing/common/notification_service.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:severingthing/common/routes.dart';
import 'package:severingthing/ui/pages/home.page.dart';
import 'package:severingthing/ui/pages/login.page.dart';
import 'package:severingthing/ui/pages/login_biometric.page.dart';
import 'package:severingthing/ui/pages/login_passcode.page.dart';
import 'package:severingthing/ui/pages/sign_in_options.page.dart';
import 'bloc/language_bloc.dart';

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

    //check init notification vs mobile No init in web
    //NotificationService.getInstance().init();
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
              primaryColor: Colors.teal,
              textTheme: GoogleFonts.notoSansTextTheme(
                Theme.of(context).textTheme,
              ),
            ),
            locale: snapshot.data,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            initialRoute: Routes.signInOptions,
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
              Routes.signInOptions: (_) => const SignInOptionsPage(),
              Routes.signInUserPass: (_) => const LoginPage(),
              Routes.signInPasscode: (_) => const LoginPassCodePage(),
              Routes.signInBiometric: (_) => const LoginBiometric(),
              Routes.home: (_) => const HomePage(),
            },
          );
        });
  }
}

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => MasterDetailBloc(),
//       child: MaterialApp(theme: AppTheme.buildShrineTheme(), home: Layout()),
//     );
//   }
// }
