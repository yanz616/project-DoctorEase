import 'package:doctor_ease_fe/core/constants/colors.dart';
import 'package:doctor_ease_fe/core/constants/font.dart';
import 'package:doctor_ease_fe/presentation/blocs/home/specialization_blocs/specialization_bloc.dart';
import 'package:doctor_ease_fe/presentation/blocs/home/specialization_blocs/specialization_event.dart';
import 'package:doctor_ease_fe/presentation/blocs/home/specialization_blocs/specialization_state.dart';
import 'package:doctor_ease_fe/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsetsGeometry.only(top: 34, left: 26, bottom: 46),
              child: Row(
                children: [
                  Text('data'),
                  Text('data'),
                  Text('data'),
                  Text('data'),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 42,
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: "Search",
                          prefixIcon: Icon(
                            Icons.search_outlined,
                            color: AppColors.darkCyan,
                          ),
                          fillColor: AppColors.whiteSmoke,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(
                              color: AppColors.lightGray,
                              width: 1,
                            ),
                          ),
                          hintStyle: GoogleFonts.poppins(
                            color: AppColors.mediumGray,
                            fontSize: 16,
                            fontWeight: AppFontWeights.medium,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Gap(8),
                  Container(
                    height: 42,
                    width: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: AppColors.lightGrayishCyan,
                    ),
                    child: Center(
                      child: Icon(
                        Icons.filter_alt_outlined,
                        size: 12,
                        color: AppColors.darkTeal,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Gap(32),
            Card(
              margin: EdgeInsets.all(10),
              child: Row(
                children: [
                  Container(
                    height: 102,
                    padding: EdgeInsets.only(top: 24),
                    decoration: BoxDecoration(color: AppColors.darkCyan),
                    child: Text('data'),
                  ),
                  Column(children: [Text('data'), Text('data')]),
                ],
              ),
            ),
            Padding(
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
          ],
        ),
      ),
    );
  }
}
