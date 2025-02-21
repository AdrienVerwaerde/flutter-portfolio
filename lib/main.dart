import 'package:flutter/material.dart';
import 'package:flutter_b3/theme.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Portfolio',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 9, 9, 216),
        ),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const PortfolioScreen(),
    );
  }
}

class PortfolioScreen extends StatefulWidget {
  const PortfolioScreen({super.key});

  @override
  _PortfolioScreenState createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends State<PortfolioScreen> {
  final ScrollController _scrollController = ScrollController();

  bool _showFooter = false;
  String _activeSection = "";
  String _activeButton = "";

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    // Vérifie si on est en bas de la page
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      setState(() {
        _showFooter = true;
      });
    } else {
      setState(() {
        _showFooter = false;
      });
    }
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0.0, // Position en haut de la page
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void _toggleProjects() {
    setState(() {
      if (_activeSection == "projects") {
        _activeSection = "";
        _activeButton = "";
      } else {
        _activeSection = "projects";
        _activeButton = "projects";
      }
    });
  }

  void _toggleSocials() {
    setState(() {
      if (_activeSection == "socials") {
        _activeSection = "";
        _activeButton = "";
      } else {
        _activeSection = "socials";
        _activeButton = "socials";
      }
    });
  }

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    SizedBox(
                      height: 55,
                      child: AppBar(
                        title: Text(
                          'Adrien Verwaerde',
                          style: GoogleFonts.gemunuLibre(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        titleTextStyle: const TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                        backgroundColor: primaryColor,
                        actions: [
                          Padding(
                            padding: const EdgeInsets.only(right: 16.0),
                            child: Center(
                              child: Text(
                                'Développeur Frontend',
                                style: GoogleFonts.gemunuLibre(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      left: MediaQuery.of(context).size.width / 2 - 53,
                      child: const CircleAvatar(
                        radius: 45,
                        backgroundColor: primaryColor,
                        child: CircleAvatar(
                          radius: 40,
                          backgroundImage: AssetImage('/images/pp.png'),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 70),
                Text(
                  "Bienvenue sur mon Portfolio !",
                  style: GoogleFonts.gemunuLibre(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: secondaryColor
                                ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30.0,
                    vertical: 10.0,
                  ),
                  child: Column(
                    mainAxisAlignment:
                        MainAxisAlignment.center,
                    crossAxisAlignment:
                        CrossAxisAlignment
                            .stretch,
                    children: [
                      Text(
                        "Lorem ipsum dolor sit amet consectetur adipisicing elit. Quae, quos. Lorem ipsum dolor sit amet consectetur adipisicing elit. Quae, quos. Lorem ipsum dolor sit amet consectetur adipisicing elit.",
                        textAlign:
                            TextAlign
                                .justify,
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: _toggleProjects,
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            _activeButton == "projects"
                                ? secondaryColor
                                : primaryColor,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                      ),
                      child: Text(
                        "Voir mes projets".toUpperCase(),
                        style: GoogleFonts.gemunuLibre(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    ElevatedButton(
                      onPressed: _toggleSocials,
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            _activeButton == "socials"
                                ? secondaryColor
                                : primaryColor,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                      ),
                      child: Text(
                        "Me contacter".toUpperCase(),
                        style: GoogleFonts.gemunuLibre(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                if (_activeSection == "projects")
                  Column(
                    children: [
                      _buildProjectCard(
                        "GameChamp",
                        "Description du Projet 1",
                        'images/project1.png',
                        "https://gamechamp.vercel.app/",
                      ),
                      _buildProjectCard(
                        "CBDlisse",
                        "Description du Projet 2",
                        'images/project2.png',
                        "https://cbdlisse.fr/",
                      ),
                      _buildProjectCard(
                        "Balance Ton Spot",
                        "Description du Projet 3",
                        'images/project3.png',
                        "https://github.com/AdrienVerwaerde/BalanceTonSpot",
                      ),
                    ],
                  ),
                if (_activeSection == "socials")
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildSocialItem(
                          "GitHub",
                          "images/github.png",
                          "https://github.com/AdrienVerwaerde",
                        ),
                        _buildSocialItem(
                          "LinkedIn",
                          "images/linkedin.png",
                          "https://www.linkedin.com/in/adrien-verwaerde-018ba4195/",
                        ),
                        _buildSocialItem(
                          "Discord",
                          "images/discord.png",
                          "https://discord.com/users/139466047387336704",
                        ),
                      ],
                    ),
                  ),
                const SizedBox(height: 60),
              ],
            ),
          ),
          if (_showFooter)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                color: primaryColor,
                padding: const EdgeInsets.symmetric(
                  vertical: 0,
                  horizontal: 20,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Adrien Verwaerde - Portfolio',
                      style: GoogleFonts.gemunuLibre(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 20),
                    IconButton(
                      icon: const Icon(Icons.arrow_upward, color: Colors.white),
                      onPressed: _scrollToTop,
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  // Project cards
  Widget _buildProjectCard(
    String projectName,
    String projectDescription,
    String imagePath,
    String url,
  ) {
    return GestureDetector(
      onTap: () => _launchURL(url),
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        color: secondaryColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    projectName,
                    style: GoogleFonts.gemunuLibre(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    projectDescription,
                    style: const TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                8.0, // Left
                0.0, // Top
                8.0, // Right
                0.0, // Bottom
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  imagePath,
                  height: 320,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            TextButton(
              onPressed: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text("Voir le projet", style: TextStyle(color: Colors.white)),
                  Icon(Icons.arrow_forward, color: Colors.white),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Social media item
  Widget _buildSocialItem(String socialName, String imagePath, String url) {
    return GestureDetector(
      onTap: () => _launchURL(url),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(imagePath, height: 50, width: 50),
          const SizedBox(height: 8),
          Text(socialName, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
