import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

part '../event/auth_event.dart';
part '../state/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<LoginButtonPressed>(_onLoginButtonPressed);
  }

  Future<void> _onLoginButtonPressed(
      LoginButtonPressed event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final response = await http.post(
        Uri.parse('https://space-staging.salt.id/api-backend/v1/m/auths/login'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, String>{
          // 'email': event.email,
          // 'password': event.password,
          "email": "ops-snp-01@mailinator.com",
          "password": "P@s5word"
        }),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        print(responseData);
        // Save token to Shared Preferences after successful login
        final token = responseData['data']['token']['access'];
        await _saveTokenToSharedPreferences(token);
        // Do something with response data after successful login
        await Future.delayed(Duration(seconds: 2));
        emit(AuthLoggedIn(data: responseData)); // Use the appropriate state
      } else {
        emit(const AuthFailure(error: 'Login gagal')); // State login failed
      }
    } catch (error) {
      emit(AuthFailure(error: 'Terjadi kesalahan: $error'));
    }
  }

  Future<void> _saveTokenToSharedPreferences(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }
}
