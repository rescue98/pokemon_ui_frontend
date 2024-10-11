class Pokemon {
  final int id;
  final String name;
  final List<String> types;

  Pokemon({required this.id, required this.name, required this.types});

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    // Obtener la lista de tipos del JSON
    var typesJson = json['types'] as List;

    // Transformar la lista de tipos a una lista de strings con casting
    List<String> typesList = List<String>.from(typesJson.map((type) => type['type']['name']));

    return Pokemon(
      id: json['id'],
      name: json['name'],
      types: typesList,
    );
  }
}

