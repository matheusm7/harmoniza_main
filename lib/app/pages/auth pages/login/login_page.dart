import 'dart:math' as math;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:harmoniza_ativos/app/controller/auth%20controller/auth_controller.dart';
import 'package:harmoniza_ativos/app/data/data.dart';
import 'package:harmoniza_ativos/app/pages/auth%20pages/forgot%20password/forgot_password_page.dart';
import 'package:harmoniza_ativos/app/pages/auth%20pages/register/register_page.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      value: 0.0,
      duration: const Duration(
        seconds: 25,
      ),
      upperBound: 1,
      lowerBound: -1,
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final bool _isError = false;
  final String _errorMessage = '';
  bool _isVisible = false;

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthController>(context);

    Future<void> handleLogin() async {
      String email = _emailController.text.trim();
      String password = _passwordController.text.trim();

      showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      );

      Navigator.of(context).pop();

      try {
        await authProvider.login(email, password);
        User? user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          String userUID = user.uid;
          // ignore: use_build_context_synchronously
          Navigator.pushReplacementNamed(context, '/mainPage', arguments: userUID);
        } else {
          // ignore: use_build_context_synchronously
          Navigator.of(context).pop();
        }
      } catch (e) {
        // ignore: use_build_context_synchronously
        showDialog(
          context: context,
          builder: (context) {
            Future.delayed(const Duration(seconds: 2), () {
              Navigator.of(context).pop(true);
            });
            return AlertDialog(
              title: const Text("Erro"),
              content: Text(e.toString()),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text("OK"),
                ),
              ],
            );
          },
        );
      }
    }

    var size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              alignment: Alignment.center,
              children: <Widget>[
                AnimatedBuilder(
                  animation: _controller,
                  builder: (BuildContext context, Widget? child) {
                    return ClipPath(
                      clipper: DrawClip(_controller.value),
                      child: Container(
                        height: size.height * 0.25,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomLeft,
                            end: Alignment.topRight,
                            colors: [const Color.fromARGB(200, 235, 212, 165).withOpacity(0.8), const Color.fromARGB(181, 168, 138, 78).withOpacity(0.8)],
                          ),
                        ),
                      ),
                    );
                  },
                ),
                AnimatedBuilder(
                  animation: _controller,
                  builder: (BuildContext context, Widget? child) {
                    return ClipPath(
                      clipper: DrawClip2(_controller.value),
                      child: Container(
                        height: size.height * 0.29,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomLeft,
                            end: Alignment.topRight,
                            colors: [const Color.fromARGB(213, 231, 201, 140).withOpacity(0.6), const Color.fromARGB(222, 167, 136, 74).withOpacity(0.6)],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Faça o login",
                    style: TextStyle(color: douradoEscuro, fontWeight: FontWeight.bold, fontSize: 30),
                  ),
                  const SizedBox(height: 15),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromRGBO(196, 135, 198, .3),
                          blurRadius: 20,
                          offset: Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(color: Colors.grey),
                            ),
                          ),
                          child: TextField(
                            style: const TextStyle(color: Colors.black),
                            controller: _emailController,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: "E-mail",
                              hintStyle: TextStyle(color: Colors.grey),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(10),
                          child: TextField(
                            style: const TextStyle(color: Colors.black),
                            controller: _passwordController,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                icon: Icon(_isVisible ? Icons.visibility_off : Icons.visibility, color: douradoEscuro),
                                onPressed: () {
                                  setState(() {
                                    _isVisible = !_isVisible;
                                  });
                                },
                              ),
                              border: InputBorder.none,
                              hintText: "Senha",
                              hintStyle: const TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                            obscureText: !_isVisible,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 5),
                  InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const ForgotPasswordPage()));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Esqueceu sua senha?',
                          style: TextStyle(fontWeight: FontWeight.w600, color: douradoEscuro),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: InkWell(
                      onTap: () async {
                        await handleLogin();
                      },
                      child: Container(
                        height: 50,
                        margin: const EdgeInsets.symmetric(horizontal: 50),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: douradoEscuro,
                        ),
                        child: const Center(
                          child: Text(
                            "ENTRAR",
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Não tem uma conta?',
                          style: TextStyle(fontSize: 14),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const RegisterPage(),
                              ),
                            );
                          },
                          child: Text(
                            ' Cadastre-se.',
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: douradoEscuro),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (_isError)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        _errorMessage,
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DrawClip extends CustomClipper<Path> {
  double move = 0;
  double slice = math.pi;
  DrawClip(this.move);

  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height * 0.86);
    double xCenter = size.width * 0.5 + (size.width * 0.6 + 1) * math.sin(move * slice);
    double yCenter = size.height + math.cos(move * slice);
    path.quadraticBezierTo(xCenter, yCenter, size.width, size.height * 0.8);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

class DrawClip2 extends CustomClipper<Path> {
  double move = 0;
  double slice = math.pi;
  DrawClip2(this.move);

  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height * 0.72);
    double xCenter = size.height * 0.9 + (size.height * 1 + 0.2) * math.sin(move * slice);

    double yCenter = size.height + math.cos(move * slice);

    path.quadraticBezierTo(xCenter, yCenter, size.width, size.height * 0.82);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
