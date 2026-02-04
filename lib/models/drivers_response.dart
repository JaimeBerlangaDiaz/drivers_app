import 'dart:convert';
import 'package:drivers_app/models/models.dart';

/// Clase encargada de procesar la respuesta global de la API.
/// Actúa como un contenedor para la lista de objetos Driver.
class DriversResponse {
    
    // Lista principal donde se almacenarán los pilotos procesados
    List<Driver> drivers;

    DriversResponse({
        required this.drivers,
    });

    /// Recibe el String crudo (body) de la respuesta HTTP, lo decodifica 
    /// y lo envía al constructor fromList para su procesamiento.
    factory DriversResponse.fromJson(String str) => DriversResponse.fromList(json.decode(str));

    /// Método especializado en la transformación y filtrado de los datos de la API.
    factory DriversResponse.fromList(List<dynamic> jsonList) {
        
        // Mapeamos cada elemento JSON al modelo Driver y aplicamos filtros de limpieza
        final drivers = jsonList
          .map((item) => Driver.fromJson(item))
          // Filtro de seguridad: Eliminamos los registros que contienen imágenes de error conocidas (Imgur)
          .where((driver) => driver.photoUrl != 'https://i.imgur.com/71H2k0b.png') 
          .toList();
        
        // Lógica de limpieza de duplicados:
        // Dado que la API puede devolver múltiples registros por piloto (por diferentes sesiones),
        // utilizamos un Map con el ID como clave para quedarnos solo con una instancia única por conductor.
        final uniqueDrivers = <int, Driver>{};
        for (var driver in drivers) {
          uniqueDrivers[driver.id] = driver;
        }

        return DriversResponse(
            // Convertimos los valores únicos del mapa de nuevo a una lista para la interfaz
            drivers: uniqueDrivers.values.toList(),
        );
    }
}