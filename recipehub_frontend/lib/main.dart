import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// PUBLIC_INTERFACE
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RecipeHub',
      theme: ThemeData(
        // Primary color according to design
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFFFF7043)),
        useMaterial3: true,
      ),
      home: const MainContainer(),
    );
  }
}

// PUBLIC_INTERFACE
class MainContainer extends StatefulWidget {
  const MainContainer({super.key});

  @override
  State<MainContainer> createState() => _MainContainerState();
}

class _MainContainerState extends State<MainContainer> {
  int _selectedIndex = 0;

  static const List<Widget> _pageOptions = <Widget>[
    Center(child: Text('Home Placeholder')),
    Center(child: Text('Search Placeholder')),
    Center(child: Text('Favorites Placeholder')),
    Center(child: Text('Profile Placeholder')),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFF7043),
        title: const Text('RecipeHub'),
        centerTitle: true,
      ),
      body: _pageOptions[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Color(0xFFFF7043),
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
