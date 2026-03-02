import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nicestore/core/constants/api_endpoints.dart';
import 'package:nicestore/core/network/enhanced_network_handler.dart';
import 'package:nicestore/core/network/network_result.dart';
import 'package:nicestore/models/products_model.dart';
import 'dart:core';

class ListsState<T> {
  ListsState({this.isLoading = false, this.items = const [], this.error});

  final bool isLoading;
  final List<T> items;
  final String? error;

  ListsState<T> copyWith({bool? isLoading, List<T>? items, String? error}) =>
      ListsState<T>(
        isLoading: isLoading ?? this.isLoading,
        items: items ?? this.items,
        error: error,
      );
}

class ListsViewModel<T> extends StateNotifier<ListsState<T>> {
  ListsViewModel(this._networkHandler, this._fromJson, this._endpoint)
    : super(ListsState<T>());

  final EnhancedNetworkHandler _networkHandler;
  final T Function(Map<String, dynamic>) _fromJson;
  final String _endpoint;

  Future<void> loadItems({bool forceRefresh = false}) async {
    state = state.copyWith(isLoading: true, error: null);

    final result = await _networkHandler.getCached<List<T>>(
      _endpoint,
      parser: (data) {
        var items = <dynamic>[];

        try {
          if (data is List) {
            items = data;
          } else if (data is Map<String, dynamic>) {
            if (data.containsKey('data')) {
              final responseData = data['data'];

              if (responseData is List) {
                print('API Response for $_endpoint: $data');
                items = responseData;
              } else if (responseData is Map<String, dynamic>) {
                for (final value in responseData.values) {
                  if (value is List) {
                    items = List<dynamic>.from(value);
                    break;
                  }
                }
              }
            } else {
              for (final value in data.values) {
                if (value is List) {
                  items = List<dynamic>.from(value);
                  break;
                }
              }
            }
          }
        } catch (e) {
          items = [];
        }

        return items
            .map((json) => _fromJson(json as Map<String, dynamic>))
            .toList();
      },
      cacheTtl: const Duration(minutes: 30),
      forceRefresh: forceRefresh,
    );

    result.when(
      onSuccess: (items) {
        state = state.copyWith(isLoading: false, items: items);
      },
      onFailure: (failure) {
        state = state.copyWith(isLoading: false, error: failure.message);
      },
    );
  }

  Future<void> refresh() async {
    await loadItems(forceRefresh: true);
  }

  void clearError() {
    state = state.copyWith(error: null);
  }

  /// 🔥 NEW: Generic Grouping Method
  Map<String, List<T>> groupBy(String Function(T item) keySelector) {
    final Map<String, List<T>> map = {};

    for (var item in state.items) {
      final key = keySelector(item);

      map.putIfAbsent(key, () => []);
      map[key]!.add(item);
    }

    return map;
  }
}
