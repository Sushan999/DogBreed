import 'dart:convert';
import 'package:meta/meta.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BreedDetailPage extends StatelessWidget {
  final String dogBreed;

  const BreedDetailPage({super.key, required this.dogBreed});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Breed Details'),
      ),
      body: Center(
        child: Text('Details for $dogBreed'),
      ),
    );
  }
}

class FriendsListPage extends StatefulWidget {
  const FriendsListPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _FriendsListPageState createState() => _FriendsListPageState();
}

class _FriendsListPageState extends State<FriendsListPage> {
  List<Friend> _friends = [];

  @override
  void initState() {
    super.initState();
    _loadFriends();
  }

  Future<void> _loadFriends() async {
    http.Response response =
        await http.get(Uri.parse("https://randomuser.me/api/?results=25"));

    setState(() {
      _friends = Friend.allFromResponse(response.body);
    });
  }

  Widget _buildFriendListTile(BuildContext context, int index) {
    var friend = _friends[index];

    return ListTile(
      onTap: () => _navigateToFriendDetails(friend, index),
      leading: Hero(
        tag: index,
        child: CircleAvatar(
          backgroundImage: NetworkImage(friend.avatar),
        ),
      ),
      title: Text(friend.name),
      subtitle: Text(friend.email),
    );
  }

  void _navigateToFriendDetails(Friend friend, Object avatarTag) {
    Navigator.of(context).push(
      MaterialPageRoute(
          builder: (c) => BreedDetailPage(
                dogBreed: 'German',
              )),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget content;

    if (_friends.isEmpty) {
      content = const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      content = ListView.builder(
        itemCount: _friends.length,
        itemBuilder: _buildFriendListTile,
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text('Friends')),
      body: content,
    );
  }
}

class Friend {
  Friend({
    required this.avatar,
    required this.name,
    required this.email,
    required this.location,
  });

  final String avatar;
  final String name;
  final String email;
  final String location;

  static List<Friend> allFromResponse(String response) {
    var decodedJson = json.decode(response).cast<String, dynamic>();

    return decodedJson['results']
        .cast<Map<String, dynamic>>()
        .map((obj) => Friend.fromMap(obj))
        .toList()
        .cast<Friend>();
  }

  static Friend fromMap(Map map) {
    var name = map['name'];

    return Friend(
      avatar: map['picture']['large'],
      name: '${_capitalize(name['first'])} ${_capitalize(name['last'])}',
      email: map['email'],
      location: _capitalize(map['location']['state']),
    );
  }

  static String _capitalize(String input) {
    return input.substring(0, 1).toUpperCase() + input.substring(1);
  }
}
