//= require_tree .

MOBILE_BREAK_POINT = 768

# Size Square Blocks
sizeSquareBlocks = ->
  $('.square_block').each ->
    contentHeight = $(this).find('.square_block--content').outerHeight(true)
    holderWidth = $(this).outerWidth(true)
    if holderWidth > contentHeight
      $(this).height holderWidth
    else
      $(this).height ''
      
# Size homepage--about 
sizeHomepage = ->
  height = $(window).height() - $('#main_header').outerHeight(true)
  $('#homepage--about').height height

# Expand menu on mobile
mainNavMobileExpand = ->
  if $(window).width() <= MOBILE_BREAK_POINT
    $('#main_nav > ol').addClass '-js-expand'
    bindMainNavMobilecollapse()

mainNavMobilecollapse = ->
  $('#main_nav > ol').removeClass '-js-expand'
  $(window).off 'scroll', mainNavMobilecollapse

bindMainNavMobilecollapse = ->
  $(window).on 'scroll', mainNavMobilecollapse

sizeAllThings = ->
  sizeSquareBlocks()
  sizeHomepage()

# here we bind it all
$ ->
  sizeAllThings()
  
  $(window).on 'resize', sizeAllThings
  
  $('#main_nav > ol').on 'click', mainNavMobileExpand
