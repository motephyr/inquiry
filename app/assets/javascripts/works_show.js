function iframeResizingTune(){
	this.style.height = this.scrollWidth * 0.7 + "px";
}
var iframesInContent = document.querySelectorAll(".ckeditor iframe");
jQuery(iframesInContent).load(iframeResizingTune);
jQuery(window).resize(function(){
	iframesInContent.forEach(function(o){ iframeResizingTune.call(o) });
});
