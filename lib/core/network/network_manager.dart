import 'dart:async';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Network connectivity state
enum NetworkStatus { connected, disconnected, unknown }

/// Network manager for handling connectivity and network state
class NetworkManager extends StateNotifier<NetworkStatus> {

  NetworkManager(this._connectivity) : super(NetworkStatus.unknown) {
    _initConnectivity();
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(
      _updateConnectionStatus,
    );
  }
  final Connectivity _connectivity;
  StreamSubscription<ConnectivityResult>? _connectivitySubscription;

  @override
  void dispose() {
    _connectivitySubscription?.cancel();
    super.dispose();
  }

  /// Initialize connectivity status
  Future<void> _initConnectivity() async {
    try {
      final result = await _connectivity.checkConnectivity();
      _updateConnectionStatus(result);
    } catch (e) {
      state = NetworkStatus.unknown;
    }
  }

  /// Update connection status based on connectivity result
  void _updateConnectionStatus(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.wifi:
      case ConnectivityResult.mobile:
      case ConnectivityResult.ethernet:
        _checkInternetAccess();
        break;
      case ConnectivityResult.none:
        state = NetworkStatus.disconnected;
        break;
      default:
        state = NetworkStatus.unknown;
    }
  }

  /// Check actual internet access by pinging a reliable server
  Future<void> _checkInternetAccess() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        state = NetworkStatus.connected;
      } else {
        state = NetworkStatus.disconnected;
      }
    } catch (e) {
      state = NetworkStatus.disconnected;
    }
  }

  /// Check if device is connected to internet
  bool get isConnected => state == NetworkStatus.connected;

  /// Check if device is disconnected from internet
  bool get isDisconnected => state == NetworkStatus.disconnected;

  /// Manually refresh network status
  Future<void> refreshStatus() async {
    await _initConnectivity();
  }
}

/// Provider for NetworkManager
final networkManagerProvider =
    StateNotifierProvider<NetworkManager, NetworkStatus>((ref) => NetworkManager(Connectivity()));

/// Provider for checking if device is connected
final isConnectedProvider = Provider<bool>((ref) {
  final networkStatus = ref.watch(networkManagerProvider);
  return networkStatus == NetworkStatus.connected;
});
