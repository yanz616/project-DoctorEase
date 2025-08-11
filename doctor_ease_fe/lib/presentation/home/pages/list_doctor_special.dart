// import 'package:doctor_ease_fe/data/models/doctor/doctor_model.dart';
// import 'package:doctor_ease_fe/data/models/specialization/specialization_model.dart';
// import 'package:doctor_ease_fe/presentation/home/blocs/doctor/doctor_bloc.dart';
// import 'package:doctor_ease_fe/presentation/home/blocs/doctor/doctor_event.dart';
// import 'package:doctor_ease_fe/presentation/home/blocs/doctor/doctor_state.dart';
// import 'package:doctor_ease_fe/presentation/home/pages/detail_doctor.dart';
// import 'package:doctor_ease_fe/presentation/profile/pages/profile_page.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class DoctorSpecialListPage extends StatefulWidget {
//   const DoctorSpecialListPage({super.key, required this.doctor});
//   final Specialization doctor;

//   @override
//   State<DoctorSpecialListPage> createState() => _DoctorSpecialListPageState();
// }

// class _DoctorSpecialListPageState extends State<DoctorSpecialListPage> {
//   @override
//   void initState() {
//     super.initState();
//     context.read<DoctorBloc>().add(
//       LoadDoctorSpecial(id: widget.),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text(widget.doctor.specialization.name)),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: BlocBuilder<DoctorBloc, DoctorState>(
//           builder: (context, state) {
//             if (state is DoctorLoadingState) {
//               return const Center(child: CircularProgressIndicator());
//             } else if (state is DoctorSpecialLoadedState) {
//               if (state.response.doctor.specialization.id.) {
//                 return Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     ElevatedButton(
//                       onPressed: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => const ProfilePage(),
//                           ),
//                         );
//                       },
//                       child: const Text('Profile'),
//                     ),
//                     Spacer(),
//                     Align(
//                       alignment: Alignment.topCenter,
//                       child: Text('Tidak ada dokter tersedia.'),
//                     ),
//                   ],
//                 );
//               } else {
//                 return Column(
//                   children: [
//                     ElevatedButton(
//                       onPressed: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => const ProfilePage(),
//                           ),
//                         );
//                       },
//                       child: const Text('Profile'),
//                     ),
//                     Expanded(
//                       child: ListView.builder(
//                         itemCount: state.doctors.length,
//                         itemBuilder: (context, index) {
//                           final doctor = state.doctors[index];
//                           return ListTile(
//                             title: Text(doctor.name),
//                             subtitle: Text(doctor.specialization.name),
//                             trailing: const Icon(Icons.arrow_forward_ios),
//                             onTap: () {
//                               // 👇 Navigasi ke halaman detail doctor
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (_) =>
//                                       DoctorDetailPage(doctor: doctor),
//                                 ),
//                               );
//                             },
//                           );
//                         },
//                       ),
//                     ),
//                   ],
//                 );
//               }
//             } else if (state is DoctorErrorState) {
//               return Center(child: Text('Terjadi kesalahan: ${state.error}'));
//             }
//             return const SizedBox.shrink(); // initial or unknown state
//           },
//         ),
//       ),
//     );
//   }
// }
