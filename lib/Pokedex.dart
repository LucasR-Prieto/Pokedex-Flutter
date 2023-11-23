import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pokedex/DetailPokemonView.dart';
import 'package:pokedex/Models/PokemonModel.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<List<PokemonModel>> _listadoPokemon;

  Future<List<PokemonModel>> _getPokemons() async {
    final response = await http.get(
      Uri.parse("https://pokedex-bb36f.firebaseio.com/pokemon.json"),
    );

    List<PokemonModel> gifs = [];

    if (response.statusCode == 200) {
      String body = utf8.decode(response.bodyBytes);
      print(body);

      final jsondata = jsonDecode(body);

      for (var item in jsondata) {
        if (item != null) {
          gifs.add(PokemonModel(item["name"], item["imageUrl"],
              item["description"], item["type"]));
        }
      }
      return gifs; 
    } else {
      throw Exception("Fallo la conexión");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _listadoPokemon = _getPokemons();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Pokedex'),
          backgroundColor: Colors.red,
          // Cambia este color según tus preferencias
        ),
        body: FutureBuilder(
          future: _listadoPokemon,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView(children: _listpokemons(snapshot.data, context));
            } else if (snapshot.hasError) {
              print(snapshot.error);
              return Text("error");
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }

  List<Widget> _listpokemons(List<PokemonModel>? data, BuildContext context) {
    List<Widget> pokemons = [];
    if (data != Null) {
      data?.forEach((pokemon) {
        pokemons.add(InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DetailPokemonView(
                        nombrePokemon: pokemon.name ?? "",
                        colorbar: getColorForType(pokemon.type ?? ""),
                        imageurl: pokemon.imageUrl ?? "",
                        description: pokemon.description ?? "",
                      )),
            );
          },
          child: Card(
              color: getColorForType(pokemon.type ?? ""),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Name: ${pokemon.name ?? ""}",
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(
                              "Type: ${pokemon.type ?? ""}",
                              style: TextStyle(color: Colors.white),
                            )
                          ]),
                    ),
                    Spacer(),
                    Expanded(
                      child: Image.network(
                        pokemon.imageUrl ?? "",
                        fit: BoxFit.contain,
                        width: 100, 
                        height: 100, 
                      ),
                    )

                  ],
                ),
              )),
        ));
      });
    }

    return pokemons;
  }

  Color getColorForType(String type) {
    switch (type.toLowerCase()) {
      case "poison":
        return Colors.purple;
      case "fire":
        return Colors.red;
      case "water":
        return Colors.blue;
            case "bug":
        return Colors.green;
                    case "ground":
        return Colors.brown;

      default:
        return Colors.grey;
    }
  }
}
