import 'package:flutter/material.dart';

// Color constants for light theme
const Color primaryColor = Color(0xFFFF7043);
const Color secondaryColor = Color(0xFFFFF3E0);
const Color accentColor = Color(0xFF388E3C);

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
        colorScheme: ColorScheme(
          brightness: Brightness.light,
          primary: primaryColor,
          onPrimary: Colors.white,
          secondary: accentColor,
          onSecondary: Colors.white,
          error: Colors.red,
          onError: Colors.white,
          background: secondaryColor,
          onBackground: Colors.black,
          surface: Colors.white,
          onSurface: Colors.black,
        ),
        scaffoldBackgroundColor: secondaryColor,
        appBarTheme: const AppBarTheme(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          centerTitle: true,
          elevation: 0,
        ),
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

  // List of navigation destinations with their associated widget builders.
  static final List<Widget> _pages = <Widget>[
    const HomePage(),
    const SearchPage(),
    const FavoritesPage(),
    const ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: _pages[_selectedIndex]),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        currentIndex: _selectedIndex,
        selectedItemColor: primaryColor,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorites'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}

// PUBLIC_INTERFACE
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Top search bar, carousel, categories (all scaffolded, nothing interactive yet)
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(22),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: TextField(
                enabled: false,
                decoration: InputDecoration(
                  hintText: 'Search recipes...',
                  prefixIcon: Icon(Icons.search, color: accentColor),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 14),
                  hintStyle: TextStyle(color: Colors.grey[500]),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),

          // Featured Recipes Carousel Placeholder
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SectionHeader(title: "Featured"),
          ),
          SizedBox(
            height: 180,
            child: PageView.builder(
              controller: PageController(viewportFraction: 0.83),
              itemCount: 3,
              itemBuilder: (context, index) => FeaturedRecipeCard(index: index),
            ),
          ),
          const SizedBox(height: 20),

          // Category Cards row
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SectionHeader(title: "Categories"),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: SizedBox(
              height: 100,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: const [
                  CategoryCard(title: "Breakfast", icon: Icons.free_breakfast, color: Color(0xFFFFB300)),
                  CategoryCard(title: "Lunch", icon: Icons.lunch_dining, color: Color(0xFF4DB6AC)),
                  CategoryCard(title: "Dinner", icon: Icons.dinner_dining, color: Color(0xFFFF8A65)),
                  CategoryCard(title: "Dessert", icon: Icons.cake, color: Color(0xFFCE93D8)),
                  CategoryCard(title: "Snacks", icon: Icons.fastfood, color: Color(0xFF90CAF9)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 32),

          // Placeholder for future sections (e.g., trending, recommended)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(28),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                color: Colors.white,
                border: Border.all(color: secondaryColor),
              ),
              child: const Center(
                  child: Text(
                      "More features coming soon...\n(Recipe details, collections, ratings, comments, sharing)",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey))),
            ),
          ),
        ],
      ),
    );
  }
}

class SectionHeader extends StatelessWidget {
  final String title;
  const SectionHeader({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, left: 4),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 20, 
          fontWeight: FontWeight.bold,
          color: accentColor,
        ),
      ),
    );
  }
}

class FeaturedRecipeCard extends StatelessWidget {
  final int index;
  const FeaturedRecipeCard({required this.index, super.key});

  @override
  Widget build(BuildContext context) {
    final demoTitles = ["Spaghetti Carbonara", "Avocado Toast", "Berry Pancakes"];
    final demoImgs = [
      "https://images.pexels.com/photos/461382/pexels-photo-461382.jpeg",
      "https://images.pexels.com/photos/1640777/pexels-photo-1640777.jpeg",
      "https://images.pexels.com/photos/376464/pexels-photo-376464.jpeg"
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(18),
          child: Stack(
            children: [
              // Demo image
              Positioned.fill(
                child: Image.network(
                  demoImgs[index % demoImgs.length],
                  fit: BoxFit.cover,
                  color: Colors.black.withOpacity(0.06),
                  colorBlendMode: BlendMode.darken,
                  loadingBuilder: (context, child, loading) =>
                      loading == null ? child : Center(child: CircularProgressIndicator(color: accentColor)),
                ),
              ),
              // Title overlay
              Positioned(
                left: 0, right: 0, bottom: 0,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.black45, Colors.transparent],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                  child: Text(
                    demoTitles[index % demoTitles.length],
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      shadows: [Shadow(color: Colors.black54, blurRadius: 4)],
                    ),
                  ),
                ),
              ),
              // 'Featured' badge placeholder
              Positioned(
                top: 10, left: 10,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: accentColor.withOpacity(0.85),
                    borderRadius: BorderRadius.circular(13),
                  ),
                  child: const Text(
                    "Featured",
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  const CategoryCard({
    required this.title,
    required this.icon,
    required this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Just a placeholder; not clickable yet.
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 8),
      child: Container(
        width: 90,
        decoration: BoxDecoration(
          color: color.withOpacity(0.15),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withOpacity(0.33), width: 1.5),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 32),
            const SizedBox(height: 6),
            Text(
              title,
              style: TextStyle(
                color: accentColor,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// --- Placeholders for other sections ---

// PUBLIC_INTERFACE
class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Search Placeholder\n(Search/filter recipes by categories, ingredients, etc.)",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 16, color: Colors.grey)),
    );
  }
}

// PUBLIC_INTERFACE
class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Favorites Placeholder\n(Create your own collections & access saved recipes)",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 16, color: Colors.grey)),
    );
  }
}

// PUBLIC_INTERFACE
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Profile Placeholder\n(Ratings, comments, sharing, account settings, etc.)",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 16, color: Colors.grey)),
    );
  }
}
