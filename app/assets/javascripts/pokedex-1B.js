Pokedex.RootView.prototype.renderPokemonDetail = function (pokemon) {
  var $details = $('<div>').addClass('detail');
  $details.append($('<img>').attr('src', pokemon.get('image_url')));
  var $attrList = $('<ul>');
  for (var key in pokemon.attributes) {
    if (key !== 'image_url' && key !== 'id' && key !== 'pokemon') {
      var $attr = $('<li>').text(key + " : " + pokemon.attributes[key]);
      $attrList.append($attr);
    }
  }
  $details.append($attrList);
  var that = this;
  pokemon.fetch({
    success: function () { that.renderToysList(pokemon.toys()); }
  });
  $details.append($('<ul>').addClass('toys'));
  this.$pokeDetail.html($details);
};

Pokedex.RootView.prototype.selectPokemonFromList = function (event) {
  var id = $(event.currentTarget).data('id');
  this.renderPokemonDetail(this.pokes.get(id));
};
