import 'dart:async';

enum AuthStatus { authenticated, unAuthenticated, unknown }

class AuthRepo {
  final _controller = StreamController<AuthStatus>();

  Stream<AuthStatus> get status async* {
    yield AuthStatus.unAuthenticated;
    yield* _controller.stream;
  }

  Future<void> logIn({
    required String username,
    required String password,
  }) async {
    await Future.delayed(
      const Duration(milliseconds: 300),
      () => _controller.add(AuthStatus.authenticated),
    );
  }

  logOut() {
    return _controller.add(AuthStatus.unAuthenticated);
  }

  void dispose() => _controller.close();
}
