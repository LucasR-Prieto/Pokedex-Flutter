import 'package:flutter/material.dart';

void main() => runApp(
    const DetailPokemonView(nombrePokemon: "Pikachu", colorbar: Colors.amber, imageurl: '', description: '',));

class DetailPokemonView extends StatelessWidget {
  final String nombrePokemon;
  final Color colorbar;
  final String imageurl ;
  final String description;

  const DetailPokemonView(
      {required this.nombrePokemon, Key? key, required this.colorbar, required this.imageurl, required this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(nombrePokemon),
        backgroundColor: colorbar,

      ),
      body: Container(
                color: colorbar,

        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                  color: colorbar,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.network(imageurl),
                        Text(description)
                  
                      ],
                    ),
                  ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
