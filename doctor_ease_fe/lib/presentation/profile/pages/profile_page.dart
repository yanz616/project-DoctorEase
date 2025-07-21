import 'package:doctor_ease_fe/presentation/auth/blocs/auth_bloc.dart';
import 'package:doctor_ease_fe/presentation/auth/blocs/auth_event.dart';
import 'package:doctor_ease_fe/presentation/auth/blocs/auth_state.dart';
import 'package:doctor_ease_fe/presentation/auth/pages/login_page.dart';
import 'package:doctor_ease_fe/presentation/home/pages/appointment_page.dart';
import 'package:doctor_ease_fe/presentation/profile/blocs/profile_bloc.dart';
import 'package:doctor_ease_fe/presentation/profile/blocs/profile_event.dart';
import 'package:doctor_ease_fe/presentation/profile/blocs/profile_state.dart';
import 'package:doctor_ease_fe/presentation/profile/pages/update_profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    context.read<ProfileBloc>().add(GetMeEvent());
  }

  void _logout() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Logout"),
        content: Text("You sure to logout?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Batal"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              context.read<AuthBloc>().add(LogoutEvent());
            },
            child: Text("Logout"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthLoading) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text("Sedang logout...")));
            } else if (state is LogoutSuccess) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.response.message)));
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => LoginPage()),
                (route) => false,
              );
            } else if (state is AuthFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Logout gagal: ${state.error}')),
              );
            }
          },
          child: Column(
            children: [
              BlocBuilder<ProfileBloc, ProfileState>(
                builder: (context, state) {
                  if (state is LoadingProfileState) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is GetMeLoaded) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Name: ${state.user.name}"),
                        Text("Email: ${state.user.email}"),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        UpdateProfilePage(user: state.user),
                                  ),
                                );
                              },
                              child: Text("Edit Profile"),
                            ),
                            ElevatedButton(
                              onPressed: _logout,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                              ),
                              child: Text("Logout"),
                            ),
                          ],
                        ),
                      ],
                    );
                  } else if (state is FailureProfileState) {
                    return Center(
                      child: Text("Gagal memuat data: ${state.error}"),
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AppointmentPage()),
                  );
                },
                child: Text("Cek Appointment"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
