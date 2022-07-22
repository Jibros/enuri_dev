	<%
	HttpSession Msession = request.getSession(true);
	String sessioinValue = "";

	if(Msession.getAttribute("M_LIST")!=null){
		sessioinValue = (String)Msession.getAttribute("M_LIST");
	}  

	String strHistoryPage = sessioinValue;
	boolean bShareSms = false;  // SMS 제외 기기
	if(ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("Android") >= 0){
		if(ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("IM-A830S") >= 0 || ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("IM-A830K") >= 0 ||
		   ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("IM-A830L") >= 0 || ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("IM-A780L") >= 0 || 
		   ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("IM-A770K") >= 0 || ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("IM-A760S") >= 0 || 
		   ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("IM-A820L") >= 0 || ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("IM-A800S") >= 0 || 
		   ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("IM-A810S") >= 0 || ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("IM-A810K") >= 0 || 
		   ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("IM-A850S") >= 0 || ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("IM-A850K") >= 0 || 
		   ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("IM-A850L") >= 0 || ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("IM-T100K") >= 0 || 
		   ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("IM-A860S") >= 0 || ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("IM-A860K") >= 0 || 
		   ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("IM-A860L") >= 0 || ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("IM-A840S") >= 0 || 
		   ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("IM-A730S") >= 0 || ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("IM-A710K") >= 0 || 
		   ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("IM-A720L") >= 0 || ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("IM-A725L") >= 0 || 
		   ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("IM-A650S") >= 0 
		){
			bShareSms = false;
		}else{ 
			//bShareSms = true;
			bShareSms = false;
		}
	}
	boolean bGNote = false;
	if (ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("2.3.6") >= 0 ){
		if (request.getRequestURI().indexOf("m4_Index.jsp") < 0 && request.getRequestURI().indexOf("detail_new.jsp") < 0 && request.getRequestURI().indexOf("detail_sim.jsp") < 0 ){
			bGNote = true;
		} 
	}  
	
	String FloatTop = "bottom:12px;padding-bottom:0px;";
	String FloatTop2 = "";
	if(strApp.equals("Y") && (ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPhone") >= 0 || ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPod") >= 0 || ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPad") >= 0)){
		FloatTop2 = "bottom:10px;"; 	
	}else{ 
		FloatTop2 = "bottom:0px;";
	}
	
	boolean bVega = false;
	if(ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("IM-A860S") >= 0 || ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("IM-A860L") >= 0 ||
		ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("IM-A860K") >= 0 || ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("IM-A850S") >= 0 ||
		ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("IM-A850L") >= 0 || ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("IM-A850K") >= 0 ||
		ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("IM-A840SP") >= 0 
	){
		FloatTop = "bottom:12px;padding-bottom:10px;";
		FloatTop2 = "bottom:12px;padding-bottom:10px;";
		bVega = true;
	}else{
		FloatTop = "bottom:0px;";
		bVega = false;
	} 

	%> 
	<%//=ChkNull.chkStr(request.getHeader("User-Agent"))%> 
	<%if(!strPageType.equals("login")){%>
	<div id="mobile_loading">  
		<img src="<%=ConfigManager.IMG_ENURI_COM%>/images/mobile/m_loading_110324.gif">
	</div> 
	<%}%>
	<%if(!strPageType.equals("index")){%>
	<div id="zzimBlank" style="height:0px;"></div> 
	<div id="bottomHome" style="clear:both;background-color:#ffffff;font-size:10pt;border:1px solid #000000;font-weight:bold;width:50px;height:25px;line-height:25px;text-align:center;margin:<%if(strPageType.equals("login")){%>0px<%}else if(strPageType.equals("todaylist")){%>60px<%}else if(strPageType.equals("detail")){%>55px<%}else{%>20px<%}%> auto 10px auto;">홈으로</div>
	<%}%>
	<%if(!strPageType.equals("index") && !strPageType.equals("detail2")){%>
	<div id="listfooterBtn"  style="clear:both;margin:0px;padding:10px 5px 3px 2px;<%if(strPageType.equals("search!")){%>display:none;<%}%>list-style-type:none;background-color:#606770;color:#ffffff;">
		<ul style="margin:0px;padding:0px;width:100%;list-style-type:none;height:20px;">
			<%
			int iBottomWidth3 = 21;
			int iBottomWidth4 = 35;
			if(!strApp.equals("Y") && !strPageType.equals("login")){
				iBottomWidth3 = 16;
				iBottomWidth4 = 34;			
			}
			%>
			<li style="width:100%;height:20px;font-size:12px;"> 
				<div style="width:<%=iBottomWidth3%>%;text-align:center;float:left;" id="islogin">&nbsp;<%if(cb.GetCookie("MEM_INFO","USER_ID").length() > 0){%>로그아웃<%}else{%>로그인<%}%>&nbsp;</div>
				<div class="line" style="float:left;width:1px;background-color:#888e95;height:18px;"></div>
				<div style="width:<%=iBottomWidth4%>%;text-align:center;float:left;" id="todaylistGo" <%if(strEnuriApp.equals("Y") && request.getRequestURI().indexOf("m4_ecoupon.jsp") < 0 ){%>onclick="preOpen('list','/mobile2/resentzzim/resentzzimList.jsp?listType=1');"<%}else{%>onclick="CmdLocation('todaylist');"<%}%>>
				최근 본 상품
				</div>
				<div class="line" style="float:left;width:1px;background-color:#888e95;height:18px;"></div>
				<div id="ZzimBtnBlank" style="position:absolute;width:<%=iBottomWidth3%>%;text-align:center;margin:auto;height:25px;display:none;"></div>
				<div style="width:<%=iBottomWidth3%>%;text-align:center;float:left;" id="zzimlistGo" onclick="CmdChkZzim();">
				찜
				</div>		
				<div class="line" style="float:left;width:1px;background-color:#888e95;height:18px;"></div>		
				<div style="width:<%=iBottomWidth3%>%;text-align:center;float:left;" id="pcGo">
				PC버전 
				</div>  
				<%if(!strApp.equals("Y") && !strPageType.equals("login")){%>
				<div class="line" style="float:left;width:1px;background-color:#888e95;height:18px;"></div>		
				<div style="width:<%=iBottomWidth3%>%;text-align:center;float:left;" class="app_down">
				&nbsp;앱다운 
				</div> 
				<%}%> 
			</li> 
		</ul>
	</div>	
	<div style="background-color:#f2f2f2;margin:0px;padding:0px 0px <%if(strPageType.equals("login")){%>0px<%}else{%>50px<%}%> 0px;<%if(strPageType.equals("search!")){%>display:none;<%}%>" id="listfooter"> 
		<ul style="margin:0px;padding:2px 0px;width:100%;list-style-type:none;">
			<div style="text-align:center;font-size:7pt;color:#000000;font-family:맑은 고딕;padding:5px; 0px;">
			에누리닷컴(주)는 통신판매 정보제공자이며, 상품의 주문/배송/환불에 대한<br> 의무와 책임은 각 쇼핑몰에 있습니다. 
			</div>
			<li style='height:42px;line-height:14px;text-align:center;letter-spacing:-1px;background-color:#f2f2f2;font-size:8pt;color:#888888;margin:0px;padding:0px;width:100%;list-style-type:none;'>
			에누리닷컴(주) | 서울시 종로구 청계천로 85 (관철동) 29층<br> 
			| 대표이사: 최문석 | Tel: 02-6354-3601 | <br>
			사업자등록번호: 206-81-18164 | 통신판매신고 종로통신 제 4406호			
			</li>
		</ul> 
	</div>  
	<%}%>  
	<%if(strApp.equals("Y") && (ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPhone") >= 0 || ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPod") >= 0 || ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPad") >= 0)){%> 
	<div id="m4_appShare" style="position:fixed;bottom:17px;right:19%;display:none;z-index:998;">
		<ul style="width:128px;height:44px;"> 
			<li><img src="<%=ConfigManager.IMG_ENURI_COM%>/images/mobile4/share_layer_top2.png" width="128" height="44" usemap="#app_share"></li>
			<map name="app_share" id="app_share">
			<area shape="rect" coords="80,1,127,43" href="#"/> 
			</map>
		</ul> 
		<ul style="width:128px;height:120px;background:url(<%=ConfigManager.IMG_ENURI_COM%>/images/mobile4/share_layer_bg2.png) repeat-y;background-size:100% 100%;"> 
			<li style="padding-left:17px;"><img src="<%=ConfigManager.IMG_ENURI_COM%>/images/mobile4/share640_kakao.png" width="79" height="28" onclick="CmdShare2('kakao');return false;"></li>
			<li style="padding-left:17px;padding-top:5px;"><img src="<%=ConfigManager.IMG_ENURI_COM%>/images/mobile4/share640_twit.png" width="79" height="28" onclick="CmdShare2('twitter');return false;"></li>
			<li style="padding-left:17px;padding-top:5px;"><img src="<%=ConfigManager.IMG_ENURI_COM%>/images/mobile4/share640_facebook.png" width="79" height="28" onclick="CmdShare2('facebook');return false;"></li>
			<!-- <li style="padding-left:17px;padding-top:5px;"><img src="<%=ConfigManager.IMG_ENURI_COM%>/images/mobile4/share640_me2.png" width="79" height="28" onclick="CmdShare2('metoday');return false;"></li> -->
		</ul>   
		<ul style="width:128px;height:20px;">
			<li><img src="<%=ConfigManager.IMG_ENURI_COM%>/images/mobile4/share_layer_bottom2.png" width="128" height="20"></li>
		</ul> 
	</div>
	<div id="m4_appMore" style="position:fixed;bottom:17px;right:4%;display:none;z-index:998;">
		<ul style="width:128px;height:44px;">  
			<li><img src="<%=ConfigManager.IMG_ENURI_COM%>/images/mobile4/share_layer_top2.png" width="128" height="44" usemap="#app_more"></li>
			<map name="app_more" id="app_more">
			<area shape="rect" coords="80,1,127,43" href="#"/> 
			</map>  
		</ul>   
		<ul style="width:128px;height:120px;background:url(<%=ConfigManager.IMG_ENURI_COM%>/images/mobile4/share_layer_bg2.png) repeat-y;background-size:100% 100%;"> 
			<li style="height:43px;padding-left:5px;"><div class="moreImg more_capture" onclick="screenCapture();">&nbsp;</div></li>
			<li style="height:43px;padding-left:5px;"><div class="moreImg more_url" onclick="urlCopy();">&nbsp;</div></li>
			<li style="height:43px;padding-left:5px;"><a href="ioscall://bookBarcode" onclick="insertLog('9225');"><div class="moreImg more_barcode">&nbsp;</div></a></li>
		</ul>     
		<ul style="width:128px;height:20px;">
			<li><img src="<%=ConfigManager.IMG_ENURI_COM%>/images/mobile4/share_layer_bottom2.png" width="128" height="20"></li>
		</ul> 
	</div>  
 	<%}%> 
	<!-- 
	<div id="m4_share2" style="position:fixed;display:none;bottom:183px;left:25%;padding:10px 10px 10px 193px;z-index:999"  onclick="CmdShare_x();">
		<img src="<%=ConfigManager.IMG_ENURI_COM%>/images/mobile4/btn_close640.png" width="39px" height="39px">
	</div> -->
	<div id="m4_share"  style="clear:both;position:fixed;bottom:50px;left:25%;display:none;z-index:998;width:220px;height:168px;background:url(http://img.enuri.info/images/mobile4/layer640_2.png) no-repeat;background-size:100% 100%;">
		<ul style="margin-top:25px;text-align:center;"> 
			<span style="margin:5px;<%if(strPageType.equals("todaylist") && strApp.equals("")){%>padding-right:15px;<%}%>"><img src="<%=ConfigManager.IMG_ENURI_COM%>/images/mobile4/home640_1.png" width="24" height="48" onclick="CmdLocation('index');"/></span>
			<%if(!listType.equals("1") ){%>
			<span style="margin:5px;<%if(!strApp.equals("") && strPageType.equals("todaylist") ){%>padding-left:15px;<%}%>"><img src="<%=ConfigManager.IMG_ENURI_COM%>/images/mobile4/recent2_1.png" width="75" height="48" onclick="insertLog('9968');CmdLocation('todaylist');"/></span>
			<%}%>
			<%if(!listType.equals("2") && !listType.equals("3")){%>
			<span style="margin:5px;<%if(!strApp.equals("") && strPageType.equals("todaylist") ){%>padding-left:15px;<%}%>"><img src="<%=ConfigManager.IMG_ENURI_COM%>/images/mobile4/zzim640_1.png" width="45" height="48" onclick="insertLog('9967');CmdLocation('zzimlist');"/></span>
			<%}%>
		</ul>	 
		<ul style="clear:both;margin-top:25px;text-align:center;"> 
			<%if(!strApp.equals("Y")){%> 
			<span style="margin:5px 6px;"><img src="<%=ConfigManager.IMG_ENURI_COM%>/images/mobile4/appdown_02.png" width="31" height="32" class="app_down"/></span>
			<%}%>  
			<span style="margin:5px 6px;"><img src="<%=ConfigManager.IMG_ENURI_COM%>/images/mobile4/btn_cacao640.png" width="29" height="28" onclick="CmdShare2('kakao');return false;"></span>
			<span style="margin:5px 6px;"><img src="<%=ConfigManager.IMG_ENURI_COM%>/images/mobile4/btn_twit640.png" width="29" height="28"  onclick="CmdShare2('twitter');return false;"></span>
			<span style="margin:5px 6px;"><img src="<%=ConfigManager.IMG_ENURI_COM%>/images/mobile4/btn_faceb640.png" width="29" height="28" onclick="CmdShare2('facebook');return false;"></span>
		</ul>
	</div>
	<div id="ebay_layer" style="position:absolute;width:100%;z-index:997;display:none;"><!--  --></div>
	<div id="layer_kakao" style="display:none;">
		<div id="kakao_head">
			<div id="kakao_head_txt">현재화면을 전송합니다.</div>
			<div id="kakao_head_x" onclick="$('#car_footer').show();$('#flick_layer').show();$('#layer_kakao').hide();">X</div>
		</div>
		<div id="kakao_body">
			<div id="kakao_body_left">
				<div id="kakao_box">
					<!-- div id="kakao_info"></div-->
					<textarea id="kakao_textarea"></textarea>
				</div>
			</div> 
			<div id="kakako_body_right">
				<div id="kakao_btt" onclick="executeURLLink()">카톡<br>전송</div>
			</div> 
		</div>
	</div>
	<div id="lotteimall_Layer" style="width:100%;position:absolute;top:50px;left:0px;text-align:center;z-index:999;display:none;">
		<img src="<%=ConfigManager.IMG_ENURI_COM%>/images/mobile4/layer_lotteimall.png" width="295px" height="200px" usemap="#lotteimall_layer" style="margin:auto;z-index:999;text-align:center;">&nbsp;
		<map name="lotteimall_layer" id="lotteimall_layer">
			<area shape="rect" coords="247,2,292,46" href="#" onclick="$('#lotteimall_Layer').hide();return false;"/>
		</map>
 	</div>
 	<div id="hns_Layer" style="width:100%;position:absolute;top:50px;left:0px;text-align:center;z-index:999;display:none;">
		<img src="<%=ConfigManager.IMG_ENURI_COM%>/images/mobile4/layer_hns.png" width="295px" height="200px" usemap="#hns_layer" style="margin:auto;z-index:999;text-align:center;">&nbsp;
		<map name="hns_layer" id="hns_layer">
			<area shape="rect" coords="247,2,292,46" href="#" onclick="$('#hns_Layer').hide();return false;"/>
		</map>
 	</div>
 	<div id="11st_Layer" style="width:100%;position:absolute;top:50px;left:0px;text-align:center;z-index:999;display:none;">
		<img src="<%=ConfigManager.IMG_ENURI_COM%>/images/mobile4/layer_11st_2.png" width="295px" height="200px" usemap="#11layer" style="margin:auto;z-index:999;text-align:center;">&nbsp;
		<map name="11layer" id="11layer">
			<area shape="rect" coords="247,2,292,46" href="#" onclick="$('#11st_Layer').hide();return false;"/>
		</map>
 	</div>
 	<div id="wemap_Layer" style="width:100%;position:absolute;top:50px;left:0px;text-align:center;z-index:999;display:none;">
		<img src="<%=ConfigManager.IMG_ENURI_COM%>/images/mobile4/layer_wemake_2.png" width="295px" height="200px" usemap="#wemakelayer" style="margin:auto;z-index:999;text-align:center;">&nbsp;
		<map name="wemakelayer" id="wemakelayer">
			<area shape="rect" coords="247,2,292,46" href="#" onclick="$('#wemap_Layer').hide();return false;"/>
		</map>
 	</div>
  	<div id="ak_Layer" style="width:100%;position:absolute;top:50px;left:0px;text-align:center;z-index:999;display:none;">
		<img src="<%=ConfigManager.IMG_ENURI_COM%>/images/mobile4/layer_akmall.png" width="290px" height="132px" usemap="#aklayer" style="margin:auto;z-index:999;text-align:center;">&nbsp;
		<map name="aklayer" id="aklayer">
			<area shape="rect" coords="247,4,284,38" href="#" onclick="$('#ak_Layer').hide();return false;"/>
		</map>
 	</div>
