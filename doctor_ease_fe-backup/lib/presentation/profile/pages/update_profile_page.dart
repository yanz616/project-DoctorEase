import 'dart:io';

import 'package:doctor_ease_fe/data/models/user/request/profile_request.dart';
import 'package:doctor_ease_fe/data/models/user/user_model.dart';
import 'package:doctor_ease_fe/presentation/profile/blocs/profile_bloc.dart';
import 'package:doctor_ease_fe/presentation/profile/blocs/profile_event.dart';
import 'package:doctor_ease_fe/presentation/profile/blocs/profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class UpdateProfilePage extends StatefulWidget {
  final User user;

  const UpdateProfilePage({super.key, required this.user});

  @override
  State<UpdateProfilePage> createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  late final TextEditingController _nameCtrl;
  late final TextEditingController _emailCtrl;
  late final TextEditingController _passwordCtrl;
  late final TextEditingController _passwordConfirmCtrl;
  File? _avatarFile;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _nameCtrl = TextEditingController(text: widget.user.name);
    _emailCtrl = TextEditingController(text: widget.user.email);
    _passwordCtrl = TextEditingController(text: widget.user.password);
    _passwordConfirmCtrl = TextEditingController(text: widget.user.password);
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    _passwordConfirmCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _avatarFile = File(pickedFile.path);
      });
    }
  }

  void _submitUpdate() {
    final request = UpdateProfileRequest(
      name: _nameCtrl.text,
      email: _emailCtrl.text,
      avatar: _avatarFile.toString(),
      password: _passwordCtrl.text,
      passwordConfirmation: _passwordConfirmCtrl.text,
    );

    context.read<ProfileBloc>().add(UpdateProfileEvent(request: request));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Update Profile")),
      body: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state is UpdatedProfile) {
            context.read<ProfileBloc>().add(GetMeEvent());
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Profile berhasil diperbarui")),
            );
            Navigator.pop(context);
          } else if (state is FailureProfileState) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text("Gagal: ${state.error}")));
          }
        },
        builder: (context, state) {
          if (state is LoadingProfileState) {
            return const Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // ==== Avatar Preview ====
                CircleAvatar(
                  radius: 50,
                  backgroundImage: _avatarFile != null
                      ? FileImage(_avatarFile!)
                      : (widget.user.avatar != null
                                ? NetworkImage(widget.user.avatar!)
                                : null)
                            as ImageProvider<Object>?,
                  child: _avatarFile == null && widget.user.avatar == null
                      ? const Icon(Icons.person, size: 40)
                      : null,
                ),
                TextButton.icon(
                  onPressed: _pickImage,
                  icon: const Icon(Icons.image),
                  label: const Text("Pilih Foto"),
                ),

                // ==== Form Fields ====
                const SizedBox(height: 16),
                TextField(
                  controller: _nameCtrl,
                  decoration: const InputDecoration(labelText: "Name"),
                ),
                TextField(
                  controller: _emailCtrl,
                  decoration: const InputDecoration(labelText: "Email"),
                ),
                TextField(
                  controller: _passwordCtrl,
                  obscureText: true,
                  decoration: const InputDecoration(labelText: "Password"),
                ),
                TextField(
                  controller: _passwordConfirmCtrl,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: "Konfirmasi Password",
                  ),
                ),

                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _submitUpdate,
                  child: const Text("Simpan Perubahan"),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
