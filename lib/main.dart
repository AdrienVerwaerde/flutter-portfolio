import 'package:flutter/material.dart';
import 'package:flutter_b3/texts.dart';
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

class _PortfolioScreenState extends State<PortfolioScreen>
    with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  bool _showFooter = false;
  String _activeSection = "";
  String _activeButton = "";
  bool _showTextSection = true;

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
      0.0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void _toggleProjects() {
    setState(() {
      if (_activeSection == "projects") {
        _activeSection = "";
        _activeButton = "";
        _showTextSection = true;
      } else {
        _activeSection = "projects";
        _activeButton = "projects";
        _showTextSection = false;
      }
    });
  }

  void _toggleSocials() {
    setState(() {
      if (_activeSection == "socials") {
        _activeSection = "";
        _activeButton = "";
        _showTextSection = true;
      } else {
        _activeSection = "socials";
        _activeButton = "socials";
        _showTextSection = false;
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
                            color: Colors.white,
                          ),
                        ),
                        backgroundColor: primaryColor,
                        actions: [
                          Padding(
                            padding: const EdgeInsets.only(right: 16.0),
                            child: Center(
                              child: Text(
                                AppTexts.appbarText,
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
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        margin: const EdgeInsets.only(top: 1),
                        child: const CircleAvatar(
                          radius: 45,
                          backgroundColor: primaryColor,
                          child: CircleAvatar(
                            radius: 40,
                            backgroundImage: AssetImage('assets/images/pp.png'),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                AnimatedSize(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  child: Column(
                    children: [
                      SizedBox(height: _showTextSection ? 70 : 50),
                      ClipRect(
                        child: AnimatedSwitcher(
                          duration:
                              _showTextSection
                                  ? const Duration(milliseconds: 0)
                                  : const Duration(milliseconds: 300),
                          transitionBuilder: (child, animation) {
                            return SlideTransition(
                              position: Tween<Offset>(
                                begin: const Offset(0, -0.3),
                                end: Offset.zero,
                              ).animate(animation),
                              child: child,
                            );
                          },
                          child:
                              _showTextSection
                                  ? Column(
                                    key: const ValueKey("textSection"),
                                    children: [
                                      Transform.translate(
                                        offset: const Offset(0, -0),
                                        child: Text(
                                          AppTexts.welcomeMessage,
                                          style: GoogleFonts.gemunuLibre(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                            color: secondaryColor,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 30.0,
                                          vertical: 10.0,
                                        ),
                                        child: Text(
                                          AppTexts.desc,
                                          textAlign: TextAlign.justify,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                    ],
                                  )
                                  : const SizedBox.shrink(),
                        ),
                      ),

                      // Boutons
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
                              AppTexts.projectsButton.toUpperCase(),
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
                              AppTexts.contactButton.toUpperCase(),
                              style: GoogleFonts.gemunuLibre(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                if (_activeSection == "projects")
                  Column(
                    children: [
                      _buildProjectCard(
                        "GameChamp",
                        "NextJS, MongoDB",
                        'assets/images/project1.png',
                        "https://gamechamp.vercel.app/",
                      ),
                      _buildProjectCard(
                        "CBDlisse",
                        "Shopify, Liquid, JavaScript",
                        'assets/images/project2.png',
                        "https://cbdlisse.fr/",
                      ),
                      _buildProjectCard(
                        "Balance Ton Spot",
                        "React, TypeScript, MySQL",
                        'assets/images/project3.png',
                        "https://github.com/AdrienVerwaerde/BalanceTonSpot",
                      ),
                    ],
                  ),
                if (_activeSection == "socials")
                  Column(
                    children: [
                      const SizedBox(height: 50),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildSocialItem(
                            "GitHub",
                            "assets/images/github.png",
                            "https://github.com/AdrienVerwaerde",
                          ),
                          const SizedBox(width: 50),
                          _buildSocialItem(
                            "LinkedIn",
                            "assets/images/linkedin.png",
                            "https://www.linkedin.com/in/adrien-verwaerde-018ba4195/",
                          ),
                          const SizedBox(width: 50),
                          _buildSocialItem(
                            "Discord",
                            "assets/images/discord.png",
                            "https://discord.com/users/139466047387336704",
                          ),
                        ],
                      ),
                    ],
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

  // Build project cards
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
        child: Container(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              center: Alignment(0.7, -0.6),
              radius: 1,
              colors: [primaryColor, secondaryColor],
            ),
            borderRadius: BorderRadius.circular(10),
          ),
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
                padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
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
                onPressed: () => _launchURL(url),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      AppTexts.seeProject,
                      style: TextStyle(color: Colors.white),
                    ),
                    Icon(Icons.arrow_forward, color: Colors.white),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Build social items
  Widget _buildSocialItem(String socialName, String imagePath, String url) {
    return GestureDetector(
      onTap: () => _launchURL(url),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(imagePath, height: 50, width: 50),
          const SizedBox(height: 8),
          Text(
            socialName,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