<%   
String strFromNaverShow = "";
String strFromNaverApp = "";
String strFromNaverLog= "";
String strFromNaverDisplay= "";

if(strFromNaver.equals("Y")){
	if(strPageType.equals("detail") || strPageType.equals("todaylist") || strPageType.equals("index")){
		strFromNaverDisplay = "display:inline;";
	}else{
		strFromNaverDisplay = "display:none;";
	}
	if(ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPhone") >= 0 || ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPod") >= 0  || ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPad") >= 0){
		strFromNaverShow = "m_layer02_v2[1].png"; 
		strFromNaverApp = "onclick=\"insertLog('8655');location.href='http://itunes.apple.com/kr/app/enuriapp/id476264124?l=ko&ls=1&mt=8'\"";
		strFromNaverLog = "insertLog('8656');"; 
	}else if (ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("Android") >= 0 ){
		strFromNaverShow = "m_layer02_v1[1].png";
		strFromNaverApp = " onclick=\"insertLog('8654');\" href='market://details?id=com.enuri.android' ";
		strFromNaverLog = "insertLog('8657');";
	}else{
		strFromNaverShow = "m_layer01_v1.png"; 
		strFromNaverApp = " onclick=\"insertLog('8654');\" href='market://details?id=com.enuri.android' ";
		strFromNaverLog = "insertLog('8657');";
	}
