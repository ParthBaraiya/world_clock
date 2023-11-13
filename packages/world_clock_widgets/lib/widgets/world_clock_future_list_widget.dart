import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:world_clock_widgets/mixins/reload_mixin.dart';

/// A base state for the listing widget that will get the data asynchronously
/// and set the UI [ListView] accordingly.
///
/// Extend this state instead of raw [State] class if you are creating any
/// widget that will get the data and show the UI list based on it.
///
/// This class is mainly created to show the list of favorite and all timezones
/// in this UI. This class will provide a common implementation to load all
/// the data.
///
/// We can still override other methods like, [initState], [dispose], etc. But
/// for [initState] make sure to call [super.initState] else, it can cause
/// issue in loading the data.
///
/// Other public methods provided are, [loadItems]
///
abstract class WorldClockFutureListWidgetState<T extends StatefulWidget,
    S extends Object> extends State<T> with ReloadWidgetMixin {
  bool _isLoading = false;
  String? _error;

  List<S> _items = [];

  @override
  void initState() {
    super.initState();

    loadItems();
  }

  @override

  /// This will return an widget defining the state of the list,
  /// which will be built based on data fetch status and data itself.
  ///
  /// i.e, If there is data, It will return a [ListView] built from the data.
  /// If there is an error or data is loading or data is empty,
  /// it will return a [Text] widget with respective message.
  ///
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Text(loadingDataMessage);
    }

    if (_error != null || _error!.isNotEmpty) {
      return Text(_error!);
    }

    if (_items.isEmpty) {
      return Text(emptyDataMessage);
    }

    return ListView.builder(
      itemBuilder: (context, index) => itemBuilder(
        context,
        _items[index],
        index,
      ),
      itemCount: _items.length,
    );
  }

  /// Returns the unmodifiable list of items that will be used to show the
  /// [ListView] in UI.
  UnmodifiableListView<S> get items => UnmodifiableListView(_items);

  /// A message to show when data is loading.
  String get loadingDataMessage => 'Data is loading please wait...';

  /// A message to show when there is no data.
  String get emptyDataMessage => 'No data found please retry.';

  /// A builder method to build a single UI List item.
  ///
  /// This method will be called inside flutter's [build] method.
  Widget itemBuilder(BuildContext context, S item, int index);

  /// This should return list of items if required else
  /// should throw respective string error if operation is failed.
  ///
  /// Tip: Return Iterable whenever possible. it will call toList method
  /// internally to create a new list. So, returning a Iterable instead of a
  /// list can reduce the time complexity by half.
  Future<Iterable<S>> getListItems();

  /// This is just an utility method to load data from outside this state class.
  /// Do not override it unless extremely necessary.
  Future<void> loadItems() async {
    if (_isLoading) return;

    _isLoading = true;
    reload();

    try {
      _items = (await getListItems()).toList();
    } catch (e) {
      _error = '$e';
    } finally {
      _isLoading = false;
      reload();
    }
  }
}
