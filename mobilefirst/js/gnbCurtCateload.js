(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
})(window,document,'script','//www.google-analytics.com/analytics.js','ga');
//런칭할때 UA-52658695-3 으로 변경
ga('create', 'UA-52658695-3', 'auto');

$( document ).ready(function() {

	var c1dept = getCookie("c1dept"); // class
	var c2dept = getCookie("c2dept"); // name
	
	if (c1dept) {
  		setTimeout(function(){

  			$( "body" ).find("#"+c1dept+" > a").trigger("click");
			$( "body" ).find("#two"+c2dept).trigger("click");			

			var id = c1dept.replace("A","");
			
			if(!c2dept){
					
				$(".depth.third").empty();
				$(".depth.fourth").empty();
				
				if(id == 121 || id == 110){
					$( ".first" ).scrollTop( $(window).height()/2 );	
				}else if(id == 112 || id == 114 || id == 118){
					$( ".first" ).scrollTop( $(window).height() );
				}
				
			}

		},300);
		
  	}

	
});



	
