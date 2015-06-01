Pokedex.RootView.prototype.addToyToList = function (toy) {
  var $toyLi = $("<li>").addClass("toy-list-item");
  $toyLi.text(toy.escape('name') +
      " - " + toy.escape('happiness') +
      " - $" + toy.escape('price'));
  $toyLi.data('toy-id', toy.id);
  $toyLi.data('pokemon-id', toy.get('pokemon_id'));
  this.$pokeDetail.find('.toys').append($toyLi);
};

Pokedex.RootView.prototype.renderToyDetail = function (toy) {
  this.$toyDetail.empty();
  var $detail = $("<div>").addClass("detail");
  $detail.append($('<img>').attr('src', toy.escape('image_url')));
  var $ul = $('<ul>');
  for (var key in toy.attributes) {
    $ul.append($('<li>').text(key + " - " + toy.attributes[key]));
  }
  $detail.append($ul);
  this.$toyDetail.css('background-color', "white");
  this.$toyDetail.append($detail);
};

Pokedex.RootView.prototype.selectToyFromList = function (event) {
  var toyId = $(event.currentTarget).data('toy-id');
  var pokemonId = $(event.currentTarget).data('pokemon-id');
  var toy = this.pokes.get(pokemonId).toys().get(toyId);
  this.renderToyDetail(toy);
};
