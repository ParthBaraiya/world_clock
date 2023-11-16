enum TimeFormat {
  hour24(24),
  hour12(12);

  final int maxPossibleTime;

  const TimeFormat(this.maxPossibleTime);
}

enum TimezoneSortBy {
  /// Sort By location.
  location('Location'),

  /// Sort By timezone.
  timezone('Timezone'),

  /// Sort By offset.
  offset('Offset');

  /// Display name of the sort by enum.
  final String display;

  const TimezoneSortBy(this.display);
}

enum SortingOrder {
  /// Ascending Order
  asc('Ascending'),

  /// Descending Order
  desc('Descending');

  /// Display name of the sorting order.
  final String display;

  bool get isAscending => this == SortingOrder.asc;
  bool get isDescending => this == SortingOrder.desc;

  const SortingOrder(this.display);
}
