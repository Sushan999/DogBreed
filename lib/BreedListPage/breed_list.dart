import 'package:pupscan/Api/api.dart';
import 'package:pupscan/utils/models.dart';
import 'package:pupscan/DetailPage/detail_screen.dart';
import 'package:flutter/material.dart';

class BreedListPage extends StatefulWidget {
  const BreedListPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _BreedsListPageState createState() => _BreedsListPageState();
}

class _BreedsListPageState extends State<BreedListPage> {
  List<ListBreed> _breeds = [];
  List<ListBreed> _filteredBreeds = [];
  bool isLoading = false;

  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadBreedsList();
  }

  Future<void> _loadBreedsList() async {
    List<ListBreed> dogs = await ApiCalls.loadBreeds();
    dogs.sort((a, b) => a.breed.compareTo(b.breed));
    setState(() {
      _breeds = dogs;
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
    var breed = _filteredBreeds[index];

    return ListTile(
      onTap: () => _navigateToBreedDetails(breed.id),
      leading: Hero(
        tag: index,
        child: CircleAvatar(
          backgroundImage: NetworkImage(breed.avatar),
        ),
      ),
      title: Text(breed.breed),
      subtitle: Text(breed.type),
    );
  }

  Future<void> _navigateToBreedDetails(int index) async {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (c) {
          return ResultScreen(
            id: index,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Identified Breeds'),
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

    if (_filteredBreeds.isEmpty || isLoading) {
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
