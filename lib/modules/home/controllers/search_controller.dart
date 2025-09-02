import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:agroconecta/modules/home/providers/search_provider.dart';
import 'package:provider/provider.dart';

class SearchController {
  final VoidCallback onUpdate;

  final TextEditingController textController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  bool showSearchBar = true;
  List<String> recentSearches = [];
  final List<String> populares = [
    'Maíz',
    'Fertilizantes',
    'Tractores',
    'Ofertas',
    'Clima',
  ];

  SearchController({required this.onUpdate});

  void init() {
    scrollController.addListener(_handleScroll);
    _loadRecentSearches();
  }

  void dispose() {
    scrollController.removeListener(_handleScroll);
    scrollController.dispose();
    textController.dispose();
  }

  void _handleScroll() {
    final direction = scrollController.position.userScrollDirection;
    if (direction == ScrollDirection.reverse && showSearchBar) {
      showSearchBar = false;
      onUpdate();
    } else if (direction == ScrollDirection.forward && !showSearchBar) {
      showSearchBar = true;
      onUpdate();
    }
  }

  Future<void> _loadRecentSearches() async {
    final prefs = await SharedPreferences.getInstance();
    recentSearches = prefs.getStringList('recentSearches') ?? [];
    onUpdate();
  }

  Future<void> _saveSearch(String query) async {
    final prefs = await SharedPreferences.getInstance();
    recentSearches.remove(query);
    recentSearches.insert(0, query);
    if (recentSearches.length > 10) {
      recentSearches = recentSearches.sublist(0, 10);
    }
    await prefs.setStringList('recentSearches', recentSearches);
    onUpdate();
  }

  void buscar(BuildContext context, String query) {
    final provider = Provider.of<SearchProvider>(context, listen: false);
    provider.buscarPorHashtag(query.trim().toLowerCase());
    _saveSearch(query);
  }

  void clearSearch() {
    textController.clear();
  }
}
