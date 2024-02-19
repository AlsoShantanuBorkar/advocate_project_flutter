import 'dart:developer';

import 'package:advocate_project_flutter/blocs/auth_cubit/auth_cubit.dart';
import 'package:advocate_project_flutter/presentation/common_widgets/custom_text_field.dart';
import 'package:advocate_project_flutter/presentation/user_auth_management/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:svg_flutter/svg.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();

  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Login",
          style: TextStyle(
              fontFamily: "Abhaya Libre",
              fontWeight: FontWeight.w500,
              fontSize: 30),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _loginFormKey,
            child: Column(
              children: [
                const SizedBox(height: 50),
                SvgPicture.asset(
                  "assets/icons/app_icon.svg",
                  height: 100,
                  width: 100,
                ),
                const SizedBox(height: 50),
                CustomTextField(
                  labelText: 'Email',
                  hintText: 'Enter your email',
                  controller: _emailController,
                  onChanged: (value) {},
                  inputFormatters: const [],
                  cursorColor: Colors.blue,
                  enabled: true,
                  maxLength: 50,
                  maxLines: 1,
                  formKey: _loginFormKey,
                  required: true,
                  validator: 'email',
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  labelText: 'Password',
                  hintText: 'Enter your password',
                  controller: _passwordController,
                  isPassword: true,
                  onChanged: (value) {},
                  inputFormatters: const [],
                  cursorColor: Colors.blue,
                  enabled: true,
                  maxLength: 30,
                  maxLines: 1,
                  formKey: _loginFormKey,
                  required: true,
                  validator: 'password',
                ),
                const SizedBox(height: 16),
                Center(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 2,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () {
                        Map<String, dynamic> data = {
                          "email": _emailController.text,
                          "password": _passwordController.text,
                        };
                        log(data.toString());
                        if (_loginFormKey.currentState?.validate() ?? false) {
                          context.read<AuthCubit>().onLogin(data);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor),
                      child: const Text(
                        'Submit',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Text("Don\'t have an account?"),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignupScreen()));
                  },
                  child: const Text(
                    "Sign Up",
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _submitForm1() {
    // Validate the form before navigating to the next screen
  }
}
