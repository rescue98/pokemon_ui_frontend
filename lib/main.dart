import 'package:flutter/material.dart';
import 'services/pokemon_services.dart';
import 'models/pokemon_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokémon UI',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        textTheme: TextTheme(
          bodyLarge: TextStyle(fontFamily: 'Poppins'),
          bodyMedium: TextStyle(fontFamily: 'Poppins'),
        ),
      ),
      home: PokemonListScreen(),
    );
  }
}

class PokemonListScreen extends StatefulWidget {
  @override
  _PokemonListScreenState createState() => _PokemonListScreenState();
}

class _PokemonListScreenState extends State<PokemonListScreen> {
  final PokemonService _pokemonService = PokemonService();
  late Future<List<Pokemon>> _pokemons;
  List<Pokemon> _capturedPokemons = [];
  final int _limit = 10; 
  int _offset = 0; 
  String _searchTerm = '';
  String? _selectedType;
  final List<String> _pokemonTypes = [
    'Fuego',
    'Agua',
    'Planta',
    'Eléctrico',
    'Tierra',
    'Hielo',
    'Lucha',
    'Psíquico',
    'Bicho',
    'Volador',
    'Fantasma',
    'Roca',
    'Acero',
    'Hada',
  ]; // Lista de tipos de Pokémon

  @override
  void initState() {
    super.initState();
    _fetchPokemons(); // Cargar Pokémon al inicio
  }

  void _fetchPokemons() {
    _pokemons = _pokemonService.fetchPokemons(_offset, _limit);
  }

  void _onSearchChanged(String value) {
    setState(() {
      _searchTerm = value.toLowerCase();
    });
  }

  void _onTypeSelected(String? type) {
    setState(() {
      _selectedType = type; 
    });
  }

  void _nextPage() {
    setState(() {
      _offset += _limit;
      _fetchPokemons();
    });
  }

  void _previousPage() {
    setState(() {
      if (_offset - _limit >= 0) {
        _offset -= _limit;
      }
      _fetchPokemons();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pokémon List', style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold)),
        actions: [
          PopupMenuButton<String>(
            icon: Icon(Icons.filter_list),
            onSelected: _onTypeSelected,
            itemBuilder: (BuildContext context) {
              return _pokemonTypes.map((String type) {
                return PopupMenuItem<String>(
                  value: type,
                  child: Text(type),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Pokemon>>(
        future: _pokemons,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No pokemons found'));
          }

          List<Pokemon> pokemons = snapshot.data!;

          // Este código sirve para filtrar pokemones
          final filteredPokemons = pokemons.where((pokemon) {
            final isMatchName = pokemon.name.toLowerCase().contains(_searchTerm);
            final isMatchType = _selectedType == null || pokemon.types.contains(_selectedType);
            return isMatchName || isMatchType;
          }).toList();

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Buscar Pokémon',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: _onSearchChanged,
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: filteredPokemons.length,
                  itemBuilder: (context, index) {
                    final pokemon = filteredPokemons[index];
                    final isCaptured = _capturedPokemons.contains(pokemon);

                    return ListTile(
                      title: Text(pokemon.name, style: TextStyle(fontFamily: 'Poppins')),
                      subtitle: Text(pokemon.types.join(', ')),
                      tileColor: isCaptured ? Colors.green.withOpacity(0.3) : null,
                      onTap: () {
                        setState(() {
                          if (isCaptured) {
                            _capturedPokemons.remove(pokemon); // Descaptura si ya está capturado
                          } else {
                            if (_capturedPokemons.length >= 6) {
                              _capturedPokemons.removeAt(0); // Eliminar el más antiguo
                            }
                            _capturedPokemons.add(pokemon); // Captura el Pokémon
                          }
                        });
                      },
                    );
                  },
                ),
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Pokémon Capturados (${_capturedPokemons.length}/6)', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: _capturedPokemons.length,
                  itemBuilder: (context, index) {
                    final pokemon = _capturedPokemons[index];

                    return ListTile(
                      title: Text(pokemon.name, style: TextStyle(fontFamily: 'Poppins')),
                      subtitle: Text(pokemon.types.join(', ')),
                    );
                  },
                ),
              ),
              
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: _previousPage,
                      child: Text('Anterior'),
                    ),
                    SizedBox(width: 16),
                    ElevatedButton(
                      onPressed: _nextPage,
                      child: Text('Siguiente'),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