%> 
<!-- 
	<div style="width:100%;position:absolute;top:50px;left:0px;text-align:center;z-index:999;">
	<img src="<%=ConfigManager.IMG_ENURI_COM%>/images/mobile4/<%=strFromNaverShow%>" width="305px" height="260px" usemap="#fromNaver" id="LayerFromNaver" style="margin:auto;z-index:999;text-align:center;<%=strFromNaverDisplay%>">
	<map name="fromNaver" id="fromNaver">
		<area shape="rect" coords="224,206,283,239" href="#" onclick="<%=strFromNaverLog%>$('#LayerFromNaver').hide();"/>
		<area shape="rect" coords="32,184,90,204" <%=strFromNaverApp%>>
	</map>
 	</div>
  -->
<%}%>
	<input type="hidden" name="myCnt" id="myCnt" <%if(strPageType.equals("todaylist") && cb.GetCookie("MOBILETODAY","MODELNOS").length() > 5){%>value="Y"<%}%>> 
	<input type="hidden" name="app2" id="app2" value="<%=strApp%>"> 
	<input type="hidden" name="pagetype2" id="pagetype2" value="<%=strPageType%>">  
	<%if(strApp.equals("Y") && (ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPhone") >= 0 || ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPod") >= 0 || ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPad") >= 0)){%>
	<%}else{%> 
	<div class="shareBtnDiv" style="position:fixed;left:22%;z-index:33;<%=FloatTop%>width:<%if(strPageType.equals("index") && strApp.equals("")){%>250px;<%}else{%>65px;<%}%>height:60px;text-align:left;<%if(strPageType.equals("search11") || strPageType.equals("login")){%>display:none;<%}else{%>display:inline;<%}%>">
		<img src="<%=ConfigManager.IMG_ENURI_COM%>/images/mobile4/btn_menu.png" width="41" height="41" id="btn_menu" class="shareBtn"  style="padding-left:10px;padding-top:10px;padding-right:0px;">
		<%if(strPageType.equals("index") && strApp.equals("")){%>
			<img src="<%=ConfigManager.IMG_ENURI_COM%>/images/mobile4/bn_appdown2.png" width="180" height="41" id="indexbanner">
			<div style="position:absolute;bottom:19px;left:170px;"><img src="<%=ConfigManager.IMG_ENURI_COM%>/images/mobile4/btn_down.png" width="56" height="21" id="indexbannerBtn2" class="app_down"></div>
		<%}%> 
	</div>       
	<div style="position:fixed;left:25%;z-index:1;<%=FloatTop%>width:65px;height:60px;text-align:left;<%if(strPageType.equals("search")){%>display:none;<%}else{%>display:inline;<%}%>"></div>  
	<%}%>
	<%if(strFromNaver.equals("Y")){%>
	<div class="floatTop move_top" style="position:fixed;bottom:0px;right:0px;z-index:0;width:0px;text-align:left;display:none;"></div>
	<%}else{%> 
		<%if(!strPageType.equals("index") && ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("Android 2.3") > -1 && ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("SHW-M180S") > -1){%>
	<div class="floatTop move_top" style="position:fixed;right:<%if(strPageType.equals("detail")){%>13px<%}else{%>10px<%}%>;z-index:33;<%=FloatTop%>;width:31px;text-align:left;display:inline;"><img src="<%=ConfigManager.IMG_ENURI_COM%>/images/mobile4/btn_top2.png" width="31" height="35">&nbsp;</div>
		<%}else{%> 
	<div class="floatTop move_top" style="position:fixed;right:<%if(strPageType.equals("detail")){%>13px<%}else{%>10px<%}%>;z-index:33;<%=FloatTop2%>;width:31px;text-align:left;display:none;"><img src="<%=ConfigManager.IMG_ENURI_COM%>/images/mobile4/btn_top2.png" width="31" height="35">&nbsp;</div>
		<%}%>
	<%}%>
	<!--   
	<div class="shareBtnHidden" style="display:none;position:absolute;top:0px;border:1px solid #ff0000;left:0px;z-index:33;padding-bottom:4px;width:65px;height:60px;"></div> 
	<div class="floatTop move_dn" style="position:fixed;bottom:64px;right:0px;width:31px;z-index:33;display:none;padding-right:5px;"><img src="<%=ConfigManager.IMG_ENURI_COM%>/images/mobile4/m_dn_btn2.png" width="31" height="35">&nbsp;</div>
	<div class="floatTop move_up" style="position:fixed;bottom:64px;right:45px;width:31px;margin-left:28px;padding-bottom:7px;z-index:33;display:none;"><img src="<%=ConfigManager.IMG_ENURI_COM%>/images/mobile4/m_up_btn2.png" width="31" height="35">&nbsp;</div>
	 --> 
