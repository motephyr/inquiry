$(".acc-title").click(function() {
  $(".acc-title").not(this).removeClass("active");
  $(this).toggleClass("active");
  $(this).siblings(".acc-content").slideToggle(350);
  $(".acc-title").not(this).siblings(".acc-content").slideUp(300);
});

      function get_hostname(url) {
        var m = url.match(/^http:\/\/[^/]+|^https:\/\/[^/]+/);
        return m ? m[0] : null;
      }
      function imgError(image){
        image.src = 'http://conkwe.com/favicon.ico';
        // image.style.display = 'none';

      }
    $(function() {
      $("a").each(function() {
        if ($(this).attr("target") == '_blank'){
          var href = $(this).attr("href");
          var host = get_hostname(href);
          if (host !== 'null'){
            $(this).before("<a href="+href+" target='_blank'><img width='32px' height='32px' src='" + host + "/favicon.ico' onerror='imgError(this);' /></a>");
          }
        }
      });
    });