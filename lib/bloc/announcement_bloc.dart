import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:education_bloc/state/announcement_state.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class AnnouncementBloc extends Bloc<AnnouncementEvent, AnnouncementState> {
  AnnouncementBloc() : super(AnnouncementLoading()) {
    on<FetchAnnouncementData>(_onFetchAnnouncementData);
  }

  void _onFetchAnnouncementData(
      FetchAnnouncementData event, Emitter<AnnouncementState> emit) async {
    try {
      final token = await _getTokenFromSharedPreferences();
      int page = 1;
      int pageSize = 10;
      final response = await http.get(
        Uri.parse(
            'https://space-staging.salt.id/api-backend/v1/m/announcements?page=$page&pageSize=$pageSize'),
        headers: <String, String>{
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        print(response.body);
        emit(AnnouncementLoaded(announcementData: responseData));
      } else {
        emit(AnnouncementLoadFailure());
        print(
            'Failed to load announcement data. Status code: ${response.statusCode}');
      }
    } catch (error) {
      emit(AnnouncementLoadFailure());
      print('Error fetching user data: $error');
    }
  }

  Future<String> _getTokenFromSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token') ?? '';
  }
}
