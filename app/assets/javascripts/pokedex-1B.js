Pokedex.RootView.prototype.renderPokemonDetail = function (pokemon) {
  var $details = $('<div>').addClass('detail');
  $details.append($('<img>').attr('src', pokemon.get('image_url')));
  var $attrList = $('<form>').addClass('update-poke');
  $attrList.data('pokemon-id', pokemon.id);


  for (var key in pokemon.attributes) {
    if (key !== 'id' && key !== 'pokemon') {
      var $input = $('<input>').attr('type', 'text').attr('name', 'pokemon[' + key + ']');
      $input.val(pokemon.attributes[key]);
      $attrList.append($('<li>').text(key + ": ").append($input));
    }
  }

  $attrList.append($('<input>').attr('type', 'submit'));

  $details.append($attrList);
  $details.append($('<button>').addClass('delete-poke').text('Delete!'));
  var that = this;
  pokemon.fetch({
    success: function () { that.renderToysList(pokemon.toys()); }
  });
  $details.append($('<ul>').addClass('toys'));
  this.$pokeDetail.html($details);
};

Pokedex.RootView.prototype.updatePoke = function (event) {
  event.preventDefault();
  var poke = this.pokes.get($(event.currentTarget).data('pokemon-id'));
  var data = $(event.currentTarget).serializeJSON();
  poke.save( data, {
    success: function () {
    alert("Saved!");
    }
  });

};

Pokedex.RootView.prototype.deletePoke = function (event) {
  event.preventDefault();
  var that = this;
  var poke = this.pokes.get($('.update-poke').data('pokemon-id'));
  poke.destroy( {
    success: function () {
    that.$pokeList.empty();
    that.refreshPokemon();
    }
  });

  this.$pokeDetail.empty();
};

Pokedex.RootView.prototype.selectPokemonFromList = function (event) {
  var id = $(event.currentTarget).data('id');
  this.renderPokemonDetail(this.pokes.get(id));
};
