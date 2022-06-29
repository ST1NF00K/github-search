import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:github_search/core/init_dependencies.dart';
import 'package:github_search/favorites/view/controllers/favorites_controller.dart';
import 'package:github_search/home/view/pages/user_details_page.dart';
import 'package:mobx/mobx.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  late final FavoritesStore _favoritesStore;

  @override
  void initState() {
    super.initState();
    _favoritesStore = getIt<FavoritesStore>()..findAll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favoritos"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Observer(builder: (BuildContext context) {
          if (_favoritesStore.findAllRequest.value == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (_favoritesStore.findAllRequest.status == FutureStatus.pending) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (_favoritesStore.findAllRequest.status ==
              FutureStatus.rejected) {
            return const Center(child: Text('Ocorreu um erro.'));
          } else {
            var data = _favoritesStore.findAllRequest.value;

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
                                )));
                  },
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const Divider();
              },
            );
          }
        }),
      ),
    );
  }
}
