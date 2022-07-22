<%
	String strCh = "";
	if(request.getRequestURI().equals("/mobilenew/search.jsp") || request.getRequestURI().equals("/mobilefirst/search.jsp")  || request.getRequestURI().equals("/mobilefirst/search2.jsp") || request.getRequestURI().equals("/mobiledepart/search.jsp")) {
		strCh="m_enuri.ch1";
	} else if(request.getRequestURI().equals("/mobilenew/detail.jsp") || request.getRequestURI().equals("/mobilefirst/detail.jsp") || request.getRequestURI().equals("/mobiledepart/detail.jsp") || request.getRequestURI().equals("/mobilefirst/vip.jsp")) {
		strCh="m_enuri.ch3";
	//}else if(strCarm.equals("y")){ 
	//	strCh="m_enuri.ch3";
	} else {
		strCh="m_enuri.ch2";
	}
%>
<!-- 파워링크 -->
<section class="powerLink" style="display:none;">
<h1><a onclick="goPowerPro();" href="JavaScript:///" style="color:#4c5363;font-size:12px;-webkit-tap-highlight-color:transparent;">파워링크 AD</a>&nbsp;&nbsp;&nbsp;<a onclick="goPowerPro();" href="JavaScript:///" style="-webkit-tap-highlight-color:transparent;font-family:'맑은 고딕','돋움';font-weight:normal;color:#0000FF;font-size:12px;">신청</a></h1>
	<ul></ul>
</section>
<div id="powerlinkBottom" class="power">
	<div class="link_tit">
		<h3 onclick="goPowerPro();">파워링크<em>AD</em></h3>
		<a onclick="goPowerPro();" href="JavaScript:///">신청하기</a>
	</div>
	<ul class="link_list">
	</ul>
