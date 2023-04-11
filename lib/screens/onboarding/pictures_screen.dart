import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import 'package:max_dating_app/blocs/blocs.dart';
import 'package:max_dating_app/widgets/widgets.dart';

class PicturesScreen extends StatelessWidget {
  final TabController tabController;

  const PicturesScreen({
    super.key,
    required this.tabController,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 30,
        vertical: 50,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomTextHeader(
                text: 'Add 2 or More Pictures',
              ),
              const SizedBox(height: 10),
              BlocBuilder<ImagesBloc, ImagesState>(
                builder: (context, state) {
                  if (state is ImagesLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is ImagesLoaded) {
                    var imagesCount = state.imageUrls.length;
                    return SizedBox(
                      height: 350,
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 0.66,
                        ),
                        itemCount: 6,
                        itemBuilder: (context, index) {
                          return imagesCount > index
                              ? CustomImageContainer(
                                  imageUrl: state.imageUrls[index],
                                )
                              : const CustomImageContainer();
                        },
                      ),
                    );
                    // return Column(
                    //   children: [
                    //     Row(
                    //       children: [
                    //         (imagesCount > 0)
                    //             ? CustomImageContainer(
                    //                 imageUrl: state.imageUrls[0],
                    //               )
                    //             : const CustomImageContainer(),
                    //         (imagesCount > 1)
                    //             ? CustomImageContainer(
                    //                 imageUrl: state.imageUrls[1],
                    //               )
                    //             : const CustomImageContainer(),
                    //         (imagesCount > 2)
                    //             ? CustomImageContainer(
                    //                 imageUrl: state.imageUrls[2],
                    //               )
                    //             : const CustomImageContainer(),
                    //       ],
                    //     ),
                    //     Row(
                    //       children: [
                    //         (imagesCount > 3)
                    //             ? CustomImageContainer(
                    //                 imageUrl: state.imageUrls[3],
                    //               )
                    //             : const CustomImageContainer(),
                    //         (imagesCount > 4)
                    //             ? CustomImageContainer(
                    //                 imageUrl: state.imageUrls[4],
                    //               )
                    //             : const CustomImageContainer(),
                    //         (imagesCount > 5)
                    //             ? CustomImageContainer(
                    //                 imageUrl: state.imageUrls[5],
                    //               )
                    //             : const CustomImageContainer(),
                    //       ],
                    //     ),
                    //   ],
                    // );
                  } else {
                    return const Center(
                      child: Text('Something went wrong.'),
                    );
                  }
                },
              ),
            ],
          ),
          Column(
            children: [
              StepProgressIndicator(
                totalSteps: 6,
                currentStep: 4,
                selectedColor: Theme.of(context).colorScheme.primary,
                unselectedColor: Theme.of(context).colorScheme.background,
              ),
              const SizedBox(height: 10),
              CustomButton(
                tabController: tabController,
                text: 'NEXT STEP',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
