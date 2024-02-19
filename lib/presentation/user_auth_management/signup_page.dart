import 'dart:convert';
import 'dart:developer';

import 'package:advocate_project_flutter/blocs/auth_cubit/auth_cubit.dart';
import 'package:advocate_project_flutter/blocs/auth_cubit/auth_state.dart';
import 'package:advocate_project_flutter/main.dart';
import 'package:advocate_project_flutter/presentation/common_widgets/custom_app_bar.dart';
import 'package:advocate_project_flutter/presentation/common_widgets/custom_text_field.dart';
import 'package:advocate_project_flutter/presentation/user_auth_management/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_validator/form_validator.dart';
import 'package:svg_flutter/svg_flutter.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const LoginScreen(),
              ),
            );
          },
          child: const Icon(Icons.arrow_back),
        ),
        title: const Text(
          "Signup",
          style: TextStyle(
              fontFamily: "Abhaya Libre",
              fontWeight: FontWeight.w500,
              fontSize: 30),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SvgPicture.asset(
                  "assets/icons/app_icon.svg",
                  height: 100,
                  width: 100,
                ),
                const SizedBox(
                  height: 50,
                ),
                CustomTextField(
                  labelText: 'Name',
                  hintText: 'Enter your name',
                  controller: _nameController,
                  onChanged: (value) {},
                  inputFormatters: const [],
                  cursorColor: Colors.blue,
                  enabled: true,
                  maxLength: 20,
                  maxLines: 1,
                  formKey: _formKey,
                  required: true,
                  validator: 'name',
                ),
                const SizedBox(height: 16),
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
                  formKey: _formKey,
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
                  formKey: _formKey,
                  required: true,
                  validator: 'password',
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  labelText: 'Phone Number',
                  hintText: 'Enter your phone number',
                  controller: _phoneController,
                  onChanged: (value) {},
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  cursorColor: Colors.blue,
                  enabled: true,
                  maxLength: 10,
                  maxLines: 1,
                  formKey: _formKey,
                  required: true,
                  validator: 'phone',
                ),
                const SizedBox(height: 16),
                Center(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 2,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: _submitForm1,
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor),
                      child: const Text(
                        'Next',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _submitForm1() {
    // Validate the form before navigating to the next screen
    Map<String, dynamic> data = {
      "name": _nameController.text,
      "email": _emailController.text,
      "password": _passwordController.text,
      "phone": {"country_isd_code": "+91", "number": _phoneController.text},
    };
    log(data.toString());
    if (_formKey.currentState?.validate() ?? false) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AddressScreen(
            form1Data: data,
          ),
        ),
      );
    }
  }
}

class AddressScreen extends StatelessWidget {
  final TextEditingController _streetController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _postalCodeController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> form1Data;
  AddressScreen({super.key, required this.form1Data});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) => Scaffold(
        appBar: AppBar(
          title: const Text(
            "Address",
            style: TextStyle(
                fontFamily: "Abhaya Libre",
                fontWeight: FontWeight.w500,
                fontSize: 30),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CustomTextField(
                  labelText: 'Street ',
                  hintText: 'Enter your street',
                  controller: _streetController,
                  onChanged: (value) {},
                  inputFormatters: const [],
                  cursorColor: Colors.blue,
                  enabled: true,
                  maxLength: 20,
                  maxLines: 1,
                  formKey: _formKey,
                  required: true,
                  validator: '',
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  labelText: 'City ',
                  hintText: 'Enter your city',
                  controller: _cityController,
                  onChanged: (value) {},
                  inputFormatters: const [],
                  cursorColor: Colors.blue,
                  enabled: true,
                  maxLength: 20,
                  maxLines: 1,
                  formKey: _formKey,
                  required: true,
                  validator: '',
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  labelText: 'State ',
                  hintText: 'Enter your state',
                  controller: _stateController,
                  onChanged: (value) {},
                  inputFormatters: const [],
                  cursorColor: Colors.blue,
                  enabled: true,
                  maxLength: 20,
                  maxLines: 1,
                  formKey: _formKey,
                  required: true,
                  validator: '',
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  labelText: 'Postal Code ',
                  hintText: 'Enter your postal code',
                  controller: _postalCodeController,
                  onChanged: (value) {},
                  inputFormatters: const [],
                  cursorColor: Colors.blue,
                  enabled: true,
                  maxLength: 10,
                  maxLines: 1,
                  formKey: _formKey,
                  required: true,
                  validator: '',
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  labelText: 'Country ',
                  hintText: 'Enter your country',
                  controller: _countryController,
                  onChanged: (value) {},
                  inputFormatters: const [],
                  cursorColor: Colors.blue,
                  enabled: true,
                  maxLength: 20,
                  maxLines: 1,
                  formKey: _formKey,
                  required: true,
                  validator: '',
                ),
                const SizedBox(height: 16),
                Center(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 2,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () {
                        Map<String, dynamic> addressData = {
                          "street": _streetController.text,
                          "city": _cityController.text,
                          "state": _stateController.text,
                          "postalCode": _postalCodeController.text,
                          "country": _countryController.text,
                        };
                        form1Data["address"] = addressData;
                        log('Collected Data:');
                        log(jsonEncode(form1Data));
                        Navigator.pop(context);
                        context.read<AuthCubit>().onSignup(form1Data);
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor),
                      child: const Text(
                        "Submit",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
