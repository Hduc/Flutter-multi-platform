import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:severingthing/bloc/facebook_bloc.dart';

import 'package:severingthing/bloc/login_bloc.dart';
import 'package:severingthing/common/message_service.dart';
import 'package:severingthing/common/model/text_field_validator.dart';
import 'package:severingthing/common/routes.dart';
import 'package:severingthing/common/utils.dart';
import 'package:severingthing/ui/common/color.dart';
import 'package:severingthing/ui/pages/widgets/custom_button.dart';
import 'package:severingthing/ui/pages/widgets/custom_text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void dispose() {
    loginBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return Scaffold(body: LayoutBuilder(builder: (context, constraints) {
      return AnimatedContainer(
          duration: Duration(milliseconds: 500),
          color: CustomColors.purpleLight,
          padding: constraints.maxWidth < 500
              ? EdgeInsets.zero
              : const EdgeInsets.all(30.0),
          child: Center(
            child: Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 30.0, horizontal: 25.0),
              constraints: const BoxConstraints(
                maxWidth: 500,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(localizations.signInText(localizations.homeText)),
                    TextFieldEmail(bloc: loginBloc),
                    TextFieldPassword(bloc: loginBloc),
                    if (true) ...[
                      TextFieldPassword(bloc: loginBloc),
                      TextFieldPassword(bloc: loginBloc),
                    ],
                    SubmitButton(
                      bloc: loginBloc,
                      onSendMessage: _showSnackBar,
                      onGoToScreen: _goToHomeScreen,
                    ),
                    CustomButton(
                      text: localizations
                          .signInText(localizations.signInPasscode),
                      onPress: () => _pushScreen(Routes.signInPasscode),
                      backgroundColor: CustomColors.lightBlue,
                      foregroundColor: CustomColors.white,
                      icon: const Icon(Icons.sms_outlined,
                          color: CustomColors.white),
                    ),
                    CustomButton(
                      text: localizations
                          .signInText(localizations.signInFingerPrint),
                      onPress: () => _pushScreen(Routes.signInBiometric),
                      backgroundColor: CustomColors.darkPurple,
                      foregroundColor: CustomColors.white,
                      icon: const Icon(
                        Icons.fingerprint_outlined,
                        color: CustomColors.white,
                      ),
                    ),
                    CustomButton(
                      text: localizations
                          .signInText(localizations.signInFacebook),
                      onPress: () async {
                        final result = await facebookBloc.authenticate();
                        if (result != null) {
                          _showSnackFacebookBar(result);
                        } else {
                          await _goToHomeScreen();
                        }
                      },
                      backgroundColor: CustomColors.kingBlue,
                      foregroundColor: CustomColors.white,
                      icon: const Icon(Icons.face_outlined,
                          color: CustomColors.white),
                    ),
                  ]),
            ),
          ));
    }));
  }

  void _showSnackBar(String message) => Future.delayed(
        const Duration(microseconds: 100),
        () => MessageService.getInstance().showMessage(context, message),
      );

  void _showSnackFacebookBar(FacebookState state) {
    final localizations = AppLocalizations.of(context)!;
    final String? message;

    switch (state) {
      case FacebookState.inProgress:
        message = localizations.signInFacebookInProgress;
        break;
      case FacebookState.cancelled:
        message = localizations.signInFacebookCancelled;
        break;
      case FacebookState.error:
        message = localizations.signInFacebookError;
        break;
    }

    MessageService.getInstance().showMessage(context, message);
  }

  Future _goToHomeScreen() => Navigator.of(context)
      .pushNamedAndRemoveUntil(Routes.home, (Route<dynamic> route) => false);

  Future<void> _pushScreen(String routeName) =>
      Navigator.of(context).pushNamed(routeName);
}

class TextFieldEmail extends HookWidget {
  const TextFieldEmail({Key? key, required this.bloc}) : super(key: key);

  final LoginBloc bloc;

  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController();

    return StreamBuilder<TextFieldValidator>(
      stream: bloc.emailStream,
      builder: (_, snapshot) {
        final localizations = AppLocalizations.of(context)!;

        controller.value = controller.value.copyWith(text: bloc.email ?? '');

        return CustomTextField(
          textController: controller,
          label: localizations.emailText,
          isRequired: true,
          requiredMessage: localizations.emailRequiredMessage,
          onChange: bloc.changeEmail,
          inputType: TextInputType.emailAddress,
          action: TextInputAction.next,
          errorText: snapshot.hasError
              ? Utils.getTextValidator(
                  context, (snapshot.error as TextFieldValidator?)!.validator)
              : null,
        );
      },
    );
  }
}

