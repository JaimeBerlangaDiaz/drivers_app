import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:drivers_app/providers/providers.dart';
import 'package:drivers_app/models/models.dart';
import 'package:drivers_app/widgets/widgets.dart';

/// Widget encargado de mostrar al compañero de equipo del piloto seleccionado.
/// Utiliza la información global del provider para realizar una búsqueda dinámica.
class CastingCards extends StatelessWidget {
  final Driver driver;

  const CastingCards({super.key, required this.driver});

  @override
  Widget build(BuildContext context) {
    // 1. Accedemos a la instancia de DriversProvider para consultar la lista completa de pilotos.
    final driversProvider = Provider.of<DriversProvider>(context);
    
    // 2. Lógica de filtrado para encontrar al compañero de equipo:
    // Buscamos en la lista global aquellos pilotos que pertenezcan a la misma escudería (team),
    // pero cuya ID sea distinta a la del piloto que estamos visualizando actualmente.
    final teamMates = driversProvider.popularDrivers
        .where((d) => d.team == driver.team && d.id != driver.id)
        .toList();

    // Si por algún motivo la API no devuelve un compañero, devolvemos un espacio vacío para no romper la UI.
    if (teamMates.isEmpty) return const SizedBox();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Text(
            'Compañero de Equipo', 
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
          ),
        ),
        
        // Reutilizamos el widget DriverSlider para mostrar al compañero, 
        // manteniendo la consistencia visual de la aplicación.
        DriverSlider(drivers: teamMates),
        
        const SizedBox(height: 30),
      ],
    );
  }
}