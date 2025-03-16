import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'login_page.dart';

class FavoritesPage extends StatefulWidget {
  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  List<dynamic> _favorites = [];
  final _prefs = SharedPreferences.getInstance();
  bool _isGridView = false;

  @override
  void initState() {
    super.initState();
    _fetchFavorites();
    _loadViewMode();
  }

  Future<void> _loadViewMode() async {
    final prefs = await _prefs;
    setState(() {
      _isGridView = prefs.getBool('view_mode') ?? false;
    });
  }

  Future<void> _saveViewMode(bool isGridView) async {
    final prefs = await _prefs;
    await prefs.setBool('view_mode', isGridView);
  }

  Future<void> _fetchFavorites() async {
    final prefs = await _prefs;
    final token = prefs.getString('token');
    if (token == null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
      return;
    }

    final response = await http.get(
      Uri.parse('http://192.168.1.4:5000/favorites'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      setState(() {
        _favorites = jsonDecode(response.body);
      });
    } else {
      Fluttertoast.showToast(msg: 'Failed to load favorites');
    }
  }

  Future<void> _removeFavorite(int articleId) async {
    final prefs = await _prefs;
    final token = prefs.getString('token');
    if (token == null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
      return;
    }

    final response = await http.post(
      Uri.parse('http://192.168.1.4:5000/remove_favorite'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({'article_id': articleId}),
    );

    if (response.statusCode == 200) {
      Fluttertoast.showToast(msg: 'Removed from favorites');
      _fetchFavorites();
    } else {
      Fluttertoast.showToast(msg: 'Failed to remove favorite');
    }
  }

  void _toggleView() {
    setState(() {
      _isGridView = !_isGridView;
    });
    _saveViewMode(_isGridView);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites'),
        actions: [
          IconButton(
            icon: Icon(_isGridView ? Icons.list : Icons.grid_view),
            onPressed: _toggleView,
          ),
        ],
      ),
      body: _isGridView ? _buildGrid() : _buildList(),
    );
  }

  Widget _buildList() {
    return ListView.builder(
      itemCount: _favorites.length,
      itemBuilder: (context, index) {
        final favorite = _favorites[index];
        return Card(
          margin: EdgeInsets.all(8.0),
          child: ListTile(
            leading: Image.network(
              favorite['image_url'],
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
            title: Text(favorite['title']),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Seller: ${favorite['seller']}'),
                Text('Rating: ${favorite['rating']}'),
              ],
            ),
            trailing: IconButton(
              icon: Icon(Icons.favorite),
              onPressed: () => _removeFavorite(favorite['id']),
            ),
          ),
        );
      },
    );
  }

  Widget _buildGrid() {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
      ),
      itemCount: _favorites.length,
      itemBuilder: (context, index) {
        final favorite = _favorites[index];
        return Card(
          margin: EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Image.network(
                  favorite['image_url'],
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      favorite['title'],
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 4),
                    Text('Seller: ${favorite['seller']}'),
                    SizedBox(height: 4),
                    Text('Rating: ${favorite['rating']}'),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: IconButton(
                  icon: Icon(Icons.favorite),
                  onPressed: () => _removeFavorite(favorite['id']),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}