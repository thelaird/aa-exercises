$.Carousel = function (el) {
  this.$el = $(el);
  this.activeIdx = 0;
  this.$el.find(".items :first-child").addClass("active");
  this.clickHandlers();
};

$.Carousel.prototype.clickHandlers = function () {
  this.$el.find(".slide-left").on("click", this.slideLeft.bind(this));
  this.$el.find(".slide-right").on("click", this.slideRight.bind(this));
};

$.Carousel.prototype.slide = function (dir) {
  this.$el.find(".items img").eq(this.activeIdx).removeClass("active");
  this.activeIdx += dir;
  this.activeIdx %= this.$el.find(".items img").length;
  this.$el.find(".items img").eq(this.activeIdx).addClass("active");
};

$.Carousel.prototype.slideLeft = function () {
  this.slide(1);
};

$.Carousel.prototype.slideRight = function () {
  this.slide(-1);
};

$.fn.carousel = function () {
  return this.each(function () {
    new $.Carousel(this);
  });
};
