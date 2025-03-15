import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class MedicliniquApp extends StatelessWidget {
  const MedicliniquApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mediclinique',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.blue,
        ).copyWith(
          secondary: Colors.green,
        ),
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Sans-serif',
      ),
      home: const MedecinsPage(),
    );
  }
}

class MedecinsPage extends StatefulWidget {
  const MedecinsPage({Key? key}) : super(key: key);

  @override
  _MedecinsPageState createState() => _MedecinsPageState();
}

class _MedecinsPageState extends State<MedecinsPage> {
  final List<String> _specialites = [
    'Cardiologie',
    'Dermatologie',
    'Pédiatrie',
    'Chirurgie',
    'Radiologie',
  ];

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> _ajouterMedecin(Map<String, dynamic> medecin) async {
    await _firestore.collection('medecins').add(medecin);
  }

  Future<List<Map<String, dynamic>>> _getMedecinsBySpecialite(String specialite) async {
    final querySnapshot = await _firestore
        .collection('medecins')
        .where('specialite', isEqualTo: specialite)
        .get();

    return querySnapshot.docs.map((doc) => doc.data()).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Médecins'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _specialites.length,
              itemBuilder: (context, index) {
                final specialite = _specialites[index];
                return Card(
                  margin: const EdgeInsets.all(8),
                  child: ListTile(
                    leading: const Icon(Icons.medical_services, size: 40),
                    title: Text(
                      specialite,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () async {
                      final medecins = await _getMedecinsBySpecialite(specialite);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ListeMedecinsPage(
                            specialite: specialite,
                            medecins: medecins,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton.icon(
              icon: const Icon(Icons.add),
              label: const Text('Ajouter un Médecin'),
              onPressed: () {
                _showAjouterMedecinDialog(context);
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showAjouterMedecinDialog(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final _nomController = TextEditingController();
    final _prenomController = TextEditingController();
    final _specialiteController = TextEditingController();
    final _anneeExperienceController = TextEditingController();
    final _photoController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Ajouter un Médecin'),
          content: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: _nomController,
                    decoration: const InputDecoration(labelText: 'Nom'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrer un nom';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _prenomController,
                    decoration: const InputDecoration(labelText: 'Prénom'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrer un prénom';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _specialiteController,
                    decoration: const InputDecoration(labelText: 'Spécialité'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrer une spécialité';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _anneeExperienceController,
                    decoration: const InputDecoration(labelText: 'Années d\'expérience'),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrer les années d\'expérience';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _photoController,
                    decoration: const InputDecoration(labelText: 'URL de la photo'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrer une URL de photo';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Annuler'),
            ),
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  final medecin = {
                    'nom': _nomController.text,
                    'prenom': _prenomController.text,
                    'specialite': _specialiteController.text,
                    'anneeExperience': int.parse(_anneeExperienceController.text),
                    'photo': _photoController.text,
                  };

                  await _ajouterMedecin(medecin);
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Médecin ajouté avec succès')),
                  );
                }
              },
              child: const Text('Ajouter'),
            ),
          ],
        );
      },
    );
  }
}

class ListeMedecinsPage extends StatelessWidget {
  final String specialite;
  final List<Map<String, dynamic>> medecins;

  const ListeMedecinsPage({
    Key? key,
    required this.specialite,
    required this.medecins,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Médecins en $specialite'),
      ),
      body: ListView.builder(
        itemCount: medecins.length,
        itemBuilder: (context, index) {
          final medecin = medecins[index];
          return Card(
            margin: const EdgeInsets.all(8),
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(medecin['photo']),
              ),
              title: Text('${medecin['nom']} ${medecin['prenom']}'),
              subtitle: Text('${medecin['anneeExperience']} ans d\'expérience'),
            ),
          );
        },
      ),
    );
  }
}