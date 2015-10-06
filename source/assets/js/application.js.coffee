//= require_tree .

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


sizeAllThings = ->
  sizeSquareBlocks()
  sizeHomepage()

# here we bind it all
$ ->
  sizeAllThings()
  
  $(window).on 'resize', sizeAllThings
