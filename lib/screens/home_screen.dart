import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:drivers_app/providers/providers.dart';
import 'package:drivers_app/widgets/widgets.dart';

/// Pantalla principal de la aplicación.
/// Muestra una interfaz organizada en secciones para navegar por los pilotos.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    // Accedemos a la instancia de DriversProvider. 
    // Al no especificar 'listen: false', este widget se redibujará automáticamente
    // cada vez que el provider llame a notifyListeners().
    final driversProvider = Provider.of<DriversProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pilotos de Formula 1'),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              // Espacio reservado para implementar una futura búsqueda
            }, 
            icon: const Icon(Icons.search_outlined)
          )
        ],
      ),
      // SingleChildScrollView permite que toda la columna sea desplazable si el contenido excede la pantalla
      body: SingleChildScrollView(
        child: Column(
          children: [
            
            // Sección superior: Tarjetas deslizantes (Swiper).
            // Inyectamos la lista de pilotos filtrados como "favoritos" desde el provider.
            CardSwiper(drivers: driversProvider.onDisplayDrivers),
        
            // Sección inferior: Slider horizontal.
            // Pasamos la lista completa de todos los pilotos obtenidos de la API.
            DriverSlider(
              drivers: driversProvider.popularDrivers,
              title: 'Todos los pilotos',
            ),
          ],
        ),
      ),
    );
  }
}