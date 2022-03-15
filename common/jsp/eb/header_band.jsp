<link rel="stylesheet" href="/css/com.simple.header.css?v=20201216" type="text/css">
<div class="com_simple_header ty_core">
   <div class="com_head__inner">
       <!-- 심플헤더 - 패밀리탭 -->
       <ul class="com_head__tab_fam" id="com_head__tab_fam">
           <!-- 노출되지 않는 list는 li태그에 display:none처리 꼭 해주세요 -->
           <!-- 해당되는 탭은 on클래스로 활성화 해주세요 -->
           <li><a href="/global/Index.jsp" onclick="insertLog(20802);" target="_blank">해외직구</a></li>
           <li><a href="/enuripc" onclick="insertLog(18617);" target="_blank" title="조립PC 페이지 새창열림">조립PC</a></li>
           <li><a href="/deal/newdeal/index.deal" onclick="insertLog(20875);" target="_blank" >소셜</a></li>
           <li><a href="/tour2012/Tour_Index.jsp" onclick="insertLog(17712);" target="_blank" title="여행 페이지 새창열림">여행</a></li>
           <!-- <li><a href="/enuricar/list.jsp" onclick="insertLog(21216);" target="_blank" title="중고차ㅣ 페이지 새창열림">중고차</a></li> -->
           <li><a href="http://auto.enuri.com" onclick="insertLog(21216);" target="_blank" title="자동차ㅣ 페이지 새창열림">자동차</a><i class="ico_simple__sprite ico_new">NEW</i></li>
           <li><a href="/knowcom/index.jsp" onclick="insertLog(20883);" target="_blank">쇼핑지식</a></li>
       </ul>
       <!-- // -->
       <!-- 심플헤더 - 배너영역 (에누리홈 only) -->
       <ul class="com_head__list_ban">
           <li class="list_ban_nm"><a href="/eventPlanZone/jsp/shoppingBenefit.jsp" onclick="insertLog(20884);" target="_blank">혜택존</a></li>
           <li class="list_ban_pick"><a href="/event2020/pick.jsp" onclick="insertLog(22644);" >PICK</a></li>
       </ul>
       <!-- // -->
       <!-- 심플헤더 - 우측메뉴 -->
       <ul class="com_head__menu">
           <!-- 노출되지 않는 메뉴 li태그에 display:none처리 꼭 해주세요 -->
           <!-- 로그인 -->
           <li id='utilMenuLogin' style="<%=cb.GetCookie("MEM_INFO","USER_ID").trim().length()> 0 ? "display:none;" : ""%>"><a href="JavaScript:" onclick="setLogintopMygoods(4);Cmd_Login('');document.getElementById('divLoginLayer').style.zIndex='99997';insertLog(4661);">로그인</a></li>
           <!-- 회원가입 -->
           <li id='utilMenuJoin' style="<%=cb.GetCookie("MEM_INFO","USER_ID").trim().length()> 0 ? "display:none;" : ""%>">
             	<a href="JavaScript:" onclick="insertLog(10519);goJoin();">
             		회원가입
             	</a>
           </li>
           <!-- 사용자 + 마이에누리 레이어 -->
           <li id="loginDiv2" style="<%=cb.GetCookie("MEM_INFO","USER_ID").trim().length()> 0 ? "":"display:none;"%>">
		   <%
	      		Object loginStatus = request.getAttribute("loginStatus");
	      		boolean isNoLoginStatus = loginStatus!=null && "no".equals(loginStatus.toString());
	      		if (isNoLoginStatus) {
					String sMymenuID  = cb.GetCookie("MEM_INFO","USER_ID");
					String sNicknameNew = cb.GetCookie("MEM_INFO","USER_NICK");
					String strMyText = "".equals(sNicknameNew)?sMymenuID:sNicknameNew;
           %>
				<a id="frmMainLogin" href="JavaScript:"><em class="user_name"><%=(strMyText.length()>13)?strMyText.substring(0,12):strMyText%></em>님<span class="ico__arr_down ico_simple__sprite"></span></a>
           <% } else { %>
	            <iframe id="frmMainLogin" name="frmMainLogin" src="/login/Loginstatus_2010.jsp?logintop_menu=top" frameborder=0 style="/*background-color:#f3f4f5;*/width:200px;height:41px;overflow:hidden;display:none" scrolling="no" onload="this.style.display=''"></iframe>
		   <% } %>
               <!-- 각 레이어는 부모 li태그가 hover될때 visible 됩니다. -->
               <!-- 레이어 : 마이에누리 -->
               <div class="com_lay_login com_lay_box"> <!-- style에 높이값/z-index값만 넣어주세요 -->
               		<%
						CookieBean cbb = new CookieBean( request.getCookies());
						String strEnrUsr  = cbb.GetCookie("MEM_INFO","USER_ID");
						Sdul_Member_Data ndata = new Sdul_Member_Proc().getSdulmember(strEnrUsr);
					
						//MS 오피스 직판 구매 유무
						boolean isMSgoodsUser = false;
						isMSgoodsUser = new Msgoods_Sale_Log_Proc().getMsgoodsSaleUser(strEnrUsr);
					
						//SDUL
						int intSdulCnt = new Sdul_Goods_Proc().SdulGoodsRedyCount(strEnrUsr);
					
						//찜한상품건수
						int intFavoriteCnt = new Save_Goods_Proc().getSaveGoodCnt(strEnrUsr, "MEMBER");
					%>
					<div class="lay_inner">
						<ul>
							<li class="js-myenuri"><a href="">My에누리</a></li>
							<li><a href="javascript:CmdJoin(3);">개인정보관리</a></li>
				
				            <%if(ndata != null) { %>
							<li><a href="javascript:goMyPage('/sdul/mallregister/SellerMain.jsp?sm=1');">SDUL(대기중) <em>(<%=intSdulCnt%>)</em></a></li> <!-- 판매자전용 -->
							<li><a href="javascript:goMyPage('/sdul/mallregister/SellerMain.jsp?sm=2');">상위노출입찰</a></li> <!-- 판매자전용 -->
				            <%}%>
				
				            <%if(isMSgoodsUser) {  %>
							<li><a href="javascript:CmdJoin(9);">My 주문내역</a></li>
				            <%}%>
				
							<li id="js-zzimCnt"><a href="javascript:;" onclick="javascript:showZzim(<%=intFavoriteCnt%>);">찜상품 <em>(<%=intFavoriteCnt%>)</em></a></li>
							<li><a href="javascript:logout();">로그아웃</a></li>
						</ul>
					</div>
				</div>
          	<!-- // -->
           </li>
           <!-- 로그아웃 -->
           <li id='utilMenuLogout' style="<%=cb.GetCookie("MEM_INFO","USER_ID").trim().length()> 0 ? "" : "display:none;"%>"><a href="JavaScript:" onclick="<%=isNoLoginStatus?"logout();":"javascript:document.getElementById('frmMainLogin').contentWindow.logout();"%>">로그아웃</a></li>
           <!-- 앱다운로드 + 레이어 -->
           <li>
               <a href="javascript:void(0);">앱다운로드<span class="ico__app_down ico_simple__sprite">받기</span></a>
               <!-- 각 레이어는 부모 li태그가 hover될때 visible 됩니다. -->
               <!-- 레이어 : 앱다운로드 -->
               <%@ include file="header_app.jsp" %>
           </li>
           <!-- 더보기 + 레이어 -->
           <li>
               <a href="javascript:void(0);">더보기<span class="ico__arr_down ico_simple__sprite"></span></a>
               <!-- 각 레이어는 부모 li태그가 hover될때 visible 됩니다. -->
               <!-- 레이어 : 사이트맵 -->
               <div class="com_lay_sitemap com_lay_box">
                   <dl>
                       <dt>주요서비스</dt>
                       <dd>
                           <a href="/deal/newdeal/index.deal" target="_new">소셜비교</a>
                           <a href="/enuripc/" target="_blank" onclick="insertLog(18618);">PC 견적비교</a>
                           <a href="/global/Index.jsp" target="_new" onclick="insertLog(20803);">해외직구</a>
                       </dd>
                       <dd>
                           <a href="/view/shopBest.jsp" target="_blank" onclick="insertLog(12171);">쇼핑 BEST</a>
                           <a href="/view/move_mall.jsp" onclick="insertLog(12172);">이사견적</a>
                           <a href="/view/Flower365.jsp" onclick="insertLog(12173);">꽃배달</a>
                           <a href="/tour2012/Tour_Index.jsp" onclick="insertLog(12175);">여행비교</a>
                           <!-- <a href="/enuricar/list.jsp" onclick="insertLog(21265);">중고차</a> -->
                           <a href="http://auto.enuri.com" onclick="insertLog(21265);">자동차</a>
                       </dd>
                   </dl>
                   <dl>
                       <dt>커뮤니티</dt>
                       <dd>
                           <a href="/knowcom/index.jsp" onclick="insertLog(12176);">쇼핑지식</a>
                           <a href="/knowcom/news.jsp" onclick="insertLog(14864);">뉴스</a>
                           <a href="/knowcom/guide.jsp" onclick="insertLog(14865);">구매가이드</a>
                           <a href="/knowbox2/review/index.jsp" onclick="insertLog(12177);">사용기</a>
                           <a href="/knowcom/enuritv.jsp" onclick="insertLog(16109);">에누리TV</a>
                           <a href="/knowbox2/nuri/index.jsp" onclick="insertLog(12178);">자유게시판</a>
                           <a href="/knowcom/eventzone.jsp" onclick="insertLog(22885 );" >이벤트존</a>
                       </dd>
                       <dd>
                           <!-- <a href="/knowbox2/sale/index.jsp" onclick="insertLog(14863);">특가게시판</a> -->
                           <a href="/knowcom/qna.jsp" onclick="insertLog(12177);">쇼핑Q&amp;A</a>
                           <a href="/eventPlanZone/jsp/shoppingBenefit.jsp?tab_ty=pick" onclick="insertLog(12178);">PICK</a>
                           <a href="/knowcom/nurigo.jsp" onclick="insertLog(22444);">누리GO</a>
                           <!-- <a href="/infoad_event/eventMain.jsp" onclick="insertLog(14863);">이벤트</a> -->
                       </dd>
                   </dl>
                   <p class="all">
                       <a href="/etc/Site_map.jsp" class="enuri_all" target="_new">에누리 서비스 전체보기</a>
                   </p>
               </div>
               <!-- // -->
           </li>
       </ul>
   </div>
</div>

<script type="text/javascript">
	function goMyPage(url) {
		location.href = url;
	}
	document.querySelector(".js-myenuri a").href = "javascript:goMyPage('https://"+location.hostname+"/my/my_enuri.jsp');";
	
	//여행 탭
	if(jQuery(location).attr('href').indexOf("/tour2012")>-1){
		var tabObj = jQuery("#com_head__tab_fam li");
		tabObj.removeClass("on");
		tabObj.each(function () {
    		var thisUrl = jQuery(this).find("a").attr("href");
    		if(thisUrl.indexOf("/tour2012/Tour_Index.jsp")>-1){
				jQuery(this).addClass("on");
    		}
    	});
		jQuery("#shop_qa").hide();
    }
</script>