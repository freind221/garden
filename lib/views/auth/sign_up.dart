import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:slick_garden/utilis/firebase.dart';
import 'package:slick_garden/utilis/widgets/custom_button.dart';
import 'package:slick_garden/utilis/widgets/custom_textfield.dart';
import 'package:slick_garden/views/auth/login.dart';
import 'package:slick_garden/views/chat_screen.dart';

class SignUpScreen extends StatefulWidget {
  static String routeName = '/signup';
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _userController = TextEditingController();

  bool isloading = false;

  final formKey = GlobalKey<FormState>();

  final AuthMethods authMethods = AuthMethods();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Sign up',
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: size.height * 0.1),
                  const Text(
                    'Email',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: CustomTextField(
                      controller: _emailController,
                      message: 'Email',
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Username',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: CustomTextField(
                      controller: _userController,
                      message: 'Username',
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Password',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: CustomTextField(
                      controller: _passwordController,
                      message: 'Password',
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomButton(
                      loading: isloading,
                      onTap: () async {
                        setState(() {
                          isloading = true;
                        });
                        if (formKey.currentState!.validate()) {
                          bool res = await authMethods.signupUser(
                              _emailController.text,
                              _passwordController.text,
                              _userController.text,
                              ChatScreen.routeName,
                              context);

                          if (res) {
                            // ignore: use_build_context_synchronously
                            //Navigator.pushNamed(context, MenuScreen.routeName);
                            setState(() {
                              isloading = false;
                            });
                          } else {
                            setState(() {
                              res = false;
                            });
                          }
                        }
                      },
                      text: 'Sign up'),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Already have an account? '),
                      InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, LoginScreen.routeName);
                          },
                          child: Text(
                            'Login here',
                            style: GoogleFonts.abel(
                                textStyle: const TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold)),
                          ))
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
