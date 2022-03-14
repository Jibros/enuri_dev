$(function(){
	var duration = 200;

	$(".nav.navbar-nav li a").click(function(e){
		e.preventDefault();

		var dropdownStat = $(this).parent("li").hasClass("dropdown");
		
		if(dropdownStat){
			return;
		}else{
			var link = $(this).attr("href");

			$.ajax({
				url: link,
				dataType: "html",
				type: "get",
				success: function(data){
					$("#sectorArea").html(data);

					SyntaxHighlighter.autoloader(
						'css						/pub_test/ui_guide/assets/js/syntaxhighlighter/scripts/shBrushCss.js',
						'js jscript javascript		/pub_test/ui_guide/assets/js/syntaxhighlighter/scripts/shBrushJScript.js',
						'xml xhtml xslt html		/pub_test/ui_guide/assets/js/syntaxhighlighter/scripts/shBrushXml.js'
					);
					SyntaxHighlighter.config.bloggerMode = true;
					// SyntaxHighlighter.config.stripBrs = true;
					// SyntaxHighlighter.defaults['html-script'] = true;
					SyntaxHighlighter.all();

					if($(document).scrollTop() != 0){
						$("html, body").animate({scrollTop: 0}, duration);
					}

					var wid = $(window).outerWidth();
					//console.log(wid);
					if(wid < 768) {
						$("#bs-example-navbar-collapse-1").removeClass("in").attr("aria-expanded", false);
					}
				}
			});
		}
	});

	// go Top
	$("#grGoTop").click(function(e){		
		e.preventDefault();

		$("html, body").animate({scrollTop: 0}, duration);
	});

	// init
	$.ajax({
		type:"GET",
		url:"/pub_test/ui_guide/include/ui-introduce.html",
		success:function(html){
			var list = $.parseHTML(html);
			console.log(list)
			$("#sectorArea").append(list);
		}
	})

	// init
	//$("#sectorArea").load("/pub_test/ui_guide/include/ui-introduce.html");
});