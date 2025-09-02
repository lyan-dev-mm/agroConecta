import 'dart:async';
import 'package:flutter/material.dart';

class PromotionsCarouselAlt extends StatefulWidget {
  const PromotionsCarouselAlt({super.key});

  @override
  State<PromotionsCarouselAlt> createState() => _PromotionsCarouselAltState();
}

class _PromotionsCarouselAltState extends State<PromotionsCarouselAlt> {
  final PageController _controller = PageController(viewportFraction: 0.9);
  int _currentPage = 0;

  final List<String> images = const ['assets/images/promo1.jpeg'];

  Timer? _autoSlideTimer;

  @override
  void initState() {
    super.initState();
    _startAutoSlide();
  }

  void _startAutoSlide() {
    _autoSlideTimer = Timer.periodic(const Duration(seconds: 5), (_) {
      if (_controller.hasClients) {
        int nextPage = (_currentPage + 1) % images.length;
        _controller.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _autoSlideTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 160,
          child: PageView.builder(
            controller: _controller,
            itemCount: images.length,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: EdgeInsets.symmetric(
                  horizontal: index == _currentPage ? 8 : 12,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    image: AssetImage(images[index]),
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 6),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(images.length, (index) {
            return Container(
              width: 8,
              height: 8,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _currentPage == index ? Colors.green : Colors.grey,
              ),
            );
          }),
        ),
      ],
    );
  }
}
