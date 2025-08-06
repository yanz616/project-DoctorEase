import 'package:doctor_ease_fe/core/constants/colors.dart';
import 'package:doctor_ease_fe/core/constants/font.dart';
import 'package:doctor_ease_fe/data/models/user/request/auth_request.dart';
import 'package:doctor_ease_fe/presentation/auth/blocs/auth_bloc.dart';
import 'package:doctor_ease_fe/presentation/auth/blocs/auth_event.dart';
import 'package:doctor_ease_fe/presentation/auth/blocs/auth_state.dart';
import 'package:doctor_ease_fe/presentation/auth/pages/login_page.dart';
import 'package:doctor_ease_fe/widgets/my_button.dart';
import 'package:doctor_ease_fe/widgets/my_form_field.dart';
import 'package:doctor_ease_fe/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late TextEditingController _nameController;

  late TextEditingController _emailController;

  late TextEditingController _passwordController;

  late TextEditingController _passwordConfirmationController;
  bool _isPasswordObscured = true;
  String? _passwordError;

  @override
  void initState() {
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _passwordConfirmationController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _passwordConfirmationController.dispose();
    super.dispose();
  }

  void _showSnackBar(
    BuildContext context,
    String message, {
    bool error = false,
  }) {
    final overlay = Overlay.of(context);
    final animationController = AnimationController(
      vsync: Navigator.of(context),
      duration: Duration(milliseconds: 300),
    );
    final animation =
        Tween<Offset>(
          begin: Offset(0, -1), // mulai di luar layar atas
          end: Offset(0, 0), // turun ke posisi
        ).animate(
          CurvedAnimation(parent: animationController, curve: Curves.easeOut),
        );

    final entry = OverlayEntry(
      builder: (context) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: SlideTransition(
              position: animation,
              child: Material(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 66, vertical: 12),
                  decoration: BoxDecoration(
                    color: error ? AppColors.linen : AppColors.mintCream,
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      color: AppColors.lightSlateGray,
                      width: 1,
                    ),
                  ),
                  child: PoppinText(
                    text: message,
                    styles: StyleText(
                      size: 12,
                      weight: AppFontWeights.bold,
                      color: error ? AppColors.crimson : AppColors.ufoGreen,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
    overlay.insert(entry);
    animationController.forward();
    Future.delayed(Duration(seconds: 2), () {
      animationController.reverse().then((_) => entry.remove());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Gap(72),
                  Center(
                    child: Image(
                      image: AssetImage('assets/icons/register.png'),
                      width: 200,
                      height: 100,
                    ),
                  ),
                  Gap(58),
                  PoppinText(
                    text: "Name",
                    styles: StyleText(
                      size: 16,
                      weight: AppFontWeights.medium,
                      color: AppColors.darkTeal,
                    ),
                  ),
                  Gap(10),
                  MyFormField(
                    controller: _nameController,
                    hintText: "Enter Your Name",
                    prefixIcon: Icon(
                      Icons.person_2_outlined,
                      color: AppColors.darkTeal,
                    ),
                    color: AppColors.white,
                    hintStyle: StyleText(
                      size: 12,
                      weight: AppFontWeights.regular,
                      color: AppColors.mediumGray,
                    ),
                  ),
                  Gap(20),
                  PoppinText(
                    text: "Email Addres",
                    styles: StyleText(
                      size: 16,
                      weight: AppFontWeights.medium,
                      color: AppColors.darkTeal,
                    ),
                  ),
                  Gap(10),
                  MyFormField(
                    controller: _emailController,
                    hintText: "Email Addres",
                    prefixIcon: Icon(
                      Icons.email_outlined,
                      color: AppColors.darkTeal,
                    ),
                    color: AppColors.white,
                    hintStyle: StyleText(
                      size: 12,
                      weight: AppFontWeights.regular,
                      color: AppColors.mediumGray,
                    ),
                  ),
                  Gap(20),
                  PoppinText(
                    text: "Password",
                    styles: StyleText(
                      size: 16,
                      weight: AppFontWeights.medium,
                      color: AppColors.darkTeal,
                    ),
                  ),
                  Gap(10),
                  MyFormField(
                    controller: _passwordController,
                    obscure: _isPasswordObscured,
                    hintText: "Password",
                    prefixIcon: Icon(
                      Icons.key_outlined,
                      color: AppColors.darkTeal,
                    ),
                    color: AppColors.white,
                    hintStyle: StyleText(
                      size: 12,
                      weight: AppFontWeights.regular,
                      color: AppColors.mediumGray,
                    ),
                    errorText: _passwordError,
                    showToggleIcon: true,
                    onToggle: () {
                      setState(() {
                        _isPasswordObscured = !_isPasswordObscured;
                      });
                    },
                  ),
                  Gap(20),
                  PoppinText(
                    text: "Password Confirmation",
                    styles: StyleText(
                      size: 16,
                      weight: AppFontWeights.medium,
                      color: AppColors.darkTeal,
                    ),
                  ),
                  Gap(10),
                  MyFormField(
                    controller: _passwordConfirmationController,
                    obscure: _isPasswordObscured,
                    hintText: "Password Confirmation",
                    prefixIcon: Icon(
                      Icons.key_outlined,
                      color: AppColors.darkTeal,
                    ),
                    color: AppColors.white,
                    hintStyle: StyleText(
                      size: 12,
                      weight: AppFontWeights.regular,
                      color: AppColors.mediumGray,
                    ),
                    errorText: _passwordError,
                    showToggleIcon: true,
                    onToggle: () {
                      setState(() {
                        _isPasswordObscured = !_isPasswordObscured;
                      });
                    },
                  ),
                  Gap(40),
                  MyButton(
                    onPressed: () {
                      if (_nameController.text.isEmpty ||
                          _emailController.text.isEmpty ||
                          _passwordConfirmationController.text.isEmpty ||
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
                    borderCircular: 28,
                    vertical: 16,
                    text: "Register",
                    styleText: StyleText(
                      size: 16,
                      weight: AppFontWeights.semiBold,
                      color: AppColors.white,
                    ),
                    isLoading: state is AuthLoading,
                  ),
                  Gap(26),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      PoppinText(
                        text: "Have a Account?",
                        styles: StyleText(
                          size: 14,
                          weight: AppFontWeights.regular,
                          color: AppColors.mediumGray,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          // Navigasi ke halaman register
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => LoginPage()),
                          );
                        },
                        child: PoppinText(
                          text: "Sign In",
                          styles: StyleText(
                            size: 14,
                            weight: AppFontWeights.extraBold,
                            color: AppColors.darkCyan,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
