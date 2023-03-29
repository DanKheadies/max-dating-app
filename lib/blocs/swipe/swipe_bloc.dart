import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:max_dating_app/models/models.dart';

part 'swipe_event.dart';
part 'swipe_state.dart';

class SwipeBloc extends Bloc<SwipeEvent, SwipeState> {
  SwipeBloc() : super(SwipeLoading()) {
    on<LoadUsersEvent>(_onSwipeLoaded);
    on<SwipeLeftEvent>(_onSwipeLeft);
    on<SwipeRightEvent>(_onSwipeRight);
  }

  void _onSwipeLoaded(
    LoadUsersEvent event,
    Emitter<SwipeState> emit,
  ) async {
    emit(
      SwipeLoaded(
        users: event.users,
      ),
    );
  }

  void _onSwipeLeft(
    SwipeLeftEvent event,
    Emitter<SwipeState> emit,
  ) {
    final state = this.state;
    if (state is SwipeLoaded) {
      emit(
        SwipeLoaded(
          users: List.from(state.users)..remove(event.user),
        ),
      );
    }
  }

  void _onSwipeRight(
    SwipeRightEvent event,
    Emitter<SwipeState> emit,
  ) {
    final state = this.state;
    if (state is SwipeLoaded) {
      emit(
        SwipeLoaded(
          users: List.from(state.users)..remove(event.user),
        ),
      );
    }
  }
}
