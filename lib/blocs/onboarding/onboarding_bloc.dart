import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

import 'package:max_dating_app/models/models.dart';
import 'package:max_dating_app/repositories/repositories.dart';

part 'onboarding_event.dart';
part 'onboarding_state.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  final DatabaseRepository _databaseRepository;
  final LocationRepository _locationRepository;
  final StorageRepository _storageRepository;

  OnboardingBloc({
    required DatabaseRepository databaseRepository,
    required LocationRepository locationRepository,
    required StorageRepository storageRepository,
  })  : _databaseRepository = databaseRepository,
        _locationRepository = locationRepository,
        _storageRepository = storageRepository,
        super(OnboardingLoading()) {
    on<StartOnboarding>(_onStartOnboarding);
    on<UpdateUser>(_onUpdateUser);
    on<UpdateUserImages>(_onUpdateUserImages);
    on<UpdateUserLocation>(_onUpdateUserLocation);
  }

  void _onStartOnboarding(
    StartOnboarding event,
    Emitter<OnboardingState> emit,
  ) async {
    await _databaseRepository.createUser(event.user);

    emit(
      OnboardingLoaded(
        user: event.user,
      ),
    );
  }

  void _onUpdateUser(
    UpdateUser event,
    Emitter<OnboardingState> emit,
  ) {
    final state = this.state;
    print('update user (ob bloc)');
    if (state is OnboardingLoaded) {
      _databaseRepository.updateUser(event.user);
      emit(
        OnboardingLoaded(
          user: event.user,
        ),
      );
    }
  }

  void _onUpdateUserImages(
    UpdateUserImages event,
    Emitter<OnboardingState> emit,
  ) async {
    final state = this.state;
    if (state is OnboardingLoaded) {
      User user = state.user;

      await _storageRepository.uploadImage(user, event.image);

      _databaseRepository.getUser(user.id!).listen((user) {
        add(
          UpdateUser(
            user: user,
          ),
        );
      });
    }
  }

  void _onUpdateUserLocation(
    UpdateUserLocation event,
    Emitter<OnboardingState> emit,
  ) async {
    final state = this.state as OnboardingLoaded;
    // print('update user location (ob bloc)');

    if (event.isUpdateComplete && event.location != null) {
      print('Getting the location with the Places API');

      final Location location =
          await _locationRepository.getLocation(event.location!.name);

      state.controller!.animateCamera(
        CameraUpdate.newLatLng(
          LatLng(
            location.lat,
            location.lon,
          ),
        ),
      );
      print(state.user.id);
      _databaseRepository.getUser(state.user.id!).listen((user) {
        // print('db get user (ob bloc)');
        // print(user.id);
        add(
          UpdateUser(
            user: state.user.copyWith(
              location: location,
            ),
          ),
        );
      });
    } else {
      // print('not complete or no location (ob bloc)');
      emit(
        OnboardingLoaded(
          user: state.user.copyWith(
            location: event.location,
          ),
          controller: event.controller ?? state.controller,
        ),
      );
    }
  }
}
