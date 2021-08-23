import 'package:rxdart/rxdart.dart';

import 'package:severingthing/bloc/base_bloc.dart';
import 'package:severingthing/common/model/text_field_validator.dart';
import 'package:severingthing/common/validator.dart';
import 'package:severingthing/reponsitory/login_repository.dart';

class LoginBloc extends BaseBloc with Validator {
  final _repository = LoginRepository();

  final _emailSubject = BehaviorSubject<String>();
  final _passwordSubject = BehaviorSubject<String>();

  Stream<TextFieldValidator> get emailStream =>
      _emailSubject.stream.transform(checkEmail);

  Stream<TextFieldValidator> get passwordStream =>
      _passwordSubject.stream.transform(checkPass);

  Stream<bool> get isValidData => Rx.combineLatest2(emailStream, passwordStream,
          (TextFieldValidator e, TextFieldValidator p) {
        return e.text != null && p.text != null;
      });

  Function(String) get changeEmail => _emailSubject.sink.add;
  Function(String) get changePassword => _passwordSubject.sink.add;

  String? get email => _emailSubject.valueOrNull;

  String? get password => _passwordSubject.valueOrNull;

  Future<bool> authenticate() async {
    loading.sink.add(true);

    final token =
        await _repository.sendData(_emailSubject.value, _passwordSubject.value);

    loading.sink.add(false);

    //return token != null && token.username == 'hduc';
    return true;
  }

  @override
  void dispose() {
    _emailSubject.close();
    _passwordSubject.close();

    loading.close();
  }
}

final loginBloc = LoginBloc();
