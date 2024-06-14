import 'package:chat_app/pages/auth/bloc/auth_bloc.dart';
import 'package:chat_app/pages/auth/ui/sign_in_page.dart';
import 'package:chat_app/pages/auth/ui/widgets/textfield_widget.dart';
import 'package:chat_app/pages/home/ui/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final AuthBloc authBloc = AuthBloc();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        bloc: authBloc,
        listener: (context, state) {
          if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Auth error"),
              ),
            );
          } else if (state is AuthSuccess) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const HomePage(),
              ),
            );
          } else if (state is AuthNavigateToLogin) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SignInPage(),
              ),
            );
          }
        },
        // if else
        builder: (context, state) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(),
                    const Text(
                      'Sign Up',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const TextFieldWidget(
                      text: 'Name',
                      icon: Icons.person,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const TextFieldWidget(
                      text: 'Email',
                      icon: Icons.email,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const TextFieldWidget(
                      text: 'Password',
                      icon: Icons.lock,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        maximumSize: const Size(double.infinity, 60),
                        minimumSize: const Size(double.infinity, 60),
                        elevation: 5,
                      ),
                      onPressed: () {
                        authBloc.add(
                          SignUpEvent(
                            name: nameController.text,
                            email: emailController.text,
                            password: passwordController.text,
                          ),
                        );
                      },
                      child: const Text(
                        "Sign Up",
                        style: TextStyle(
                            fontSize: 23, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const Spacer(),
                    Center(
                        child: TextButton(
                            onPressed: () {
                              authBloc.add(NavigateToLoginEvent());
                            },
                            child: const Text("Sign In")))
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
