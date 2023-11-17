import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/auth_bloc.dart';

class FormWidgets {
  Widget buildLoginForm(
    BuildContext context,
    TextEditingController emailController,
    TextEditingController passwordController,
  ) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            "assets/images/logo.webp",
            height: 60.0,
          ),
          const SizedBox(height: 40.0),
          TextFormField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              fontSize: 12.0,
              fontFamily: 'Quicksand',
              fontWeight: FontWeight.w500,
              color: Colors.grey.withOpacity(0.8),
            ),
            decoration: InputDecoration(
              hintText: 'Masukan Username',
              hintStyle: const TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.w600,
                color: Colors.black,
                fontFamily: 'Quicksand',
              ),
              filled: true,
              fillColor: Colors.white,
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(5.0),
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0), // Radius 5px
                borderSide: BorderSide(
                  width: 2.0,
                  color: Colors.pink.shade100,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0), // Radius 5px
                borderSide: const BorderSide(
                  width: 2.0,
                  color: Colors.pink,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10.0),
          TextFormField(
            controller: passwordController,
            keyboardType: TextInputType.visiblePassword,
            obscureText: true,
            style: TextStyle(
              fontSize: 12.0,
              fontFamily: 'Quicksand',
              fontWeight: FontWeight.w500,
              color: Colors.grey.withOpacity(0.8),
            ),
            decoration: InputDecoration(
              hintText: 'Masukan Password',
              hintStyle: const TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.w600,
                color: Colors.black,
                fontFamily: 'Quicksand',
              ),
              filled: true,
              fillColor: Colors.white,
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(5.0),
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0), // Radius 5px
                borderSide: BorderSide(
                  width: 2.0,
                  color: Colors.pink.shade100,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0), // Radius 5px
                borderSide: const BorderSide(
                  width: 2.0,
                  color: Colors.pink,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20.0),
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 46.0,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.pink,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                    onPressed: () {
                      final email = emailController.text;
                      final password = passwordController.text;
                      BlocProvider.of<AuthBloc>(context).add(
                        LoginButtonPressed(email: email, password: password),
                      );
                    },
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