<% 
	if (request.getRequestURI().indexOf("cineviewEvent_2014.jsp") < 0 && request.getRequestURI().indexOf("replyEvent_2014.jsp") < 0 && request.getRequestURI().indexOf("detail_new.jsp") < 0 && request.getRequestURI().indexOf("detail_sim.jsp") < 0 && request.getRequestURI().indexOf("login.jsp") < 0){
%>
	<div class="search_noresult_layer">
		<div class="text">전체상품의 가격대 검색입니다.<br><span>제조사</span> 선택을 취소하고 가격대를<br>검색하시겠습니까?<br>
		</div>
		<div class="x_btn"></div>
		<div class="yes_btn"></div>
	</div>
<%
	}
%>
	<div id="cm_loading" style="display:inline;position:absolute;z-index:999999;width:1px;height:1px;"></div>
<script language="javascript">
    //s_loading(100);
    $("#islogin").click(function(){
		if(document.URL.indexOf("/detail_sim.jsp") > -1 ){
			var bLogin = IsLoginCheck();
		}else{
			var bLogin = IsLogin();
		}
		if(document.URL.indexOf("/m4_Index.jsp") > -1 ){
			try{ 
				window.android.First_yn("N");
			}catch(e){  
			}
		}
		if(bLogin){
			$("#islogin").text("로그아웃");
			goLogout(); 
		}else{
			goLogin();
		}    	
    });
    $("#footer_home").click(function(){ 
		CmdLocation('index');
	});  
	$("#bottomHome").click(function(){ 
		CmdLocation('index');
	});  
    $("#footer_back").click(function(){ 
		CmdPreNext('pre');
	});
    $("#footer_next").click(function(){
		CmdPreNext('next'); 
	});
    $("#footer_today").click(function(){
		CmdLocation('todaylist');
	});
    $("#footer_share").click(function(){
		Cmdsns(); 
	});  
	$(".search_noresult_layer .x_btn").click(function(){
		$(".search_noresult_layer").hide(); 
	});
	$(".search_noresult_layer .yes_btn").click(function(){
		if($("#tab_2 div").hasClass('jejo_tab') || $("#tab_2 div").hasClass('jejo_tab_on') ){
			showAllFactory();
		}else{
			showAllShop();
		}
		$(".search_noresult_layer").hide();  
	});
		 
	$(".shareBtn").click(function(){
		if($("#btn_menu").attr("src").indexOf("btn_menu.png") > 0 ){
			/*var bVega = '<%=bVega%>';
			if( jQuery(window).scrollTop() > 0 && (navigator.userAgent.indexOf("iPhone") > 0  || navigator.userAgent.indexOf("iPod") > 0 )){
				$("#m4_share").css("top", jQuery(window).scrollTop() + jQuery(window).height()-160);
			}else{ 
				if(bVega == "true"){
					$("#m4_share").css("top", jQuery(window).scrollTop() + jQuery(window).height()-240);
				}else{
					$("#m4_share").css("top", jQuery(window).scrollTop() + jQuery(window).height()-225);
				}
			} */
			$("#m4_share").show();
			//$("#m4_share2").show();
			$("#btn_menu").attr("src", "http://img.enuri.info/images/mobile4/btn_layer_close.png");
			if(document.URL.indexOf("m4_Index.jsp") >= 0){
				insertLog('9062');
			}else if(document.URL.indexOf("m4_Index.jsp") >= 0){
				insertLog('9118');
			}else if(document.URL.indexOf("m4_todaylist.jsp") >= 0){
				insertLog('9141');
			}else if(document.URL.indexOf("m4_searchlist.jsp") >= 0){ 
				insertLog('9154');
			}else{
				insertLog('9109');
			}
		}else{
			$("#m4_share").hide();
			//$("#m4_share2").hide();
			$("#btn_menu").attr("src", "http://img.enuri.info/images/mobile4/btn_menu.png");
		}
	}); 	
	$("#indexbannerBtn2").click(function(){
		insertLog('9775');
	}); 
    $(".app_down").click(function(){
    	CmdLog('<%=strPageType%>', 'app_down');
    	if(navigator.userAgent.indexOf("Android")>0){
    		location.href = "market://details?id=com.enuri.android";
    	}else{
    		location.href = "http://itunes.apple.com/kr/app/enuriapp/id476264124?l=ko&ls=1&mt=8";
    	}
    });	
    $("#app_share area").click(function(){
    	$("#m4_appShare").hide();
    });	
    $("#app_more area").click(function(){
    	$("#m4_appMore").hide();
    });	
	$("#pcGo").click(function(){
		if( (document.URL.indexOf("detail_new.jsp") > -1 && document.URL.indexOf("m4_ecoupon.jsp") < 0 )|| document.URL.indexOf("detail_sim.jsp") > -1){
			insertLog(7839);
			back_listhome('pc', $("#hModelno").val() ,3);
		}else if($('#cate').val() == "00000000"){
			insertLog(9098);
			try{  
				window.android.android_window_open("http://www.enuri.com/Index.jsp?from=mo"); 
				return false;
			}catch(e){  
				location.href = "http://www.enuri.com/Index.jsp?from=mo";
			} 
		}else if(document.URL.indexOf("m4_stopsearch.jsp") > -1){
			try{  
				window.android.android_window_open("http://www.enuri.com/search/Searchlist.jsp?keyword="+$('#keyword').val()); 
				return false;
			}catch(e){  
				location.href = "http://www.enuri.com/search/Searchlist.jsp?keyword="+$('#keyword').val(); 
			} 		
		}else{ 
			insertLog(9098);
			try{  
				var varUrl = "";
				if(document.URL.indexOf("/login/login.jsp") > -1 || document.URL.indexOf("/resentzzimList.jsp") > -1 || document.URL.indexOf("m4_ecoupon.jsp") > -1 ){
					varUrl = "http://www.enuri.com/Index.jsp?from=mo";
				}else{
					varUrl = "http://www.enuri.com/view/Listmp3.jsp?cate="+$('#cate').val()+"&from=mo";
				}
				
				window.android.android_window_open(varUrl); 
				return false;
			}catch(e){  
				var varApp = "<%=strApp%>";
				var varUrl = "";

				if(document.URL.indexOf("/login/login.jsp") > -1 || document.URL.indexOf("/resentzzimList.jsp") > -1 ||  document.URL.indexOf("m4_ecoupon.jsp") > -1 ){
					varUrl = "http://www.enuri.com/Index.jsp?from=mo";
				}else{
					varUrl = "http://www.enuri.com/view/Listmp3.jsp?cate="+$('#cate').val()+"&from=mo";
				}   
 
				if(varApp == "Y"){
					window.open(varUrl);
				}else{
					location.href = varUrl;
				}
			}  
		}        
	});  
    
    	  
	var varSNSpathname = window.location.pathname; 
	var varSNSTITLE = "";
	var varSNSURL = "";
	 
	function Cmd_AppShare(){
		CmdShare();
		if($("#m4_appMore").is(":visible")){
			$("#m4_appMore").hide();
		}
		if($("#m4_appShare").is(":visible")){
			$("#m4_appShare").hide();
		}else{
			$("#m4_appShare").show(); 
		}  
	} 
	function Cmd_AppMore(){
		if($("#m4_appShare").is(":visible")){
			$("#m4_appShare").hide();
		}
		if($("#m4_appMore").is(":visible")){
			$("#m4_appMore").hide();
		}else{
			$("#m4_appMore").show(); 
		}  
	} 
	function CmdShare_x(){
		$("#m4_share").hide();
		//$("#m4_share2").hide();
		$("#btn_menu").attr("src", "http://img.enuri.info/images/mobile4/btn_menu.png");	
	}
	function Cmdsns(){
		if($("#m4_share").is(':visible')){
			$("#m4_share").hide(); 
			//$("#m4_share2").hide(); 
		}else{
			$("#m4_share").slideToggle('slow');
			//$("#m4_share2").show(); 
		}	 
	} 
	var SNS_URL = window.location;			// 현재 페이지 
		
	function CmdShare(){ 
		//alert(1);
		SNS_URL = window.location;

		if((SNS_URL+"").indexOf("resentzzim/resentzzimList.jsp")>-1) {
			varSNSTITLE = getResentZzimPageTitle();
			SNS_URL = getResentZzimPageUrl();
		}
		  
		varSNSURL = "m_url="+SNS_URL; 
		varSNSURL = varSNSURL.replace("http://www.enuri.com","http://m.enuri.com");
		varSNSURL = varSNSURL.replace("app=Y","app=");
		varSNSURL = varSNSURL.replace("?app=?","?");
		varSNSURL = varSNSURL.replace("m_url=","");
		
		var url = "/url_check/Short_Url_Rtn.jsp";
		var param2 = "org_url="+varSNSURL; 
 
		var Dns; 
		Dns = location.href; 
		Dns = Dns.split("//"); 
		Dns = "http://"+Dns[1].substr(0,Dns[1].indexOf("/")); 	
	 	
	 	<%if(strPageType.equals("index")){%>
	 		varSNSURL = "http://m.enuri.com";
	 	<%}else{%>
		$.ajax({  
			type: "POST",
			url: url,  
			data: param2,  
			async: false,
			success: function(result){ 	
				varSNSURL = Dns+"/short/"+result.trim();
				//alert(result);
			}
		});
		<%}%>
		
	} 
	//CmdShare();
	function CmdShare2(param){ 

		//if(SNS_URL.indexOf("/short/") < 0 ){
			CmdShare();
		//}	 
		CmdLog('<%=strPageType%>', param);
		<%if(strPageType.equals("index")){%> 
			varSNSTITLE = "[에누리닷컴 가격비교]\n";
		<%}else if(strPageType.equals("list")){%>
			varSNSTITLE = "에누리 ->["+$("#cate_name").val()+"] 목록\n";
		<%}else if(strPageType.equals("search")){%> 
			var searchTxt = $("#search_loc_txt2").val();
			varSNSTITLE = "에누리 ->["+searchTxt+"]의 검색결과\n";		 
		<%}else if(strPageType.equals("detail")){%> 
			varSNSTITLE = "["+$(".m_catename").text()+"] -> ["+$(".m_name").text()+"]\n";
		<%}else if(strPageType.equals("todaylist") ){%>
			<%if(listType.equals("1")){%>
				varSNSTITLE = "에누리 ->[최근본상품]\n";
			<%}else{%>
				varSNSTITLE = "에누리 ->[찜 상품]\n";
			<%}%>
		<%}%>	
		if(document.URL.indexOf("m4_searchlist.jsp") > -1 && ($('#keyword').val().toUpperCase() == "LG 시네뷰" || $('#keyword').val().toUpperCase() == "LG시네뷰" ) ){
			varSNSTITLE = "[LG 시네뷰 + 소형TV 이벤트]\n";
		}
		if(param == "kakao"){ 
			<%if(!strPageType.equals("index")){%> 
				$("#kakao_textarea").val(varSNSTITLE.replace('에누리','에누리 가격비교')+"\n"+varSNSURL+"\n");
			<%}else{%>
				$("#kakao_textarea").val(varSNSTITLE+"\n"+varSNSURL+"\n");
			<%}%>	
			$("#kakao_textarea").val(varSNSTITLE+"\n"+varSNSURL+"\n");
			$("#layer_kakao").css("top",(($(window).height()-40-$("#layer_kakao").height())/2)+$(window).scrollTop()-65);
			$("#layer_kakao").show(); 
			onTcMove2();
			//$("#kakao_textarea").focus();  
		}else if(param == "twitter"){ 
			try{    
				window.android.android_window_open("http://twitter.com/intent/tweet?text="+encodeURIComponent(varSNSTITLE)+"&url="+varSNSURL); 
			}catch(e){
				window.open("http://twitter.com/intent/tweet?text="+encodeURIComponent(varSNSTITLE)+"&url="+varSNSURL);
			}
		}else if(param == "facebook"){  
			var url = varSNSURL; //공유할 URL 
			var image= "<%=ConfigManager.IMG_ENURI_COM%>/images/mobile4/f_enuri.png";//이미지 경로
			var title = varSNSTITLE; 												//페이스북 공유 제목 문구
			var summary = "가격비교 에누리닷컴"; 										//페이스북 공유 상세문구
			//var url= "http://www.facebook.com/sharer.php?s=100&p[url]=" + url + "&p[images][0]=" + image + "&p[title]=" + title + "&p[summary]=" + summary;
			//url = url.split("#").join("%23");
			//url = encodeURI(url);  
			//window.open(url);
			try{   
				window.android.android_window_open("http://www.facebook.com/sharer.php?t="+encodeURIComponent(title)+"&u="+url); 
			}catch(e){
				window.open("http://www.facebook.com/sharer.php?t="+encodeURIComponent(title)+"&u="+url);
			}
		}else if(param == "metoday"){ 
			try{ 
				window.android.android_window_open("http://me2day.net/posts/new?new_post[body]="+encodeURIComponent(varSNSTITLE.replace('[','(').replace(']',')'))+" "+varSNSURL);
			}catch(e){
				window.open("http://me2day.net/posts/new?new_post[body]="+encodeURIComponent(varSNSTITLE.replace('[','(').replace(']',')'))+" "+varSNSURL);		
			}	
		}else if(param == "email"){ 
		}else if(param == "sms"){
			try{ 
				window.android.android_send_sms("", varSNSTITLE+""+varSNSURL);
			}catch(e){
				location.href="sms:?body="+varSNSTITLE+"     "+varSNSURL;
			}
		}  
	}
	function CmdLog(param_page, param_gubun){
		if(param_gubun == "index"){
			if(param_page == "index"){
				insertLog('9065');
			}else if(param_page == "detail"){
				insertLog('9110');
			}else if(param_page == "todaylist"){
				insertLog('9149');
			}else if(param_page == "search"){
				insertLog('9162');
			}else{
				insertLog('9101'); 
			}
		}else if(param_gubun == "todaylist"){
			if(param_page == "index"){
				insertLog('9066');
			}else if(param_page == "detail"){
				insertLog('9111');
			}else if(param_page == "todaylist"){
				insertLog('9148');
			}else if(param_page == "search"){
				insertLog('9160');
			}else{
				insertLog('9102');
			}
		}else if(param_gubun == "app_down"){
			if(param_page == "index"){
				insertLog('9067');
			}else if(param_page == "detail"){
				insertLog('9112');
			}else if(param_page == "todaylist"){
				insertLog('9147');
			}else if(param_page == "search"){
				insertLog('9159');
			}else{
				insertLog('9103');
			}
		}else if(param_gubun == "kakao"){
			if(param_page == "index"){
				insertLog('9068');
			}else if(param_page == "detail"){
				insertLog('9115');
			}else if(param_page == "todaylist"){
				insertLog('9144');
			}else if(param_page == "search"){
				insertLog('9156');
			}else{
				insertLog('9106');
			}
		}else if(param_gubun == "twitter"){
			if(param_page == "index"){
				insertLog('9069'); 
			}else if(param_page == "detail"){
				insertLog('9114');
			}else if(param_page == "todaylist"){
				insertLog('9145');
			}else if(param_page == "search"){
				insertLog('9157');
			}else{
				insertLog('9105');
			}
		}else if(param_gubun == "facebook"){
			if(param_page == "index"){
				insertLog('9070');
			}else if(param_page == "detail"){
				insertLog('9113');
			}else if(param_page == "todaylist"){
				insertLog('9146');
			}else if(param_page == "search"){
				insertLog('9158');
			}else{
				insertLog('9104');
			}
		}else if(param_gubun == "metoday"){
			if(param_page == "index"){ 
				insertLog('9071');
			}else if(param_page == "detail"){
				insertLog('9116');
			}else if(param_page == "todaylist"){
				insertLog('9143');
			}else if(param_page == "search"){
				insertLog('9155');
			}else{
				insertLog('9107');
			}
		}
	}
	function executeURLLink(){
		$("#layer_kakao").hide();

		var url = ""; 
		var msg = $("#kakao_textarea").val();
		var appid = "m.euri.com"; 
		var appver = "1.0"; 
		var appname = ""; 
		
		if(document.URL.indexOf("m4_Index.jsp") >= 0 ){
			insertLog('9151');
		}else if(document.URL.indexOf("m4_todaylist.jsp") >= 0 ){
			insertLog('9150');
		}else if(document.URL.indexOf("detail_new.jsp") >= 0 ){
			insertLog('9153');
		}else if(document.URL.indexOf("m4_searchlist.jsp") >= 0 ){ 
			insertLog('9161');
		}else{
			insertLog('9152');
		}
		
		try{  
			window.android.android_kakao("",msg);
		}catch(e){
			kakao.link("talk").send({
		        msg : msg,
		        url : url,
		        appid : appid, 
		        appver : appver, 
		        appname : appname,
		        type : "link"  
		    });
		    //var link = new com.kakao.talk.KakaoLink(msg, url, appid, appver, appname);
		    //link.execute();
		}
	}
	
	function setPosition(param){ 
		var bScroll2 = false;
		if(navigator.userAgent.indexOf("Android 4.") > 0 || navigator.userAgent.indexOf("OS 7") > 0){
			if(navigator.userAgent.indexOf("Android 4.0") > 0){
				bScroll2 = false;
			}else{
				bScroll2 = true;
			}
		}

		var setTimeIn = 500;
		
		if(navigator.userAgent.indexOf("Android 2.3") > 0 ){
			setTimeIn = 1000;
		}else{
			setTimeIn = 1000;
		} 
		 
		setTimeout(function(){
			var varHeight = $(window).height();
			var varWidth = $(window).width();
			
			$("#Main_default").css("width", varWidth-$("#layer_Lcate").width()-5);
			if(bScroll2){
				varHeight = varHeight - 43;
				
			}

			if (varHeight < 300 && navigator.userAgent.indexOf("Android 2.3") > 0 && window.orientation == 0){
				varHeight = fnGetCookie2010("_hg");
			}else{
				fnSetCookie2010("_hg",varHeight,365);
			}
			
			
			if(navigator.userAgent.indexOf("iPhone OS 7") > 0 ){
				if(param != "main"){
					if (window.orientation == 0){
						$("#Default_content").css("height",($("#DefaultUl").height()- 60 )+"px");
					}else{
						$("#Default_content").css("height",($("#DefaultUl").height()- 70 )+"px");
					}
				}
			}else if(navigator.userAgent.indexOf("iPhone") > 0  || navigator.userAgent.indexOf("iPod") > 0 ){
				varHeight = varHeight + 18;
				if(param != "main"){
					if (window.orientation == 0){
						
					}else{
						$("#Default_content").css("height",($("#DefaultUl").height())+"px");
					}
				}
			}else{
				if(param != "main"){
					if (window.orientation == 0){
						$("#Default_content").css("height",($("#DefaultUl").height()- 20 )+"px");
					}else{
						$("#Default_content").css("height",($("#DefaultUl").height()- 20)+"px");
					}
				}			 
			}  

			if(bScroll2){
				$("#layer_Lcate_body").css("height",varHeight);
				$("#layer_Mcate_body").css("height",varHeight);
				$("#layer_Scate_body").css("height",varHeight);
				$("#layer_Dcate_body").css("height",varHeight);
				$("#layer_Ingi").css("height",varHeight);
				$("#Main_default").css("height",varHeight);
			}else{ 
				$("#layer_Lcate").css("height",varHeight);
				$("#layer_Mcate").css("height",varHeight);
				$("#layer_Scate").css("height",varHeight);
				$("#layer_Dcate").css("height",varHeight);
				$("#layer_Ingi").css("height",varHeight);
				$("#Main_default").css("height",varHeight);
			
				menu_scroll_Lcate.refresh(); 
				
				if($("#Main_default").height() > 0){
					if (menu_scroll_default != null){
						menu_scroll_default.refresh(); 
					} 
				}
				if($("#layer_Mcate").height() > 0){
					if (menu_scroll_Mcate != null){
						menu_scroll_Mcate.refresh();
					}
				}
				if($("#layer_Scate").height() > 0){
					if (menu_scroll_Scate != null){
						menu_scroll_Scate.refresh();
					} 
				} 
				if($("#layer_Dcate").height() > 0){
					if (menu_scroll_Dcate != null){
						menu_scroll_Dcate.refresh();
					} 
				} 
				if($("#layer_Ingi").height() > 0){
					if (menu_scroll_Ingi != null){
						menu_scroll_Ingi.refresh();
					} 
				}	 
			}
		}, setTimeIn);

		//쇼핑박스 너비 조절
		setShoppingBox();
		//쇼핑몰 모음 너비 조절
		setShopGo();
		// 인기키워드 너비 조절
		setKeywordSize(); 

	}    
	function CmdPreNext(param){	
		var varreferrer = document.referrer;
		var pageType = '<%=strPageType%>';

		event.cancelBubble=true;
		if(param == "pre"){ 
			if((varreferrer.indexOf("Index.jsp") > -1 || varreferrer.indexOf("list.jsp") > -1) && pageType.indexOf("detail") > -1){
				window.close();
			} 			
			history.go(-1);  
		}else{
			history.go(1);
		}
	}
	function CmdChkZzim(){
		if(document.URL.indexOf("/detail_sim.jsp") > -1 ){
			var bLogin = IsLoginCheck();
		}else{
			var bLogin = IsLogin();
		}
		$("#ZzimBtnBlank").show(); 
		setTimeout(function(){ 
			$("#ZzimBtnBlank").hide(); 
		},500);  
		if(bLogin){
			CmdLocation('zzimlist');
		}else{
			//if(confirm("찜 상품을 보시려면 로그인이 필요합니다.\n로그인 하시겠습니까?")) {
			CmdLocation('zzimlist');
			//}
		}
	} 
	function CmdLocation(param){

		var Dns; 
		Dns = location.href; 
		Dns = Dns.split("//"); 
		Dns = "http://"+Dns[1].substr(0,Dns[1].indexOf("/")); 	
		if(Dns == "http://"){
			Dns =  "http://m.enuri.com";
		} 
		var pageType = '<%=strPageType%>';
		//var varToday = '<%=cb.GetCookie("MOBILETODAY","MODELNOS")%>';
		var varVersion = '<%=ChkNull.chkStr((String)Mobilesession.getAttribute("version"),"")%>';
		var varRefer = '<%=ChkNull.chkStr(request.getHeader("REFERER"),"")%>';
		var varToday = getResentCnt();
		var app2 = $("#app2").val();
		
		CmdLog('<%=strPageType%>', param);
		
		<%//if(strEnuriApp.equals("Y")){%>
		if(app2 == "Y"){ 
			if(param == "index" ){ 
				if(navigator.userAgent.indexOf("Android")>0){
					if(pageType == "detail"){ 
						window.android.android_End_Activity();
						window.android.android_Main_Activity(Dns+"/mobile2/m4_Index.jsp?app=<%=strEnuriApp%>&version="+varVersion); 
					}else if(pageType == "list" || pageType == "search" || pageType == "todaylist"){
						window.android.android_Main_Activity(Dns+"/mobile2/m4_Index.jsp?app=<%=strEnuriApp%>&version="+varVersion); 
					}else if(pageType == "login"){
						if(varRefer.indexOf("m4_Index") < 0){
							window.android.android_End_Activity();
							window.android.android_Main_Activity(Dns+"/mobile2/m4_Index.jsp?app=<%=strEnuriApp%>&version="+varVersion); 
						}else{  
							location.href = "/mobile2/m4_Index.jsp?app=<%=strEnuriApp%>&version="+varVersion; 
						}
					}else{ 
						if(param == "index"){ 
							try{  
								window.android.First_yn("N");
							}catch(e){  
							}
						}
						location.href = "/mobile2/m4_Index.jsp?app=<%=strEnuriApp%>&version="+varVersion; 
					}
				}else{
					location.href = "/mobile2/m4_Index.jsp?app=<%=strEnuriApp%>&version="+varVersion; 
				}
			}else if( param == "index2"){
				window.android.android_End_Activity();
			}else if(param == "todaylist"){
				if(varToday  < 1){  
					alert("최근 본 상품이 없습니다.");
				}else{     
					if(navigator.userAgent.indexOf("Android")>0){
						if(pageType == "detail"){ 
							window.android.android_End_Activity();	
							window.android.android_List_Activity(Dns+"/mobile2/resentzzim/resentzzimList.jsp?listType=1&app=<%=strEnuriApp%>"); 
						}else if(pageType == "list" || pageType == "search" || pageType == "todaylist"){
							location.href = "/mobile2/resentzzim/resentzzimList.jsp?listType=1&app=<%=strEnuriApp%>";
						}else if(pageType == "index"){
							window.android.android_List_Activity(Dns+"/mobile2/resentzzim/resentzzimList.jsp?listType=1&app=<%=strEnuriApp%>"); 
						}else{
							location.href = "/mobile2/resentzzim/resentzzimList.jsp?listType=1&app=<%=strEnuriApp%>";
						}	
					}else{ 
							location.href = "/mobile2/resentzzim/resentzzimList.jsp?listType=1&app=<%=strEnuriApp%>";
					}
				}	
			}else if(param == "zzimlist"){
				if(navigator.userAgent.indexOf("Android")>0){
					if(pageType == "detail"){ 
						window.android.android_End_Activity();	
						window.android.android_List_Activity(Dns+"/mobile2/resentzzim/resentzzimList.jsp?listType=2&app=<%=strEnuriApp%>"); 
					}else if(pageType == "list" || pageType == "search" || pageType == "todaylist"){
						location.href = "/mobile2/resentzzim/resentzzimList.jsp?listType=2&app=<%=strEnuriApp%>";
					}else if(pageType == "index"){ 
						window.android.android_List_Activity(Dns+"/mobile2/resentzzim/resentzzimList.jsp?listType=2&app=<%=strEnuriApp%>"); 
					}else{
						location.href = "/mobile2/resentzzim/resentzzimList.jsp?listType=2&app=<%=strEnuriApp%>";
					}	
				}else{ 
						location.href = "/mobile2/resentzzim/resentzzimList.jsp?listType=2&app=<%=strEnuriApp%>";
				}
			}else{
			
			}	
		}else{
		<%//}else{%>
			if(param == "index" || param == "index2"){ 
				if(pageType == "detail"){
					if(opener){
						if(opener.opener){
							window.close(); 
							opener.window.close();
							opener.opener.location.href = "/mobile2/m4_Index.jsp";
						}else{
							window.close(); 
							opener.location.href = "/mobile2/m4_Index.jsp";
						}
					}else{
						location.href = "/mobile2/m4_Index.jsp";
					}
				}else{
					if(opener){
						window.close(); 
						if(param == "index"){
							opener.location.href = "/mobile2/m4_Index.jsp";
						}
					}else{
						location.href = "/mobile2/m4_Index.jsp";
					}
				}  
			}else if(param == "todaylist"){
				if(varToday  < 1){  
					alert("최근 본 상품이 없습니다.");
				}else{
					if(pageType == "detail"){
						if(opener){
							window.close(); 
							opener.location.href = "/mobile2/resentzzim/resentzzimList.jsp?listType=1";
						}else{
							location.href = "/mobile2/resentzzim/resentzzimList.jsp?listType=1";
						}
					}else{
						location.href = "/mobile2/resentzzim/resentzzimList.jsp?listType=1";
					}
				}
			}else if(param == "zzimlist"){
				if(pageType == "detail"){
					if(opener){
						window.close(); 
						opener.location.href = "/mobile2/resentzzim/resentzzimList.jsp?listType=2";
					}else{
						location.href = "/mobile2/resentzzim/resentzzimList.jsp?listType=2";
					}
				}else{
					location.href = "/mobile2/resentzzim/resentzzimList.jsp?listType=2";
				}
			}else{
				return false;
			}
		}
		<%//}%>
	} 
	function urlCopy() {
		insertLog('9224');
		var copyUrl = "copyurl="+location.href;
		copyUrl = copyUrl.replace("http://","").replace("copyurl=",""); 
		window.open("ioscall://loc"+copyUrl);
	}
	function screenCapture() {
	 insertLog('9223');
	 Cmd_AppMore();
	 
	 setTimeout("iosCapture()", 1000);
	}
	function iosCapture() {
		 window.open("ioscall://screenCapture");
	}
	function insertSession(sname, sval){
		//sval = Number(sval) + 1;
		//sval = 0;
		var url = "/include/ajax/AjaxSetSession.jsp"; 
		var param = "sname="+sname+"&svalue="+sval;
		$.ajax({ 
			type: "POST",
			url: url, 
			data: param, 
			success: function(result){ 																		
			},
			complete : function(){
			} 
		});
	}
	$("#footer").show();
