import 'package:flutter_trip/wan/data/protocol/models.dart';
import 'package:rxdart/subjects.dart';

import 'bloc_provider.dart';

class MainBloc implements BlocBase {
  BehaviorSubject<List<BannerModel>> _banner =
      BehaviorSubject<List<BannerModel>>();

  @override
  void dispose() {
    // TODO: implement dispose
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
}
