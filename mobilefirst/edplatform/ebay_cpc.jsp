<%@ page contentType="text/html; charset=utf-8" %>
<%
cb = new CookieBean(request.getCookies());      //쿠키빈을 Default로 생성한다.
String isAdult = ChkNull.chkStr(cb.GetCookie("MEM_INFO","ADULT"), "");
String strEdReqUrl = ChkNull.chkStr(request.getRequestURL().toString(), "");
String strEdUserIp = ConfigManager.szConnectIp(request);
String strEdShopImg = ConfigManager.IMG_ENURI_COM;

String sCate = ChkNull.chkStr(request.getParameter("cate"), "");
sCate = CutStr.cutStr(sCate, 4);

String appYN = "N";
try{
    Cookie[] cookies = request.getCookies();              
 
    if(cookies!=null){                                     

        for(int i=0; i<cookies.length; i++){                    
            if(cookies[i].getName().equals("appYN")){               
                appYN =cookies[i].getValue();                   
                break;
            }
        }
    }
}catch(Exception e){
    appYN = "N";    
}finally{
}

String sFreetoken = "";
if(appYN.equals("Y")) {
    sFreetoken= "?freetoken=social";
} 
 
String socialSKeyword = ChkNull.chkStr(request.getParameter("skeyword"),"");       //분류검색어
String socialKeyword = ChkNull.chkStr(request.getParameter("keyword"),"");      //검색어, 키워드
 
String socialLink = "/deal/mobile/main.deal#/home"+sFreetoken; 

if(socialSKeyword.length() > 0){
    socialLink = "/deal/mobile/main.deal#/search/"+socialSKeyword+sFreetoken;
}else if(socialKeyword.length() > 0){
    socialLink = "/deal/mobile/main.deal#/search/"+socialKeyword+sFreetoken;
}
%>

<!-- 150604 소셜 인기상품 --> 
<div id="socialMiniDiv" class="depart_hit" style="display:none;">
    <h3>소셜 인기상품</h3> 
    <a href="<%=socialLink%>" class="go_hotdeal" target="_new">에누리 핫딜쇼핑 소셜모아</a><!-- 150619 -->
             
    <div id="hit_scrollDiv" class="hit_scroll">
        <div id="hit_List_areaDiv" class="hit_List_area">
            <div id="social_hitDiv" class="hit_product"></div>
        </div>
    </div>

    <div id="hit_pagingDiv" class="hit_paging"></div>
</div>
<!--// 150604 소셜 인기상품 -->

<script language="JavaScript"> 
    //공용 변수(URL정보, 사용자IP, Enuri 이미지 URL)
    var varEDSearchPage = "<%=strEdReqUrl %>";
    var varEDUserIp = "<%=strEdUserIp %>";
    var varShopImage = "<%=strEdShopImg %>";
    
    //Listbody_Mp3.jsp 용 변수 선언 (카테고리코드, 키워드)
    var varEDCateCode = "<%=strCate %>";
    var varEDKeyword = "";      //기본 키워드 변수로 사용 하기로 정함.

    //EnuriSearch.jsp 용 변수 선언 (키워드) - SRP는 카테고리 검색이 없으므로, 키워드만 받아서 사용한다. 
    var varSrpKeyword = "<%=strKeyword %>";        //searchList Keyword Param
    var varSrpKeyword2 = "<%=strSKeyword %>";
    
     if ((varEDSearchPage.indexOf("/mobilefirst/search.jsp") > -1 || varEDSearchPage.indexOf("/mobilefirst/search2.jsp") > -1) && varSrpKeyword.length > 0) {     //search/EnuriSearch.jsp 용 키워드 값  : 일반적인 검색일때
        varEDKeyword = varSrpKeyword;
        varEDCateCode  = $(".prodList .listarea:first").attr("catecode");
    } else if ((varEDSearchPage.indexOf("/mobilefirst/list.jsp") > -1 || varEDSearchPage.indexOf("/mobilefirst/list2.jsp") > -1) && $(".search_mnt")) { //search/EnuriSearch.jsp 용 키워드 값  : 분류검색어로 검색페이지에서 넘어왔을때도 cpc 검색 로직을 태움
        varEDKeyword = varSrpKeyword2;
    }
    
    if(varEDKeyword == "")        varEDKeyword = varEDCateCode;
    
    //성인 상품 노출 위해 인증여부 변수 
    var varIsAdult = "<%= isAdult %>";
    //운영서버 체크 위한 구문
    var varEdIsReal = false; 
    if (varEDSearchPage.indexOf("www.enuri.com") > -1 || varEDSearchPage.indexOf("m.enuri.com") > -1) {
        varEdIsReal = true;
    }
</script> 
<script>
var ebayMakeTmp = "";
var nowSocialPage = 0;
var itemOneWidth = 0;
var urlKind = document.URL;

