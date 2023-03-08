import 'package:bloc/bloc.dart';
import 'package:coffe_app/utils/nav_utils.dart';
import 'package:coffe_app/utils/notification_utils.dart';
import 'package:coffe_app/utils/prefs_utils.dart';
import 'package:coffe_app/view/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  Future<void> login(String pin) async {
    emit(LoginLoading());
    Future.delayed(const Duration(seconds: 2), () {
      if (pin == "2022") {
        Nav.toAll(const HomePage());
        PrefsUtils().save("isLogin", true);
        emit(LoginSuccess('login success'));
      } else {
        NotifUtils.showSnackbar('WRONG PIN, FAILED',
            backgroundColor: Colors.red);
        emit(LoginFailed('login failed'));
      }
    });
  }
}
