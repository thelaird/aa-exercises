$.Zoomable = function (el) {
  this.$el = $(el);
  this.size = 200;
  this.bindEvents();
  this.focused = false;

};

$.Zoomable.prototype.showFocusBox = function (event) {

  var that = this;
  $(".focus-box").remove();
  this.$focusBox = $('<div>').addClass('focus-box');

  if (event.clientX > parseInt(this.$el.css('width')) - this.size + 100) {
    event.clientX = parseInt(this.$el.css('width')) - this.size + 100;
  }

  if (event.clientY > parseInt(this.$el.css('width')) - this.size + 100 ) {
    event.clientY = parseInt(this.$el.css('width')) - this.size + 100;
  }
  this.$focusBox.css('top', event.clientY - 100);
  this.$focusBox.css('left', event.clientX - 100);
  this.$focusBox.css('height', this.size);
  this.$focusBox.css('width', this.size);
  this.$el.append(this.$focusBox);
};

$.Zoomable.prototype.bindEvents = function () {
  this.$el.on('mousemove', this.showFocusBox.bind(this));
  this.$el.on('mouseleave', this.removeFocusBox.bind(this));
};

$.Zoomable.prototype.removeFocusBox = function () {
  $(".focus-box").remove();
  console.log("WE'RE HERE");
};

$.fn.zoomable = function () {
  return this.each(function () {
    new $.Zoomable(this);
  });
};
