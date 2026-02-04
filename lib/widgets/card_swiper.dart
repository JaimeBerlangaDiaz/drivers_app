import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:drivers_app/models/models.dart';

/// Widget encargado de mostrar los pilotos destacados en un carrusel tridimensional.
/// Utiliza la librería 'card_swiper' para lograr el efecto de tarjetas apiladas.
class CardSwiper extends StatelessWidget {
  
  // Lista de pilotos inyectada desde el HomeScreen
  final List<Driver> drivers;

  const CardSwiper({super.key, required this.drivers});

  @override
  Widget build(BuildContext context) {
    // Obtenemos las dimensiones de la pantalla para que el widget sea responsivo
    final size = MediaQuery.of(context).size;

    // Validación de datos: Si la lista está vacía (mientras carga la API), 
    // mostramos un indicador de progreso centrado.
    if (drivers.isEmpty) {
      return SizedBox(
        width: double.infinity,
        height: size.height * 0.5,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    // Contenedor principal del Swiper
    return SizedBox(
        width: double.infinity,
        // Establecemos que el carrusel ocupe el 50% del alto de la pantalla
        height: size.height * 0.5,
        child: Swiper(
          itemCount: drivers.length, 
          layout: SwiperLayout.STACK, // Estilo de tarjetas apiladas una sobre otra
          itemWidth: size.width * 0.6,
          itemHeight: size.height * 0.45, 
          itemBuilder: (BuildContext context, int index) {
            
            // Referencia al piloto actual basado en el índice del carrusel
            final driver = drivers[index];

            // GestureDetector permite detectar el toque del usuario para navegar
            return GestureDetector(
                // Al pulsar, navegamos a la pantalla de detalles enviando el objeto Driver completo
                onTap: () =>
                    Navigator.pushNamed(context, 'details', arguments: driver),
                child: Column(
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          color: Colors.white, // Fondo sólido para evitar transparencias entre tarjetas y evitar que se vean los nombres de los pilotos de atrás.
                          child: FadeInImage(
                              // Mostramos una imagen local mientras se descarga la de la red
                              placeholder: const AssetImage('assets/no-image.jpg'),
                              // Usamos el getter que gestiona errores de URL
                              image: NetworkImage(driver.fullPhotoUrl),
                              fit: BoxFit.cover),
                        ),
                      ),
                    ),
                    
                    // Etiqueta de texto para identificar al piloto debajo de su imagen
                    const SizedBox(height: 5),
                    Text(
                      driver.fullName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis, // Corta el texto con "..." si es muy largo
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    )
                  ],
                ));
          },
        ));
  }
}