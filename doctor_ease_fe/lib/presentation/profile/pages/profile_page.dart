import 'package:doctor_ease_fe/presentation/profile/blocs/me/me_bloc.dart';
import 'package:doctor_ease_fe/presentation/profile/blocs/me/me_event.dart';
import 'package:doctor_ease_fe/presentation/profile/blocs/me/me_state.dart';
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
    // TODO: implement initState
    super.initState();
    context.read<MeBloc>().add(MeLoadEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile')),
      body: Padding(
        padding: EdgeInsetsGeometry.all(16),
        child: BlocConsumer<MeBloc, MeState>(
          builder: (context, state) {
            // final user = context.read<MeBloc>();
            if (state is MeLoadingState) {
              return Center(child: CircularProgressIndicator());
            } else if (state is MeLoadedState) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Name: ${state.user.name}"),
                  Text("Email: ${state.user.email}"),
                  // Add more user details as needed
                ],
              );
            } else if (state is MeErrorState) {
              return Center(
                child: Text("Failed to load profile: ${state.error}"),
              );
            } else {
              return Center(child: Text("Loading..."));
            }
          },
          listener: (context, state) {
            if (state is MeErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.error),
                  backgroundColor: Colors.red,
                ),
              );
            } else if (state is MeLoadedState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Profile loaded successfully!"),
                  backgroundColor: Colors.green,
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
