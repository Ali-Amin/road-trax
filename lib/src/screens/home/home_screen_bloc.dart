import 'package:rxdart/rxdart.dart';

class HomeScreenBloc {
  final List<String> _titles = [
    "Stream Music",
    "Map View",
    "Local Music",
  ];

  BehaviorSubject<String> _titles$;
  Observable<String> get titles$ => _titles$;

  HomeScreenBloc() {
    _titles$ = BehaviorSubject.seeded(_titles[1]);
  }

  void sendIndex(int index) {
    _pushStringToStream(index);
  }

  void _pushStringToStream(int index) {
    _titles$.add(_titles[index]);
  }

  void dispose() {
    _titles$.close();
  }
}
