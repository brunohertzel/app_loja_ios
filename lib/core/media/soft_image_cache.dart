import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

/// Cache persistente com limite de arquivos. Nao armazena tokens ou dados
/// privados: usar somente URLs PUBLICAS de imagens da vitrine.
class SoftImageCache {
  SoftImageCache._();

  static final CacheManager manager = CacheManager(
    Config(
      'soft_ecommerce_public_images_v1',
      stalePeriod: const Duration(days: 7),
      maxNrOfCacheObjects: 350,
    ),
  );

  static ImageProvider<Object> provider(String url) =>
      CachedNetworkImageProvider(url, cacheManager: manager);

  /// Precarrega um conjunto pequeno de fotos ENQUANTO o app esta aberto.
  /// Nunca baixa o catalogo inteiro ou executa um servico de rastreamento.
  static Future<void> warmPublicUrls(Iterable<String?> urls,
      {int maxItems = 12}) async {
    final unique = <String>{};
    for (final raw in urls) {
      final url = raw?.trim() ?? '';
      final uri = Uri.tryParse(url);
      if (uri == null || uri.scheme != 'https' || uri.host.isEmpty) continue;
      unique.add(url);
      if (unique.length >= maxItems) break;
    }
    // Um download por vez para evitar saturar a conexao movel.
    for (final url in unique) {
      try {
        // Se esta em disco, nao requisitar novamente.
        if (await manager.getFileFromCache(url) == null) {
          await manager.downloadFile(url).timeout(const Duration(seconds: 9));
        }
      } catch (_) {
        // Falta de internet/espaco nao impede o uso normal da loja.
      }
    }
  }
}

/// Substituto de Image.network com a MESMA interface usada na loja,
/// mantendo errorBuilder, ajuste de imagem, semantica e transicoes.
class SoftCachedImage extends StatelessWidget {
  const SoftCachedImage.network(
    this.url, {
    super.key,
    this.width,
    this.height,
    this.fit,
    this.alignment = Alignment.center,
    this.cacheWidth,
    this.errorBuilder,
    this.loadingBuilder,
    this.semanticLabel,
    this.gaplessPlayback = false,
    this.filterQuality = FilterQuality.low,
  });

  final String url;
  final double? width, height;
  final BoxFit? fit;
  final AlignmentGeometry alignment;
  final int? cacheWidth;
  final ImageErrorWidgetBuilder? errorBuilder;
  final ImageLoadingBuilder? loadingBuilder;
  final String? semanticLabel;
  final bool gaplessPlayback;
  final FilterQuality filterQuality;

  @override
  Widget build(BuildContext context) {
    final image = SoftImageCache.provider(url);
    return Image(
      image: cacheWidth == null
          ? image
          : ResizeImage.resizeIfNeeded(cacheWidth, null, image),
      fit: fit,
      alignment: alignment,
      width: width,
      height: height,
      semanticLabel: semanticLabel,
      gaplessPlayback: gaplessPlayback,
      filterQuality: filterQuality,
      errorBuilder: errorBuilder,
      loadingBuilder: loadingBuilder,
    );
  }
}
