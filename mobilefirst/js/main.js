(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
})(window,document,'script','//www.google-analytics.com/analytics.js','ga');
//런칭할때 UA-52658695-3 으로 변경
ga('create', 'UA-52658695-3', 'auto');

$(document).ready(function() {
	// 클릭이벤트 속도 향상을 위한 fastclick 적용
    FastClick.attach(document.body);
	
    var sessionStorage = null,
    	gJson = "", // 세션 스토리지에서 menu json 값을 확인 없으면 메뉴json 데이터를 받아온다.
		d = "";
    
    // 메인 배너 json 로드
    $.getJSON('/mobilenew/gnb/category/mainBanner.json', function(json){
		  var template = $('#bannerTemplate').html(), //  소분탬플릿
		  		rendered = [];
	        Mustache.parse(template); // optional, speeds up future uses
	        $.each(json, function(k, json) {
	            rendered.push(Mustache.render(template, json));
	        });			
		
		$("#bannerCarousel").empty()
			.append(rendered)
			.slick({
	    		arrows : true,
	    		infinite : true,
	    		mobileFirst : true,
	    		swipeToSlide : true,
	    		autoplay : true,
	    		dots: true
	    	}).css('visibility', 'visible');
	});
	
	/**
	 * 세션스토리지에 home-json이 들어 있다면 꺼내오고 없으면
	 * 새로 불러와 저장 시킨다.
	 */
    (function initializeHome(){
    	sessionStorage = $.sessionStorage;
    	if (!sessionStorage.isSet("HOME-JSON")) {
    		ajaxHomeJson();
    		return;
    	}

    	 // 데이터 저장		
         gJson = sessionStorage.get("HOME-JSON");
         doRender();
    })();

    
    /**
     * 트렌드픽업, 백화점, 쇼설모아 json 데이터가 
     * 들어있는  json 파일 로드 
     */
    function ajaxHomeJson(){
        $.getJSON('ajax/enruri_home_json.js', function(json){
			gJson = json;
			var deal = JSON.parse(gJson.deal);
			var depart = JSON.parse(gJson.depart);

			// 세션에 저장하여 다시 json을 불러오지 않도록 처리 	        
	        sessionStorage.set("HOME-JSON", gJson);
			doRender();
		});
    }	

	/**
	 *  트렌드 픽업 , 백화점 , 쇼셜모아 렌더링 처리 
	 */
    function doRender(){
        console.dir(gJson);
		var deal = JSON.parse(gJson.deal);
		var depart = JSON.parse(gJson.depart);
		var trendpick = JSON.parse(gJson.trendpick);

		// 트렌드픽업 렌더링 
		renderTrendPick(trendpick.trend , function(){
			// callback
		});
		

		// 핫딜 렌더링 
		renderHotdeal(deal.list.DS_COUPON , function(){
			// callback
		});
		
		// 백화점 렌더링	
		renderDepart(depart.departmentGoodsList, function(){
			// callback 
		});    	
    }
    
	/**
	 * 트렌드픽업 렌더링 처리
	 * @param  {[type]}   list     [description]
	 * @param  {Function} callback [description]
	 */
    function renderTrendPick(list, callback){
        var rendered = [], // 랜더링 html
        	template = $('#trendPickTemplate').html(), 
        	$trendpick_list = $("#trendpick_list"),
			subRendered = [];

        Mustache.parse(template); // optional, speeds up future uses
        list = shuffle(list);
        // 랜덤으로 2개만 추출한다.
        for(var i=0; i<2; i++){
        	console.dir(list[i]);
        	$trendpick_list.append(Mustache.render(template, list[i]))
        	subRendered = [];
        	console.dir(list[i].keywordlist);
        	$.each(list[i].keywordlist, function(k, v){
        		subRendered.push("<dd><a href='");
        		subRendered.push(v.url);
        		subRendered.push("'>");
        		subRendered.push(v.keywords);
        		subRendered.push("</a></dd>");
        	});

        	$trendpick_list.find('.keyword:last > dt').after(subRendered.join(""));
        }

        
         // rolling 
         $trendpick_list.slick({
    		arrows : false,
    		infinite : true,
    		mobileFirst : true,
    		draggable : false,
    		swipe : false,
    		autoplay : true,
    		dots: false,
    		//autoplaySpeed : 3000
    	}).find('a')
    		.on('click', function(){
    		var $this = $(this);
    		window.location = $this.attr('href');
    		
    		return true;
    	});	
		
		callback();
    }


	/**
	 * 소셜모아 렌더링 처리
	 * @param  {[type]}   list     [description]
	 * @param  {Function} callback [description]
	 */
    function renderHotdeal(list, callback){
        var rendered = [], // 랜더링 html
        subMenuTemplate = $('#hotDealTemplate').html(); //  소분탬플릿
        Mustache.parse(subMenuTemplate); // optional, speeds up future uses
        $.each(list, function(k, json) {
        	if(!json.cpSalerate){
        		json.cpSalerate = "<span class=\"special\">특가</span>";
        	}else{
        		json.cpSalerate = "<span class=\"sale\">" + json.cpSalerate + "<em>%</em></span>";
        	}
        	
        	// 통화 단위 append
        	json.cpPrice = commaNum(json.cpPrice);
        	json.cpSaleprice = commaNum(json.cpSaleprice);
            rendered.push(Mustache.render(subMenuTemplate, json));
        });			
		
		// 동적이미지로드 적용 
        $(".deal_list").append(rendered.join(""));
        $("img.lazy").lazyload();
		
		callback();
    }
	
	/**
	 * 백화점 렌더링 
	 * @param  {[type]}   list     [description]
	 * @param  {Function} callback [description]
	 * @return {[type]}            [description]
	 */
    function renderDepart(list, callback){
        var rendered = [], 
        	template = $('#departTemplate').html(),
        	count = 0;
        	// 가격 목록 
        	subRendered = [], 
        	subTemplate = $('#departPriceTemplate').html(), 
        	$depart = $("#depart_list");
        	
        Mustache.parse(template); // optional, speeds up future uses
        Mustache.parse(subTemplate);
        list = shuffle(list);
        console.log("백화점 : " + list.length);
        
        for(var i=0; i<list.length; i++){
        	// 모바일껀만 노출  
        	if(list[i].mobile_yn != "Y"){
        		continue;
        	}else if(count > 2){
        		break;
        	}
        	console.dir(list[i]);
        	// 가격목록
        	subRendered = [];
        	$.each(list[i].mallList, function(k, v){
        		subRendered.push(Mustache.render(subTemplate, v));
        	});
        	
        	list[i].folder1 = list[i].modelno.substring(0,3) + "00000";
        	list[i].folder2 = list[i].modelno.substring(0,4) + "0000";
        	$depart.append(Mustache.render(template, list[i]))
	    		.find('.departArea:last')
	    		.append(subRendered.join(""));   
        	
        	count++;
        }

		// rolling        
         $depart.slick({
    		arrows : false,
    		infinite : true,
    		mobileFirst : true,
    		draggable : false,
    		swipe : false,
    		autoplay : true,
    		dots: false,
    		//autoplaySpeed : 3000
    	}).find('a')
    		.on('click', function(){
    		var $this = $(this);
    		window.location = $this.attr('href');
    		
    		return true;
    	});
        
		callback();
    }	
	
    $(window).scroll(function(){
        if ( $(window).scrollTop() == 0 ){
        	$(".TBtn").hide();
        }else{
        	$(".TBtn").show();
        }
    });	
    
	/**
	 *	Top으로 이동 
	 */
	$(".TBtn").on('click', function(e){
		window.scrollTo(0,0);
		e.stoppropagation();
		e.preventDefault();
		return false;
	});	
	

	/**
	 *	트랜드 픽업 홈페이지로 이동 
	 */
	$(".morebtn_deal").on('click', function(){
		window.open('http://m.enuri.com/deal/mobile/main.deal');
	});	
	
	/**
	 *	소셜모아 홈페이지로 이동 
	 */
	$(".morebtn_deal").on('click', function(){
		window.open('http://m.enuri.com/deal/mobile/main.deal');
	});
	
	/**
	 * 백화점 홈페이지로 이동
	 */
	$("#departMoreBtn").on('click', function(){
		window.open('http://m.enuri.com/mobiledepart/Index.jsp');
	});

	/**
	 *  로그인 
	 */
	$("#loginBtn").on('click', function(){
		var host = location.hostname,
			url = "http://" + host
				+ "/mobilenew/login/login.jsp?app=&backUrl"
				+ "=http://" + host + "/deal/mobile/main.deal";

		window.location.href = url;				

	});
	
	
	/**
	 * 카테고리 선택
	 */
	$("ul.m_depth > li").on('click', function(){
		var $this = $(this),
			className = $this.attr('class');
		
		$this.parent()
			.find('a')
			.removeClass('on');
		
		$this.find('a:first')
			 .addClass('on');
		
		if(window.android){
			try{
				android.onCate(className);
			}catch(e){
				console.e('no send android');
			}
		}
		
	});
	
	
	/**
	 * 메뉴 버튼
	 */
	$(".cateBtn").on('click', function(){
		if(window.android){
			try{
				android.onMenu();
			}catch(e){
				console.e('no onMenu send android');
			}
		}else{
			$(".cate_menu").trigger('click');
		}
	});

	
	function insertLog(d){
		
	}
	
	
	//+ Jonas Raoni Soares Silva
	//@ http://jsfromhell.com/array/shuffle [v1.0]
	function shuffle(o){ //v1.0
	    for(var j, x, i = o.length; i; j = Math.floor(Math.random() * i), x = o[--i], o[i] = o[j], o[j] = x);
	    return o;
	};	


	// link
	$(".newMallList > li > a > img").click(function(){
		var mall = $(this).attr("alt");
		var outLinkUrl = "";
		if(mall == '롯데닷컴'){
			insertLog('11000');
			//ga('send', 'event', 'home', 'shop', 'shop_'+mall);
			outLinkUrl = "http://m.lotte.com/main.do?&cn=112346&cdn=783491&DEVICE_BROWSER=Y";		
		}else if(mall == '신세계몰'){
			insertLog('11000');
			//ga('send', 'event', 'home', 'shop', 'shop_'+mall);
			outLinkUrl = "http://shinsegaemall.ssg.com/?ckwhere=s_enuri&DEVICE_BROWSER=Y";
		}else if(mall == '현대H몰'){
			insertLog('11000');
			//ga('send', 'event', 'home', 'shop', 'shop_'+mall);
			outLinkUrl = "http://www.hyundaihmall.com/front/shNetworkShop.do?NetworkShop=Html&ReferCode=022&Url=http://www.hyundaihmall.com/Home.html&DEVICE_BROWSER=Y";
		}else if(mall == '갤러리아'){
			insertLog('11000');
			//ga('send', 'event', 'home', 'shop', 'shop_'+mall);
			outLinkUrl = "http://www.galleria.co.kr/common.do?method=join&channel_id=2764&link_id=0001&DEVICE_BROWSER=Y";
		}else if(mall == 'GS SHOP'){
			insertLog('11000');
			//ga('send', 'event', 'home', 'shop', 'shop_'+mall);
			outLinkUrl = "http://with.gsshop.com/jsp/jseis_withLGeshop.jsp?DEVICE_BROWSER=Y&media=Pg&gourl=http://m.gsshop.com";
		}else if(mall == 'CJmall'){
			insertLog('11000');
			//ga('send', 'event', 'home', 'shop', 'shop_'+mall);
			outLinkUrl = "http://m.cjmall.com/wigktf.jsp?wid=indexI&SHOPID=ENURI&DEVICE_BROWSER=Y";
		}else if(mall == '롯데 홈쇼핑'){
			insertLog('11000');
			//ga('send', 'event', 'home', 'shop', 'shop_'+mall);
			outLinkUrl = "http://www.lotteimall.com/coop/affilGate.lotte?chl_no=140769&chl_dtl_no=2540476&DEVICE_BROWSER=Y";
		}else if(mall == 'ak mall'){
			insertLog('11000');
			//ga('send', 'event', 'home', 'shop', 'shop_'+mall);
			outLinkUrl = "http://www.akmall.com/assc/associate.jsp?assc_comp_id=26392&DEVICE_BROWSER=Y";
		}else if(mall == '홈앤쇼핑'){
			insertLog('11000');
			//ga('send', 'event', 'home', 'shop', 'shop_'+mall);
			outLinkUrl = "http://m.hnsmall.com/channel/gate?channel_code=20200&DEVICE_BROWSER=Y";
		}else if(mall == '11번가'){
			insertLog('11000');
			//ga('send', 'event', 'home', 'shop', 'shop_'+mall);
			outLinkUrl = "http://www.11st.co.kr/connect/Gateway.tmall?method=Xsite&tid=1000997249&DEVICE_BROWSER=Y";
		}else if(mall == '이마트'){
			insertLog('11000');
			//ga('send', 'event', 'home', 'shop', 'shop_'+mall);
			outLinkUrl = "http://emart.ssg.com/?ckwhere=m_enuri&DEVICE_BROWSER=Y";
		}else if(mall == 'dshop'){
			insertLog('11000');
			//ga('send', 'event', 'home', 'shop', 'shop_'+mall);
			outLinkUrl = "http://www.dnshop.com/?Sid=0024_8H050000_01_01&DEVICE_BROWSER=Y" ;
		}else if(mall == '위메프'){
			insertLog('11000');
			//ga('send', 'event', 'home', 'shop', 'shop_'+mall);
			outLinkUrl = "http://www.wemakeprice.com/widget/aff_bridge_public/enuri_m/0/Y/PRICE_af?DEVICE_BROWSER=Y" ;
		}else if(mall == '티몬'){
			insertLog('11000');
			//ga('send', 'event', 'home', 'shop', 'shop_'+mall);
			outLinkUrl = "http://m.ticketmonster.co.kr/entry/?jp=80025&ln=214285&DEVICE_BROWSER=Y";
		}else if(mall == '보리보리'){
			insertLog('11000');
			//ga('send', 'event', 'home', 'shop', 'shop_'+mall);
			outLinkUrl = "http://m.boribori.co.kr/partner/commonv2.aspx?partnerid=b_enuri_m2&ReturnUrl=http%3a%2f%2fm.boribori.co.kr&DEVICE_BROWSER=Y";
		}else if(mall == '홈플러스'){
			insertLog('11000');
			//ga('send', 'event', 'home', 'shop', 'shop_'+mall);
			outLinkUrl = "http://www.homeplus.co.kr/app.exhibition.main.PartnerMall.ghs?extends_id=enuri&service_cd=56080&nextUrl=http://www.homeplus.co.kr&DEVICE_BROWSER=Y";
		}else if(mall == '지마켓'){
			insertLog('11000');
			//ga('send', 'event', 'home', 'shop', 'shop_'+mall);
			outLinkUrl = "http://www.gmarket.co.kr/index.asp?jaehuid=200006254&DEVICE_BROWSER=Y";
		}else if(mall == '옥션'){
			insertLog('11000');
			//ga('send', 'event', 'home', 'shop', 'shop_'+mall);
			outLinkUrl = "http://banner.auction.co.kr/bn_redirect.asp?ID=BN00181187&DEVICE_BROWSER=Y";
		}else if(mall == '인터파크'){
			insertLog('11000');
			//ga('send', 'event', 'home', 'shop', 'shop_'+mall);
			outLinkUrl = "http://m.interpark.com/mobileGW.html?svc=Shop&bizCode=P14126&url=http://m.shop.interpark.com&DEVICE_BROWSER=Y";
		}else if(mall == '엘롯데'){
			insertLog('11000');
			//ga('send', 'event', 'home', 'shop', 'shop_'+mall);
			outLinkUrl = "http://m.ellotte.com/main.do?&cn=153348&cdn=2942692&DEVICE_BROWSER=Y";
		}else if(mall == '롯데마트'){
			insertLog('11000');
			//ga('send', 'event', 'home', 'shop', 'shop_'+mall);
			outLinkUrl = "http://m.lottemart.com/mobile/mobile_main.do?AFFILIATE_ID=01030001&CHANNEL_CD=00056&DEVICE_BROWSER=Y";
		}
		//여행사
		else if(mall == '하나투어'){
			//ga('send', 'event', 'home', 'tour', 'tour_'+mall);
			outLinkUrl = "http://menuri.hanatour.com?DEVICE_BROWSER=Y";
		}else if(mall == '모두투어'){
			//ga('send', 'event', 'home', 'tour', 'tour_'+mall);
			outLinkUrl = "http://m.enuri.modetour.co.kr?DEVICE_BROWSER=Y";
		}else if(mall == '한진관광'){
			//ga('send', 'event', 'home', 'tour', 'tour_'+mall);
			outLinkUrl = "http://enurim.kaltour.com?DEVICE_BROWSER=Y";
		}else if(mall == '온라인투어'){
			//ga('send', 'event', 'home', 'tour', 'tour_'+mall);
			outLinkUrl = "http://m.onlinetour.co.kr/web/tour?channel_code=enuri&DEVICE_BROWSER=Y";
		}
	
		window.open(outLinkUrl);
	
	});	
	
});