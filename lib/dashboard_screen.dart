import 'package:flutter/material.dart';
import 'DossiersPage.dart';
import 'medecins.dart';

void main() {
  runApp(const MedicliniquApp());
}

class MedicliniquApp extends StatelessWidget {
  const MedicliniquApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mediclinique',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        //accentColor: Colors.green, // Couleur d'accentuation verte
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.blue,
        ).copyWith(
          secondary: Colors.green, // Utilisation correcte
        ),
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Sans-serif',
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  // Pages correspondant aux onglets du BottomNavigationBar
  final List<Widget> _pages = [
    const AccueilPage(),
    const RendezVousPage(),
    const DossiersPage(),
    const PatientsPage(),
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
        title: const Text('Mediclinique'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DossiersPage()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MedecinsPage()),
              );
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.local_hospital,
                      size: 40,
                      color: Colors.blue,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Mediclinique',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.calendar_today),
              title: const Text('Rendez-vous'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Rendez-vous - Fonctionnalité à venir'),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.folder),
              title: const Text('Dossiers médicaux'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Dossiers médicaux - Fonctionnalité à venir'),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.people),
              title: const Text('Patients'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Patients - Fonctionnalité à venir'),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.medical_services),
              title: const Text('Médecins'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Médecins - Fonctionnalité à venir'),
                  ),
                );
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Paramètres'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Paramètres - Fonctionnalité à venir'),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.help),
              title: const Text('Aide'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Aide - Fonctionnalité à venir'),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Accueil'),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Rendez-vous',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.folder), label: 'Dossiers'),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Patients'),
        ],
        onTap: _onItemTapped,
      ),
    );
  }
}

class AccueilPage extends StatelessWidget {
  const AccueilPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          const Text(
            'Bienvenue sur Mediclinique',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          const Text(
            'Votre solution complète pour la gestion de votre clinique',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          const SizedBox(height: 24),
          TextField(
            decoration: InputDecoration(
              hintText: 'Rechercher un patient...',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const SizedBox(height: 24),
          _buildFeatureCardsGrid(context),
          const SizedBox(height: 24),
          const Text(
            'Rendez-vous à venir',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _buildAppointmentsList(),
        ],
      ),
    );
  }

  Widget _buildFeatureCardsGrid(BuildContext context) {
    final features = [
      {
        'title': 'Rendez-vous',
        'icon': Icons.calendar_today,
        'description': 'Gérer les rendez-vous et la disponibilité',
        'color': Colors.blue,
      },
      {
        'title': 'Dossiers médicaux',
        'icon': Icons.folder,
        'description': 'Accéder aux dossiers des patients',
        'color': Colors.green,
      },
      {
        'title': 'Orientation',
        'icon': Icons.location_on,
        'description': 'Améliorer l\'accueil et l\'orientation',
        'color': Colors.orange,
      },
      {
        'title': 'Médecins',
        'icon': Icons.medical_services,
        'description': 'Gérer les médecins et leurs spécialités',
        'color': Colors.purple,
      },
    ];

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1,
      ),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: features.length,
      itemBuilder: (context, index) {
        final feature = features[index];
        return _buildFeatureCard(
          context,
          title: feature['title'] as String,
          icon: feature['icon'] as IconData,
          description: feature['description'] as String,
          color: feature['color'] as Color,
        );
      },
    );
  }

  Widget _buildAppointmentsList() {
    final appointments = [
      {
        'patient': 'Martin Dupont',
        'doctor': 'Dr. Lefèvre',
        'time': '15:00',
        'date': '15/03/2025',
      },
      {
        'patient': 'Sophie Lambert',
        'doctor': 'Dr. Moreau',
        'time': '16:00',
        'date': '16/03/2025',
      },
      {
        'patient': 'Jean Petit',
        'doctor': 'Dr. Dubois',
        'time': '17:00',
        'date': '17/03/2025',
      },
    ];

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: appointments.length,
      itemBuilder: (context, index) {
        final appointment = appointments[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: ListTile(
            leading: const CircleAvatar(child: Icon(Icons.person)),
            title: Text(appointment['patient'] as String),
            subtitle: Text(
              '${appointment['doctor']} - ${appointment['time']}, ${appointment['date']}',
            ),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Détails du rendez-vous avec ${appointment['patient']} - Fonctionnalité à venir',
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildFeatureCard(
    BuildContext context, {
    required String title,
    required IconData icon,
    required String description,
    required Color color,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: () {
          if (title == 'Rendez-vous') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const RendezVousPage()),
            );
          } else if (title == 'Dossiers médicaux') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const DossiersPage()),
            );
          } else if (title == 'Patients') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const PatientsPage()),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('$title - Fonctionnalité à venir')),
            );
          }
        },
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 48, color: color),
              const SizedBox(height: 16),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                description,
                style: const TextStyle(fontSize: 12, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RendezVousPage extends StatelessWidget {
  const RendezVousPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Page Rendez-vous', style: TextStyle(fontSize: 24)),
    );
  }
}

class DossiersPage extends StatelessWidget {
  const DossiersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Page Dossiers', style: TextStyle(fontSize: 24)),
    );
  }
}

class PatientsPage extends StatelessWidget {
  const PatientsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Page Patients', style: TextStyle(fontSize: 24)),
    );
  }
}
