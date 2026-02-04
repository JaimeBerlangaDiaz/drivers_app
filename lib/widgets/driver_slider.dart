import 'package:flutter/material.dart';
import 'package:drivers_app/models/models.dart';

/// Widget versátil que muestra una lista horizontal de pilotos.
/// Se utiliza tanto en la pantalla principal como en la sección de compañeros de equipo.
class DriverSlider extends StatelessWidget {
  final List<Driver> drivers;
  final String? title;

  const DriverSlider({
    super.key, 
    required this.drivers, 
    this.title
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 270,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Renderizado condicional del título: Solo se muestra si se proporciona uno
          if (title != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(title!, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
          
          const SizedBox(height: 5),
          
          // ListView.builder optimiza el rendimiento cargando solo los elementos visibles en pantalla
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              // BouncingScrollPhysics proporciona el efecto de rebote elástico típico de iOS
              physics: const BouncingScrollPhysics(), 
              itemCount: drivers.length,
              itemBuilder: (_, int index) => _DriverPoster(driver: drivers[index]),
            ),
          ),
        ],
      ),
    );
  }
}

/// Sub-widget privado que representa cada tarjeta individual dentro del slider.
class _DriverPoster extends StatelessWidget {
  final Driver driver;
  const _DriverPoster({required this.driver});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      height: 190,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          // GestureDetector permite que cada póster sea interactivo
          GestureDetector(
            // Al pulsar, navegamos a la pantalla de detalles con el objeto Driver como argumento
            onTap: () => Navigator.pushNamed(context, 'details', arguments: driver),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                // Placeholder local para evitar huecos en blanco durante la descarga
                placeholder: const AssetImage('assets/no-image.jpg'),
                // Uso del getter de imagen que centraliza la lógica de URLs nulas
                image: NetworkImage(driver.fullPhotoUrl),
                width: 130,
                height: 180,
                fit: BoxFit.cover,
              ),
            ),
          ),
          
          const SizedBox(height: 5),
          
          // Nombre del piloto con control de desbordamiento para mantener la estética de la cuadrícula
          Text(
            driver.fullName,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}