import 'package:doctor_ease_fe/core/constants/colors.dart';
import 'package:doctor_ease_fe/core/constants/font.dart';
import 'package:doctor_ease_fe/presentation/blocs/home/specialization_blocs/specialization_bloc.dart';
import 'package:doctor_ease_fe/presentation/blocs/home/specialization_blocs/specialization_event.dart';
import 'package:doctor_ease_fe/presentation/blocs/home/specialization_blocs/specialization_state.dart';
import 'package:doctor_ease_fe/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    context.read<SpecializationBloc>().add(GetAllSpecializationEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page "),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: EdgeInsetsGeometry.all(10),
        child: BlocBuilder<SpecializationBloc, SpecializationState>(
          builder: (context, state) {
            if (state is LoadingSpecializationState) {
              return Center(child: CircularProgressIndicator());
            } else if (state is LoadedGetAllSpecializationState) {
              if (state.response.isEmpty) {
                return Center(
                  child: PoppinText(
                    text: "Specialization is Empty",
                    styles: StyleText(
                      size: 20,
                      weight: AppFontWeights.semiBold,
                      color: AppColors.darkTeal,
                    ),
                  ),
                );
              } else {
                return Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: state.response.length,
                        itemBuilder: (context, index) {
                          final specialization = state.response[index];
                          return TextButton(
                            onPressed: () {},
                            child: PoppinText(
                              text: specialization.name,
                              styles: StyleText(
                                size: 10,
                                weight: AppFontWeights.semiBold,
                                color: AppColors.dimGray,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              }
            } else if (state is FailureSpecializationState) {
              return Center(
                child: PoppinText(
                  text: "Can't Load the Button",
                  styles: StyleText(
                    size: 12,
                    weight: AppFontWeights.semiBold,
                    color: AppColors.darkTeal,
                  ),
                ),
              );
            }
            return const Center(
              child: Text("Can't Initial State or Unknown State"),
            );
          },
        ),
      ),
    );
  }
}
