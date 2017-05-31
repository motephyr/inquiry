
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

window.pathReg = new RegExp("/user_infos/[^/]+/works/.*");
window.fromDismissEvent = false;
window.fromStateChangeEvent = false;
window.fromModalEmptyEvent = false;

$('a.item-wrap[data-remote=true]').on('click', function(e){
  var url = $(this).attr('href');
  
  $("#myModal").prop('url', url);
  
  if(!fromModalEmptyEvent){
    history.forward();
    if(!history.state || !history.state.url){
      history.pushState({url: url}, "", url);
      $("#myModal").modal();
    }
  }
  fromModalEmptyEvent = false;
});

$("#myModal").on( 'hide.bs.modal', function(){
  var ck = this.querySelector('.ckeditor');
  if(ck){
    var frame = ck.querySelector('iframe'),
      video = ck.querySelector('video'),
      audio = ck.querySelector('audio');
    if(frame) frame.contentWindow.postMessage('{"event":"command","func":"pauseVideo","args":""}','*');
    if(video) video.pause();
    if(audio) audio.pause();
    if(!fromStateChangeEvent){
      fromDismissEvent = true;
      history.back(); // to trigger hashchange
    }
  }
});

window.addEventListener('popstate', function(e){
  var state = e.state;
  var fromModalUrl = $("#myModal").prop('url');
  if(state){
    if(fromModalUrl && pathReg.test(fromModalUrl) && state.url != fromModalUrl){
      history.replaceState({url: fromModalUrl}, "", fromModalUrl);
    }else if(!fromModalUrl){
      fromModalEmptyEvent = true;
      $('a.item-wrap[href="' + state.url + '"]').trigger('click'); 
    }
    $("#myModal").modal();
  }else{
    // means to dismiss
    if(!fromDismissEvent){
      fromStateChangeEvent = true;
      if($('#myModal').is(':visible')) $("#myModal").modal('hide');
    }
    fromDismissEvent = fromStateChangeEvent = false;
  }
  console.log(history.state);
  if(history.state) console.log(history.state.url);
});
