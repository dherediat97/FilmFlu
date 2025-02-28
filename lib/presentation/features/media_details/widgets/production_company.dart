import 'package:film_flu/app/constants/app_urls.dart';
import 'package:flutter/material.dart';

class ProductionCompany extends StatelessWidget {
  const ProductionCompany({
    super.key,
    required this.productionCompanyImage,
  });

  final List<String?> productionCompanyImage;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: 200,
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: productionCompanyImage.length,
          itemBuilder: (context, index) {
            return Image.network(
              '${AppUrls.providerImgBaseUrl}${productionCompanyImage[index]}',
              height: 20,
              width: 20,
            );
          }),
    );
  }
}
