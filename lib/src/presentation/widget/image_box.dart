import 'package:flutter/material.dart';

import '../../core/util/constants_assets.dart';


class ImageBox extends StatelessWidget {
  const ImageBox({
    required this.widgetImg,
    super.key,
  });

  final String? widgetImg;

  @override
  Widget build(BuildContext context) {
    return widgetImg != null
        ? Image.network(
            widgetImg!,
            fit: BoxFit.fill,
          )
        : Image.asset(
            assetCardBackImage,
          );
  }
}
