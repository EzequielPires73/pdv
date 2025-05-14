import 'package:comerciou_pdv/injections.dart';
import 'package:comerciou_pdv/presentation/view_models/auth_view_model.dart';
import 'package:comerciou_pdv/presentation/widgets/button.dart';
import 'package:comerciou_pdv/presentation/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final AuthViewModel authViewModel = injec();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height,
          ),
          padding: const EdgeInsets.all(16),
          alignment: Alignment.center,
          child: Card(
            color: Colors.white,
            child: Container(
              width: double.infinity,
              constraints: BoxConstraints(maxWidth: 448),
              padding: const EdgeInsets.all(24),
              child: Column(
                spacing: 24,
                children: [
                  Image.asset('assets/logo-linear.webp', width: 120),
                  Column(
                    children: [
                      Text(
                        'Fazer Login',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        'Facilite a gestão do seu negócio com a plataforma Comerciou.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  ListenableBuilder(
                    listenable: authViewModel.signin,
                    builder: (context, child) {
                      return Column(
                        spacing: 8,
                        children: [
                          CustomTextField(controller: email, label: 'Email'),
                          CustomTextField(
                            controller: password,
                            label: 'Senha',
                            obscureText: true,
                          ),
                          SizedBox(height: 4),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              InkWell(child: Text('Esqueceu sua senha?')),
                            ],
                          ),
                          SizedBox(height: 4),
                          Button(
                            label: 'Entrar',
                            onPressed:
                                authViewModel.signin.running
                                    ? null
                                    : () => authViewModel.signin.execute({
                                      'email': email.text,
                                      'password': password.text,
                                    }),
                            isLoading: authViewModel.signin.running,
                          ),
                        ],
                      );
                    },
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
