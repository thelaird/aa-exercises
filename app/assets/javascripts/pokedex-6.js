Pokedex.Router = Backbone.Router.extend({
  routes: {
    '': 'pokemonIndex',
    'pokemon/:id': 'show',
    'pokemon/:pokemonId/toys/:toyId': 'toyDetail'
  },

  show: function(id) {
    this.pokemonDetail(id);
  },

  pokemonDetail: function (id, callback) {
    !this._pokemonIndex && this.pokemonIndex(this.pokemonDetail.bind(this, id));

    var pokemon = this._pokemonIndex.collection.get(id);
    this._pokemonDetail = new Pokedex.Views.PokemonDetail( {model: pokemon });
    $("#pokedex .pokemon-detail").html(this._pokemonDetail.$el);
    this._pokemonDetail.refreshPokemon();
    debugger

  },

  pokemonIndex: function (callback) {
    var pokemons = new Pokedex.Collections.Pokemon();
    this._pokemonIndex = new Pokedex.Views.PokemonIndex({
      collection: pokemons
    });
    this._pokemonIndex.refreshPokemon(callback);

    $("#pokedex .pokemon-list").html(this._pokemonIndex.$el);

  },

  toyDetail: function (pokemonId, toyId) {

    !this._pokemonDetail && this.pokemonDetail(pokemonId, this.toyDetail.bind(this, pokemonId, toyId));
    var toy = this._pokemonDetail.model.toys().get(toyId);
    this._toyDetail = new Pokedex.Views.ToyDetail( { model: toy });
    $("#pokedex .toy-detail").html(this._toyDetail.$el);
    this._toyDetail.render([]);

  },

  pokemonForm: function () {
  }
});


$(function () {
  new Pokedex.Router();
  Backbone.history.start();
});
