$.Tabs = function (el) {
  this.$el = $(el);
  this.$contentTabs = $(this.$el.attr("data-content-tabs"));
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
  this.$activeTab.removeClass('active');
  this.$activeLink.removeClass('active');
  this.$activeLink = $(event.currentTarget).addClass('active');
  this.$activeTab = $(this.$activeLink.attr("href")).addClass('active');

};
