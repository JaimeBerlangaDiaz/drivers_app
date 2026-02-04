import 'package:flutter/material.dart';
import 'package:drivers_app/models/models.dart';
import 'package:drivers_app/widgets/widgets.dart';

/// Pantalla detallada de cada piloto.
/// Utiliza un StatelessWidget ya que la información se recibe mediante argumentos de navegación.
class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Recogemos el objeto Driver pasado como argumento desde la pantalla anterior
    final Driver driver = ModalRoute.of(context)!.settings.arguments as Driver;

    return Scaffold(
      // CustomScrollView permite crear efectos de scroll avanzados como el AppBar que se expande
      body: CustomScrollView(
        slivers: [
          _CustomAppBar(driver: driver),
          SliverList(
            delegate: SliverChildListDelegate([
              _PosterAndTitle(driver: driver),
              _Overview(driver: driver),
              CastingCards(driver: driver), // Widget para mostrar al compañero de equipo
            ]),
          )
        ],
      ),
    );
  }
}

/// AppBar personalizada que se expande y contrae, cambiando de tamaño según el scroll.
class _CustomAppBar extends StatelessWidget {
  final Driver driver;
  const _CustomAppBar({required this.driver});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      // Aplicamos el color oficial de la escudería al fondo del AppBar
      backgroundColor: Color(driver.teamColor),
      expandedHeight: 200,
      floating: false,
      pinned: true, // Mantiene el título visible al hacer scroll hacia arriba
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: const EdgeInsets.all(0),
        title: Container(
          width: double.infinity,
          alignment: Alignment.bottomCenter,
          padding: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
          color: Colors.black12, // Sombreado suave para mejorar la lectura del nombre
          child: Text(driver.fullName, style: const TextStyle(fontSize: 16)),
        ),
        background: FadeInImage(
          placeholder: const AssetImage('assets/loading.gif'),
          image: NetworkImage(driver.fullPhotoUrl),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

/// Sección que muestra la foto de perfil, el nombre completo, siglas y equipo.
class _PosterAndTitle extends StatelessWidget {
  final Driver driver;
  const _PosterAndTitle({required this.driver});

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              placeholder: const AssetImage('assets/no-image.jpg'),
              image: NetworkImage(driver.fullPhotoUrl),
              height: 150,
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Nombre del piloto acompañado de sus siglas de competición
                Text('${driver.fullName} (${driver.acronym})', 
                    style: textTheme.headlineSmall, 
                    overflow: TextOverflow.ellipsis, 
                    maxLines: 2),
                
                Text(driver.team, style: textTheme.titleMedium),
                
                Row(
                  children: [
                    const Icon(Icons.numbers_outlined, size: 15, color: Colors.grey),
                    const SizedBox(width: 5),
                    Text(driver.dorsal, style: textTheme.bodySmall)
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

/// Bloque de texto con una descripción generada sobre el piloto.
class _Overview extends StatelessWidget {
  final Driver driver;
  const _Overview({required this.driver});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Información de Carrera', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 10),
          // Resumen narrativo utilizando los datos del modelo Driver
          Text(
            'El piloto ${driver.fullName}, conocido en la tabla de tiempos por las siglas "${driver.acronym}", compite actualmente para la escudería ${driver.team}. Su país de origen es ${driver.country} y utiliza el dorsal ${driver.dorsal} en su monoplaza.',
            textAlign: TextAlign.justify,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }
}