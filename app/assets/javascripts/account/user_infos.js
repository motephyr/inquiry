$(".acc-title").click(function() {
  $(this).toggleClass("active");
  $(this).siblings(".acc-content-show").slideToggle(350);
});

      function get_hostname(url) {
        var m = url.match(/^http:\/\/[^/]+|^https:\/\/[^/]+/);
        return m ? m[0] : null;
      }
      function imgError(image){
        image.src = '/favicon.ico';
        // image.style.display = 'none';

      }
    $(function() {
      $("a").each(function() {
        if ($(this).attr("target") == '_blank'){
          var href = $(this).attr("href");
          var host = get_hostname(href);
          if (host !== 'null'){
            $(this).before("<a href="+href+" target='_blank'><img width='16px' height='16px' src='" + host + "/favicon.ico' onerror='imgError(this);' /></a>");
          }
        }
      });
    });