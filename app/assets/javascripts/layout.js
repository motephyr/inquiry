  function toFixedSquareSize(){
    var el = $(".UserDataBox .WorksList ul.designerWorksList li .photoBox a.photogo");
    el.height(el.width());
  }

  window.addEventListener('resize', toFixedSquareSize);
  window.addEventListener('load', toFixedSquareSize);

  function detect_is_safari(){
    return /constructor/i.test(window.HTMLElement) || (function (p) { return p.toString() === "[object SafariRemoteNotification]"; })(!window['safari'] || safari.pushNotification) || /iPad|iPhone|iPod/.test(navigator.userAgent); 
  }

  function toFixedPercent(num, decimals){
    decimals = decimals || 1;
    var shiftRight = Math.pow(10,(decimals + 2));
    return Math.floor( num * shiftRight ) / Math.pow(10, decimals);
  }

    function imgFlexboxFixed(img){
      var parent = img.parentElement;
      var w = parent.offsetWidth;
      var h = parent.offsetHeight;
      var nw = img.naturalWidth;
      var nh = img.naturalHeight;
      if(nw > nh){
        var resizeW = h / nh * nw;
        if(resizeW > w){
          img.style.cssText += "top:0px;left:-" + toFixedPercent((resizeW - w) / 2 / w, 1) + "%;";
        }else{
          img.style.cssText += "top:0px;left:" + toFixedPercent((w - resizeW) / 2 / w, 1) + "%;";
        }
      }else{
        var resizeH = w / nw * nh;
        if(resizeH > h){
          img.style.cssText += "left:0px;top:-" + toFixedPercent((resizeH - h) / 2 / h, 1) + "%;";
        }else{
          img.style.cssText += "left:0px;top:" + toFixedPercent((h - resizeH) / 2 / h, 1) + "%;";
        }
      }
    }

    function onImageLoad(o){
      // Off the event
      o.onload = null;
      if(o.naturalWidth > o.naturalHeight){
        o.style.cssText += "width: auto; height: auto;";
      }

      if(detect_is_safari()){
        imgFlexboxFixed(o);
        window.addEventListener('resize', (function(img){
          return function(){ imgFlexboxFixed(img); };
        })(o));
      }
    }