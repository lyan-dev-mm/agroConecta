import 'package:agroconecta/modules/home/forum/widgets/local_post_card.dart';
import 'package:flutter/material.dart';
import 'package:agroconecta/modules/home/widgets/app_bar_home.dart';
import 'package:agroconecta/modules/home/widgets/promotions_carousel_alt.dart';
import 'package:agroconecta/modules/home/widgets/bottom_nav_bar.dart';
import 'package:flutter/rendering.dart';
import 'package:agroconecta/modules/home/widgets/menu_fab.dart';
import 'package:agroconecta/modules/home/forum/widgets/post_card.dart';
import 'package:agroconecta/modules/home/controllers/home_controllers.dart';
import 'package:agroconecta/modules/home/providers/post_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  late final ScrollController _scrollController;
  bool _showFab = true;

  @override
  void initState() {
    super.initState();

    // Ejecutar migración solo si eres tú (opcional)
    //final currentUserId = FirebaseAuth.instance.currentUser?.uid ?? '';
    //if (currentUserId == 'adminUser123') {
    //  PostController().migrateLikedByField();
    //}

    _scrollController = ScrollController();
    _scrollController.addListener(() {
      final direction = _scrollController.position.userScrollDirection;
      if (direction == ScrollDirection.reverse && _showFab) {
        setState(() => _showFab = false);
      } else if (direction == ScrollDirection.forward && !_showFab) {
        setState(() => _showFab = true);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final homeController = ref.watch(homeControllerProvider);
    final currentUserId = FirebaseAuth.instance.currentUser?.uid ?? '';

    return Scaffold(
      appBar: const AppBarHome(),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 5),
            const PromotionsCarouselAlt(),
            const SizedBox(height: 16),
            const LocalPostCard(),
            const SizedBox(height: 8),
            _buildPostList(ref, homeController, currentUserId),
          ],
        ),
      ),
      floatingActionButton: MenuFAB(isVisible: _showFab),
      bottomNavigationBar: const BottomNavBar(),
    );
  }

  Widget _buildPostList(
    WidgetRef ref,
    HomeController homeController,
    String currentUserId,
  ) {
    final postProviderInstance = ref.watch(postProvider);
    final posts = postProviderInstance.posts;

    if (posts.isEmpty) {
      return const Center(child: Text('No hay publicaciones'));
    }

    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      controller: homeController.scrollController,
      itemCount: posts.length,
      itemBuilder: (context, index) {
        return PostCard(post: posts[index], currentUserId: currentUserId);
      },
    );
  }
}
