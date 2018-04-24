$ ->
  getBox = (elem) ->
    return elem.parent() if elem.parent().hasClass 'item'
    elem.parentsUntil('.item').parent().eq(0)

  $('.item a').mouseenter () ->
    getBox($(@)).addClass 'hover'
  .mouseleave () ->
    getBox($(@)).removeClass 'hover'

  $('.products').masonry
    itemSelector: '.item'
  .masonry 'reload', () ->
    n = $(@).length
    [1..n].seq (item, idx, next) =>
      $(@).eq(idx).betterToggle()
      do () ->
        setTimeout () ->
          next()
        , 50
    , (err) ->

  unless /localhost/.test location.href
    $('.library .item').each (idx) ->
      repo = $(@).find('h4').text().replace(/^\s+/, '').replace(/\s+$/, '')
      $.ajax
        url: "https://api.github.com/repos/ktty1220/#{repo}"
        dataType: 'jsonp',
        success: (json) =>
          $(@).find('.hubinfo .star').show().text json.data.watchers ? 0
