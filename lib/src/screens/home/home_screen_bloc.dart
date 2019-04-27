import 'package:rxdart/rxdart.dart';

class HomeScreenBloc {
  BehaviorSubject<int> _pageIndex$;
  Observable<int> get pageIndex$ => _pageIndex$;

  HomeScreenBloc() {
    _pageIndex$ = BehaviorSubject.seeded(1);
  }

  void sendPageIndex(int index) {
    _pushStringToStream(index);
  }

  void _pushStringToStream(int index) {
    _pageIndex$.add(index);
  }

  void dispose() {
    _pageIndex$.close();
  }
}
