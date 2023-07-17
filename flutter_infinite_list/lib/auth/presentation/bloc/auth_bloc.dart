import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_infinite_list/auth/data/user_model.dart';
import 'package:flutter_infinite_list/auth/domain/auth_repo.dart';
import 'package:flutter_infinite_list/auth/domain/user_repo.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepo _authenticationRepository = AuthRepo();
  final UserRepo _userRepository = UserRepo();
  late StreamSubscription<AuthStatus> _authenticationStatusSubscription;

  @override
  Future<void> close() {
    _authenticationStatusSubscription.cancel();
    return super.close();
  }

  AuthBloc() : super(const AuthState.unknown()) {
    on<AuthStatusChanged>(onAuthStatusChanged);
    on<AuthLogOutRequested>(onAuthLogOutRequested);
    _authenticationStatusSubscription = _authenticationRepository.status.listen(
      (status) => add(AuthStatusChanged(status)),
    );
  }

  FutureOr<void> onAuthStatusChanged(AuthStatusChanged event, Emitter<AuthState> emit) async {
    switch (event.status) {
      case AuthStatus.authenticated:
        final user = await _userRepository.getUser();
        return emit(
            user != null ? AuthState.authenticated(user) : const AuthState.unAuthenticated());
      case AuthStatus.unAuthenticated:
        return emit(const AuthState.unAuthenticated());

      case AuthStatus.unknown:
        return emit(const AuthState.unknown());
    }
  }

  FutureOr<void> onAuthLogOutRequested(AuthLogOutRequested event, Emitter<AuthState> emit) {
    _authenticationRepository.logOut();
  }
}