keywordStr = "<%=socialKeyword%>";

var ebayData = {};
jQuery(document).ready(function($) {
    
    if(urlKind.indexOf("/mobilefirst/list.jsp") > -1 || urlKind.indexOf("/mobilefirst/list2.jsp") > -1)  ga('send', 'event', 'mf_lp_ebaycpc', 'ebaycpc_lp PV', 'ebaycpc_'+varEDCateCode);
    else                                                           ga('send', 'event', 'mf_srp_ebaycpc', 'ebaycpc_srp PV', 'ebaycpc_'+varSrpKeyword);
  // cpcLoading(); 
    //cpc 영역 클릭
    $("body").on('click', "#lp_cpc > li", function(event) {
        var url = $(this).attr("data-id");
        var clk_t = $(this).attr("data-log");
        //ebay click log
        goClk_t(clk_t);
        
        if(urlKind.indexOf("/mobilefirst/list.jsp") > -1 )            ga('send', 'event', 'mf_lp_ebaycpc', 'ebaycpc_lp click_'+varEDCateCode, 'click_리스트형');
        else                                                                     ga('send', 'event', 'mf_srp_ebaycpc','ebaycpc_srp click_'+varSrpKeyword, 'click_리스트형');
        
        if( url.indexOf("http://") > -1 ) window.open(url);
    });
    
    $("body").on('click', "#lp_ebaycpc > li", function(event) {
        var url = $(this).attr("data-id");
        var clk_t = $(this).attr("data-log");
        //ebay click log
        goClk_t(clk_t);
        
        if(urlKind.indexOf("/mobilefirst/list.jsp") > -1) {
        	insertLogLSV(21236);
        	ga('send', 'event', 'mf_lp_ebaycpc', 'ebaycpc_lp click_'+varEDCateCode, 'click_리스트형');
        } else {
        	insertLog(21240);
        	ga('send', 'event', 'mf_srp_ebaycpc','ebaycpc_srp click_'+varSrpKeyword, 'click_리스트형');
        }
        
        if( url.indexOf("http://") > -1 ) window.open(url);
    });
    
    //신청하기
    $("body").on('click', ".cpcgo", function(event) {
        
        var nowType = $(this).attr("id");
        
        if(urlKind.indexOf("/mobilefirst/list.jsp") > -1 || urlKind.indexOf("/mobilefirst/list2.jsp") > -1){
            if( nowType == "cpcgoList"  )               ga('send', 'event', 'mf_lp_ebaycpc', 'ebaycpc_lp click_'+varEDCateCode, 'click_리스트형_신청하기');
            else if( nowType == "cpcgoBottom"  )   ga('send', 'event', 'mf_lp_ebaycpc', 'ebaycpc_lp click_'+varEDCateCode, 'click_소셜형_신청하기');
        }else{
            if( nowType == "cpcgoList"  )               ga('send', 'event', 'mf_srp_ebaycpc','ebaycpc_srp click_'+varSrpKeyword, 'click_리스트형_신청하기');
            else if( nowType == "cpcgoBottom"  )   ga('send', 'event', 'mf_srp_ebaycpc','ebaycpc_srp click_'+varSrpKeyword, 'click_소셜형_신청하기');
        }
        window.open("https://ad.esmplus.com/");
    });
    //하단영역 클릭 
    $("body").on('click', "div.ad_powerclick[data-type=bottom] li", function(event) {
        var $this = $(this);
        var index = $this.index();
        var clk_t = $(this).attr("data-url");
        var moveGo =  $(this).attr("data-id")   ;
        
        /// 이벤트 로그
        if(urlKind.indexOf("/mobilefirst/list.jsp") > -1 || urlKind.indexOf("/mobilefirst/list2.jsp") > -1){
        //	insertLogLSV(21237);
        	if(moveGo.indexOf("/deal/mobile/goods.deal") > -1){
        		ga('send', 'event', 'mf_lp', 'social', '상품 클릭 수');	
        	}else{
        		ga('send', 'event', 'mf_lp_ebaycpc', 'ebaycpc_lp click_'+varEDCateCode, 'click_소셜형');
        	}
        }else{
        //	insertLog(21241);
        	if(moveGo.indexOf("/deal/mobile/goods.deal") > -1){
            	ga('send', 'event', 'mf_srp', 'social', '상품 클릭 수');
            }else if(urlKind.indexOf("/mobilefirst/list.jsp") > -1 || urlKind.indexOf("/mobilefirst/list2.jsp") > -1){
            	ga('send', 'event', 'mf_lp_ebaycpc', 'ebaycpc_lp click_'+varEDCateCode, 'click_소셜형');
            }else if(urlKind.indexOf("/mobilefirst/search.jsp") > -1 || urlKind.indexOf("/mobilefirst/search2.jsp") > -1){
            	ga('send', 'event', 'mf_srp_ebaycpc','ebaycpc_srp click_'+varSrpKeyword, 'click_소셜형');
            }
        }
        //ebay click log
        //소셜은 클릭 잡지 않는다
        if( typeof(clk_t) != 'undefined' ){
        	goClk_t(clk_t);	
        }
        
        if( moveGo.indexOf("http://") > -1 ) window.open(moveGo);
    });             
});
//cpc 로딩
function cpcLoading(){
	var isAdult = "<%=isAdult%>"; //성인인증여부 쿠키
	var url = "/ebayCpc/jsp/connectApi2.jsp";
    //http://dev.enuri.com/ebayCpc/jsp/connectApi.jsp?maxCnt=6&keyword=%EB%85%B8%ED%8A%B8%EB%B6%81&chInfo=채널정보 
    var listKIND = "LP"; 
    
    if(urlKind.indexOf("/mobilefirst/list.jsp") > -1 || urlKind.indexOf("/mobilefirst/list2.jsp") > -1) listKIND = "LP";
    else listKIND = "SRP";
    
    var channerType = "";
    var searchCate = "";
    
    //srp 일경우 s_lp
    //LP 인데 카테고리 에서 클릭했을 경우 b_lpsrp
    //LP 인데 검색어로 LP로 왔을 경우 클릭했을 경우 s_lp 
    if(listKIND == "SRP" ){
        channerType = "m_lpsrp";
        searchCate  = $(".prodList .listarea:first").attr("catecode");
    }else if( listKIND == "LP"  ){
        if(varSrpKeyword2 == "") channerType = "b_lpsrp";
        else                              channerType = "s_lp";
    }
    
    $.ajax({ 
        type : "get", 
        url : url, 
        data : {keyword : varEDKeyword, isCate:listKIND, chInfo:channerType, cateCode:searchCate}, 
        async : false,
        dataType : "json", 
        success : function(result) {
            var size = $(".prodList > li").size();
            ebayData = result;
            if(result.sum_sort.length > 0 ){
                var adlineidx = 3; // 파워링크 와 파워클릭 간 상품수
                // adline은 네이버 파워링크가 걸리는 위치. 그 아래 모델 2개 + ebaycpc 가 위치함. 
                $('.prodList > li').each(function(idx, item){
                    //console.log(this);
                    if ($(this).attr('id') == 'adline'){
                        //console.log(idx);
                        adlineidx += idx;
                    }
                });
                
                // 파워링크 뒤에 모델이 2개 미만이면 ebaycpc 위치를 마지막으로 조절.
                if (adlineidx > $('.prodList > li').length){
                    adlineidx = $('.prodList > li').length - 1;
                }

             // $(".prodList li:eq(5)").after(ebayCpcMake(result));
             	if(urlKind.indexOf("/mobilefirst/list.jsp") > -1 || urlKind.indexOf("/mobilefirst/search.jsp") > -1){
             		
             		// 20200110 #37714 파워클릭 개편
             		$(".prodList > li:eq(" + adlineidx.toString()  + ")").last().after(initCenterPowerClick());	
             		
             		if( listKIND == "LP" ) {
             			drawPowerClick(result.sum_sort, varSrpKeyword, varEDCateCode, isAdult, listKIND);
             		} else if ( listKIND == "SRP" ) {
             			drawPowerClick(result.sum_sort, varSrpKeyword, searchCate, isAdult, listKIND);
             		}
             		
             		
             	}else{
             		$(".prodList > li:eq(" + adlineidx.toString()  + ")").last().after(ebayCpcMake(result));
             	}       	
                
             	//하단 소셜 인기상품 노출
               <%--  var cpcCnt = 6-result.sum_sort2.second.items.length;
                var cpcBottom = getEbayCpcBottom(result); // ebaycpc 하단 노출
                if(cpcCnt > 0){
                	var cnt = result.sum_sort2.second.items.length;
                    getSocialList("<%=sCate%>",cpcCnt , result.sum_sort2.second.items.length , cpcBottom);
                }else{ 
                    //$("#socialMiniDiv").after(cpcBottom);
                	if($(".depart_hit").is(":visible")){ 
                		$(".depart_hit").html(cpcBottom);
                	}else{
                		$("#socialMiniDiv").after(cpcBottom); 
                	}  
                } --%>
            }else{

                var oxyYN = false;
                /*
                #33351 검색 금지어 전체 삭제 2019.04.08, 최서진 선임 
                #35507 "수퍼굽 스킨 수딩 미네랄 선스크린" 외 15건 결과없음 처리 2019.08.19, jinwook 
                #35971 조개젓 관련 키워드 결과 없음 처리 2019.09.18. shwoo
                #36492 삼성 셀리턴 외 2019.10.23 jinwook
                #36741 베이비드림 키워드 결과 없음 처리 2019.11.07. shwoo
                */
                
                //단어 일치 할 경우 
                var strNoUseKwd = ["SKINSOOTHINGMINERALSUNSCREENSPF40","SOOTHINGMINERALSUNSCREENSPF40","수퍼굽스킨수딩미네랄선스크린SPF40"
                                   ,"수퍼굽스킨수딩미네랄선스크린","수퍼굽스킨수딩미네랄","수퍼굽스킨수딩","수퍼굽스킨","수퍼굽수딩","수퍼굽선스크린"
                                   ,"수퍼굽미네랄선스크린","수퍼굽수딩미네랄선스크린","AUSTRALIANGOLDLOTIONSUNSCREENSPF15"
                                   ,"오스트레일리안골드로션선스크린SPF15","오스트레일리안골드선스크린SPF15","CERAVESUNSCREENBODYLOTIONSPF30","세라베선스크린바디로션SPF30"
                                   ,"조개젓", "조개젓갈", "whrowjt","삼성셀리턴","삼성전자셀리턴","삼성LED마스크","삼성전자LED마스크","베이비드림"];

            	//단어가 포함될 경우 
            	var strNoUseContainKwd = ["조개젓", "조개젓갈", "whrowjt","삼성셀리턴","삼성전자셀리턴","삼성LED마스크","삼성전자LED마스크"];

            	  for(var i = 0; i < strNoUseKwd.length; i++){
                        if (strNoUseKwd[i] == keywordStr.replace( /(\s*)/g, "" ).toUpperCase()){
                        	oxyYN = true;
                            break;
                        }
                    }
            	  
            	  if (!oxyYN) {
            		  for(var i = 0; i < strNoUseContainKwd.length; i++){
            	            if (keywordStr.replace( /(\s*)/g, "" ).toUpperCase().indexOf(strNoUseContainKwd[i]) > -1){
            	            	oxyYN = true;
            	                break;
            	            }
            	        }
            	  } 
            	  
            	/*
        		// 상위의 조건에서 oxyYN = true 로 걸려있더라도, 정확히 일치하는 경우 다시 oxyYN = false 로 변환 시켜준다.
        		#36771 LP/SRP 검색결과없음 처리 보완 2019.11.18 jinwook
        		*/
        		var matchArray = ["베이비 드림"];
        		for(var mIdx=0; mIdx<matchArray.length; mIdx++) {
        			if (matchArray[mIdx] == keywordStr.toUpperCase()) {
        				oxyYN = false;
        				break;
        			}
        		}
				
                if(oxyYN == "" || oxyYN == "false" || !oxyYN ){
                    //getSocialSearch(keywordStr);
                    if( listKIND == "LP" ) {
                    	getSocialLp(varEDCateCode, 6);
                    } else if( listKIND == "SRP" ){
                    	getSocialSRP(keywordStr, 6);
                    }
                    <%-- getSocialList("<%=sCate%>",cpcCnt , 0 , cpcBottom);  --%>
                }
            }
        }
    });
}

