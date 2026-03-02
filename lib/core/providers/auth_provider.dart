import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nicestore/core/constants/api_endpoints.dart';
import 'package:nicestore/core/network/enhanced_network_handler.dart';
import 'package:nicestore/core/network/network_result.dart';
import 'package:nicestore/core/providers/auth_state.dart';
import 'dart:core';

import 'package:nicestore/models/user.dart';

final authProvider = StateNotifierProvider<AuthViewModel, AuthState>(
  (ref) => AuthViewModel(ref.read(enhancedNetworkHandlerProvider)),
);

class AuthViewModel extends StateNotifier<AuthState> {
  AuthViewModel(this._networkHandler) : super(const AuthState());

  final EnhancedNetworkHandler _networkHandler;

  Future<void> login({required String email, required String password}) async {
    state = state.copyWith(isLoading: true, error: null);

    final NetworkResult<Customer> result = await _networkHandler
        .postCached<Customer>(
          ApiEndpoints.login,
          data: {"email": email, "password": password},
          parser: (json) => Customer.fromJson(json),
        );

    // 🔹 Check type instead of calling non-existing methods
    if (result is NetworkSuccess<Customer>) {
      state = state.copyWith(isLoading: false, user: result.data);
    } else if (result is NetworkFailure<Customer>) {
      state = state.copyWith(isLoading: false, error: result.message);
    }
  }

  void logout() {
    state = const AuthState();
  }

  void clearError() {
    state = state.copyWith(error: null);
  }
}




/// 🔹 Auth provider
// final authProvider = StateNotifierProvider<AuthViewModel, AuthState>(
//   (ref) => AuthViewModel(ref.read(enhancedNetworkHandlerProvider)),
// );