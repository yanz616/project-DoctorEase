import 'package:doctor_ease_fe/presentation/auth/pages/login_page.dart';
import 'package:doctor_ease_fe/presentation/home/screen/appointment_page.dart';
import 'package:doctor_ease_fe/presentation/profile/blocs/logout/logout_bloc.dart';
import 'package:doctor_ease_fe/presentation/profile/blocs/logout/logout_event.dart';
import 'package:doctor_ease_fe/presentation/profile/blocs/logout/logout_state.dart';
import 'package:doctor_ease_fe/presentation/profile/blocs/me/me_bloc.dart';
import 'package:doctor_ease_fe/presentation/profile/blocs/me/me_event.dart';
import 'package:doctor_ease_fe/presentation/profile/blocs/me/me_state.dart';
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
    context.read<MeBloc>().add(MeLoadEvent());
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
              context.read<LogoutBloc>().add(LogoutSubmitted());
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
        child: BlocListener<LogoutBloc, LogoutState>(
          listener: (context, state) {
            if (state is LogoutLoadingState) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text("Sedang logout...")));
            } else if (state is LogoutSuccessState) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text('Logout Berhasil')));
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => LoginPage()),
                (route) => false,
              );
            } else if (state is LogoutErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Logout gagal: ${state.error}')),
              );
            }
          },
          child: Column(
            children: [
              BlocBuilder<MeBloc, MeState>(
                builder: (context, state) {
                  if (state is MeLoadingState) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is MeLoadedState) {
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
                  } else if (state is MeErrorState) {
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
