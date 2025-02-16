import 'package:flutter/material.dart';

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
  bool _showProjects = false; // Contrôle l'affichage des projets

  void _toggleProjects() {
    setState(() {
      _showProjects = !_showProjects; // Change l'état pour afficher/masquer les projets
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              SizedBox(
                height: 55,
                child: AppBar(
                  title: const Text('Adrien Verwaerde'),
                  titleTextStyle: const TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                  backgroundColor: const Color.fromARGB(255, 0, 89, 170),
                ),
              ),
              Positioned(
                left: MediaQuery.of(context).size.width / 2 - 53,
                child: const CircleAvatar(
                  radius: 55,
                  backgroundColor: Color.fromARGB(255, 0, 89, 170),
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('pp.png'),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 70),
          const Text(
            "Bienvenue sur mon Portfolio !",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: _toggleProjects,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 0, 89, 170),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                ),
                child: const Text(
                  "Voir mes projets",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(width: 20),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 0, 89, 170),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                ),
                child: const Text(
                  "Me contacter",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          // Afficher les projets si _showProjects est vrai
          if (_showProjects)
            Column(
              children: [
                _buildProjectCard("Projet 1"),
                _buildProjectCard("Projet 2"),
                _buildProjectCard("Projet 3"),
              ],
            ),
        ],
      ),
    );
  }

  // Méthode pour créer des cartes de projet
  Widget _buildProjectCard(String projectName) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        title: Text(
          projectName,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: const Text("Description du projet ici."),
        trailing: const Icon(Icons.arrow_forward),
        onTap: () {
          // Action à effectuer lorsqu'on clique sur la carte
        },
      ),
    );
  }
}
