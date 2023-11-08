import 'package:flutter/material.dart';
import 'package:harmoniza_ativos/app/data/data.dart';
import 'package:provider/provider.dart';

import '../../../controller/auth controller/auth_controller.dart';
import '../login/login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _isVisible = true;
  bool _isVisible2 = true;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _displayNameController = TextEditingController();
  bool _isError = false;
  String _errorMessage = '';

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
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final authProvider = Provider.of<AuthController>(context);
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
                          ))),
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
                    "Registre-se",
                    style: TextStyle(
                      color: douradoEscuro,
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
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
                        )
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
                            controller: _displayNameController,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: "Nome",
                              hintStyle: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
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
                              focusColor: Colors.red,
                              border: InputBorder.none,
                              hintText: "E-mail",
                              hintStyle: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(color: Colors.grey),
                            ),
                          ),
                          child: TextField(
                            style: const TextStyle(color: Colors.black),
                            controller: _passwordController,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _isVisible ? Icons.visibility_off : Icons.visibility,
                                  color: douradoEscuro,
                                ),
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
                            obscureText: _isVisible,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(10),
                          child: TextField(
                            style: const TextStyle(color: Colors.black),
                            controller: _confirmPasswordController,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _isVisible2 ? Icons.visibility_off : Icons.visibility,
                                  color: douradoEscuro,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _isVisible2 = !_isVisible2;
                                  });
                                },
                              ),
                              border: InputBorder.none,
                              hintText: "Confirme sua senha",
                              hintStyle: const TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                            obscureText: _isVisible2,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: InkWell(
                      onTap: () async {
                        String email = _emailController.text.trim();
                        String password = _passwordController.text.trim();
                        String confirmPassword = _confirmPasswordController.text.trim();
                        String displayName = _displayNameController.text;
                        if (email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text("Erro"),
                                content: const Text("Preencha todos os campos."),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text("OK"),
                                  ),
                                ],
                              );
                            },
                          );
                          return;
                        }
                        if (password != confirmPassword) {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text("Erro"),
                                content: const Text("As senhas não correspondem."),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text("OK"),
                                  ),
                                ],
                              );
                            },
                          );
                          return;
                        }

                        final success = await authProvider.register(email, password, confirmPassword, displayName);
                        if (success) {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text("Registro Concluído"),
                                content: const Text(
                                  "Você foi registrado com sucesso!",
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => const LoginPage(),
                                        ),
                                      );
                                    },
                                    child: const Text(
                                      "OK",
                                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        } else {
                          setState(() {
                            _isError = true;
                            _errorMessage = "Já existe uma conta com este e-mail.";
                          });
                        }
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
                            "Registrar",
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Já é registrado?',
                          style: TextStyle(fontSize: 14),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const LoginPage()),
                            );
                          },
                          child: Text(
                            ' Faça o login.',
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
