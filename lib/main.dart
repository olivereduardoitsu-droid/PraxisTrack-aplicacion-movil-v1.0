import 'package:flutter/material.dart';

import 'screens/ofertas_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bitácora Pasantías',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        // Definimos los colores basados en tu paleta (Oscuros de fondo, claros y amarillos de acento)
        scaffoldBackgroundColor: const Color(
          0xFF2C1518,
        ), // Fondo general oscuro (Borgoña muy oscuro)
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFD48128), // Tono terracota / amarillo base
          primary: const Color(
            0xFFE59C3B,
          ), // Amarillo/Naranja claro para botones y elementos destacados
          secondary: const Color(0xFF8B262B), // Borgoña medio
          surface: const Color(
            0xFF3D1E22,
          ), // Fondo para tarjetas (ligeramente más claro que el fondo general)
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(
            0xFF1F0E11,
          ), // El tono más oscuro para la barra superior
          foregroundColor: Color(0xFFF3C677), // Texto/Iconos en amarillo claro
          elevation: 0,
        ),
        cardTheme: CardThemeData(
          color: const Color(
            0xFF3D1E22,
          ), // Tarjetas con fondo oscuro intermedio
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: const BorderSide(
              color: Color(
                0xFFD48128,
              ), // Delineado en amarillo/terracota claro como indicaste
              width: 1.5,
            ),
          ),
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white70),
          bodyMedium: TextStyle(color: Colors.white60),
        ),
      ),
      home: const OfertasScreen(),
    );
  }
}
