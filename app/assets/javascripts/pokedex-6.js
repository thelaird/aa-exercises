Pokedex.Router = Backbone.Router.extend({
  routes: {
    '': 'pokemonIndex',
    'pokemon/:id': 'show'
  },

  show: function(id) {
    this.pokemonDetail(id);
  },

  pokemonDetail: function (id) {
    !this._pokemonIndex && this.pokemonIndex(this.pokemonDetail.bind(this, id));

    var pokemon = this._pokemonIndex.collection.get(id);
    var view = new Pokedex.Views.PokemonDetail( {model: pokemon });
    $("#pokedex .pokemon-detail").html(view.$el);
    view.refreshPokemon();

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
  },

  pokemonForm: function () {
  }
});


$(function () {
  new Pokedex.Router();
  Backbone.history.start();
});
