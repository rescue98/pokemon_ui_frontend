import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/pokemon_model.dart';

class PokemonService {
  static const String baseUrl = 'https://pokeapi.co/api/v2/pokemon';

  Future<List<Pokemon>> fetchPokemons(int offset, int limit) async {
    final response = await http.get(Uri.parse('$baseUrl?offset=$offset&limit=$limit'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List<Pokemon> pokemons = [];

      for (var pokemon in data['results']) {
        final detailsResponse = await http.get(Uri.parse(pokemon['url']));
        if (detailsResponse.statusCode == 200) {
          pokemons.add(Pokemon.fromJson(json.decode(detailsResponse.body)));
        }
      }
      return pokemons;
    } else {
      throw Exception('Failed to load pokemons');
    }
  }
}


