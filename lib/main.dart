import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; 
import 'package:drivers_app/providers/providers.dart';
import 'package:drivers_app/screens/screens.dart';     

void main() => runApp(const AppState());

/// Clase de nivel superior encargada de gestionar el estado global.
/// Utilizamos el patrón Provider para separar la lógica de negocio (API) de la interfaz.
class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Cargamos la información de los pilotos en cuanto arranca la app.
        // Así, cuando entremos en la pantalla principal, los datos ya estarán listos para mostrarse.
        ChangeNotifierProvider(create: ( _ ) => DriversProvider()),
      ],
      // El child es MyApp, lo que garantiza que MaterialApp y todas sus rutas tengan acceso a los datos
      child: const MyApp(),
    );
  }
}

/// Configuración principal de la aplicación Flutter.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'F1 Drivers Hub',
      
      // Definición del sistema de rutas de la aplicación
      initialRoute: 'home', 
      routes: {
        'home':    ( _ ) => const HomeScreen(),
        'details': ( _ ) => const DetailsScreen(),
      },
      
      // Personalización del tema visual para adaptarlo a la estética de la Fórmula 1
      theme: ThemeData.light().copyWith(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.red, // Color corporativo predominante
          elevation: 0,
          centerTitle: true,
        )
      ),
    );
  }
}