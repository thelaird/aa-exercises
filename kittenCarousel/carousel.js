$.Carousel = function (el) {
  this.$el = $(el);
  this.activeIdx = 0;
  this.$el.find(".items :first-child").addClass("active");
  this.clickHandlers();
  this.transitioning = false;
};

$.Carousel.prototype.clickHandlers = function () {
  this.$el.find(".slide-left").on("click", this.slideLeft.bind(this));
  this.$el.find(".slide-right").on("click", this.slideRight.bind(this));
};

$.Carousel.prototype.slide = function (dir) {
  if (this.transitioning === true) {
    return;
  }
  this.transitioning = true;
  var oldActive = this.$el.find(".items img").eq(this.activeIdx);
  this.activeIdx += dir;
  this.activeIdx %= this.$el.find(".items img").length;
  var that = this;
  if (dir === 1){
    oldActive.addClass("right");
    this.$el.find(".items img").eq(this.activeIdx).addClass("left active");
  } else {
    oldActive.addClass("left");
    this.$el.find(".items img").eq(this.activeIdx).addClass("right active");
  }

  setTimeout( function () {
    that.$el.find(".items img").eq(that.activeIdx).removeClass("left right");
  }, 0);

  oldActive.one("transitionend", function () {
    oldActive.removeClass("active left right");
    that.transitioning = false;
  });
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
