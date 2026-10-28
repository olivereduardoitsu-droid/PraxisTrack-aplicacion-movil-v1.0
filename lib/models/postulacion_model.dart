class Postulacion {
  final String idPostulacion;
  final String tituloOferta;
  final String estadoActual;
  final String fechaRegistro;

  Postulacion({
    required this.idPostulacion,
    required this.tituloOferta,
    required this.estadoActual,
    required this.fechaRegistro,
  });

  factory Postulacion.fromJson(Map<String, dynamic> json) {
    return Postulacion(
      idPostulacion: json['id_postulacion'] ?? '',
      tituloOferta: json['titulo_oferta'] ?? '',
      estadoActual: json['estado_actual'] ?? 'Enviada',
      fechaRegistro: json['fecha_registro'] ?? '',
    );
  }
}
