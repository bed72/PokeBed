import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

Widget loadImage(String url) {
  return CachedNetworkImage(
    imageUrl: url,
    placeholder: (context, url) => const Center(
      child: CircularProgressIndicator.adaptive(),
    ),
    errorWidget: (context, url, error) => const Icon(Icons.error),
  );
}
