// class Tickers {
//   const Tickers();

//   Stream<int> tick({required int second}) {
//     return Stream.periodic(const Duration(seconds: 1), (count) => second - count - 1).take(second);
//   }
// }
class Tickers {
  const Tickers();
  Stream<int> tick({required int ticks}) {
    return Stream.periodic(const Duration(seconds: 1), (x) => ticks - x - 1).take(ticks);
  }
}
