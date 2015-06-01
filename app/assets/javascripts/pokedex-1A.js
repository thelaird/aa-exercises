Pokedex.RootView.prototype.addPokemonToList = function (pokemon) {
  var $pokeLi = $("<li>").addClass("poke-list-item");
  $pokeLi.text(pokemon.get('name') + " - " + pokemon.escape('poke_type'));
  this.$pokeList.append($pokeLi);
};

Pokedex.RootView.prototype.refreshPokemon = function () {
  var that = this;
  this.pokes.fetch({
    success: function () {
      that.pokes.each( function (poke) { that.addPokemonToList(poke); });
    }
  });
};
