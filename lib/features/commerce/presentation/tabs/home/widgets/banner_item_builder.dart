import 'dart:async';

import 'package:e_commerce/features/commerce/domain/entity/banner_entity.dart';
import 'package:e_commerce/features/commerce/presentation/tabs/home/widgets/home_banner_card.dart';
import 'package:flutter/material.dart';

class BannerItemBuilder extends StatefulWidget {
  const BannerItemBuilder({super.key, required this.bannerEntity});
  final List<BannerEntity> bannerEntity;
  @override
  State<BannerItemBuilder> createState() => _BannerItemBuilderState();
}

class _BannerItemBuilderState extends State<BannerItemBuilder> {
  late PageController _pageController;
  Timer? _timer;
  int _currentPage = 0;
  @override
  void initState() {
    super.initState();

    _pageController = PageController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startAutoScroll();
    });
  }

  void _startAutoScroll() {
    _timer?.cancel();

    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (!mounted) return;
      if (!_pageController.hasClients) return;

      int nextPage = _currentPage + 1;
      if (nextPage >= widget.bannerEntity.length) {
        nextPage = 0;
      }

      _pageController
          .animateToPage(
            nextPage,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          )
          .then((_) {
            if (mounted) {
              setState(() {
                _currentPage = nextPage;
              });
            }
          });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2,
      child: PageView.builder(
        scrollDirection: Axis.horizontal,
        controller: _pageController,
        itemCount: widget.bannerEntity.length,
        onPageChanged: (value) {
          setState(() {
            _currentPage == value;
          });
        },
        itemBuilder: (context, index) {
          return HomeBannerCard(bannerEntity: widget.bannerEntity[index]);
        },
      ),
    );
  }
}
