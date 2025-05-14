import 'package:comerciou_pdv/injections.dart';
import 'package:comerciou_pdv/presentation/screens/auth/signin_screen.dart';
import 'package:comerciou_pdv/presentation/screens/home/home_screen.dart';
import 'package:comerciou_pdv/presentation/view_models/auth_view_model.dart';
import 'package:flutter/material.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({super.key});

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  final AuthViewModel viewModel = injec<AuthViewModel>();

  @override
  void initState() {
    super.initState();
    viewModel.load.execute();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: viewModel.load,
      builder: (context, child) {
        if (viewModel.load.running) {
          return Center(child: CircularProgressIndicator());
        }
        if (viewModel.load.error) {
          return SigninScreen();
        }
        return HomeScreen();
      },
    );
  }
}
