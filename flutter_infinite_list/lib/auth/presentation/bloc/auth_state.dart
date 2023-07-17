part of 'auth_bloc.dart';

class AuthState extends Equatable {
  final AuthStatus status;
  final User user;
  const AuthState({
    this.status = AuthStatus.unknown,
    this.user = User.empty,
  });

  const AuthState.unknown() : this();
  const AuthState.authenticated(User user) : this(status: AuthStatus.authenticated, user: user);
  const AuthState.unAuthenticated() : this(status: AuthStatus.unAuthenticated);

  @override
  List<Object> get props => [status, user];
}
