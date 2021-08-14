import 'package:rxdart/rxdart.dart';
import 'package:severingthing/bloc/base_bloc.dart';
import 'package:severingthing/common/model/text_field_validator.dart';
import 'package:severingthing/common/validator.dart';
import 'package:severingthing/reponsitory/login_repository.dart';

class PassCodeBloc extends BaseBloc with Validator {
  PassCodeBloc() {
    _pageSubject.sink.add(0);
  }
  final _repository = LoginRepository();

  final _pageSubject = BehaviorSubject<int>();

  final _phoneSubject = BehaviorSubject<String>();
  final _codeSubject = BehaviorSubject<String>();

  Stream<TextFieldValidator> get phoneStream =>
      _phoneSubject.stream.transform(checkNum);

  Stream<TextFieldValidator> get codeStream =>
      _codeSubject.stream.transform(checkPass);

  Stream<bool> get isValidPhone =>
      phoneStream.map((value) => value.text != null);

  Stream<bool> get isValidPasscode =>
      codeStream.map((value) => value.text != null);

  Stream<int> get pageStream => _pageSubject.stream;

  Function(String) get changePhone => _phoneSubject.sink.add;

  Function(String) get changeCode => _codeSubject.sink.add;

  Function(int) get changePage => _pageSubject.sink.add;

  String? get phone => _phoneSubject.valueOrNull;

  int? get page => _pageSubject.value;

  Future<bool> verifyPhone() async {
    loading.sink.add(true);
    final token = await _repository.verifyPhone(_phoneSubject.value);
    loading.sink.add(false);

    return token != null && token.isEmpty;
  }

  Future<bool> verifyCode() async {
    loading.sink.add(true);
    final token = await _repository.verifyCode(_codeSubject.value);
    loading.sink.add(false);

    return token != null && token == 'hduc';
  }

  @override
  void dispose() {
    _phoneSubject.close();
    _codeSubject.close();
    loading.close();
  }
}

final passCodeBloc = PassCodeBloc();
