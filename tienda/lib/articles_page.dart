import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tienda/login_page.dart';
import 'favorites_page.dart';

class ArticlesPage extends StatefulWidget {
  @override
  _ArticlesPageState createState() => _ArticlesPageState();
}

class _ArticlesPageState extends State<ArticlesPage> {
  List<dynamic> _articles = [];
  final _prefs = SharedPreferences.getInstance();
  bool _isGridView = false;

  @override
  void initState() {
    super.initState();
    _fetchArticles();
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
  
  Future<void> _fetchArticles() async {
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
      Uri.parse('http://192.168.1.4:5000/articles'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      setState(() {
        _articles = jsonDecode(response.body);
      });
    } else {
      Fluttertoast.showToast(msg: 'Failed to load articles');
    }
  }

  Future<void> _addFavorite(int articleId) async {
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
      Uri.parse('http://192.168.1.4:5000/add_favorite'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({'article_id': articleId}),
    );

    if (response.statusCode == 200) {
      Fluttertoast.showToast(msg: 'Added to favorites');
    } else {
      Fluttertoast.showToast(msg: 'Failed to add favorite');
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
        title: Text('Articles'),
        actions: [
          IconButton(
            icon: Icon(_isGridView ? Icons.list : Icons.grid_view),
            onPressed: _toggleView,
          ),
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FavoritesPage()),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              final prefs = await _prefs;
              await prefs.remove('token');
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
          ),
        ],
      ),
      body: _isGridView ? _buildGrid() : _buildList(),
    );
  }

  Widget _buildList() {
    return ListView.builder(
      itemCount: _articles.length,
      itemBuilder: (context, index) {
        final article = _articles[index];
        return Card(
          margin: EdgeInsets.all(8.0),
          child: ListTile(
            leading: Image.network(
              article['image_url'],
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
            title: Text(article['title']),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Seller: ${article['seller']}'),
                Text('Rating: ${article['rating']}'),
              ],
            ),
            trailing: IconButton(
              icon: Icon(Icons.favorite_border),
              onPressed: () => _addFavorite(article['id']),
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
      itemCount: _articles.length,
      itemBuilder: (context, index) {
        final article = _articles[index];
        return Card(
          margin: EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Image.network(
                  article['image_url'],
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      article['title'],
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 4),
                    Text('Seller: ${article['seller']}'),
                    SizedBox(height: 4),
                    Text('Rating: ${article['rating']}'),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: IconButton(
                  icon: Icon(Icons.favorite_border),
                  onPressed: () => _addFavorite(article['id']),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}