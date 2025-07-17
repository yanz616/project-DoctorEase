import 'package:doctor_ease_fe/data/models/user/request/profile_request.dart';
import 'package:doctor_ease_fe/data/models/user/user_model.dart';
import 'package:doctor_ease_fe/presentation/profile/blocs/profile_bloc.dart';
import 'package:doctor_ease_fe/presentation/profile/blocs/profile_event.dart';
import 'package:doctor_ease_fe/presentation/profile/blocs/profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateProfilePage extends StatefulWidget {
  final User user;

  const UpdateProfilePage({super.key, required this.user});

  @override
  State<UpdateProfilePage> createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  late TextEditingController nameCtrl;
  late TextEditingController emailCtrl;

  @override
  void initState() {
    super.initState();
    nameCtrl = TextEditingController(text: widget.user.name);
    emailCtrl = TextEditingController(text: widget.user.email);
  }

  void _submitUpdate() {
    final request = UpdateProfileRequest(
      name: nameCtrl.text,
      email: emailCtrl.text,
    );

    context.read<ProfileBloc>().add(UpdateProfileEvent(request: request));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Update Profile")),
      body: BlocConsumer<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is LoadingProfileState) {
            return CircularProgressIndicator();
          }
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                TextField(
                  controller: nameCtrl,
                  decoration: InputDecoration(labelText: "Name"),
                ),
                TextField(
                  controller: emailCtrl,
                  decoration: InputDecoration(labelText: "Email"),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _submitUpdate,
                  child: const Text("Simpan"),
                ),
              ],
            ),
          );
        },
        listener: (context, state) {
          if (state is UpdatedProfile) {
            // Refresh profil
            context.read<ProfileBloc>().add(GetMeEvent());
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Profile berhasil diperbarui")),
            );
            Navigator.pop(context); // Kembali setelah sukses
          } else if (state is FailureProfileState) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text("Gagal: ${state.error}")));
          }
        },
      ),
    );
  }
}
