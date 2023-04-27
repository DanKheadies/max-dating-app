import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';

import 'package:max_dating_app/blocs/blocs.dart';
import 'package:max_dating_app/models/models.dart';
import 'package:max_dating_app/repositories/repositories.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final AuthBloc _authBloc;
  final DatabaseRepository _databaseRepository;
  final LocationRepository _locationRepository;
  StreamSubscription? _authSubscription;

  ProfileBloc({
    required AuthBloc authBloc,
    required DatabaseRepository databaseRepository,
    required LocationRepository locationRepository,
  })  : _authBloc = authBloc,
        _databaseRepository = databaseRepository,
        _locationRepository = locationRepository,
        super(ProfileLoading()) {
    on<LoadProfile>(_onLoadProfile);
    on<EditProfile>(_onEditProfile);
    on<SaveProfile>(_onSaveProfile);
    on<UpdateUserProfile>(_onUpdateUserProfile);
    on<UpdateUserLocation>(_onUpdateUserLocation);

    _authSubscription = _authBloc.stream.listen((state) {
      if (state.user is AuthUserChanged) {
        if (state.user != null) {
          add(
            LoadProfile(
              userId: state.authUser!.uid,
            ),
          );
        }
      }
    });
  }

  void _onLoadProfile(
    LoadProfile event,
    Emitter<ProfileState> emit,
  ) async {
    // _databaseRepository.getUser(event.userId).listen((user) {
    //   add(
    //     UpdateProfile(
    //       user: user,
    //     ),
    //   );
    // });
    User user = await _databaseRepository.getUser(event.userId).first;
    emit(
      ProfileLoaded(
        user: user,
      ),
    );
  }

  void _onEditProfile(
    EditProfile event,
    Emitter<ProfileState> emit,
  ) {
    final state = this.state;

    if (state is ProfileLoaded) {
      emit(
        ProfileLoaded(
          user: state.user,
          isEditingOn: event.isEditingOn,
          controller: state.controller,
        ),
      );
    }
  }

  void _onSaveProfile(
    SaveProfile event,
    Emitter<ProfileState> emit,
  ) {
    final state = this.state;

    if (state is ProfileLoaded) {
      _databaseRepository.updateUser(state.user);

      emit(
        ProfileLoaded(
          user: state.user,
          isEditingOn: false,
          controller: state.controller,
        ),
      );
    }
  }

  void _onUpdateUserProfile(
    UpdateUserProfile event,
    Emitter<ProfileState> emit,
  ) {
    final state = this.state;
    if (state is ProfileLoaded) {
      print(event.user.location);
      emit(
        ProfileLoaded(
          user: event.user,
          isEditingOn: state.isEditingOn,
          controller: state.controller,
        ),
      );
    }
  }

  void _onUpdateUserLocation(
    UpdateUserLocation event,
    Emitter<ProfileState> emit,
  ) async {
    final state = this.state;
    if (state is ProfileLoaded) {
      if (event.isUpdateComplete && event.location != null) {
        final Location location =
            await _locationRepository.getLocation(event.location!.name);

        state.controller!.animateCamera(
          CameraUpdate.newLatLng(
            LatLng(
              location.lat.toDouble(),
              location.lon.toDouble(),
            ),
          ),
        );

        add(
          UpdateUserProfile(
            user: state.user.copyWith(
              location: location,
            ),
          ),
        );
      } else {
        emit(
          ProfileLoaded(
            user: state.user.copyWith(
              location: event.location,
            ),
            controller: event.controller ?? state.controller,
            isEditingOn: state.isEditingOn,
          ),
        );
      }
    }
  }

  @override
  Future<void> close() async {
    _authSubscription?.cancel();
    super.close();
  }
}
