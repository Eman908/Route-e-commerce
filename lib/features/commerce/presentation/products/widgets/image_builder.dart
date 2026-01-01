import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/features/commerce/domain/entity/products_entity.dart';
import 'package:flutter/material.dart';

class ImageBuilder extends StatefulWidget {
  const ImageBuilder({super.key, required this.productsEntity});
  final ProductsEntity productsEntity;
  @override
  State<ImageBuilder> createState() => _ImageBuilderState();
}

class _ImageBuilderState extends State<ImageBuilder> {
  final PageController _controller = PageController();
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: PageView.builder(
        controller: _controller,
        scrollDirection: Axis.horizontal,
        itemCount: widget.productsEntity.images?.length ?? 0,
        itemBuilder: (context, index) => CachedNetworkImage(
          imageUrl: widget.productsEntity.images?[index] ?? '',
          errorWidget: (context, url, error) => const Icon(Icons.error),
          placeholder: (context, url) =>
              const Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}
