import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:pinput/pin_put/pin_put.dart';

import 'package:severingthing/bloc/passcode_bloc.dart';

import 'package:severingthing/common/message_service.dart';
import 'package:severingthing/common/model/text_field_validator.dart';
//import 'package:severingthing/common/notification_service.dart';
import 'package:severingthing/common/routes.dart';
import 'package:severingthing/common/utils.dart';

import 'package:severingthing/ui/common/color.dart';
import 'package:severingthing/ui/widgets/custom_button.dart';
import 'package:severingthing/ui/widgets/custom_text_field.dart';
import 'package:severingthing/ui/widgets/loading.dart';

class LoginPassCodePage extends StatefulWidget {
  const LoginPassCodePage({Key? key}) : super(key: key);

  @override
  _LoginPassCodePageState createState() => _LoginPassCodePageState();
}

class _LoginPassCodePageState extends State<LoginPassCodePage> {
  final PageController _pageController = PageController();
  @override
  void dispose() {
    passCodeBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _returnPageFromBar,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: CustomColors.white,
        body: Stack(
          children: <Widget>[
            Stack(
              children: <Widget>[
                StreamBuilder<int>(
                  stream: passCodeBloc.pageStream,
                  builder: (_, pageSnapshot) {
                    if (_pageController.hasClients && pageSnapshot.hasData) {
                      if (_pageController.page!.round() != passCodeBloc.page) {
                        _goToPage(passCodeBloc.page!);
                      }
                    }

                    return PageView(
                      controller: _pageController,
                      physics: const NeverScrollableScrollPhysics(),
                      children: <Widget>[
                        FormPhone(
                          bloc: passCodeBloc,
                          onSendMessage: _showSnackBar,
                        ),
                        FormPasscode(
                          bloc: passCodeBloc,
                          onGoToScreen: _goToScreen,
                          onSendMessage: _showSnackBar,
                        ),
                      ],
                    );
                  },
                ),
                Positioned(
                  top: 30,
                  left: 16,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back_ios),
                    onPressed: _returnPage,
                  ),
                ),
              ],
            ),
            StreamBuilder<bool>(
              initialData: false,
              stream: passCodeBloc.isLoading,
              builder: (context, AsyncSnapshot<bool> snapshot) => Offstage(
                offstage: !snapshot.data!,
                child: const Loading(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> _returnPageFromBar() {
    if (passCodeBloc.page == 0) return Future<bool>.value(true);

    passCodeBloc.changePage(0);
    return Future<bool>.value(false);
  }

  void _returnPage() {
    if (passCodeBloc.page == 0) {
      Navigator.of(context).pop();
    } else {
      passCodeBloc.changePage(0);
    }
  }

  void _goToPage(int page) => _pageController.animateToPage(page,
      curve: Curves.easeOut, duration: const Duration(milliseconds: 400));

  void _showSnackBar(String message) =>
      MessageService.getInstance().showMessage(context, message);

  Future<void> _goToScreen() => Navigator.of(context)
      .pushNamedAndRemoveUntil(Routes.home, (Route<dynamic> route) => false);
}

class FormPhone extends HookWidget {
  const FormPhone({Key? key, required this.bloc, required this.onSendMessage})
      : super(key: key);

  final PassCodeBloc bloc;
  final ValueSetter<String> onSendMessage;

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final controller = useTextEditingController();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            localizations.phoneNumberTitle,
            textAlign: TextAlign.center,
            style: const TextStyle(color: CustomColors.darkBlue, fontSize: 20),
          ),
          const SizedBox(height: 50),
          StreamBuilder<TextFieldValidator>(
            stream: bloc.phoneStream,
            builder: (_, snapshot) {
              final localizations = AppLocalizations.of(context)!;
              controller.value = controller.value.copyWith(text: bloc.phone);

              return CustomTextField(
                textController: controller,
                hint: localizations.phoneNumberPlaceholder,
                isRequired: true,
                requiredMessage: localizations.phoneNumberRequired,
                onChange: bloc.changePhone,
                inputType: TextInputType.phone,
                errorText: snapshot.hasError
                    ? Utils.getTextValidator(context,
                        (snapshot.error as TextFieldValidator?)!.validator)
                    : null,
              );
            },
          ),
          const SizedBox(height: 20),
          StreamBuilder<bool>(
            stream: bloc.isValidPhone,
            builder: (_, isValidSnapshot) {
              final localizations = AppLocalizations.of(context)!;

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: CustomButton(
                        text: localizations.verifyButtonText,
                        onPress: isValidSnapshot.hasData
                            ? () => _onPressButton(context)
                            : null,
                        backgroundColor: CustomColors.lightGreen,
                        foregroundColor: CustomColors.white,
                        icon: const Icon(
                          Icons.verified_outlined,
                          color: CustomColors.white,
                        ),
                        direction: IconDirection.right,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Future<void> _onPressButton(BuildContext context) async {
    final localizations = AppLocalizations.of(context)!;
    final result = await bloc.verifyPhone();

    if (result) {
      bloc.changePage(1);
      // await NotificationService.getInstance().showNotification(
      //   localizations.notificationTitle,
      //   localizations.notificationMessage('0000'),
      // );
    } else {
      onSendMessage(localizations.phoneNumberIncorrect);
    }
  }
}

class FormPasscode extends HookWidget {
  const FormPasscode({
    Key? key,
    required this.bloc,
    required this.onSendMessage,
    required this.onGoToScreen,
  }) : super(key: key);

  final PassCodeBloc bloc;
  final ValueSetter<String> onSendMessage;
  final VoidCallback onGoToScreen;

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final controller = useTextEditingController();

    final _decoration = BoxDecoration(
      border: Border.all(color: CustomColors.darkPurple),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            localizations.passcodeTitle,
            textAlign: TextAlign.center,
            style: const TextStyle(color: CustomColors.darkBlue, fontSize: 20),
          ),
          const SizedBox(height: 50),
          PinPut(
            fieldsCount: 4,
            controller: controller,
            onChanged: bloc.changeCode,
            onSubmit: (_) => _onSubmitPin(context),
            submittedFieldDecoration: _decoration.copyWith(
              borderRadius: BorderRadius.circular(20),
            ),
            selectedFieldDecoration: _decoration.copyWith(
              borderRadius: BorderRadius.circular(15),
            ),
            followingFieldDecoration: _decoration.copyWith(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _onSubmitPin(BuildContext context) async {
    final localizations = AppLocalizations.of(context)!;
    final result = await bloc.verifyCode();

    if (result) {
      onGoToScreen();
    } else {
      onSendMessage(localizations.passcodeIncorrect);
    }
  }
}
