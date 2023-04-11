import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:max_dating_app/models/models.dart';

part 'swipe_event.dart';
part 'swipe_state.dart';

class SwipeBloc extends Bloc<SwipeEvent, SwipeState> {
  SwipeBloc() : super(SwipeLoading()) {
    on<LoadUsers>(_onLoadUsers);
    on<SwipeLeft>(_onSwipeLeft);
    on<SwipeRight>(_onSwipeRight);
  }

  void _onLoadUsers(
    LoadUsers event,
    Emitter<SwipeState> emit,
  ) async {
    emit(
      SwipeLoaded(
        users: event.users,
      ),
    );
  }

  void _onSwipeLeft(
    SwipeLeft event,
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
    SwipeRight event,
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
