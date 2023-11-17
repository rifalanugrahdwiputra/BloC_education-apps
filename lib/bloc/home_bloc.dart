import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import '../state/home_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserLoading()) {
    on<FetchUserData>(_onFetchUserData);
  }

  void _onFetchUserData(FetchUserData event, Emitter<UserState> emit) async {
    try {
      final token = await _getTokenFromSharedPreferences();
      final response = await http.get(
        Uri.parse('https://space-staging.salt.id/api-backend/v1/m/users/me'),
        headers: <String, String>{
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        emit(UserLoaded(userData: responseData));
      } else {
        emit(UserLoadFailure());
        print('Failed to load user data. Status code: ${response.statusCode}');
      }
    } catch (error) {
      emit(UserLoadFailure());
      print('Error fetching user data: $error');
    }
  }

  Future<String> _getTokenFromSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token') ?? '';
  }
}
