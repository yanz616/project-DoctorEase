import 'package:doctor_ease_fe/data/models/user/request/profile_request.dart';
import 'package:doctor_ease_fe/data/models/user/user_model.dart';
import 'package:doctor_ease_fe/presentation/profile/blocs/update/update_bloc.dart';
import 'package:doctor_ease_fe/presentation/profile/blocs/update/update_event.dart';
import 'package:doctor_ease_fe/presentation/profile/blocs/update/update_state.dart';
import 'package:doctor_ease_fe/presentation/profile/blocs/me/me_bloc.dart';
import 'package:doctor_ease_fe/presentation/profile/blocs/me/me_event.dart';
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

    context.read<UpdateBloc>().add(UpdateLoadEvent(request: request));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Update Profile")),
      body: BlocConsumer<UpdateBloc, UpdateState>(
        builder: (context, state) {
          if (state is UpdateLoadingState) {
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
          if (state is UpdateLoadedState) {
            // Refresh profil
            context.read<MeBloc>().add(MeLoadEvent());

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Profile berhasil diperbarui")),
            );
            Navigator.pop(context); // Kembali setelah sukses
          } else if (state is UpdateErrorState) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text("Gagal: ${state.error}")));
          }
        },
      ),
    );
  }
}
