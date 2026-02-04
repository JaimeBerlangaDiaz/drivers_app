import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:drivers_app/models/models.dart'; 

/// Clase encargada de la gestión del estado global de los pilotos.
/// Extiende de ChangeNotifier para poder notificar a la interfaz cuando los datos cambien.
class DriversProvider extends ChangeNotifier {

  // Configuración de la API OpenF1
  final String _baseUrl = 'api.openf1.org';
  final String _sessionKey = '9640'; // Clave de sesión específica para obtener los datos de la temporada

  // Listas de datos para los diferentes componentes de la UI
  List<Driver> onDisplayDrivers = []; // Datos para el CardSwiper superior
  List<Driver> popularDrivers   = []; // Datos para el DriverSlider inferior

  DriversProvider() {
    print('Drivers Provider inicialitzat!'); 
    getDrivers(); // Iniciamos la carga de datos al instanciar el proveedor
  }

  /// Realiza la petición HTTP a la API y procesa los resultados de forma asíncrona.
  Future<void> getDrivers() async {
    
    // 1. Construcción de la URL con parámetros de consulta (query parameters)
    var url = Uri.https(_baseUrl, '/v1/drivers', {
      'session_key': _sessionKey
    });

    // 2. Ejecución de la petición GET y espera de la respuesta
    final response = await http.get(url);

    if (response.statusCode == 200) {
      
      // Transformación de la respuesta JSON cruda en un objeto DriversResponse
      final driversResponse = DriversResponse.fromJson(response.body);

      // Asignamos la lista completa de pilotos únicos al slider inferior
      popularDrivers = driversResponse.drivers;

      // Lógica de filtrado para la sección de destacados (Swiper):
      // Definimos una lista de dorsales específicos para mostrar como favoritos.
      final List<int> favoriteNumbers = [1, 14, 44, 55, 16, 11];

      // Filtramos la lista general basándonos en los números de dorsal definidos
      onDisplayDrivers = driversResponse.drivers
          .where((driver) => favoriteNumbers.contains(driver.id))
          .toList();

      // Punto clave: Notificamos a todos los widgets que están escuchando este Provider
      // para que se reconstruyan con la nueva información.
      notifyListeners();
      
    } else {
      // Manejo de errores en caso de fallo en la petición (opcionalmente silenciado)
      print('Request failed with status: ${response.statusCode}');
    }
  }
}