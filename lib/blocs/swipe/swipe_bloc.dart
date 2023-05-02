import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:max_dating_app/blocs/blocs.dart';
import 'package:max_dating_app/models/models.dart';
import 'package:max_dating_app/repositories/repositories.dart';

part 'swipe_event.dart';
part 'swipe_state.dart';

class SwipeBloc extends Bloc<SwipeEvent, SwipeState> {
  final AuthBloc _authBloc;
  final DatabaseRepository _databaseRepository;
  StreamSubscription? _authSubscription;

  SwipeBloc({
    required AuthBloc authBloc,
    required DatabaseRepository databaseRepository,
  })  : _authBloc = authBloc,
        _databaseRepository = databaseRepository,
        super(SwipeLoading()) {
    on<LoadUsers>(_onLoadUsers);
    on<UpdateHome>(_onUpdateHome);
    on<SwipeLeft>(_onSwipeLeft);
    on<SwipeRight>(_onSwipeRight);

    _authSubscription = _authBloc.stream.listen((state) {
      print('auth sub');
      if (state.status == AuthStatus.authenticated) {
        add(
          LoadUsers(),
        );
      }
    });
  }

  void _onLoadUsers(
    LoadUsers event,
    Emitter<SwipeState> emit,
  ) {
    if (_authBloc.state.user != null) {
      print('on load users');
      User currentUser = _authBloc.state.user!;
      print('current user: ${currentUser.name}');

      _databaseRepository.getUsersToSwipe(currentUser).listen((users) {
        // NOTE: running multiple times, Stream effect (?)
        // Runs UpdateHome (which triggers LoadUsers ?) below
        print('Load users');
        print(users.length);
        print(users);
        if (users.isNotEmpty) {
          print('not empty');
          add(
            UpdateHome(
              users: users,
            ),
          );
        } else {
          print('empty');
          // add(
          //   LoadUsers(),
          // );
          add(
            const UpdateHome(
              users: [],
            ),
          );
        }
      });
    }
  }

  void _onUpdateHome(
    UpdateHome event,
    Emitter<SwipeState> emit,
  ) {
    print('updating home');
    if (event.users!.isNotEmpty) {
      emit(
        SwipeLoaded(
          users: event.users!,
        ),
      );
    } else {
      emit(
        SwipeError(),
      );
    }
  }

  void _onSwipeLeft(
    SwipeLeft event,
    Emitter<SwipeState> emit,
  ) async {
    final state = this.state;
    if (state is SwipeLoaded) {
      // String userId = _authBloc.state.authUser!.uid;
      List<User> users = List.from(state.users)..remove(event.user);
      print('swipe left');
      await _databaseRepository.updateUserSwipe(
        _authBloc.state.authUser!.uid,
        event.user.id!,
        false,
      );

      if (users.isNotEmpty) {
        emit(
          SwipeLoaded(
            users: users,
          ),
        );
      } else {
        emit(
          SwipeError(),
        );
      }
    }
  }

  void _onSwipeRight(
    SwipeRight event,
    Emitter<SwipeState> emit,
  ) async {
    final state = this.state;
    if (state is SwipeLoaded) {
      String userId = _authBloc.state.authUser!.uid;
      List<User> users = List.from(state.users)..remove(event.user);
      print('swipe right');

      _databaseRepository.updateUserSwipe(
        _authBloc.state.authUser!.uid,
        event.user.id!,
        true,
      );

      if (event.user.swipeRight!.contains(userId)) {
        await _databaseRepository.updateUserMatch(
          userId,
          event.user.id!,
        );
        User matchedUser = await _databaseRepository.getMatchedUser(event.user);
        emit(
          // SwipeLoaded(
          //   users: users,
          // ),
          SwipeMatched(
            user: matchedUser,
          ),
        );
      } else if (users.isNotEmpty) {
        emit(
          SwipeLoaded(
            users: users,
          ),
        );
      } else {
        emit(
          SwipeError(),
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
