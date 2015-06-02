Pokedex.RootView.prototype.reassignToy = function (event) {
  var oldPoke = this.pokes.get($(event.currentTarget).data('pokemon-id'));
  var toy = oldPoke.toys().get($(event.currentTarget).data('toy-id'));
  toy.set('pokemon_id', $(event.currentTarget).val());
  var that = this;
  toy.save({}, {
    success: function () {
      oldPoke.toys().remove(toy);
      that.renderToysList(oldPoke.toys());
      that.$toyDetail.empty();
    }
  });
};

Pokedex.RootView.prototype.renderToysList = function (toys) {
  this.$pokeDetail.find(".toys").empty();
  var that = this;
  toys.each( function (toy) { that.addToyToList(toy); });
};
