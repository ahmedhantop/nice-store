import 'package:nicestore/models/user.dart';

class AuthState {
  final bool isLoading;
  final Customer? user;
  final String? error;

  const AuthState({this.isLoading = false, this.user, this.error});

  AuthState copyWith({bool? isLoading, Customer? user, String? error}) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      user: user ?? this.user,
      error: error,
    );
  }
}
