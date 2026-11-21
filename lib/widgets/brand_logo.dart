import '../core/media/soft_image_cache.dart';
import 'package:flutter/material.dart';

class BrandLogo extends StatelessWidget {
  const BrandLogo({super.key, required this.logoUrl, this.size = 76});

  final String? logoUrl;
  final double size;

  @override
  Widget build(BuildContext context) {
    final url = logoUrl?.trim() ?? '';
    Widget localLogo() => SizedBox(
          width: size * 2.2,
          height: size,
          child: Image.asset(
            'assets/brand/logo.png',
            fit: BoxFit.contain,
            errorBuilder: (_, __, ___) => Icon(
              Icons.shopping_bag_outlined,
              size: size,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        );
    if (url.isEmpty) return localLogo();

    return SizedBox(
      width: size * 2.2,
      height: size,
      child: SoftCachedImage.network(
        url,
        fit: BoxFit.contain,
        errorBuilder: (_, __, ___) => localLogo(),
      ),
    );
  }
}
