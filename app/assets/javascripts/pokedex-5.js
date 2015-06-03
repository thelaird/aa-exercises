Pokedex.Views = {}

Pokedex.Views.PokemonIndex = Backbone.View.extend({
  events: {
    "click li": "selectPokemonFromList"
  },

  initialize: function (options) {
    this.listenTo(this.collection, "sync", this.render);
  },

  addPokemonToList: function (pokemon) {
    this.$el.append(JST['pokemonListItem']({ pokemon: pokemon}));
  },

  refreshPokemon: function (callback) {
    this.collection.fetch( {
      success: function () {
        this.render();
        callback();
      }.bind(this)
    }
  );
  },

  render: function () {
    this.$el.empty();
    this.collection.each( function (pokemon) {
      this.addPokemonToList(pokemon);
    }, this);
  },

  selectPokemonFromList: function (event) {
    var id = $(event.currentTarget).data("id");
    var pokemon = this.collection.get(id);

    // var view = new Pokedex.Views.PokemonDetail( {model: pokemon });
    // $("#pokedex .pokemon-detail").html(view.$el);
    // view.refreshPokemon();

    Backbone.history.navigate('pokemon/' + id, { trigger: true });
  }
});

Pokedex.Views.PokemonDetail = Backbone.View.extend({
  events: {
    "click li.toy-list-item": "selectToyFromList"
  },

  refreshPokemon: function (options) {
    var pokemon = this.model;
    pokemon.fetch({
      success: function () {
        this.render();
      }.bind(this)
    });
  },

  render: function () {
    var pokemon = this.model;
    var that = this;
    this.$el.append(JST['pokemonDetail']({ pokemon: pokemon }));

    pokemon.toys().each(function(toy) {
      that.$el.append(JST['toyListItem']({ pokemon: pokemon, toy: toy,
        shortInfo: ['name', 'happiness', 'price'] }));
    });
  },

  selectToyFromList: function (event) {
    var toy = this.model.toys().get($(event.currentTarget).data("id"));

    var view = new Pokedex.Views.ToyDetail( { model: toy });
    view.render([]);
    $("#pokedex .toy-detail").html(view.$el);

  }
});

Pokedex.Views.ToyDetail = Backbone.View.extend({
  render: function (pokes) {
    var that = this;
    this.$el.append(JST["toyDetail"]({ toy: this.model, pokes: pokes}));
  }
});

//
// $(function () {
//   var pokemons = new Pokedex.Collections.Pokemon();
//   pokemons.fetch();
//   var pokemonIndex = new Pokedex.Views.PokemonIndex({
//     collection: pokemons
//   });
//   pokemonIndex.refreshPokemon();
//
//   $("#pokedex .pokemon-list").html(pokemonIndex.$el);
// });
