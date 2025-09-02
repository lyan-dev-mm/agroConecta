import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:agroconecta/modules/home/forum/widgets/post_card.dart';
import 'package:agroconecta/modules/home/providers/search_provider.dart';
import 'package:agroconecta/modules/home/controllers/search_controller.dart'
    as custom;

class SearchScreen extends StatefulWidget {
  final String currentUserId;

  const SearchScreen({super.key, required this.currentUserId});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late custom.SearchController searchController;

  @override
  void initState() {
    super.initState();
    searchController = custom.SearchController(onUpdate: () => setState(() {}));
    searchController.init();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SearchProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              child: SingleChildScrollView(
                controller: searchController.scrollController,
                padding: const EdgeInsets.only(top: 100),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (provider.resultados.isEmpty) ...[
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          'Populares',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Wrap(
                          spacing: 8,
                          children: searchController.populares
                              .map(_buildChip)
                              .toList(),
                        ),
                      ),
                      const SizedBox(height: 24),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          'Búsquedas recientes',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Wrap(
                          spacing: 8,
                          children: searchController.recentSearches
                              .map(_buildChip)
                              .toList(),
                        ),
                      ),
                    ] else ...[
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: provider.resultados.length,
                        itemBuilder: (context, index) {
                          final post = provider.resultados[index];
                          return PostCard(
                            post: post,
                            currentUserId: widget.currentUserId,
                          );
                        },
                      ),
                    ],
                  ],
                ),
              ),
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              top: searchController.showSearchBar ? 20 : 0,
              left: 16,
              right: 16,
              child: _buildSearchBar(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    final provider = Provider.of<SearchProvider>(context);

    return Material(
      elevation: 6,
      borderRadius: BorderRadius.circular(30),
      child: TextField(
        controller: searchController.textController,
        decoration: InputDecoration(
          hintText: 'Buscar por hashtag...',
          prefixIcon: const Icon(Icons.search, color: Colors.green),
          suffixIcon: searchController.textController.text.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear, color: Colors.green),
                  onPressed: () {
                    searchController.clearSearch();
                    provider.limpiarResultados();
                    setState(() {});
                  },
                )
              : null,
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 12,
            horizontal: 16,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(color: Colors.green, width: 2),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(color: Colors.green, width: 2),
          ),
        ),
        onChanged: (_) => setState(() {}),
        onSubmitted: (query) => searchController.buscar(context, query),
      ),
    );
  }

  Widget _buildChip(String label) {
    return ActionChip(
      label: Text(label),
      onPressed: () {
        searchController.textController.text = label;
        searchController.buscar(context, label);
      },
    );
  }
}
