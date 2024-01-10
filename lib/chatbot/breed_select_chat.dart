import 'package:flutter/material.dart';
import 'package:pupscan/Api/api.dart';
import 'package:pupscan/utils/models.dart';
import 'package:pupscan/ChatBot/chat_bot_ui.dart';

class BreedListPageBot extends StatefulWidget {
  const BreedListPageBot({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _BreedsListPageState createState() => _BreedsListPageState();
}

class _BreedsListPageState extends State<BreedListPageBot> {
  List<ListBreed> _breeds = [];
  List<ListBreed> _filteredBreeds = [];

  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadBreeds();
  }

  Future<void> _loadBreeds() async {
    List<ListBreed> breeds = await ApiCalls.loadBreeds();
    breeds.sort((a, b) => a.breed.compareTo(b.breed));
    setState(() {
      _breeds = breeds;
      _filteredBreeds = _breeds; // Initialize filtered list with all breeds
    });
  }

  void _filterBreeds(String query) {
    setState(() {
      _filteredBreeds = _breeds
          .where((breed) =>
              breed.breed.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  Widget _buildBreedListTile(BuildContext context, int index) {
    var breeds = _filteredBreeds[index];

    return ListTile(
      onTap: () => _navigateToChatBot(breeds),
      leading: Hero(
        tag: index,
        child: CircleAvatar(
          backgroundImage: NetworkImage(breeds.avatar),
        ),
      ),
      title: Text(breeds.breed),
      subtitle: Text(breeds.type),
    );
  }

  void _navigateToChatBot(ListBreed breed) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (c) {
          return ChatBot(
            breed: breed,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Breed for Chat Preference'),
        backgroundColor: Colors.lightGreen[200],
      ),
      body: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 10),
            child: TextField(
              controller: _searchController,
              onChanged: _filterBreeds,
              decoration: InputDecoration(
                labelText: 'Search by Breed',
                suffixIcon: const Icon(Icons.search),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.green),
                  borderRadius: BorderRadius.circular(20),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.green),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
          Expanded(
            child: _buildBreedListView(),
          ),
        ],
      ),
    );
  }

  Widget _buildBreedListView() {
    Widget content;

    if (_filteredBreeds.isEmpty) {
      content = const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      content = ListView.builder(
        itemCount: _filteredBreeds.length,
        itemBuilder: _buildBreedListTile,
      );
    }

    return content;
  }
}
