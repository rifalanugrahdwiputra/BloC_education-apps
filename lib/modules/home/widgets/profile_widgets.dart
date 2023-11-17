import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/logout_bloc.dart';
import '../../../event/logout_event.dart';

class ProfileWidget {
  Widget profileInfo(dynamic userData, BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(
          "assets/icons/profiles.png",
          height: 50.0,
        ),
        const SizedBox(width: 10.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${userData['data']['jobTitle']}',
              style: const TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Text(
              '${userData['data']['phoneNumber']}',
              style: const TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
        const SizedBox(width: 40.0),
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              BlocProvider.of<LogoutBloc>(context)
                  .add(LogoutButtonPressed(context: context));
            },
            child: const Text('Logout'),
          ),
        ),
      ],
    );
  }
}
