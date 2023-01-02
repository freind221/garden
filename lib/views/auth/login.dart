import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:slick_garden/utilis/firebase.dart';
import 'package:slick_garden/utilis/widgets/custom_button.dart';
import 'package:slick_garden/utilis/widgets/custom_textfield.dart';
import 'package:slick_garden/views/auth/sign_up.dart';
import 'package:slick_garden/views/chat_screen.dart';

class LoginScreen extends StatefulWidget {
  static String routeName = '/login';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final AuthMethods _authMethods = AuthMethods();
  bool isloading = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Login',
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
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
                    message: "Email",
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
                    message: 'Password',
                    controller: _passwordController,
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
                      bool res = await _authMethods.loginUser(
                          _emailController.text,
                          _passwordController.text,
                          context);
                      // ignore: use_build_context_synchronously
                      Navigator.pushNamed(context, ChatScreen.routeName);
                      if (res) {
                        setState(() {
                          isloading = false;
                        });
                      }
                    },
                    text: 'Log In'),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Dont have an account? '),
                    InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, SignUpScreen.routeName);
                        },
                        child: Text(
                          'SignUp here',
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
    );
  }
}
