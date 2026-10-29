import 'package:flutter/material.dart';

class PoliticasScreen extends StatelessWidget {
  const PoliticasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF140D0E),
      appBar: AppBar(
        title: const Text('Políticas y Términos - PraxisTrack'),
        backgroundColor: const Color(0xFF140D0E),
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFFE59C3B)),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Documentación Legal y Cumplimiento',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFFE59C3B),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Conforme a los estándares académicos y normativas de gestión de pasantías, PraxisTrack garantiza la transparencia en el manejo de la información.',
              style: TextStyle(color: Colors.grey, fontSize: 13),
            ),
            const SizedBox(height: 20),

            // 1. Política de Privacidad
            _buildSeccionLegal(
              titulo: '1. Política de Privacidad',
              icono: Icons.privacy_tip_outlined,
              contenido:
                  'En PraxisTrack recopilamos únicamente la información estrictamente necesaria para la gestión de pasantías académicas (correo electrónico, nombre, número de teléfono y registro de horas de bitácora).\n\n'
                  '• Los datos son utilizados exclusivamente para auditar y validar las horas de pasantía ante el comité académico.\n'
                  '• No compartimos información personal con terceros ajenos a la institución educativa o los tutores asignados.',
            ),
            const SizedBox(height: 12),

            // 2. Términos y Condiciones
            _buildSeccionLegal(
              titulo: '2. Términos y Condiciones de Uso',
              icono: Icons.gavel_rounded,
              contenido:
                  'El acceso y uso de la aplicación móvil PraxisTrack implica la aceptación de los siguientes términos:\n\n'
                  '• El estudiante es responsable de la veracidad de las horas registradas en su bitácora de pasantías.\n'
                  '• El uso indebido de la plataforma o la falsificación de reportes de horas acarreará sanciones según el reglamento de la institución educativa.\n'
                  '• La plataforma se proporciona bajo un entorno de validación académica y desarrollo continuo.',
            ),
            const SizedBox(height: 12),

            // 3. Política de Cookies
            _buildSeccionLegal(
              titulo: '3. Política de Cookies y Almacenamiento Local',
              icono: Icons.cookie_outlined,
              contenido:
                  'Debido a que PraxisTrack cuenta con versiones web y móvil sincronizadas:\n\n'
                  '• Utilizamos almacenamiento local seguro (tokens de sesión y caché local) en el dispositivo para mantener la sesión activa del estudiante.\n'
                  '• No utilizamos cookies de rastreo publicitario ni analíticas comerciales de terceros.\n'
                  '• Los datos guardados localmente se eliminan automáticamente al cerrar sesión de forma segura.',
            ),
            const SizedBox(height: 30),

            Center(
              child: Text(
                'PraxisTrack 2026 • Versión Académica 1.0',
                style: TextStyle(color: Colors.grey[700], fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget auxiliar para mantener el diseño limpio
  Widget _buildSeccionLegal({
    required String titulo,
    required IconData icono,
    required String contenido,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF261618),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white10),
      ),
      child: ExpansionTile(
        leading: Icon(icono, color: const Color(0xFFE59C3B)),
        title: Text(
          titulo,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
        iconColor: const Color(0xFFE59C3B),
        collapsedIconColor: Colors.grey,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Text(
              contenido,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 13,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
