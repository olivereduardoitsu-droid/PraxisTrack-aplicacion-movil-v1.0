import 'package:flutter/material.dart';

import '../models/oferta_model.dart';
import '../services/api_service.dart';
import 'bitacora_screen.dart';

class OfertasScreen extends StatefulWidget {
  const OfertasScreen({super.key});

  @override
  State<OfertasScreen> createState() => _OfertasScreenState();
}

class _OfertasScreenState extends State<OfertasScreen> {
  final ApiService _apiService = ApiService();
  late Future<List<Oferta>> _futureOfertas;

  @override
  void initState() {
    super.initState();
    _futureOfertas = _apiService.getOfertas();
  }

  void _postularse(String tituloOferta) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Postulación enviada con éxito a: $tituloOferta'),
        backgroundColor: const Color(0xFFE59C3B),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PraxisTrack - Marketplace'),
        backgroundColor: const Color(0xFF1A1112),
        foregroundColor: const Color(0xFFF3C677),
        actions: [
          IconButton(
            icon: const Icon(Icons.assignment_outlined),
            tooltip: 'Ir a Bitácora',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const BitacoraScreen()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF261618),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFF5A3230), width: 1),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Mi Progreso de Prácticas',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF3D2314),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Text(
                            '71%',
                            style: TextStyle(
                              color: Color(0xFFE59C3B),
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Text(
                              '348 hrs',
                              style: TextStyle(
                                color: Color(0xFFE59C3B),
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'APROBADAS',
                              style: TextStyle(
                                color: Colors.white54,
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 30,
                          child: VerticalDivider(color: Colors.white24),
                        ),
                        Column(
                          children: [
                            Text(
                              '148 hrs',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'RESTANTES',
                              style: TextStyle(
                                color: Colors.white54,
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF3D2314),
                          foregroundColor: const Color(0xFFE59C3B),
                          side: const BorderSide(
                            color: Color(0xFFE59C3B),
                            width: 0.5,
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const BitacoraScreen(),
                            ),
                          );
                        },
                        icon: const Icon(Icons.edit_calendar, size: 18),
                        label: const Text('Ver / Registrar Bitácora Completa'),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Oportunidades Disponibles',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Vacantes pre-aprobadas y auditadas para acreditación.',
                style: TextStyle(color: Colors.white54, fontSize: 12),
              ),
              const SizedBox(height: 12),
              FutureBuilder<List<Oferta>>(
                future: _futureOfertas,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(20.0),
                        child: CircularProgressIndicator(
                          color: Color(0xFFE59C3B),
                        ),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        'Error: ${snapshot.error}',
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(
                      child: Text(
                        'No hay ofertas disponibles.',
                        style: TextStyle(color: Colors.white70),
                      ),
                    );
                  }

                  final ofertas = snapshot.data!;
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: ofertas.length,
                    itemBuilder: (context, index) {
                      final oferta = ofertas[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        color: const Color(0xFF261618),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: const BorderSide(
                            color: Color(0xFF5A3230),
                            width: 1,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      oferta.empresa ?? 'Empresa',
                                      style: const TextStyle(
                                        color: Colors.white60,
                                        fontSize: 13,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF3D2314),
                                      borderRadius: BorderRadius.circular(6),
                                      border: Border.all(
                                        color: const Color(0xFFE59C3B),
                                        width: 0.5,
                                      ),
                                    ),
                                    child: Text(
                                      '🔥 ${oferta.matchScore}',
                                      style: const TextStyle(
                                        color: Color(0xFFE59C3B),
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text(
                                oferta.titulo,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                oferta.descripcion,
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 13,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.monetization_on_outlined,
                                    size: 14,
                                    color: Color(0xFFE59C3B),
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    oferta.salario,
                                    style: const TextStyle(
                                      color: Colors.white60,
                                      fontSize: 12,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  const Icon(
                                    Icons.access_time,
                                    size: 14,
                                    color: Color(0xFFE59C3B),
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    oferta.horas,
                                    style: const TextStyle(
                                      color: Colors.white60,
                                      fontSize: 12,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  const Icon(
                                    Icons.location_on_outlined,
                                    size: 14,
                                    color: Color(0xFFE59C3B),
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    oferta.modalidad,
                                    style: const TextStyle(
                                      color: Colors.white60,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Wrap(
                                spacing: 6,
                                runSpacing: 4,
                                children: oferta.tags.map((tag) {
                                  return Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF1A1112),
                                      borderRadius: BorderRadius.circular(4),
                                      border: Border.all(color: Colors.white12),
                                    ),
                                    child: Text(
                                      tag,
                                      style: const TextStyle(
                                        color: Colors.white70,
                                        fontSize: 11,
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                              const SizedBox(height: 14),
                              Align(
                                alignment: Alignment.centerRight,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        oferta.estadoPostulacion == 'Postularme'
                                        ? const Color(0xFFE59C3B)
                                        : const Color(0xFF3D2314),
                                    foregroundColor:
                                        oferta.estadoPostulacion == 'Postularme'
                                        ? Colors.black87
                                        : const Color(0xFFE59C3B),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      side:
                                          oferta.estadoPostulacion !=
                                              'Postularme'
                                          ? const BorderSide(
                                              color: Color(0xFFE59C3B),
                                              width: 0.5,
                                            )
                                          : BorderSide.none,
                                    ),
                                  ),
                                  onPressed:
                                      oferta.estadoPostulacion == 'Postularme'
                                      ? () => _postularse(oferta.titulo)
                                      : null,
                                  child: Text(
                                    oferta.estadoPostulacion,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
