import 'package:flutter/material.dart';

import '../services/api_service.dart';

class BitacoraScreen extends StatefulWidget {
  const BitacoraScreen({super.key});

  @override
  State<BitacoraScreen> createState() => _BitacoraScreenState();
}

class _BitacoraScreenState extends State<BitacoraScreen> {
  final _formKey = GlobalKey<FormState>();
  final ApiService _apiService = ApiService();

  final TextEditingController _fechaController = TextEditingController(
    text: '2026-10-27',
  );
  final TextEditingController _horasController = TextEditingController();
  final TextEditingController _descController = TextEditingController();

  bool _isLoading = false;

  void _enviarRegistro() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      try {
        final resultado = await _apiService.registrarHoras(
          idPostulacion:
              "22222222-2222-4222-8222-222222222222", // ID de prueba simulado
          fecha: _fechaController.text,
          horasInvertidas: int.parse(_horasController.text),
          descripcion: _descController.text,
        );

        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              '¡Horas registradas con éxito! Estado: ${resultado.estadoActual}',
            ),
            backgroundColor: Colors.green,
          ),
        );
        _horasController.clear();
        _descController.clear();
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
        );
      } finally {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registro de Bitácora Diaria')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _fechaController,
                decoration: const InputDecoration(
                  labelText: 'Fecha (YYYY-MM-DD)',
                ),
                validator: (value) =>
                    value!.isEmpty ? 'Ingrese la fecha' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _horasController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Horas Invertidas (Máximo 8)',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return 'Ingrese las horas';
                  int? horas = int.tryParse(value);
                  if (horas == null || horas <= 0 || horas > 8) {
                    return 'Debe ser un número mayor a 0 y máximo 8';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _descController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText:
                      'Descripción de actividades (Mínimo 10 caracteres)',
                ),
                validator: (value) {
                  if (value == null || value.length < 10) {
                    return 'La descripción debe tener al menos 10 caracteres';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _isLoading ? null : _enviarRegistro,
                child: _isLoading
                    ? const CircularProgressIndicator()
                    : const Text('Guardar Registro en Bitácora'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
