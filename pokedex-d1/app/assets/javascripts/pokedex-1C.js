Pokedex.RootView.prototype.createPokemon = function (attrs, callback) {
  var newPoke = new Pokedex.Models.Pokemon(attrs);
  var that = this;
  newPoke.save({}, {
    success: function () {
    that.pokes.add(newPoke);
    that.addPokemonToList(newPoke);
    callback(newPoke);
    that.$el.find('.new-pokemon :input').val('');
    }
  });
};

Pokedex.RootView.prototype.submitPokemonForm = function (event) {
  event.preventDefault();
  var data = $(event.currentTarget).serializeJSON();
  this.createPokemon(data, this.renderPokemonDetail.bind(this));
};
