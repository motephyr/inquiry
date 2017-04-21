
function onHeartClick(o){
    // $(this).find('i').toggleClass('glyphicon glyphicon-heart').toggleClass('glyphicon glyphicon-heart text-danger');
    // if $(this).find('i').class()
    var el = $(o).find('i');
    var next_count = $(o).next(".heart_count_link").find('.heart_count');
    if (el.hasClass('text-danger')) {
      next_count.text(parseInt(next_count.text()) - 1);
    } else {
      next_count.text(parseInt(next_count.text()) + 1);
    }
    el.toggleClass('glyphicon glyphicon-heart').toggleClass('glyphicon glyphicon-heart text-danger'); 
}