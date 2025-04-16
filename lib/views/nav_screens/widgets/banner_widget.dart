import 'package:flutter/material.dart';
import 'package:les_store_app/controllers/banner_controller.dart';
import 'package:les_store_app/models/bannermodel.dart';

class BannerWidget extends StatefulWidget {
  const BannerWidget({super.key});

  @override
  State<BannerWidget> createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  Future<List<BannerModel>>? futureBanners;

  @override
  void initState() {
    super.initState();
    futureBanners = BannerController().fetchBanner();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Colors.transparent,
        ),
        width: MediaQuery.of(context).size.width,
        height: 170,
        child: FutureBuilder(
          future: futureBanners,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('No Banners Data'));
            } else {
              final banners = snapshot.data!;
              return PageView.builder(
                itemCount: banners.length,
                itemBuilder: (context, index) {
                  final bannersData = banners[index];
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: Image.network(bannersData.image, fit: BoxFit.cover),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
