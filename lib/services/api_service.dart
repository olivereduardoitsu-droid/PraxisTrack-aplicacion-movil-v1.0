import 'package:dio/dio.dart';

import '../models/oferta_model.dart';

class ApiService {
  final Dio _dio = Dio(BaseOptions(baseUrl: 'http://10.0.2.2:3000/api'));
  final bool _usarMocks =
      true; // Cambiar a false el jueves para conectar con el backend real

  // 1. Obtener Ofertas
  Future<List<Oferta>> getOfertas() async {
    if (_usarMocks) {
      await Future.delayed(const Duration(milliseconds: 500));
      final Map<String, dynamic> mockData = {
        "data": [
          {
            "id_oferta": "1",
            "titulo": "Junior Backend Developer (Go / DDD)",
            "descripcion": "Desarrollo de servicios robustos y arquitectura limpia bajo patrones de dominio.",
            "empresa": "NuvoMetrics Labs • Fintech",
            "match_score": "98% Match",
            "salario": "\$750 USD/n",
            "horas": "160 hrs",
            "modalidad": "Remoto",
            "tags": ["Golang", "PostgreSQL", "Docker"],
            "estado_postulacion": "Postularme",
          },
          {
            "id_oferta": "2",
            "titulo": "Fullstack React & Node.js Intern",
            "descripcion": "Creación de interfaces responsivas y consumo de APIs seguras con JWT.",
            "empresa": "BioCloud Systems • HealthTech",
            "match_score": "94% Match",
            "salario": "\$820 USD/n",
            "horas": "180 hrs",
            "modalidad": "Híbrido",
            "tags": ["React 19", "Node.js", "PostgreSQL"],
            "estado_postulacion": "Enviada: 12 Mar",
          },
          {
            "id_oferta": "3",
            "titulo": "Cloud & SRE Platform Intern",
            "descripcion": "Automatización de despliegues y monitoreo de infraestructura en la nube.",
            "empresa": "Aethelgard Cloud • Infra",
            "match_score": "89% Match",
            "salario": "\$900 USD/n",
            "horas": "140 hrs",
            "modalidad": "Remoto",
            "tags": ["Terraform", "Kubernetes", "Supabase"],
            "estado_postulacion": "Postularme",
          },
          {
            "id_oferta": "4",
            "titulo": "Security & API Developer Intern",
            "descripcion": "Auditoría de endpoints, políticas RLS y protección contra payloads alterados.",
            "empresa": "Kratos Identity • Cybersecurity",
            "match_score": "91% Match",
            "salario": "\$889 USD/n",
            "horas": "160 hrs",
            "modalidad": "Presencial",
            "tags": ["OAuth2", "Rust / Go", "PostgreSQL"],
            "estado_postulacion": "En Evaluación",
          },
        ],
      };
      List list = mockData['data'];
      return list.map((item) => Oferta.fromJson(item)).toList();
    } else {
      final response = await _dio.get('/ofertas');
      List list = response.data['data'];
      return list.map((item) => Oferta.fromJson(item)).toList();
    }
  }

  // 2. Registrar Horas en la Bitácora
  Future<dynamic> registrarHoras({
    required String idPostulacion,
    required String fecha,
    required int horasInvertidas,
    required String descripcion,
  }) async {
    if (_usarMocks) {
      await Future.delayed(const Duration(milliseconds: 600));
      return {
        "success": true,
        "estadoActual": "Registrado y pendiente de validación",
      };
    } else {
      final response = await _dio.post(
        '/bitacora',
        data: {
          "id_postulacion": idPostulacion,
          "fecha": fecha,
          "horas_invertidas": horasInvertidas,
          "descripcion": descripcion,
        },
      );
      return response.data;
    }
  }
}
