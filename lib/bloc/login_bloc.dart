import 'package:rxdart/rxdart.dart';

import 'package:severingthing/bloc/base_bloc.dart';
import 'package:severingthing/common/model/text_field_validator.dart';
import 'package:severingthing/common/validator.dart';
import 'package:severingthing/model/login_model.dart';
import 'package:severingthing/reponsitory/login_repository.dart';

class LoginBloc extends BaseBloc with Validator {
  final _repository = LoginRepository();

  final _emailSubject = BehaviorSubject<String>();
  final _passwordSubject = BehaviorSubject<String>();
  final _rePasswordSubject = BehaviorSubject<String>();
  final _surnameSubject = BehaviorSubject<String>();
  final _nameSubject = BehaviorSubject<String>();

  Stream<TextFieldValidator> get emailStream =>
      _emailSubject.stream.transform(checkEmail);

  Stream<TextFieldValidator> get passwordStream =>
      _passwordSubject.stream.transform(checkPass);

  Stream<TextFieldValidator> get rePasswordStream =>
      _rePasswordSubject.stream.transform(checkPass);

  Stream get surNameStream => _surnameSubject.stream;

  Stream<TextFieldValidator> get nameStream =>
      _nameSubject.stream.transform(checkEmpty);

  Stream<bool> get isValidDataLogin =>
      Rx.combineLatest2(emailStream, passwordStream,
          (TextFieldValidator e, TextFieldValidator p) {
        return e.text != null && p.text != null;
      });

  Stream<bool> get isValidDataRegister => Rx.combineLatest4(
          emailStream, passwordStream, rePasswordStream, nameStream,
          (TextFieldValidator e, TextFieldValidator p, TextFieldValidator rp,
              TextFieldValidator n) {
        return e.text != null &&
            p.text != null &&
            rp.text != null &&
            rp.text == p.text &&
            n.text != null;
      });

  Function(String) get changeEmail => _emailSubject.sink.add;
  Function(String) get changePassword => _passwordSubject.sink.add;
  Function(String) get changeRePassword => _rePasswordSubject.sink.add;
  Function(String) get changeSurname => _surnameSubject.sink.add;
  Function(String) get changeName => _nameSubject.sink.add;

  String? get email => _emailSubject.valueOrNull;

  String? get password => _passwordSubject.valueOrNull;
  String? get rePassword => _rePasswordSubject.valueOrNull;
  String? get surname => _surnameSubject.valueOrNull;
  String? get name => _nameSubject.valueOrNull;

  Future<LoginModel?> authenticate() async {
    loading.sink.add(true);

    final token = await _repository.authenticate(_emailSubject.value,
        _passwordSubject.value, _surnameSubject.value, _nameSubject.value);

    loading.sink.add(false);
    return token;
  }

  @override
  void dispose() {
    _emailSubject.close();
    _passwordSubject.close();
    _rePasswordSubject.close();
    _surnameSubject.close();
    _nameSubject.close();

    loading.close();
  }
}

final loginBloc = LoginBloc();
