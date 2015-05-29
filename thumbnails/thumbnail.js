$.Thumbnails = function (el) {
  this.$el = $(el);
  this.$activeImg = this.$el.find(".gutter-images :first-child").addClass("active");
  this.activate(this.$activeImg);
  this.clickHandler();

  this.gutterIdx = 0;
  this.$images = this.$el.find(".gutter-images img");
  this.fillGutterImages();
};

$.Thumbnails.prototype.activate = function ($img) {
  $('div.active').empty();
  $img.clone().appendTo($("div.active"));
};


$.Thumbnails.prototype.fillGutterImages = function () {
  this.$el.find(".gutter-images").empty();
  for (var i = this.gutterIdx; i < this.gutterIdx + 5; i++) {
    this.$el.find(".gutter-images").append(this.$images.eq(i));
  }
};

$.Thumbnails.prototype.clickHandler = function () {
  var that = this;
  $(".gutter-images").on("click", "img", function (event) {
    var $currentTarget = $(event.currentTarget);
    that.$activeImg = $currentTarget;
    that.activate(that.$activeImg);
  });
  $(".gutter-images").on("mouseenter", "img", function (event) {
    that.activate($(event.currentTarget));
  });
  $(".gutter-images").on("mouseleave", "img", function (event) {
    that.activate(that.$activeImg);
  });
  $("a.nav").on("click", function () {
    if ($(event.currentTarget).text() === "<") {
      that.gutterIdx -= 1;
    } else {
      that.gutterIdx += 1;
    }
    that.fillGutterImages();
  });
};

$.fn.thumbnails = function () {
  return this.each(function () {
    new $.Thumbnails(this);
  });
};
