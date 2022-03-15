<script>
	jQuery.cachedScript = function( url, options ) {options = $.extend( options || {}, {dataType: "script",cache: true,url: url}); return jQuery.ajax( options );};
	jQuery.cachedScript("/lsv2016/js/lib/jquery.lazyload.min.js");
	jQuery.cachedScript("/js/swiper.min.js");
	//jQuery.cachedScript("/common/js/function.js");
</script>
