enum TimeFormat {
  hour24(24),
  hour12(12);

  final int maxPossibleTime;

  const TimeFormat(this.maxPossibleTime);
}
