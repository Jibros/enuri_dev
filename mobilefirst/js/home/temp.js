
(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
	(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
	m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
	})(window,document,'script','//www.google-analytics.com/analytics.js','ga');
	//런칭할때 UA-52658695-3 으로 변경
	ga('create', 'UA-52658695-3', 'auto');


	//view-source:http://www.sutanaryan.com/wpcp/Tutorials/fixed-menu-when-scrolling-page-with-CSS-and-jQuery/
$(document).ready(function() {

    $("body").on('touchend', function(e) {
        if (window.android && android.onTouchEnd) {
            window.android.onTouchEnd();
        } else if ($("#ios").val()) {

        }
    });
    
    (function initPage(){
    	// 사용자 아이디
		$.getJSON("/mobilefirst/ajax/login/loginInfo_ajax.jsp", null, function(result) {
			var userId = result.id;
			// $("html").text(result.id);
		});
		
		// 
		$(window).scroll(function () {
			if ($(this).scrollTop() > 136) {
				$('.nav-container').addClass("f-nav");
			} else {
				$('.nav-container').removeClass("f-nav");
			}
		});
		
    })();
    
    
    /**
     *  로그인 
     */
    $("#aa").on('click', function() {
        var host = location.hostname,
            url = "http://" + host + "/mobilenew/login/login.jsp?app=&backUrl" + "=http://" + host + "/deal/mobile/main.deal";
        window.location.href = url;

    });    
    
    
    /**
     *  이벤트 페이지 이동 
     */
    $("#aa").on('click', function() {
        var host = location.hostname,
            url = "http://" + host + "/mobilenew/login/login.jsp?app=&backUrl" + "=http://" + host + "/deal/mobile/main.deal";
        window.location.href = url;
    });    
   
    /**
     *  유의사항 레이어 띄우기  
     */
    $("#noticeLayer").on('click', function() {
    	//show
    });    
    
    
    /**
     *	상세 내역으로 이동      
     */
    $("#noticeLayer").on('click', function() {
    	// 앱 미설치자 ->레이어-> 스토어 
    	if(IsLogin()){
	    	// or  상세내역으로 이동 
	    	var $mainLayer = $("#mainLayer2");
	        $mainLayer.show();
    	}else{
    		//
    	}
    });        

});