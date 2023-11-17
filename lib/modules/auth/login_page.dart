import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:education_bloc/bloc/auth_bloc.dart';

import '../home/home_page.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: BlocProvider(
        create: (context) => AuthBloc(),
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthLoggedIn) {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const HomeScreen()));
            }
          },
          builder: (context, state) {
            if (state is AuthLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is AuthFailure) {
              return Center(child: Text('Gagal: ${state.error}'));
            } else {
              return _buildLoginForm(
                  context, emailController, passwordController);
            }
          },
        ),
      ),
    );
  }

  Widget _buildLoginForm(
      BuildContext context,
      TextEditingController emailController,
      TextEditingController passwordController) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextField(
            controller: emailController,
            decoration: const InputDecoration(
              labelText: 'Email',
            ),
          ),
          const SizedBox(height: 20.0),
          TextField(
            controller: passwordController,
            decoration: const InputDecoration(
              labelText: 'Password',
            ),
            obscureText: true,
          ),
          const SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: () {
              final email = emailController.text;
              final password = passwordController.text;
              BlocProvider.of<AuthBloc>(context)
                  .add(LoginButtonPressed(email: email, password: password));
            },
            child: const Text('Login'),
          ),
        ],
      ),
    );
  }
}
