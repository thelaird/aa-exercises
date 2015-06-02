Pokedex.RootView.prototype.reassignToy = function (event) {
  var oldPoke = this.pokes.get($(event.currentTarget).data('pokemon-id'));
  var toy = oldPoke.toys().get($(event.currentTarget).data('toy-id'));
  toy.set('pokemon_id', $(event.currentTarget).val());
  var that = this;
  toy.save({}, {
    success: function () {
      oldPoke.toys().remove(toy);
      that.renderPokemonDetail(oldPoke);
      that.$toyDetail.empty();
    }
  });

  console.log('Old Pokemon ID: ' + $(event.currentTarget).data('pokemon-id'));
  console.log('Old Toy ID: ' + $(event.currentTarget).data('toy-id'));
  console.log('New Pokemon ' + $(event.currentTarget).val());
};

Pokedex.RootView.prototype.renderToysList = function (toys) {
};
