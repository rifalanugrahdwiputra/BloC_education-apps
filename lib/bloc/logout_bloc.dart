// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:education_bloc/event/logout_event.dart';
import 'package:education_bloc/state/logout_state.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../modules/auth/login_page.dart';

class LogoutBloc extends Bloc<LogoutEvent, LogoutState> {
  LogoutBloc() : super(LogoutInitial()) {
    on<LogoutButtonPressed>(_onLogoutButtonPressed);
  }

  Future<void> _onLogoutButtonPressed(
      LogoutButtonPressed event, Emitter<LogoutState> emit) async {
    emit(LogoutLoading());
    try {
      await _removeTokenFromSharedPreferences();
      Navigator.of(event.context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    } catch (error) {
      emit(LogoutFailure(error: 'Terjadi kesalahan: $error'));
    }
  }

  Future<void> _removeTokenFromSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }
}
