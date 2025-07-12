import 'package:ezycourse/data/local/shared_prefs.dart';
import 'package:ezycourse/features/community/view/community_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';
import '../repository/auth_repository.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final authRepository = AuthRepository();
  bool _rememberMe = false;

  @override
  void initState() {
    super.initState();
    final savedEmail = SharedPrefs.getString("email");
    final savedPass = SharedPrefs.getString("pass");

    if (savedEmail.isNotEmpty && savedPass.isNotEmpty) {
      setState(() {
        emailController.text = savedEmail;
        passwordController.text = savedPass;
        _rememberMe = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor = const Color(0xFF0A5F66);
    final loginYellow = const Color(0xFFE7F11A);

    return BlocProvider(
      create: (_) => AuthBloc(authRepository),
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  // Logo Box
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.white.withOpacity(0.2)),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.school, color: Colors.white, size: 32),
                            const SizedBox(width: 8),
                            const Text(
                              'ezycourse',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'The Best Online Learning Platform',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.yellowAccent,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),

                  // Sign In Box
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: backgroundColor.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.black12),
                    ),
                    child: BlocConsumer<AuthBloc, AuthState>(
                        listener: (context, state) {
                          if (state is LoginFailure) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(state.error)),
                            );
                          } else if (state is LoginInitial) {
                            // This means login succeeded and loading is stopped
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (_) => CommunityPage()), // change to your next screen
                            );
                          }
                        },
                      builder: (context, state) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const Text(
                              'Sign In',
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 24),
                            TextField(
                              controller: emailController,
                              style: const TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                labelText: 'Email',
                                labelStyle: const TextStyle(color: Colors.white),
                                filled: true,
                                fillColor: Colors.white.withOpacity(0.1),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            TextField(
                              controller: passwordController,
                              obscureText: true,
                              style: const TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                labelText: 'Password',
                                labelStyle: const TextStyle(color: Colors.white),
                                filled: true,
                                fillColor: Colors.white.withOpacity(0.1),
                                suffixIcon: const Icon(Icons.visibility, color: Colors.white),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                Checkbox(
                                  value: _rememberMe,
                                  onChanged: (value) {
                                    setState(() {
                                      _rememberMe = value!;
                                    });
                                  },
                                  side: const BorderSide(color: Colors.white),
                                ),
                                const Text(
                                  'Remember me',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                            const SizedBox(height: 24),
                            state is LoginLoading
                            ? Center(
                              child: SizedBox(
                                height: 50,
                                  width: 50,
                                  child: const CircularProgressIndicator()),
                            ) :
                            SizedBox(
                              height: 50,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: loginYellow,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                onPressed: () {
                                  final email = emailController.text;
                                  final pass = passwordController.text;

                                  if (_rememberMe) {
                                    SharedPrefs.setString("email", email);
                                    SharedPrefs.setString("pass", pass);
                                  } else {
                                    SharedPrefs.remove("email");
                                    SharedPrefs.remove("pass");
                                  }

                                  context.read<AuthBloc>().add(LoginButtonPressed(email, pass));
                                },
                                child: const Text(
                                  'Login',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      }
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}



