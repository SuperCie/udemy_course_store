import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:les_store_app/controllers/banner_controller.dart';
import 'package:les_store_app/provider/banner_provider.dart';

class BannerWidget extends ConsumerStatefulWidget {
  const BannerWidget({super.key});

  @override
  ConsumerState<BannerWidget> createState() => _BannerWidgetState();
}

class _BannerWidgetState extends ConsumerState<BannerWidget> {
  @override
  void initState() {
    super.initState();
    loadBanners();
  }

  Future<void> loadBanners() async {
    try {
      final bannerController = BannerController();
      final bannerData = await bannerController.fetchBanner();
      ref.read(bannerProvider.notifier).setBanner(bannerData);
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final banners = ref.watch(bannerProvider);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Colors.transparent,
        ),
        width: MediaQuery.of(context).size.width,
        height: 170,
        child: PageView.builder(
          itemCount: banners.length,
          itemBuilder: (context, index) {
            final bannersData = banners[index];
            return ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: Image.network(bannersData.image, fit: BoxFit.cover),
            );
          },
        ),
      ),
    );
  }
}
