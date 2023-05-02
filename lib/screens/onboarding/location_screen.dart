import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:max_dating_app/blocs/blocs.dart';
import 'package:max_dating_app/models/models.dart';
import 'package:max_dating_app/screens/screens.dart';
import 'package:max_dating_app/widgets/widgets.dart';

class LocationScreen extends StatelessWidget {
  final OnboardingLoaded state;

  const LocationScreen({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return OnboardingLayout(
      currentStep: 6,
      onPressed: () {
        Navigator.of(context).pushNamed(HomeScreen.routeName);
      },
      children: [
        const CustomTextHeader(
          text: 'Where Are You?',
        ),
        CustomTextField(
          hint: 'ENTER YOUR LOCATION',
          onChanged: (value) {
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
              return;
            } else {
              // TODO: location's placeId continues to toggle in / out on Firebase (?)
              // Happens after a refresh; stops when the app is quit (?)
              // Nope, keeps running..
              // UPDATE: the UpdateUser keeps getting called in a loop where it
              // contains and does not contain the placeId
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
        SizedBox(
          height: MediaQuery.of(context).size.width,
          width: MediaQuery.of(context).size.width,
          child: GoogleMap(
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            onMapCreated: (GoogleMapController controller) {
              context.read<OnboardingBloc>().add(
                    SetUserLocation(
                      mapController: controller,
                    ),
                  );
            },
            initialCameraPosition: CameraPosition(
              zoom: 10,
              target: LatLng(
                state.user.location!.lat.toDouble(),
                state.user.location!.lon.toDouble(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
