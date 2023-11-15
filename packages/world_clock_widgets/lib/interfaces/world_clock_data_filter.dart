abstract class WorldClockDataFilter<T> {
  const WorldClockDataFilter();
  
  Iterable<T> apply(Iterable<T> data);
}
