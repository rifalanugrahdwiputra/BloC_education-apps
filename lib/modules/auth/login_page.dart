import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:education_bloc/bloc/auth_bloc.dart';

import '../home/home_page.dart';
import 'widgets/form_widgets.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              "assets/images/bg_lg.png",
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: BlocProvider(
          create: (context) => AuthBloc(),
          child: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthLoggedIn) {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const HomeScreen()));
              }
            },
            builder: (context, state) {
              if (state is AuthLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is AuthFailure) {
                return Center(child: Text('Gagal: ${state.error}'));
              } else {
                return FormWidgets().buildLoginForm(
                    context, emailController, passwordController);
              }
            },
          ),
        ),
      ),
    );
  }
}