<%
	if (bGNote){
%>
	var varfTop = jQuery(window).height()+jQuery(window).scrollTop()-$("#footer").height(); 
	$("#footer").css("top",varfTop+"px");
	$("#footer").css("position","absolute");
		
	$(window).scroll(function(e){
		var varfTop = jQuery(window).height()+jQuery(window).scrollTop()-$("#footer").height();
		$("#footer").hide(); 
		$("#footer").css("top",varfTop+"px");
		$("#footer").css("position","absolute");
		$("#footer").show();	
	});
<%
	}
%>

	//document.addEventListener("touchstart", onTcStart2, false);
	//document.addEventListener("touchmove", onTcMove2, false);
	function onTcStart2(e){
		var touch = e.touches[0]; 
	
		if($("#m4_share").is(":visible")){  
			var menuX_A = $("#m4_share").position().left;
			var menuX_B = menuX_A + 220;
			//alert(menuX_A +" , "+menuX_B);
			//if(touch.clientX > 0 && touch.clientX < 250 && jQuery(window).height() - 190 < touch.clientY && jQuery(window).height()-30 > touch.clientY ){
			if(touch.clientX > menuX_A && touch.clientX < menuX_B && jQuery(window).height() - 190 < touch.clientY && jQuery(window).height()-30 > touch.clientY ){
			
			}else{
				setTimeout(function(){
					if($("#m4_share").is(":visible")){  
						$("#m4_share").hide();
						//$("#m4_share2").hide();
						$("#btn_menu").attr("src", "http://img.enuri.info/images/mobile4/btn_menu.png");
					}
				}, 500);  
			}
		}
		
	}
	function onTcMove2(e){
		if($("#m4_share").is(":visible")){
			$("#m4_share").hide();
			//$("#m4_share2").hide();
			$("#btn_menu").attr("src", "http://img.enuri.info/images/mobile4/btn_menu.png");
		}
	}
	function getToday(){
		var intTodayCnt1 = $("#myCnt").val();
		var intTodayCnt2 = "<%=cb.GetCookie("MOBILETODAY","MODELNOS")%>";
		
		if(intTodayCnt1 == "Y" || intTodayCnt2.length > 5 ){
			return "Y"; 		
		}else{
			return 0; 
		} 

	} 
	insertLog('9774');
	//alert(getToday());
	//insertSession('M_LIST', '<%=strHistoryPage%>');
</script>