class Oferta {
  final String idOferta;
  final String titulo;
  final String descripcion;
  final String? empresa;
  final String matchScore;
  final String salario;
  final String horas;
  final String modalidad;
  final List<String> tags;
  final String
  estadoPostulacion; // Ej: 'Postularme', 'Enviada', 'En Evaluación'

  Oferta({
    required this.idOferta,
    required this.titulo,
    required this.descripcion,
    this.empresa,
    required this.matchScore,
    required this.salario,
    required this.horas,
    required this.modalidad,
    required this.tags,
    required this.estadoPostulacion,
  });

  factory Oferta.fromJson(Map<String, dynamic> json) {
    return Oferta(
      idOferta: json['id_oferta'] ?? '',
      titulo: json['titulo'] ?? '',
      descripcion: json['descripcion'] ?? '',
      empresa: json['empresa'],
      matchScore: json['match_score'] ?? '90% Match',
      salario: json['salario'] ?? '\$700 USD/n',
      horas: json['horas'] ?? '160 hrs',
      modalidad: json['modalidad'] ?? 'Remoto',
      tags: List<String>.from(json['tags'] ?? []),
      estadoPostulacion: json['estado_postulacion'] ?? 'Postularme',
    );
  }
}
