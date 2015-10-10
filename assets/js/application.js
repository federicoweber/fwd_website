(function() {
  var MOBILE_BREAK_POINT, bindMainNavMobilecollapse, mainNavMobileExpand, mainNavMobilecollapse, sizeAllThings, sizeHomepage, sizeIframes, sizeSquareBlocks;

  MOBILE_BREAK_POINT = 768;

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
    height = $(window).height() - $('#main_header').outerHeight(true) - $('#main_footer').outerHeight(true);
    return $('#homepage--about').height(height);
  };

  sizeIframes = function() {
    var targetWidth;
    targetWidth = $('iframe').first().parent().width();
    return $('iframe').each(function() {
      var ratio, targetHeight;
      ratio = $(this).data('ratio');
      if (!ratio) {
        ratio = $(this).width() / $(this).height();
        $(this).data('ratio', ratio);
      }
      targetHeight = targetWidth / ratio;
      return $(this).width(targetWidth).height(targetHeight);
    });
  };

  sizeAllThings = function() {
    sizeSquareBlocks();
    sizeIframes();
    return sizeHomepage();
  };

  mainNavMobileExpand = function() {
    if ($(window).width() <= MOBILE_BREAK_POINT) {
      $('#main_nav > ol').addClass('-js-expand');
      return bindMainNavMobilecollapse();
    }
  };

  mainNavMobilecollapse = function() {
    $('#main_nav > ol').removeClass('-js-expand');
    return $(window).off('scroll', mainNavMobilecollapse);
  };

  bindMainNavMobilecollapse = function() {
    return $(window).on('scroll', mainNavMobilecollapse);
  };

  $(function() {
    sizeAllThings();
    $(window).on('resize', sizeAllThings);
    return $('#main_nav > ol').on('click', mainNavMobileExpand);
  });

}).call(this);
