

import 'package:flutter/cupertino.dart';

@immutable
sealed class LanguageState {}

final class LanguageInitial extends LanguageState {}
final class LanguageChangeState extends LanguageState {}
final class SaveLanguageState extends LanguageState {}
final class getLanguageState extends LanguageState {}