//리스트 cpc append
function ebayCpcMake(result){
    var isAdult = "<%=isAdult%>"; //성인인증여부 쿠키
    if( typeof(result.sum_sort2.first) != "undefined" && result.sum_sort2.first.items.length > 0){

        $.each(result.sum_sort2.first.items , function(i, v){
                
                if(i > 3 ) return false;
                
                ebayMakeTmp += "<li class=\"lp_cpc\">";
                
                if(i == 0 )  ebayMakeTmp +=    "<div class=\"lp_cpc_tit\"><h3>파워클릭<em>AD</em></h3><a href='javascript:///' class=\"cpcgo\" id='cpcgoList' >신청하기</a></div>";
                ebayMakeTmp +=    "<ul id=\"lp_cpc\">";
                
                if(v.plno)      ebayMakeTmp +=        "<li data-id='"+v.plno+"' data-log='"+v.clk_t+"'>";
                else                ebayMakeTmp +=        "<li data-id='"+v.landing+"' data-log='"+v.clk_t+"' >";
                
                goImpT(v.imp_t);
                
                ebayMakeTmp +=            "<a href='javascript:///' class='listarea'>";
                ebayMakeTmp +=               "<span class=\"pluslink\">파워클릭AD</span>";
                
                /*
                if(v.is_adult && isAdult == 2 || isAdult == "" ){ //이베이 성인여부 true 고 로그인 한 계정이 성인 인증을 안했을 경우
                ebayMakeTmp +=               "<span class='thum'><img src='http://imgenuri.enuri.gscdn.com/images/mobilenew/images/img_19.jpg' alt=''  width='100%'></span>";
                }else{
                ebayMakeTmp +=               "<span class='thum'><img src='"+v.imgL+"'  onerror=\"if (this.src != '"+v.imgS+"') this.src = '"+v.imgS+"';\"  alt=''  width='100%'></span>";
                }
                */

                if(v.is_adult){
			        if(isAdult == 1){ // 성인인증 1
			            ebayMakeTmp +=          "                  <span class='thum'><img src='"+v.imgL+"'  onerror=\"if (this.src != '"+v.imgS+"') this.src = '"+v.imgS+"';\"></span>";
			        }else{
			            ebayMakeTmp +=               "             <span class='thum'><img src='http://imgenuri.enuri.gscdn.com/images/home/thumb_adult_300.jpg' alt=''  width='100%'></span>";
			        }
			    }else{
			        ebayMakeTmp +=          "                  <span class='thum'><img src='"+v.imgL+"'  onerror=\"if (this.src != '"+v.imgS+"') this.src = '"+v.imgS+"';\"></span>";
			    }
                
                ebayMakeTmp +=                "<div>";
                if( v.shopcode == 4027 ){
                ebayMakeTmp +=                    "<span class='best_mall'><img src=\"http://imgenuri.enuri.gscdn.com/images/board/big/logo_4027b.gif\"></span>";
                }else{
                ebayMakeTmp +=                    "<span class='best_mall'><img src='http://imgenuri.enuri.gscdn.com/images/board/big/logo_536b.gif' ></span>";
                }
                
                ebayMakeTmp +=                    "<strong>"+v.title+"</strong>";
                
                if( v.shopcode == 4027  ){
                    if( v.shipping_fee > 0  ) ebayMakeTmp +="<em class=\"deli free\">조건부무료배송</em>";
                    else                            ebayMakeTmp +="<em class=\"deli free\">무료배송</em>";
                }else{
                    if( v.shipping_fee > 0  ) ebayMakeTmp +="<em class=\"deli free\">배송비"+numberFormat(v.shipping_fee)+"</em>";
                    else                             ebayMakeTmp +="<em class=\"deli free\">무료배송</em>";             
                }
                
                if(v.enuri_price == -1){
                ebayMakeTmp +=                    "<span class=\"price\"><span class=\"min\">추가할인가</span> <em>"+numberFormat(v.sale_price)+"<em>원</em></em></span>";
                }else{
                ebayMakeTmp +=                    "<span class=\"price\"><span class=\"min\">추가할인가</span> <em>"+numberFormat(v.enuri_price)+"<em>원</em></em></span>";               
                }
                ebayMakeTmp +=                "</div>";
                ebayMakeTmp +=            "</a>";
                ebayMakeTmp +=        "</li>";
              
                ebayMakeTmp +=    "</ul>";
                ebayMakeTmp +="</li>";
        });
    }
    return ebayMakeTmp;
}

