class PokemonModel {
  String? name;
  String? imageUrl;
  String? description;
  String? type;
  int? attack;
  int? defense;


  PokemonModel(name , url , description , type){
    this.name = name;
    this.imageUrl = url;
    this.description = description;
    this.type = type;
    
  }

}