import 'package:cached_network_image/cached_network_image.dart';
import 'package:film_flu/app/constants/app_assets.dart';
import 'package:film_flu/app/constants/app_urls.dart';
import 'package:film_flu/domain/models/person_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PersonCarrouselItem extends StatelessWidget {
  const PersonCarrouselItem({super.key, required this.personEntity});

  final PersonEntity personEntity;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          key: key,
          width: 150,
          height: 240,
          child: CachedNetworkImage(
            imageUrl: '${AppUrls.personImgBaseUrl}${personEntity.profilePath}',
            imageBuilder:
                (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(32),
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
            errorWidget:
                (context, url, error) =>
                    personEntity.gender == 1
                        ? SvgPicture.asset(
                          AppAssets.actressImageIcon,
                          width: 150,
                          height: 240,
                          fit: BoxFit.cover,
                        )
                        : SvgPicture.asset(
                          AppAssets.actorImageIcon,
                          width: 150,
                          height: 240,
                          fit: BoxFit.cover,
                        ),
          ),
        ),
        Text(
          personEntity.name,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
