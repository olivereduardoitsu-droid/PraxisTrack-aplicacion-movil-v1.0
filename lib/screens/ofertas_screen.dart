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
  late Future<List<Oferta>> _ofertasFuture;

  String filtroSeleccionado = 'Todos';
  String queryBusqueda = '';

  @override
  void initState() {
    super.initState();
    _ofertasFuture = _apiService.getOfertas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF140D0E),
      appBar: AppBar(
        title: const Text('PraxisTrack - Marketplace'),
        backgroundColor: const Color(0xFF140D0E),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.assignment, color: Color(0xFFE59C3B)),
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
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Panel de Progreso
            _buildPanelProgreso(),
            const SizedBox(height: 20),

            // 2. Buscador y Filtros
            _buildBarraBusquedaYFiltros(),
            const SizedBox(height: 20),

            // 3. Título de la sección
            const Text(
              'Oportunidades Disponibles',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 12),

            // 4. Lista de Ofertas
            FutureBuilder<List<Oferta>>(
              future: _ofertasFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(color: Color(0xFFE59C3B)),
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
                      'No hay vacantes disponibles.',
                      style: TextStyle(color: Colors.grey),
                    ),
                  );
                }

                // Filtrado seguro con comprobación de nulos (?? '')
                final ofertasFiltradas = snapshot.data!.where((oferta) {
                  final titulo = (oferta.titulo).toLowerCase();
                  final empresa = (oferta.empresa ?? '').toLowerCase();
                  final modalidad = (oferta.modalidad).toLowerCase();
                  final query = queryBusqueda.toLowerCase();

                  final coincideBusqueda =
                      titulo.contains(query) ||
                      empresa.contains(query) ||
                      oferta.tags.any(
                        (tag) => tag.toLowerCase().contains(query),
                      );

                  if (filtroSeleccionado == 'Todos') {
                    return coincideBusqueda;
                  } else if (filtroSeleccionado == 'Remoto') {
                    return coincideBusqueda && modalidad.contains('remoto');
                  } else {
                    return coincideBusqueda &&
                        (titulo.contains(filtroSeleccionado.toLowerCase()) ||
                            oferta.tags.any(
                              (t) => t.toLowerCase().contains(
                                filtroSeleccionado.toLowerCase(),
                              ),
                            ));
                  }
                }).toList();

                if (ofertasFiltradas.isEmpty) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Center(
                      child: Text(
                        'No se encontraron coincidencias',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  );
                }

                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: ofertasFiltradas.length,
                  itemBuilder: (context, index) {
                    final oferta = ofertasFiltradas[index];
                    return _buildTarjetaOferta(oferta);
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPanelProgreso() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF261618),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'Mi Progreso de Prácticas',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                '71%',
                style: TextStyle(
                  color: Color(0xFFE59C3B),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: const [
                  Text(
                    '348 hrs',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'APROBADAS',
                    style: TextStyle(fontSize: 10, color: Colors.grey),
                  ),
                ],
              ),
              Container(height: 25, width: 1, color: Colors.grey[700]),
              Column(
                children: const [
                  Text(
                    '148 hrs',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'RESTANTES',
                    style: TextStyle(fontSize: 10, color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          OutlinedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const BitacoraScreen()),
              );
            },
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Color(0xFFE59C3B)),
              minimumSize: const Size(double.infinity, 36),
            ),
            child: const Text(
              'Ver / Registrar Bitácora Completa',
              style: TextStyle(color: Color(0xFFE59C3B)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBarraBusquedaYFiltros() {
    final filtros = ['Todos', 'Backend', 'Fullstack', 'Remoto'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          onChanged: (val) => setState(() => queryBusqueda = val),
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: 'Buscar por rol, stack (Go, PostgreSQL), empresa...',
            hintStyle: const TextStyle(color: Colors.grey, fontSize: 13),
            prefixIcon: const Icon(Icons.search, color: Color(0xFFE59C3B)),
            filled: true,
            fillColor: const Color(0xFF261618),
            contentPadding: const EdgeInsets.symmetric(vertical: 10),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        const SizedBox(height: 12),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: filtros.map((filtro) {
              final activo = filtroSeleccionado == filtro;
              return Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: ChoiceChip(
                  label: Text(filtro),
                  selected: activo,
                  selectedColor: const Color(0xFFE59C3B),
                  backgroundColor: const Color(0xFF261618),
                  labelStyle: TextStyle(
                    color: activo ? Colors.black : Colors.white,
                    fontWeight: activo ? FontWeight.bold : FontWeight.normal,
                  ),
                  onSelected: (bool selected) {
                    setState(() => filtroSeleccionado = filtro);
                  },
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildTarjetaOferta(Oferta oferta) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF261618),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  oferta.empresa ?? '', // Protección de nulos aquí
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.orange.withAlpha(50),
                  borderRadius: BorderRadius.circular(12),
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
          const SizedBox(height: 4),
          Text(
            oferta.titulo,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            oferta.descripcion,
            style: const TextStyle(color: Colors.grey, fontSize: 12),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Text(
                oferta.salario,
                style: const TextStyle(
                  color: Color(0xFFE59C3B),
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                '⏱ ${oferta.horas}',
                style: const TextStyle(color: Colors.grey, fontSize: 12),
              ),
              const SizedBox(width: 10),
              Text(
                '📍 ${oferta.modalidad}',
                style: const TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 6,
            runSpacing: 4,
            children: oferta.tags.map((tag) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: Colors.white10,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  tag,
                  style: const TextStyle(color: Colors.white70, fontSize: 10),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 12),
          Align(
            alignment: Alignment.centerRight,
            child: oferta.estadoPostulacion == 'Postularme'
                ? ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFE59C3B),
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    child: const Text(
                      'Postularme',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  )
                : OutlinedButton(
                    onPressed: null,
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.grey),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    child: Text(
                      oferta.estadoPostulacion,
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