class TextFieldPassword extends HookWidget {
  const TextFieldPassword({Key? key, required this.bloc}) : super(key: key);

  final LoginBloc bloc;

  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController();

    return StreamBuilder<TextFieldValidator>(
      stream: bloc.passwordStream,
      builder: (_, snapshot) {
        final localizations = AppLocalizations.of(context)!;

        controller.value = controller.value.copyWith(text: bloc.password ?? '');

        return CustomTextField(
          textController: controller,
          label: localizations.passwordValidation,
          isRequired: true,
          requiredMessage: localizations.passwordRequiredMessage,
          onChange: bloc.changePassword,
          errorText: snapshot.hasError
              ? Utils.getTextValidator(
                  context, (snapshot.error as TextFieldValidator?)!.validator)
              : null,
          hasPassword: true,
        );
      },
    );
  }
}

// class TextFieldRePassword extends HookWidget {
//   const TextFieldRePassword({Key? key, required this.bloc}) : super(key: key);

//   final LoginBloc bloc;

//   @override
//   Widget build(BuildContext context) {
//     final controller = useTextEditingController();

//     return StreamBuilder(
//       builder: (_, snapshot) {
//         final localizations = AppLocalizations.of(context)!;

//         controller.value =
//             controller.value.copyWith(text: bloc.rePassword ?? '');

//         return CustomTextField(
//           textController: controller,
//           hint: localizations.emailPlaceholder,
//           isRequired: true,
//           requiredMessage: localizations.emailRequiredMessage,
//           onChange: bloc.changeEmail,
//           inputType: TextInputType.emailAddress,
//           action: TextInputAction.next,
//           errorText: snapshot.hasError
//               ? Utils.getTextValidator(
//                   context, (snapshot.error as TextFieldValidator?)!.validator)
//               : null,
//         );
//       },
//     );
//   }
// }

// class TextFieldSurname extends HookWidget {
//   const TextFieldSurname({Key? key, required this.bloc}) : super(key: key);

//   final LoginBloc bloc;

//   @override
//   Widget build(BuildContext context) {
//     final controller = useTextEditingController();

//     return StreamBuilder(
//       builder: (_, snapshot) {
//         final localizations = AppLocalizations.of(context)!;
//         controller.value = controller.value.copyWith(text: bloc.surname ?? '');

//         return CustomTextField(
//           textController: controller,
//           hint: localizations.emailPlaceholder,
//           isRequired: true,
//           requiredMessage: localizations.emailRequiredMessage,
//           onChange: bloc.changeEmail,
//           inputType: TextInputType.emailAddress,
//           action: TextInputAction.next,
//           errorText: snapshot.hasError
//               ? Utils.getTextValidator(
//                   context, (snapshot.error as TextFieldValidator?)!.validator)
//               : null,
//         );
//       },
//     );
//   }
// }

class SubmitButton extends StatelessWidget {
  const SubmitButton({
    Key? key,
    required this.bloc,
    required this.onSendMessage,
    required this.onGoToScreen,
  }) : super(key: key);

  final LoginBloc bloc;
  final ValueSetter<String> onSendMessage;
  final VoidCallback onGoToScreen;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: bloc.isValidData,
      builder: (_, isValidSnapshot) {
        final localizations = AppLocalizations.of(context)!;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            children: <Widget>[
              Expanded(
                child: CustomButton(
                  text: localizations.signInButton,
                  onPress: isValidSnapshot.hasData
                      ? () => _onPressButton(context)
                      : null,
                  backgroundColor: CustomColors.lightGreen,
                  foregroundColor: CustomColors.white,
                  icon: const Icon(Icons.send, color: CustomColors.white),
                  direction: IconDirection.right,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _onPressButton(BuildContext context) async {
    final localizations = AppLocalizations.of(context)!;

    final result = await bloc.authenticate();
    if (result) {
      onGoToScreen();
    } else {
      onSendMessage(localizations.userPasswordIncorrectMessage);
    }
  }
}
