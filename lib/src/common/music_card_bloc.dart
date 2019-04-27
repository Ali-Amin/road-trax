import 'package:rxdart/rxdart.dart';

class MusicCardBloc {
  BehaviorSubject<bool> _favourite$;
  BehaviorSubject<bool> get favourite$ => _favourite$;

  MusicCardBloc() {
    _favourite$ = BehaviorSubject<bool>.seeded(false);
  }

  void triggerFavourite() {
    _favourite$.add(!_favourite$.value);
  }

  void dispose() {
    _favourite$.close();
  }
}
