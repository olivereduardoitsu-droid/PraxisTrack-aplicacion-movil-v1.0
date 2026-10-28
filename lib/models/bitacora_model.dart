class BitacoraRegistro {
  final String idRegistro;
  final String estadoActual;
  final int horasDiarias;
  final int totalHorasAcumuladas;

  BitacoraRegistro({
    required this.idRegistro,
    required this.estadoActual,
    required this.horasDiarias,
    required this.totalHorasAcumuladas,
  });

  factory BitacoraRegistro.fromJson(Map<String, dynamic> json) {
    return BitacoraRegistro(
      idRegistro: json['id_registro'] ?? '',
      estadoActual: json['estado_actual'] ?? 'Registro_Creado',
      horasDiarias: json['horas_diarias'] ?? 0,
      totalHorasAcumuladas: json['total_horas_acumuladas'] ?? 0,
    );
  }
}
