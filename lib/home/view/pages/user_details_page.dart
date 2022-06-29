import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:github_search/core/init_dependencies.dart';
import 'package:github_search/favorites/view/controllers/favorites_controller.dart';
import 'package:github_search/home/domain/entity/user.dart';
import 'package:github_search/home/view/controllers/github_store.dart';
import 'package:mobx/mobx.dart';

class UserDetailsPage extends StatefulWidget {
  final User user;

  const UserDetailsPage({super.key, required this.user});

  @override
  _UserDetailsPageState createState() => _UserDetailsPageState();
}

class _UserDetailsPageState extends State<UserDetailsPage> {
  late GithubStore _githubStore;
  late FavoritesStore _favoritesStore;

  @override
  void initState() {
    super.initState();
    _githubStore = getIt<GithubStore>()..findById(widget.user.id);
    _favoritesStore = getIt<FavoritesStore>()..findAll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Observer(builder: (context) {
          if (_githubStore.findByIdRequest.status == FutureStatus.pending) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (_githubStore.findByIdRequest.status ==
              FutureStatus.rejected) {
            return const Center(child: Text('Ocorreu um erro.'));
          } else {
            return Text(_githubStore.findByIdRequest.value!.login);
          }
        }),
        actions: [
          IconButton(
              icon: const Icon(Icons.favorite),
              onPressed: () {
                _favoritesStore.save(widget.user);
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("Você adicionou um favorito!"),
                ));
              }),
        ],
      ),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Observer(builder: (BuildContext context) {
            User data = _githubStore.findByIdRequest.value as User;
            if (_githubStore.findByIdRequest.status == FutureStatus.pending) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (_githubStore.findByIdRequest.status ==
                FutureStatus.rejected) {
              return const Center(child: Text('Ocorreu um erro.'));
            } else {
              return _buildUserDetails(data);
            }
          })),
    );
  }

  Widget _buildUserDetails(User data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20.0),
        Center(
          child: CircleAvatar(
            radius: 90.0,
            backgroundImage: NetworkImage(data.avatarUrl),
          ),
        ),
        const SizedBox(height: 40.0),
        Text(
          data.email,
          style: const TextStyle(fontSize: 18.0),
        ),
        Text(
          data.location,
          style: const TextStyle(fontSize: 18.0),
        ),
        Text(
          data.bio,
          style: const TextStyle(fontSize: 18.0),
        ),
      ],
    );
  }
}
