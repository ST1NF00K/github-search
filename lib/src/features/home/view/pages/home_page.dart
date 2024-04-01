import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:github_search/src/core/init_dependencies.dart';
import 'package:github_search/src/features/home/view/controllers/github_store.dart';
import 'package:github_search/src/features/home/view/pages/user_details_page.dart';

import '../../../favorites/view/pages/favorites_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late GithubStore _githubStore;
  late TextEditingController _searchQueryController;
  late ScrollController _scrollController;
  Timer? _debounce;
  int _currentPage = 1;

  @override
  void initState() {
    super.initState();
    _githubStore = getIt<GithubStore>();
    _searchQueryController = TextEditingController();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
    _searchQueryController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      final String searchText = _searchQueryController.text.trim();
      if (searchText.isNotEmpty) {
        _currentPage = 1;
        _githubStore.clearResults();
        _githubStore.findAll(searchText, page: _currentPage);
      } else {
        _githubStore.clearResults();
      }
    });
  }

  void _onScroll() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent && !_githubStore.isLoading) {
      _loadMore();
    }
  }

  Future<void> _loadMore() async {
    _currentPage++;
    _githubStore.findAll(_searchQueryController.text.trim(), page: _currentPage);
  }

  @override
  void dispose() {
    _searchQueryController.dispose();
    _scrollController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchQueryController,
          decoration: const InputDecoration(
            hintText: "Search a user...",
            border: InputBorder.none,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              _searchQueryController.clear();
              _githubStore.clearResults();
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const FavoritesPage()));
        },
        child: const Icon(Icons.favorite),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Observer(
          builder: (_) {
            var data = _githubStore.usersList;
            bool isListNotEmpty = data.isNotEmpty;

            return ListView.builder(
              controller: _scrollController,
              itemCount: isListNotEmpty ? data.length + 1 : 0,
              itemBuilder: (context, index) {
                if (index == data.length) {
                  return _githubStore.isLoading ? const Center(child: CircularProgressIndicator()) : Container();
                }

                return ListTile(
                  title: Text(data[index].login),
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(data[index].avatarUrl),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UserDetailsPage(user: data[index]),
                      ),
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