function ebayCpcMake2(result){
    var isAdult = "<%=isAdult%>"; //성인인증여부 쿠키
    if( typeof(result.sum_sort2.first) != "undefined" && result.sum_sort2.first.items.length > 0){

        $.each(result.sum_sort2.first.items , function(i, v){
                
                if(i > 3 ) return false;
                
                //ebayMakeTmp += "<li class=\"powerclick\">";
               
                //if(i == 0 )  ebayMakeTmp +=    "<div class=\"link_tit\"><h3>파워클릭<em>AD</em></h3><a href='javascript:///' class=\"cpcgo\" id='cpcgoList' >신청하기</a></div>";
                //ebayMakeTmp +=    "<ul>";
                 
                if(v.plno)      ebayMakeTmp +=        "<li data-id='"+v.plno+"' data-log='"+v.clk_t+"'>";
                else                ebayMakeTmp +=        "<li data-id='"+v.landing+"' data-log='"+v.clk_t+"' >";
                
                goImpT(v.imp_t);
                
                ebayMakeTmp +=            "<div class='listarea'>";
                ebayMakeTmp +=            "<a href='javascript:///'>";
                //ebayMakeTmp +=               "<span class=\"pluslink\">파워클릭AD</span>";
                
                /*
                if(v.is_adult && isAdult == 2 || isAdult == "" ){ //이베이 성인여부 true 고 로그인 한 계정이 성인 인증을 안했을 경우
                ebayMakeTmp +=               "<span class='thum'><img src='http://imgenuri.enuri.gscdn.com/images/mobilenew/images/img_19.jpg' alt=''  width='100%'></span>";
                }else{
                ebayMakeTmp +=               "<span class='thum'><img src='"+v.imgL+"'  onerror=\"if (this.src != '"+v.imgS+"') this.src = '"+v.imgS+"';\"  alt=''  width='100%'></span>";
                }
                */

                if(v.is_adult){
			        if(isAdult == 1){ // 성인인증 1
			            ebayMakeTmp +=          "                  <span class='thum'><img src='"+v.imgL+"'  onerror=\"if (this.src != '"+v.imgS+"') this.src = '"+v.imgS+"';\"></span>";
			        }else{
			            ebayMakeTmp +=               "             <span class='thum'><img src='http://imgenuri.enuri.gscdn.com/images/home/thumb_adult_300.jpg' alt=''  width='100%'></span>";
			        }
			    }else{
			        ebayMakeTmp +=          "                  <span class='thum'><img src='"+v.imgL+"'  onerror=\"if (this.src != '"+v.imgS+"') this.src = '"+v.imgS+"';\"></span>";
			    }
                
                if( v.shopcode == 4027 ){
                ebayMakeTmp +=                    "<span class='mall'><img src=\"http://imgenuri.enuri.gscdn.com/images/board/big/logo_4027b.gif\"></span>";
                }else{
                ebayMakeTmp +=                    "<span class='mall'><img src='http://imgenuri.enuri.gscdn.com/images/board/big/logo_536b.gif' ></span>";
                }
                
                ebayMakeTmp +=                    "<strong class=\"tit\">"+v.title+"</strong>";
                
                if(v.enuri_price == -1){
                    ebayMakeTmp +=                    "<span class=\"price\"><em>"+numberFormat(v.sale_price)+"</em>원</span>";
                    }else{
                    ebayMakeTmp +=                    "<span class=\"price\"><em>"+numberFormat(v.enuri_price)+"</em>원</span>";               
                    }
                if( v.shopcode == 4027  ){
                    if( v.shipping_fee > 0  ) ebayMakeTmp +="<em class=\"deli\">조건부무료배송</em>";
                    else                            ebayMakeTmp +="<em class=\"deli\">무료배송</em>";
                }else{
                    if( v.shipping_fee > 0  ) ebayMakeTmp +="<em class=\"deli\">배송비"+numberFormat(v.shipping_fee)+"</em>";
                    else                             ebayMakeTmp +="<em class=\"deli\">무료배송</em>";             
                }
                
                ebayMakeTmp +=            "</a>";
                ebayMakeTmp +=            "</div>";
                ebayMakeTmp +=        "</li>";
              
                //ebayMakeTmp +=    "</ul>";
                //ebayMakeTmp +="</li>";
        });
    }
    return ebayMakeTmp;
}
function getEbayCpcBottom(result){

    var isAdult = "<%=isAdult%>"; //성인인증여부 쿠키
    var makeTmp = "";
    
    makeTmp += "<div class=\"depart_hit cpc\">";
    makeTmp +=         "<h3>파워클릭</h3>";
    makeTmp +=          "<a href=\"javascript:///\" class=\"cpcgo\" id='cpcgoBottom'>신청하기</a>";
    makeTmp +=          "<div class=\"hit_scroll\">";
    makeTmp +=          "<div class=\"hit_List_area\" id='hit_List_areaDiv'>";
    makeTmp +=          "      <div class=\"hit_product\">";
    
    $.each(result.sum_sort2.second.items , function(i, v){
    
    if(v.plno) makeTmp +=   "         <div data-id='"+v.plno+"'  id='ebayCpcList"+i+"' data-url='"+v.clk_t+"'>";
    else makeTmp +=         "          <div data-id='"+v.landing+"'  id='ebayCpcList"+i+"' data-url='"+v.clk_t+"' '>";
    
    goImpT(v.imp_t);//ebay loading log
    
    makeTmp +=          "              <a href='javascript:///'>";
    makeTmp +=          "                  <em class='cpcad'>AD</em>";
    makeTmp +=          "                  <span class='lowest'>";
    
	   if( v.shopcode == 4027  ){
	        if( v.shipping_fee > 0  ) makeTmp +="<em class=\"deli free\">조건부무료배송</em>";
	        else                            makeTmp +="<em class=\"deli free\">무료배송</em>";
	    }else{
	        if( v.shipping_fee > 0  ) makeTmp +="<em class=\"deli free\">배송비"+numberFormat(v.shipping_fee)+"</em>";
	        else                             makeTmp +="<em class=\"deli free\">무료배송</em>";             
	    }
    
	    if( v.shopcode == 4027 )    makeTmp +=                    "<em class='shop'><img src='http://imgenuri.enuri.gscdn.com/images/board/big/logo_4027b.gif''></em>";
	    else                                 makeTmp +=                    "<em class='shop'><img src='http://imgenuri.enuri.gscdn.com/images/board/big/logo_536b.gif' ></em>";
    
        makeTmp +=          "                      <span class='tit'>"+v.title+"</span>";
    
	    if(v.enuri_price == -1)    makeTmp +=          "                      <strong>"+numberFormat(v.sale_price)+"</strong>원";
	    else                            makeTmp +=          "                      <strong>"+numberFormat(v.enuri_price)+"</strong>원";    
    
        makeTmp +=          "                  </span>";
    
	    if(v.is_adult){
	        if(isAdult == 1){ // 성인인증 1
	            makeTmp +=          "                  <img src='"+v.imgL+"'  onerror=\"if (this.src != '"+v.imgS+"') this.src = '"+v.imgS+"';\">";
	        }else{
	            makeTmp +=               "             <img src='http://imgenuri.enuri.gscdn.com/images/home/thumb_adult_300.jpg' alt=''  width='100%'></span>";
	        }
	    }else{
	        makeTmp +=          "                  <img src='"+v.imgL+"'  onerror=\"if (this.src != '"+v.imgS+"') this.src = '"+v.imgS+"';\">";
	    }

		    makeTmp +=          "              </a>";
		    makeTmp +=          "          </div>";
    });
    makeTmp +=          "      </div>";
    makeTmp +=          "  </div>";
    makeTmp +=        "</div>";

    makeTmp +=    "</div>";
    return makeTmp; 
}