</div>
<script language="JavaScript"> 
var adRequestLink = "";
function goPowerPro() {
	window.open(adRequestLink);
}
//파워 링크 가져오기
function setPowerLinkLink() {
	//alert(szCategoryPower);
	//alert(ad_commandPower);
	//alert(catePower);
	//alert(referrerPower);
	//alert(urlPower); 
	 
	if(location.href.indexOf("/mobilefirst/search.jsp") > -1){
		if(szCategoryPower == "00000000"){
			szCategoryPower = $(".prodList .listarea:first").attr("catecode");
			catePower = $(".prodList .listarea:first").attr("catecode");
		}
		if(ad_commandPower == "" || ad_commandPower == "undefined"){
			ad_commandPower = $("#all_keyword").val();
		}
	} 
	
	
	var url_i = "/mobilefirst/ajax/getSponsorLink_json.jsp?";
	var param_i = "szCategory="+szCategoryPower+"&ad_command="+ad_commandPower+"&ad_command2="+ad_commandPower2+"&cate="+catePower+"&referrer="+referrerPower+"&url="+urlPower+"&strCh=<%=strCh%>";
	var loadUrl = url_i + param_i;
    
	$.getJSON(loadUrl, null, function(result) {

		var jsonObj = result["adLinkList"];
		var powerLinkObj = $(".power ul");
		var htmlText = "";

		adRequestLink = result["adRequestLink"];
        
		if(jsonObj!=null) {
			$.each(jsonObj, function(indexI, listObj) {
				url = listObj["url"];
				line1 = listObj["line1"];
				line2 = listObj["line2"];
				visible_url = listObj["visible_url"];
                
				var deviceBrowserLinkParam = "DEVICE_BROWSER=Y";
				if(url.indexOf(deviceBrowserLinkParam)<0) {
					if(url.indexOf("?")>-1) 	url = url + "&" + deviceBrowserLinkParam;
					else 						    url = url + "?" + deviceBrowserLinkParam;
				} 
				htmlText += "<li class=\"power_bottom\" onclick=\"ga_powerlink('b');\">";
				htmlText += "	<a href=\""+url+"\">";
				htmlText += "		<strong><em>"+(indexI+1)+"</em>"+line1+"</strong>";
				htmlText += "		"+line2;
				htmlText += "		<span>"+visible_url+"</span>";
				htmlText += "	</a>";
				htmlText += "</li>";
				if(indexI == 4) return false; //하단 노출 개수 5개만 노출
			});
		}
		powerLinkObj.html(htmlText);
		if(htmlText.length<20) 			$(".power").css("display", "none"); $("#paging2").hide();
		
	});
}
var htmlText_Top = "";
var htmlText_Bottom = "";
function setPowerLinkLinkLp() {
	//alert(szCategoryPower);
	//alert(ad_commandPower);
	//alert(catePower);
	//alert(referrerPower);
	//alert(urlPower); 

	if(location.href.indexOf("/mobilefirst/search.jsp") > -1){
		if(szCategoryPower == "00000000"){
			szCategoryPower = $(".prodList .listarea:first").attr("catecode");
			catePower = $(".prodList .listarea:first").attr("catecode");
		}
		if(ad_commandPower == "" || ad_commandPower == "undefined"){
			ad_commandPower = $("#all_keyword").val();
		}
	} 
	
	var url_i = "/mobilefirst/ajax/getSponsorLink_json.jsp?";
	var param_i = "szCategory="+szCategoryPower+"&ad_command="+ad_commandPower+"&ad_command2="+ad_commandPower2+"&cate="+catePower+"&referrer="+referrerPower+"&url="+urlPower+"&strCh=<%=strCh%>";
	//console.log("222="+param_i);
	var loadUrl = url_i + param_i;

	$.getJSON(loadUrl, null, function(result) {
		var jsonObj = result["adLinkList"];
		var powerLinkObj = $(".power ul");
		 
		adRequestLink = result["adRequestLink"];

		if(jsonObj!=null) {
			htmlText_Top +="<li class=\"powerlink\">";
			htmlText_Top +="<div class=\"power\">";
			//	if(jsonObj.length > 1){
				htmlText_Top +="<div class=\"link_tit\">";
				htmlText_Top +="	<h3 onclick=\"goPowerPro();\">파워링크<em>AD</em></h3>";
				htmlText_Top +="	<a onclick=\"goPowerPro();\" href=\"JavaScript:///\">신청하기</a>";
				htmlText_Top +="</div>";
			//} 
			htmlText_Top +="<ul class=\"link_list\">";
			
			$.each(jsonObj, function(indexI, listObj) {
				url = listObj["url"];
				line1 = listObj["line1"];
				line2 = listObj["line2"];
				visible_url = listObj["visible_url"];
 
				var deviceBrowserLinkParam = "DEVICE_BROWSER=Y";
				if(url.indexOf(deviceBrowserLinkParam)<0) {
					if(url.indexOf("?")>-1) {
						url = url + "&" + deviceBrowserLinkParam;
					} else {
						url = url + "?" + deviceBrowserLinkParam;
					}
				} 
				if(indexI < 2){	
					htmlText_Top += "<li class=\"power_top\" onclick=\"ga_powerlink('t');\">";
					htmlText_Top += "	<a href=\""+url+"\">";
					htmlText_Top += "		<strong><em>"+(indexI+1)+"</em>"+line1+"</strong>";
					htmlText_Top += "		"+line2;
					htmlText_Top += "		<span>"+visible_url+"</span>";
					htmlText_Top += "	</a>";
					htmlText_Top += "</li>";
				}else{
					htmlText_Bottom += "<li class=\"power_bottom\" onclick=\"ga_powerlink('b');\">";
					htmlText_Bottom += "	<a href=\""+url+"\">";
					htmlText_Bottom += "		<strong><em>"+(indexI-1)+"</em>"+line1+"</strong>";
					htmlText_Bottom += "		"+line2;
					htmlText_Bottom += "		<span>"+visible_url+"</span>";
					htmlText_Bottom += "	</a>";
					htmlText_Bottom += "</li>";				
				}
			}); 
			htmlText_Top +="</ul>";
			htmlText_Top +="</div>"; 
			htmlText_Top +="</li>";
		} 
		//powerLinkObj.html(htmlText);  
		if(jsonObj!=null) {
			if(jsonObj.length == 1) {
				//powerLinkObj.html(htmlText_Top);
				$('.prodList #adline').after(htmlText_Top);
			}else if(jsonObj.length == 2) {
				$('.prodList #adline').after(htmlText_Top);
			}else{
				$('.prodList #adline').after(htmlText_Top);
				powerLinkObj.html(htmlText_Bottom);	
				if(htmlText_Bottom.length < 20){
					$("#paging2").hide();
				}else{
					$("#paging2").show();
				}
			}
			
		}else{  
			$(".power").hide();
			$("#paging2").hide();
		}
		if(htmlText_Bottom.length==0 && htmlText_Bottom==""){
			$("#powerlinkBottom").hide();
		}
	}); 
}
function setPowerLinkLinkLpRe() {
	$('.prodList #adline').after(htmlText_Top);
}
function ga_powerlink(param){ 
	var vhref = location.href; 
	
	if(vhref.indexOf("/mobilefirst/list.jsp") > -1){
		if(param == "t"){		//상단 2개
			//alert('LP_중단광고');
			insertLogLSV(21234);
			ga('send', 'event', 'mf_lp', 'lp_파워링크', 'LP_중단광고');			
		}else if(param == "b"){	//하단 2개
			//alert('LP_하단광고');
			insertLogLSV(21235);
			ga('send', 'event', 'mf_lp', 'lp_파워링크', 'LP_하단광고');			
		}
		ga('send', 'event', 'mf_lp', 'lp_common', 'click_파워링크');	
	}else if(vhref.indexOf("/mobilefirst/search.jsp") > -1 || vhref.indexOf("/mobilefirst/search2.jsp") > -1){	
		if(param == "t"){		//상단 2개
			//alert('SRP_중단광고');
			insertLog(21238);
			ga('send', 'event', 'mf_srp', 'srp_파워링크', 'SRP_중단광고');			
		}else if(param == "b"){	//하단 2개
			//alert('SRP_하단광고');
			insertLog(21239);
			ga('send', 'event', 'mf_srp', 'srp_파워링크', 'SRP_하단광고');			
		}
		ga('send', 'event', 'mf_srp', 'srp_common', 'click_파워링크')
	}else if(vhref.indexOf("/mobilefirst/detail.jsp") > -1 ){	
		insertLog_cate(21382,vCate4);
	}
	
}
</script>
