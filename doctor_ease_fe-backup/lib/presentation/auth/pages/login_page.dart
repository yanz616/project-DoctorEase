import 'package:doctor_ease_fe/core/constants/colors.dart';
import 'package:doctor_ease_fe/core/constants/font.dart';
import 'package:doctor_ease_fe/data/models/user/request/auth_request.dart';
import 'package:doctor_ease_fe/presentation/auth/blocs/auth_bloc.dart';
import 'package:doctor_ease_fe/presentation/auth/blocs/auth_event.dart';
import 'package:doctor_ease_fe/presentation/auth/blocs/auth_state.dart';
import 'package:doctor_ease_fe/presentation/auth/pages/register_page.dart';
import 'package:doctor_ease_fe/presentation/home/pages/doctor_list_page.dart';
import 'package:doctor_ease_fe/widgets/my_button.dart';
import 'package:doctor_ease_fe/widgets/my_form_field.dart';
import 'package:doctor_ease_fe/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  bool _isPasswordObscured = true;
  String? _emailError;
  String? _passwordError;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
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
        padding: EdgeInsetsGeometry.all(16),
        child: BlocConsumer<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is AuthLoading) {
              return Center(child: CircularProgressIndicator());
            }
            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 110),
                        child: PoppinText(
                          text: "Hello!",
                          styles: StyleText(
                            size: 22,
                            weight: AppFontWeights.bold,
                            color: AppColors.black,
                          ),
                        ),
                      ),
                      Center(
                        child: Image(
                          image: AssetImage("assets/icons/login.png"),
                        ),
                      ),
                    ],
                  ),
                  Gap(4),
                  Center(
                    child: PoppinText(
                      text: "We're Glad to Have You Back",
                      styles: StyleText(
                        size: 12,
                        weight: AppFontWeights.medium,
                        color: AppColors.bluishGrey,
                      ),
                    ),
                  ),
                  Gap(76),
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
                    errorText: _emailError,
                  ),
                  Gap(26),
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

                  // SizedBox(height: 20),
                  Gap(44),
                  // Tombol untuk login
                  MyButton(
                    onPressed: () {
                      final request = LoginRequest(
                        email: _emailController.text,
                        password: _passwordController.text,
                      );
                      if (_emailController.text.isEmpty) {
                        setState(() {
                          _emailError = "Please Enter Your Email";
                        });
                        Future.delayed(Duration(seconds: 2), () {
                          setState(() {
                            _emailError = null;
                          });
                        });
                        return;
                      }
                      if (_passwordController.text.length < 6) {
                        setState(() {
                          _passwordError = "Password is incorrect!";
                        });
                        Future.delayed(Duration(seconds: 2), () {
                          if (mounted) {
                            setState(() {
                              _passwordError = null; // Reset error
                            });
                          }
                        });
                        return;
                      }
                      context.read<AuthBloc>().add(
                        LoginEvent(request: request),
                      );
                    },
                    borderCircular: 28,
                    vertical: 16,
                    text: "Login",
                    styleText: StyleText(
                      size: 16,
                      weight: AppFontWeights.semiBold,
                      color: const Color.fromRGBO(255, 255, 255, 1),
                    ),
                    isLoading: state is AuthLoading,
                  ),
                  Gap(26),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      PoppinText(
                        text: "Don't Have Account?",
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
                            MaterialPageRoute(builder: (_) => RegisterPage()),
                          );
                        },
                        child: PoppinText(
                          text: "Sign Up",
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
          listener: (context, state) {
            if (state is AuthFailure) {
              _showSnackBar(context, state.error, error: true);
            }
            if (state is AuthSuccessResponse) {
              _showSnackBar(context, state.response.message);
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
