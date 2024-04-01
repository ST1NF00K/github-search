import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:github_search/src/core/init_dependencies.dart';
import 'package:github_search/src/features/favorites/view/pages/favorites_page.dart';
import 'package:github_search/src/features/home/view/controllers/github_store.dart';
import 'package:github_search/src/features/home/view/pages/user_details_page.dart';
import 'package:mobx/mobx.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late GithubStore _githubStore;
  late TextEditingController _searchQueryController;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _searchQueryController = TextEditingController(text: '');
    _githubStore = getIt<GithubStore>();

    _searchQueryController.addListener(_onSearchChanged);
  }

  _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      String searchText = _searchQueryController.text.trim();
      if (searchText.isNotEmpty) {
        _githubStore.findAll(searchText);
      } else {
        _githubStore.clearResults();
      }
    });
  }

  @override
  void dispose() {
    _searchQueryController.dispose();
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
        child: Observer(builder: (BuildContext context) {
          var data = _githubStore.findAllRequest.value;
          if (_searchQueryController.text == '') {
            return const SizedBox();
          } else if (_githubStore.findAllRequest.status == FutureStatus.pending) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (_githubStore.findAllRequest.status == FutureStatus.rejected) {
            return const Center(child: Text('An error occurred.'));
          } else {
            return ListView.separated(
              itemCount: data!.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(data[index].login),
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(data[index].avatarUrl),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UserDetailsPage(
                            user: data[index],
                          ),
                        ));
                  },
                );
              },
              separatorBuilder: (BuildContext context, int index) => const Divider(),
            );
          }
        }),
      ),
    );
  }
}
