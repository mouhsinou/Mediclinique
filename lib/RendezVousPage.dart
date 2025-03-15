import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RendezVousPage extends StatelessWidget {
  const RendezVousPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rendez-vous'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Gestion des Rendez-vous',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text(
              'Planifiez et gérez les rendez-vous de vos patients.',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 24),
            _buildAppointmentsList(),
          ],
        ),
      ),
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
}