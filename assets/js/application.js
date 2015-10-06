(function() {
  var sizeAllThings, sizeHomepage, sizeSquareBlocks;

  sizeSquareBlocks = function() {
    return $('.square_block').each(function() {
      var contentHeight, holderWidth;
      contentHeight = $(this).find('.square_block--content').outerHeight(true);
      holderWidth = $(this).outerWidth(true);
      if (holderWidth > contentHeight) {
        return $(this).height(holderWidth);
      } else {
        return $(this).height('');
      }
    });
  };

  sizeHomepage = function() {
    var height;
    height = $(window).height() - $('#main_header').outerHeight(true);
    return $('#homepage--about').height(height);
  };

  sizeAllThings = function() {
    sizeSquareBlocks();
    return sizeHomepage();
  };

  $(function() {
    sizeAllThings();
    return $(window).on('resize', sizeAllThings);
  });

}).call(this);
