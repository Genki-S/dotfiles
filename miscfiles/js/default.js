var clickables = $(':not(a)').filter(function() {
  return $(this).css('cursor') == 'pointer';
});
clickables.addClass('vimperator-hint-target');
