import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:max_dating_app/blocs/blocs.dart';
import 'package:max_dating_app/models/models.dart';
import 'package:max_dating_app/widgets/widgets.dart';

class ProfileLocation extends StatelessWidget {
  final String title;
  final String value;

  const ProfileLocation({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is ProfileLoaded) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Location',
                style: Theme.of(context).textTheme.displaySmall,
              ),
              const SizedBox(height: 10),
              state.isEditingOn
                  ? CustomTextField(
                      initialValue: value,
                      onChanged: (value) {
                        Location location = state.user.location!.copyWith(
                          name: value,
                        );
                        print('daco');
                        print(value);
                        print(location);
                        // print(state.user.id);
                        context.read<ProfileBloc>().add(
                              UpdateUserLocation(
                                location: location,
                              ),
                            );
                      },
                      onFocusChanged: (hasFocus) {
                        if (hasFocus) return;
                        print('taco');
                        print(state.user.location);
                        context.read<ProfileBloc>().add(
                              UpdateUserLocation(
                                isUpdateComplete: true,
                                location: state.user.location,
                              ),
                            );
                      },
                    )
                  : Text(
                      value,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(height: 1.5),
                    ),
              const SizedBox(height: 10),
              SizedBox(
                height: MediaQuery.of(context).size.width,
                width: MediaQuery.of(context).size.width,
                child: GoogleMap(
                  myLocationEnabled: true,
                  myLocationButtonEnabled: false,
                  onMapCreated: (GoogleMapController controller) {
                    context.read<ProfileBloc>().add(
                          UpdateUserLocation(
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
              const SizedBox(height: 20),
            ],
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
