
function onHeartClick(ostr){
    // $(this).find('i').toggleClass('glyphicon glyphicon-heart').toggleClass('glyphicon glyphicon-heart text-danger');
    // if $(this).find('i').class()
    var el = $('#'+ ostr).find('.glyphicon-heart');
    var next_count = $('#'+ ostr).find('.heart_count');
    if (el.hasClass('text-danger')) {
      next_count.text(parseInt(next_count.text()) - 1);
    } else {
      next_count.text(parseInt(next_count.text()) + 1);
    }
    el.toggleClass('glyphicon glyphicon-heart').toggleClass('glyphicon glyphicon-heart text-danger');
}

$('a.item-wrap[data-remote=true]').on('click', function(e){
  // history.pushState({}, '', $(this).attr('href')+ '.html');
  var url = $(this).attr('href');
  $("#myModal").prop('url', url);
  location.hash = url;
});

window.hashReg = new RegExp("/user_infos/[^/]+/works/.*");
window.fromDismissEvent = false;
window.fromHashChangeEvent = false;
$("#myModal").on( 'hide.bs.modal', function(){
  var ck = this.querySelector('.ckeditor');
  if(ck){
    var frame = ck.querySelector('iframe'),
      video = ck.querySelector('video'),
      audio = ck.querySelector('audio');
    if(frame) frame.contentWindow.postMessage('{"event":"command","func":"pauseVideo","args":""}','*');
    if(video) video.pause();
    if(audio) audio.pause();
    if(!fromHashChangeEvent){
      fromDismissEvent = true;
      history.back(); // to trigger hashchange
    }
  }
});

window.addEventListener('hashchange',function(){
  var hash = window.location.hash.substr(1);
  if(hash && hashReg.test(hash)){
    // means not yet load
    if($("#myModal").prop('url') != hash) $('a.item-wrap[href="' + hash + '"]').trigger('click'); 
    $("#myModal").modal();
  }else{
    if(!fromDismissEvent){
      fromHashChangeEvent = true;
      if($('#myModal').is(':visible')) $("#myModal").modal('hide');
    }
    fromDismissEvent = fromHashChangeEvent = false;
  }
});

window.addEventListener('load', function(){
  var hash = window.location.hash.substr(1);
  if(hash && hashReg.test(hash)){
    var target = document.querySelector('a.item-wrap[href="' + hash + '"]');
    if(target) $(target).trigger('click');
    $("#myModal").modal();
  }
});

