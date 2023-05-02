import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
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
    on<ContinueOnboarding>(_onContinueOnboarding);
    on<UpdateUser>(_onUpdateUser);
    on<UpdateUserImages>(_onUpdateUserImages);
    on<SetUserLocation>(_onSetUserLocation);
  }

  void _onStartOnboarding(
    StartOnboarding event,
    Emitter<OnboardingState> emit,
  ) {
    emit(
      OnboardingLoaded(
        user: User.empty,
        tabController: event.tabController,
      ),
    );
  }

  void _onContinueOnboarding(
    ContinueOnboarding event,
    Emitter<OnboardingState> emit,
  ) async {
    final state = this.state as OnboardingLoaded;

    if (event.isSignup) {
      await _databaseRepository.createUser(event.user);
    }

    state.tabController.animateTo(state.tabController.index + 1);

    emit(
      OnboardingLoaded(
        user: event.user,
        tabController: state.tabController,
      ),
    );
  }

  void _onUpdateUser(
    UpdateUser event,
    Emitter<OnboardingState> emit,
  ) async {
    // NOTE: this calls for UpdateUser's state and tab, but why matter?
    // final state = this.state;
    // print('update user (ob bloc)');
    // UPDATE: this is called multiple times as the Streams / repos listening
    // to the user account run this and notify those subs
    if (state is OnboardingLoaded) {
      print('update user, notify the sub');
      await _databaseRepository.updateUser(event.user);

      emit(
        OnboardingLoaded(
          user: event.user,
          tabController: (state as OnboardingLoaded).tabController,
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
        // print('taco');
        print('update user images');
        add(
          UpdateUser(
            user: user,
          ),
        );
      });
    }
  }

  void _onSetUserLocation(
    SetUserLocation event,
    Emitter<OnboardingState> emit,
  ) async {
    final state = this.state as OnboardingLoaded;
    // print('update user location (ob bloc)');

    if (event.isUpdateComplete && event.location != null) {
      print('Getting the location with the Places API');

      final Location location =
          await _locationRepository.getLocation(event.location!.name);

      state.mapController!.animateCamera(
        CameraUpdate.newLatLng(
          LatLng(
            location.lat.toDouble(),
            location.lon.toDouble(),
          ),
        ),
      );

      _databaseRepository.getUser(state.user.id!).listen((user) {
        // print('daco');
        print('update user location');
        print('getUser stateId: ${state.user.id}');
        print('listened userId: $user');
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
          mapController: event.mapController ?? state.mapController,
          tabController: state.tabController,
        ),
      );
    }
  }
}
