$.Zoomable = function () {

}



$.fn.zoomable = function () {
  return this.each(function () {
    new $.Zoomable(this);
  });
};
