import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

import 'package:max_dating_app/models/models.dart';
import 'package:max_dating_app/repositories/repositories.dart';

part 'onboarding_event.dart';
part 'onboarding_state.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  final DatabaseRepository _databaseRepository;
  final StorageRepository _storageRepository;

  OnboardingBloc({
    required DatabaseRepository databaseRepository,
    required StorageRepository storageRepository,
  })  : _databaseRepository = databaseRepository,
        _storageRepository = storageRepository,
        super(OnboardingLoading()) {
    on<StartOnboarding>(_onStartOnboarding);
    on<UpdateUser>(_onUpdateUser);
    on<UpdateUserImages>(_onUpdateUserImages);
  }

  void _onStartOnboarding(
    StartOnboarding event,
    Emitter<OnboardingState> emit,
  ) async {
    print('start');
    // User user = User.empty;

    // String documentId = await _databaseRepository.createUser(user);
    await _databaseRepository.createUser(event.user);
    print('awaited');

    emit(
      OnboardingLoaded(
        // user: user.copyWith(
        //   id: documentId,
        // ),
        user: event.user,
      ),
    );
    print('emitted');
  }

  void _onUpdateUser(
    UpdateUser event,
    Emitter<OnboardingState> emit,
  ) {
    print('update');
    final state = this.state;
    if (state is OnboardingLoaded) {
      print('loaded');
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
}
