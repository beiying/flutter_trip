import 'package:rxdart/subjects.dart';

import 'bloc_provider.dart';

class ApplicationBloc implements BlocBase {
  BehaviorSubject<int> _appEvent = BehaviorSubject<int>();
  Sink<int> get _appEventSink => _appEvent.sink;
  Stream<int> get appEventStream => _appEvent.stream;
  @override
  void dispose() {
    _appEvent.close();
  }

  @override
  Future getData({String labelId, int page}) {
    // TODO: implement getData
    throw UnimplementedError();
  }

  @override
  Future onLoadMore({String labelId}) {
    // TODO: implement onLoadMore
    throw UnimplementedError();
  }

  @override
  Future onRefresh({String labelId}) {
    // TODO: implement onRefresh
    throw UnimplementedError();
  }

  void sendAppEvent(int type) {
    _appEventSink.add(type);
  }
}
