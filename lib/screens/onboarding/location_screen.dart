import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import 'package:max_dating_app/blocs/blocs.dart';
import 'package:max_dating_app/models/models.dart';
import 'package:max_dating_app/widgets/widgets.dart';

class LocationScreen extends StatelessWidget {
  final TabController tabController;

  const LocationScreen({
    super.key,
    required this.tabController,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingBloc, OnboardingState>(
      builder: (context, state) {
        if (state is OnboardingLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is OnboardingLoaded) {
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 30,
              vertical: 50,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomTextHeader(
                      text: 'Where Are You?',
                    ),
                    CustomTextField(
                      hint: 'ENTER YOUR LOCATION',
                      onChanged: (value) {
                        // print('location change');
                        Location location = state.user.location!.copyWith(
                          name: value,
                        );
                        context.read<OnboardingBloc>().add(
                              SetUserLocation(
                                location: location,
                              ),
                            );
                      },
                      onFocusChanged: (hasFocus) {
                        if (hasFocus) {
                          // print('has focus');
                          return;
                        } else {
                          // print('lost focus');
                          context.read<OnboardingBloc>().add(
                                SetUserLocation(
                                  isUpdateComplete: true,
                                  location: state.user.location,
                                ),
                              );
                        }
                      },
                    ),
                    const SizedBox(height: 10),
                    // Expanded(
                    SizedBox(
                      // height: 200,
                      // height: MediaQuery.of(context).size.height / 2,
                      height: MediaQuery.of(context).size.width,
                      // width: 200,
                      // width: MediaQuery.of(context).size.height - 100,
                      width: MediaQuery.of(context).size.width,
                      child: GoogleMap(
                        myLocationEnabled: true,
                        myLocationButtonEnabled: false,
                        onMapCreated: (GoogleMapController controller) {
                          context.read<OnboardingBloc>().add(
                                SetUserLocation(
                                  controller: controller,
                                ),
                              );
                        },
                        initialCameraPosition: CameraPosition(
                          // zoom: 1,
                          zoom: 10,
                          target: LatLng(
                            // Not picking up user's init location
                            state.user.location!.lat.toDouble(),
                            state.user.location!.lon.toDouble(),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
                Column(
                  children: [
                    StepProgressIndicator(
                      totalSteps: 6,
                      currentStep: 6,
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
        } else {
          return const Center(
            child: Text('Something went wrong.'),
          );
        }
      },
    );
  }
}
