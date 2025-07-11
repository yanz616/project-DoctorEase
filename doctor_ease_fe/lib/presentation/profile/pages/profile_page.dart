import 'package:doctor_ease_fe/presentation/profile/blocs/me/me_bloc.dart';
import 'package:doctor_ease_fe/presentation/profile/blocs/me/me_event.dart';
import 'package:doctor_ease_fe/presentation/profile/blocs/me/me_state.dart';
import 'package:doctor_ease_fe/presentation/profile/pages/update_profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//stateful digunakan untuk berkomunikasi dengan bloc
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  //memuat data user
  @override
  void initState() {
    super.initState();
    context.read<MeBloc>().add(MeLoadEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile')),
      body: Padding(
        padding: EdgeInsetsGeometry.all(16),
        //bloc consumer digunakan untuk membangun ui berdasar state dari bloc
        child: BlocConsumer<MeBloc, MeState>(
          //builder digunakan untuk menampilkan ui berdasarkan state
          builder: (context, state) {
            // final user = context.read<MeBloc>();
            //manampilkan loading spinner saat data sedang dimuat
            if (state is MeLoadingState) {
              return Center(child: CircularProgressIndicator());
            } else if (state is MeLoadedState) {
              //saat berhasil dimuat menampilkan data dibawah ini
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Name: ${state.user.name}"),
                  Text("Email: ${state.user.email}"),
                  // Add more user details as needed
                  ElevatedButton(
                    onPressed: () {
                      //berpindah ke halaman edit
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => UpdateProfilePage(user: state.user),
                        ),
                      );
                    },
                    child: Text("Edit Profile"),
                  ),
                ],
              );
            } else {
              return SizedBox.shrink();
            }
          },
          //listener digunakan untuk menampilkan notifikasi saat terjadi perubahan di state
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
