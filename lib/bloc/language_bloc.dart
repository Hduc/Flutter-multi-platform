import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:severingthing/bloc/base_bloc.dart';
import 'package:severingthing/reponsitory/language_repository.dart';

class LanguageBloc extends BaseBloc {
  final _repository = LangueRepository();
  final _localeSubject = BehaviorSubject<Locale?>();

  Stream<Locale?> get localeStream => _localeSubject.stream.distinct();

  Future<void> getLanguage() async {
    final language = await _repository.getLanguage();
    if (language != null) {
      _localeSubject.sink.add(Locale(language));
    }
  }

  Future<void> setLanguage(String language) async {
    await _repository.setLanguage(language);
    _localeSubject.sink.add(Locale(language));
  }

  @override
  void dispose() {
    _localeSubject.close();
  }
}

// sử dụng biến languageBloc static thay thế
final languageBloc = LanguageBloc();
