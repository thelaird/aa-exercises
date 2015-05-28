$.Tabs = function (el) {
  this.$el = $(el);
  this.$contentTabs = $(this.$el.data("content-tabs"));
  this.$activeTab = this.$contentTabs.find(".active");
  this.$activeLink = this.$el.find(".active");
  this.$el.on('click', 'a', this.clickTab.bind(this));
 };

$.fn.tabs = function () {
  return this.each(function () {
    new $.Tabs(this);
  });
};


$.Tabs.prototype.clickTab = function (event) {
  var that = this;
  this.$activeTab.addClass('transitioning');
  this.$activeLink.removeClass('active');
  this.$activeLink = $(event.currentTarget).addClass('active');

  this.$activeTab.one('transitionend', function (event){
    that.$activeTab.removeClass('active transitioning');
    that.$activeTab = $(that.$activeLink.attr("href")).addClass('active transitioning');

    setTimeout(function () {
      that.$activeTab.removeClass('transitioning');
    }, 0);
  });
};
