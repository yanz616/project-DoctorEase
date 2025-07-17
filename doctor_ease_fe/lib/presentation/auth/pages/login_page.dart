import 'package:doctor_ease_fe/data/models/user/request/auth_request.dart';
import 'package:doctor_ease_fe/presentation/auth/blocs/auth_bloc.dart';
import 'package:doctor_ease_fe/presentation/auth/blocs/auth_event.dart';
import 'package:doctor_ease_fe/presentation/auth/blocs/auth_state.dart';
import 'package:doctor_ease_fe/presentation/auth/pages/register_page.dart';
import 'package:doctor_ease_fe/presentation/home/screen/doctor_list_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

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
      appBar: AppBar(title: Text('Login Page')),
      body: Padding(
        padding: EdgeInsetsGeometry.all(16),
        child: BlocConsumer<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is AuthLoading) {
              return Center(child: CircularProgressIndicator());
            }
            return Column(
              children: [
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(labelText: 'Email'),
                ),
                TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(labelText: 'Password'),
                  obscureText: true,
                ),
                // SizedBox(height: 20),
                Gap(20),
                // Tombol untuk login
                ElevatedButton(
                  onPressed: () {
                    final request = LoginRequest(
                      email: _emailController.text,
                      password: _passwordController.text,
                    );
                    context.read<AuthBloc>().add(LoginEvent(request: request));
                  },
                  child: Text('Login'),
                ),
                Gap(20),
                TextButton(
                  onPressed: () {
                    // Navigasi ke halaman register
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => RegisterPage()),
                    );
                  },
                  child: Text('Belum punya akun? Daftar di sini'),
                ),
              ],
            );
          },
          listener: (context, state) {
            if (state is AuthFailure) {
              _showSnackBar(context, state.error, error: true);
            }
            if (state is AuthSuccessResponse) {
              _showSnackBar(context, state.response.message);
              // Navigasi ke halaman home atau halaman lain jika perlu
              // Navigator.pushReplacementNamed(context, '/home');
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (_) => MultiBlocProvider(
              //       providers: [
              //         BlocProvider.value(value: context.read<MeBloc>()),
              //         BlocProvider.value(value: context.read<LogoutBloc>()),
              //       ],
              //       child: ProfilePage(),
              //     ),
              //   ),
              // );
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => DoctorListPage()),
              );
            }
          },
        ),
      ),
    );
  }
}
