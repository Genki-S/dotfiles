jQuery ($) ->
  $('form#f select').each ->
    select = $(this)

    good = $('<a>○</a>').css('margin', '0 5px')
    maybe = $('<a>△<a>').css('margin', '0 5px')
    bad = $('<a>×<a>').css('margin', '0 5px')
    good.bind 'click', ->
      select.val('○')
    maybe.bind 'click', ->
      select.val('△')
    bad.bind 'click', ->
      select.val('×')

    select.parent().append good, maybe, bad
