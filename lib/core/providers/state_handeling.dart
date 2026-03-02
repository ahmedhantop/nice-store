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
