import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:les_store_app/models/bannermodel.dart';

class BannerProvider extends StateNotifier<List<BannerModel>> {
  BannerProvider() : super([]);

  void setBanner(List<BannerModel> banner) {
    state = banner;
  }
}

final bannerProvider = StateNotifierProvider<BannerProvider, List<BannerModel>>(
  (ref) {
    return BannerProvider();
  },
);