function getSocialList(cate, cnt,  cptTotCnt ,bottomHtml) {

    var scate1 = ""; 
    var params = {};
    params.mbId = "";
    params.mobile = "M";
    params.pagingRnum = 0;
    params.pagingSize = 20;
    params.keyword = "<%=socialKeyword%>";
    params.cate1 = "";
    
    /*
    $.ajax({
        type: "POST",
        dataType: 'json',
        
        url: '/deal/mobile/search.deal',
        data: JSON.stringify(params),
        */
    
    var goUrl = "";
    var sendData = "";
    
    if(urlKind.indexOf("/mobilefirst/list.jsp") > -1 || urlKind.indexOf("/mobilefirst/list2.jsp") > -1) listKIND = "LP";
    else listKIND = "SRP";
    
    if(listKIND == "LP"){
        goUrl = "/mobilefirst/ajax/listAjax/getListDealMini_ajax.jsp";
        sendData = "cate="+cate;
    }else{
        goUrl = "/deal/mobile/search.deal";
        sendData = JSON.stringify(params);
    }
    
    $.ajax({
        type:"POST",
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        url: goUrl,
        data: sendData,
        success: function(result) {
            var list;
            
            if(listKIND == "LP"){
                list = result.goods;
            } else {
                list = result.list.DS_COUPON;
            }
            
            var outHtml = "";
            
            //검색결과 상품리스트가 존재하는 경우.

            if(list.length > 0) {
               
            	for (i=0;i<list.length;i++){
	                    var rowdata = list[i];
	                    
	                    var img = "";
	                    var companyNm = ""; 
	                    var cpName ="";               
	                    var cpSalerate = "";
	                    var cpPrice = "";
	                    var cpSalecnt = "";
	                    var alink = "";
                    	
                    if( listKIND == "LP" ){
                    
                        img = rowdata.img2;
	                    companyNm = rowdata.company; 
	                    cpName =rowdata.name;               
	                    cpSalerate = rowdata.rate;
	                    cpPrice = rowdata.price;
	                    cpSalecnt = rowdata.cpSalecnt;
	                   //alink = "http://" + location.hostname + "/deal/mobile/goods.deal?id="+rowdata.cp_id+"&referrer=core";
	                    alink = "http://" + location.hostname + "/deal/move.html?freetoken=outlink&cpId="+rowdata.cp_id+"&cpUrl="+encodeURIComponent(url);
                    }else{
                        img = rowdata.cpImage;
	                    companyNm = rowdata.companyNm; 
	                    cpName =rowdata.cpName;             
	                    cpSalerate = rowdata.cpSalerate ? rowdata.cpSalerate : '특가';
	                    cpPrice = rowdata.cpSaleprice;
	                    cpSalecnt = rowdata.cpSalecnt;
	                    alink = rowdata.cpUrl;
	                    //alink = "http://" + location.hostname + "/deal/mobile/goods.deal?id="+rowdata.cpId+"&referrer=core";
                    }
                    
                    
                    if(rowdata.adFlag=='Y'){
                        if(rowdata.mobile_social_category2_id.length > 0){
                            alink = rowdata.url;
                        }
                    } 
                    var adMark = "";
                    
                    if(!cpSalerate || cpSalerate=="0") cpSalerate = "특가";
 
                    outHtml += "<div data-id=\""+alink+"\" target=\"_new\">";
                    outHtml += "    <a href='javascript:///'>";
                    if(cpSalerate!="특가") {
                        cpSalerate = cpSalerate + "<em>%</em>";
                        outHtml += "        <span class=\"sale\">"+cpSalerate+"</span>";
                    } else {
                        outHtml += "        <span class=\"special\">"+cpSalerate+"</span>";
                    }
                    
                    // 첫번쨰나 두번쨰가 광고이면 ad 마크를 붙여준다.
                    if(rowdata.adFlag=='Y'){
                        if(rowdata.mobile_social_category2_id.length > 0){
                            adMark = "<em class=\"AdminAd\" emCpId=\""+rowdata.cp_id+"\" emCategory2Id=\""+rowdata.mobile_social_category2_id+"\">AD</em>";
                        }else{
                            adMark = "<em class=\"sonyAd\" emCpId=\""+rowdata.cp_id+"\">AD</em>";       
                        }
                    }
                    outHtml += "        <span class=\"lowest\"><em class=\"shop\">" + adMark + companyNm+"</em>";
                    outHtml +="<span class='tit'>"+cpName+"</span>";
                    outHtml +="<strong>"+numberFormat(cpPrice)+"</strong>원</span>";
                    outHtml += "        <img src=\""+img+"\" />";
                    outHtml += "    </a>";
                    outHtml += "</div>";
                    if(i>=cnt-1) break; 
                }
            }
                //console.log("더해져야할 소셜갯수:"+cnt); //더해져야 할 소셜 갯수
                //console.log("소셜상품갯수:"+list.length); //소셜 상품 갯수
                //console.log("cpc 갯수:"+cptTotCnt); //소셜 상품 갯수
 
                if(  list.length+cptTotCnt >=3  ){
	                    if(typeof(bottomHtml) == "undefined"){
	                        var makeTmp = "";
	                        $(".depart_hit").hide();
	                        makeTmp += "<div class=\"depart_hit cpc\">";
						    makeTmp +=         "<h3>파워클릭</h3>";
						    makeTmp +=          "<a href=\"javascript:///\" class=\"cpcgo\" id='cpcgoBottom'>신청하기</a>";
						    makeTmp +=          "<div class=\"hit_scroll\">";
						    makeTmp +=          "<div class=\"hit_List_area\" id='hit_List_areaDiv'>";
						    makeTmp +=          "      <div class=\"hit_product\">";
						    makeTmp +=          "      </div>";
						    makeTmp +=          "  </div>";
						    makeTmp +=        "</div>";
						    makeTmp +=    "</div>";
						    
						    $("#socialMiniDiv").after(makeTmp);
						    $(".hit_product").append(outHtml);

	                    }else{
	                    	$("#socialMiniDiv").after(bottomHtml);
	                        $(".hit_product").append(outHtml);
	                    }
                }else{
                           /*
                           var makeTmp = "";
                            
                            makeTmp += "<div class=\"depart_hit cpc\">";
                            makeTmp +=         "<h3>파워클릭</h3>";
                            makeTmp +=          "<a href=\"javascript:///\" class=\"cpcgo\" id='cpcgoBottom'>신청하기</a>";
                            makeTmp +=          "<div class=\"hit_scroll\">";
                            makeTmp +=          "<div class=\"hit_List_area\" id='hit_List_areaDiv'>";
                            makeTmp +=          "      <div class=\"hit_product\">";
                            makeTmp +=          "      </div>";
                            makeTmp +=          "  </div>";
                            makeTmp +=        "</div>";
                            makeTmp +=    "</div>";
                            
                            $("#socialMiniDiv").after(makeTmp);
                            $(".hit_product").append(outHtml);
                            */
                }
            }
        });
}
//어드민상품 로그 넣기
function insertMobileSocialLog(mobile_social_category_id, is_mobile){
    $.ajax({
            url: "/view/IncDealListSocialAjax.jsp?mobile_social_category_id=" + mobile_social_category_id + "&is_mobile=" + is_mobile ,
            type: "GET",
            async   : false, 
            success: function(data) {             }
    });
}
//노출 log
function goImpT(adurl){

    if(location.href.indexOf("m.enuri.com") > -1 || location.href.indexOf("www.enuri.com") > -1){
        var imgSrc = new Image();
        imgSrc.src = adurl;
    } else {        //console.log("test-powerClickAnalysis()");      
    }
}
//클릭 log
function goClk_t(url){

    if(location.href.indexOf("m.enuri.com") > -1 || location.href.indexOf("www.enuri.com") > -1){
        var imgSrc = new Image();
        imgSrc.src = url; 
    } else {
        //console.log("test-powerClickAnalysis()");                           
    }
    
} 
function numberFormat(num) {
    num += ''; //문자열로 치환
    var pattern = /(-?[0-9]+)([0-9]{3})/;
    while(pattern.test(num)) {
        num = num.replace(pattern,"$1,$2");
    }
    return num;
}
</script>
<script type="text/javascript" src="/mobilefirst/js/powerClickMo.js"></script>