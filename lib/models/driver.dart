class Driver {
  // Definición de los campos del piloto obtenidos de la API OpenF1
  final int id;
  final String team;
  final String fullName;
  final String acronym;
  final String country;
  final String dorsal;
  final int teamColor;
  
  // La URL de la foto es opcional (String?) porque la API no siempre la proporciona dependiendo de la sesión.
  final String? photoUrl;

  Driver({
    required this.id,
    required this.team,
    required this.fullName,
    required this.acronym,
    required this.country,
    required this.dorsal,
    required this.teamColor,
    this.photoUrl, 
  });

  /// Getter dinámico para gestionar la visualización de imágenes.
  /// Implementa una lógica de respaldo (fallback) que garantiza que la UI 
  /// nunca intente cargar una URL nula, evitando errores de renderizado.
  String get fullPhotoUrl {
    // Si la API proporcionó una URL, la utilizamos asegurando el tipo con '!'
    if (photoUrl != null) {
      return photoUrl!;
    }
    // Si el dato es nulo, devolvemos una imagen genérica de sustitución
    return 'https://www.shutterstock.com/image-vector/no-image-available-vector-illustration-260nw-744886198.jpg';
  }

  /// Factory constructor para transformar el mapa JSON de la API en una instancia de Driver.
  /// Incluye lógica de transformación para el color del equipo y valores por defecto.
  factory Driver.fromJson(Map<String, dynamic> json) {
    
    // Convertimos el string hexadecimal del color (ej: 'FF1801') a un entero que Flutter pueda usar.
    // Usamos '000000' como valor por defecto si el dato es nulo.
    String hexString = json["team_colour"] ?? '000000';
    int colorInt = int.parse('0xFF$hexString');

    return Driver(
      id:        json["driver_number"],
      team:      json["team_name"] ?? 'Sin Equipo',
      fullName:  json["full_name"],
      acronym:   json["name_acronym"] ?? 'UNK',
      country:   json["country_code"] ?? 'INT',
      dorsal:    '#${json["driver_number"]}', // Formateamos el dorsal para la interfaz
      teamColor: colorInt,
      photoUrl:  json["headshot_url"], // Mantenemos el valor original (puede ser null)
    );
  }
}