import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:github_search/src/core/init_dependencies.dart';
import 'package:github_search/src/features/favorites/view/controllers/favorites_controller.dart';
import 'package:github_search/src/features/home/domain/entity/user.dart';
import 'package:github_search/src/features/home/view/controllers/github_store.dart';
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
    _favoritesStore = getIt<FavoritesStore>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Observer(builder: (context) {
          var request = _githubStore.findByIdRequest;
          if (request.status == FutureStatus.pending) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (request.status == FutureStatus.rejected) {
            return const Center(child: Text('Username não encontrado'));
          } else {
            return Text(request.value!.login);
          }
        }),
        actions: [
          IconButton(
              icon: const Icon(Icons.favorite),
              onPressed: () {
                _favoritesStore.save(widget.user);
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  duration: Duration(seconds: 1),
                  content: Text("Você adicionou um favorito!"),
                ));
              }),
        ],
      ),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Observer(builder: (BuildContext context) {
            var request = _githubStore.findByIdRequest;
            if (request.status == FutureStatus.pending) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (request.status == FutureStatus.rejected) {
              return const Center(child: Text('Ocorreu um erro.'));
            } else {
              return _buildUserDetails(request.value!);
            }
          })),
    );
  }

  Widget _buildUserDetails(User data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Center(
          child: CircleAvatar(
            radius: 90.0,
            backgroundImage: NetworkImage(data.avatarUrl),
          ),
        ),
        getUserInfo(data.email, 'E-mail'),
        getUserInfo(data.location, 'Location'),
        getUserInfo(data.bio, 'Description'),
      ],
    );
  }

  Widget getUserInfo(String data, String title) {
    return data != ''
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                data,
                style: const TextStyle(fontSize: 18.0),
              ),
            ],
          )
        : const SizedBox();
  }
}
