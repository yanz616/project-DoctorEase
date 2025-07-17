import 'package:doctor_ease_fe/data/models/user/request/auth_request.dart';
import 'package:doctor_ease_fe/presentation/auth/blocs/auth_bloc.dart';
import 'package:doctor_ease_fe/presentation/auth/blocs/auth_event.dart';
import 'package:doctor_ease_fe/presentation/auth/blocs/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordConfirmationController = TextEditingController();

  void _showSnackBar(
    BuildContext context,
    String message, {
    bool error = false,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),

        backgroundColor: error ? Colors.red : Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Register')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthFailure) {
              _showSnackBar(context, state.error, error: true);
            }
            if (state is AuthSuccessResponse) {
              _showSnackBar(context, state.response.message);
              // Navigasi ke halaman login atau home jika perlu
              // Navigator.pushReplacementNamed(context, '/login');
            }
          },
          builder: (context, state) {
            if (state is AuthLoading) {
              return Center(child: CircularProgressIndicator());
            }
            return Column(
              children: [
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(labelText: 'Name'),
                ),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(labelText: 'Email'),
                ),
                TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(labelText: 'Password'),
                  obscureText: true,
                ),
                TextField(
                  controller: _passwordConfirmationController,
                  decoration: InputDecoration(labelText: 'Confirm Password'),
                  obscureText: true,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Validasi sederhana
                    if (_nameController.text.isEmpty ||
                        _emailController.text.isEmpty ||
                        _passwordController.text.isEmpty ||
                        _passwordConfirmationController.text.isEmpty) {
                      _showSnackBar(
                        context,
                        "Semua field harus diisi",
                        error: true,
                      );
                      return;
                    }
                    if (_passwordController.text !=
                        _passwordConfirmationController.text) {
                      _showSnackBar(
                        context,
                        "Password tidak sama",
                        error: true,
                      );
                      return;
                    }
                    final request = RegisterRequest(
                      name: _nameController.text,
                      email: _emailController.text,
                      avatar: null, // Avatar opsional
                      password: _passwordController.text,
                      passwordConfirmation:
                          _passwordConfirmationController.text,
                    );
                    context.read<AuthBloc>().add(
                      RegisterEvent(request: request),
                    );
                  },
                  child: Text('Register'),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
