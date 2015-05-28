$.Thumbnails = function (el) {
  this.$el = $(el);
  this.$activeImg = this.$el.find(".gutter-images :first-child").addClass("active");
  this.activate(this.$activeImg);
  this.clickHandler();
};

$.Thumbnails.prototype.activate = function ($img) {
  $('div.active').empty();
  $img.clone().appendTo($("div.active"));
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
};

$.fn.thumbnails = function () {
  return this.each(function () {
    new $.Thumbnails(this);
  });
};
