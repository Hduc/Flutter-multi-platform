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
  final _firstNameSubject = BehaviorSubject<String>();
  final _lastNameSubject = BehaviorSubject<String>();

  Stream<TextFieldValidator> get emailStream =>
      _emailSubject.stream.transform(checkEmail);

  Stream<TextFieldValidator> get passwordStream =>
      _passwordSubject.stream.transform(checkPass);

  Stream<TextFieldValidator> get rePasswordStream =>
      _rePasswordSubject.stream.transform(checkPass);

  Stream get firstNameStream => _firstNameSubject.stream;

  Stream<TextFieldValidator> get lastNameStream =>
      _lastNameSubject.stream.transform(checkEmpty);

  Stream<bool> get isValidDataLogin =>
      Rx.combineLatest2(emailStream, passwordStream,
          (TextFieldValidator e, TextFieldValidator p) {
        return e.text != null && p.text != null;
      });

  Stream<bool> get isValidDataRegister => Rx.combineLatest4(
          emailStream, passwordStream, rePasswordStream, lastNameStream,
          (TextFieldValidator e, TextFieldValidator p, TextFieldValidator rp,
              TextFieldValidator ln) {
        return e.text != null &&
            p.text != null &&
            rp.text == p.text &&
            ln.text != null;
      });

  Function(String) get changeEmail => _emailSubject.sink.add;
  Function(String) get changePassword => _passwordSubject.sink.add;
  Function(String) get changeRePassword => _rePasswordSubject.sink.add;
  Function(String) get changeFirstName => _firstNameSubject.sink.add;
  Function(String) get changeLastName => _lastNameSubject.sink.add;

  String? get email => _emailSubject.valueOrNull;

  String? get password => _passwordSubject.valueOrNull;
  String? get rePassword => _rePasswordSubject.valueOrNull;
  String? get firstName => _firstNameSubject.valueOrNull;
  String? get lastName => _lastNameSubject.valueOrNull;

  Future<LoginModel?> authenticate() async {
    loading.sink.add(true);
    final result = await _repository.authenticate(
        _emailSubject.value,
        _passwordSubject.value,
        _firstNameSubject.valueOrNull,
        _lastNameSubject.valueOrNull);
    loading.sink.add(false);
    return result;
  }

  @override
  void dispose() {
    _emailSubject.close();
    _passwordSubject.close();
    _rePasswordSubject.close();
    _firstNameSubject.close();
    _lastNameSubject.close();

    loading.close();
  }
}

final loginBloc = LoginBloc();
