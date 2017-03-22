$(".acc-title").click(function() {
  $(".acc-title").not(this).removeClass("active");
  $(this).toggleClass("active");
  $(this).siblings(".acc-content").slideToggle(350);
  $(".acc-title").not(this).siblings(".acc-content").slideUp(300);
});