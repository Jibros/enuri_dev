<%@page import="org.json.JSONObject"%>
<%@page import="com.enuri.bean.event.Event_PlusRsv_Proc"%>
<%
	boolean eventViewYn = false;
	String promViewYn = "";
	String event_id = "";
	String title_img_url_nm = "";
	String emoney_img_nm = "";
	String event_start_dt = "";
	String event_start_dt_str = "";
	String event_end_dt = "";
	String event_end_dt_str = "";
	String plus_rsv_rt_cts = "";
	String wrok_note = "";

	JSONObject jSONObject = new JSONObject();
	String server_type = request.getServerName().contains("dev") ? "dev" : "real";
	
	try{ 
		jSONObject = new Event_PlusRsv_Proc().getPlusRsvData_v2(server_type, numSdt);
		
		if( !jSONObject.isNull("event_id") ){
			event_id			= jSONObject.getString("event_id");
			promViewYn			= jSONObject.getString("view_yn");				//프로모션 노출여부
			title_img_url_nm	= jSONObject.getString("title_img_url_nm");		//이벤트 정보
			emoney_img_nm  		= jSONObject.getString("emoney_img_nm");

			event_start_dt  	= jSONObject.getString("event_start_dt");
			event_end_dt  		= jSONObject.getString("event_end_dt");
			
			event_start_dt_str	= event_start_dt.substring(0, 4)+"년 "+event_start_dt.substring(4, 6)+"월 "+event_start_dt.substring(6, 8)+"일";
			event_end_dt_str  	= event_end_dt.substring(0, 4)+"년 "+event_end_dt.substring(4, 6)+"월 "+event_end_dt.substring(6, 8)+"일";
			
			plus_rsv_rt_cts  	= jSONObject.getString("plus_rsv_rt_cts");
			wrok_note  			= jSONObject.getString("wrok_note");
			
			eventViewYn = true;
		}
 	}catch(Exception e){
		System.out.println(e.getMessage());
	}
%>
<%if(eventViewYn) {%>

<!-- 180515 추가 -->
<!-- 대상카테고리 확인하기 레이어 추가-->
<!-- 
<div class="layer_back topfixed" id="app_only3" style="display:none;">
    <div class="appLayer2">
        <h4><img src="http://imgenuri.enuri.gscdn.com/images/event/2018/buy/june/cate_layer_tit.png" alt="추가적립 카테고리"></h4>
        <div class="inner">
            <ul id="targetCate"></ul>
        </div>
        <a class="btn layclose2" href="javascript:void(0);" onclick="onoff('app_only3')"><em>창닫기</em></a>
    </div>
</div>
 -->	
<!-- //대상카테고리 확인하기 레이어 -->	
<div class="notice catelayer" id="app_only3" style="display:none;">
	<div class="notice_layer cate_layer_open">
		<h4><span class="eico"> e머니</span>추가적립 카테고리</h4>
		<div class="cont">
			<ul id="targetCate"></ul>
		</div>
		<a class="btn layclose2" href="javascript:void(0);" onclick="$('#app_only3').hide()"><em>팝업 닫기</em></a>
	</div>
</div>
<!-- 앱전용 최대5배 추가적립 -->
<div id="tab4" class="maxfive_wrap">
	<!-- INNER -->
	<div class="inner">
		<div class="imgbox">
		
			<div class="top_area">
				<h2><img src="http://img.enuri.info/images/event/2019/buy_stamp/jul/w_sec2_tit.png" alt="최대 5만점 추가 적립 -받고 또 받는 기간 한정 카테고리 적립!"></h2>
			</div>

			<div class="maxfive__cont">
				<span class="icon badge100">100% 증정</span>
				<img src="<%=ConfigManager.STORAGE_ENURI_COM%>/<%=emoney_img_nm%>"  alt="e머니 구매적립 5배 100% 증정" />
			</div>
			
			<a href="javascript:///" id="plusRsvClk" >
				<img src="<%=ConfigManager.IMG_ENURI_COM%>/images/event/2019/buy_stamp/jul/m_btn_apply.png" alt="신청하기">
			</a>
			<ul class="info_list">
				<li><strong>· 이벤트 및 구매기간:</strong>  <%=event_start_dt_str%>~<%=event_end_dt_str%></li>
				<li><strong>· 추가 적립률:</strong><%=plus_rsv_rt_cts%></li>
				<li><strong>· <%=wrok_note%></strong></li>
			</ul>
            <a class="btn_cate" id="btnCategory" href="javascript:///" onclick="onoff('app_only3'); return false;">
            	<img src="<%=ConfigManager.IMG_ENURI_COM%>/images/event/2019/buy_stamp/mar/btn_cate.png" alt="카테고리 확인하기" />
            </a>
		</div>
	</div>			
	<!-- //INNER -->
	<!-- 유의사항 WRAPPER -->
	<div class="caution-wrap">
		<a href="javascript:///" class="btn_check">이벤트 유의사항<span class="line"></span></a>

		<!-- 카테고리 추가적립 유의사항 -->
		<!-- 180816 수정 -->
		<div class="moreview" style="display: none;">
					<h4>카테고리 추가적립 유의사항</h4>
					<div class="txt">
						<strong>이벤트 및 구매기간</strong>
						<ul class="txt_indent">
							<li><%= dateFormatter.format(prevFormat.parse(startDate)) %> ~ <%= dateFormatter.format(prevFormat.parse(endDate)) %></li>
						</ul>
						<strong>이벤트 혜택</strong>
						<ul class="txt_indent">
							<li>이벤트 기간 내 추가적립 카테고리 상품 구매시 최대 5만점 추가적립</li>
							<li>카테고리별 적립률 및 최대 적립액
								<div class="tb">
									<table>
										<colgroup>
											<col><col><col><col>
										</colgroup>
                                        <tbody>
                                            <tr>
                                                <th>대상 카테고리</th>
                                                <th>기본 적립률</th>
                                                <th>추가 적립률</th>
                                                <th>최대 적립액</th>
                                            </tr>
											<tr><td>캠코더,액션캠</td><td>0.30%</td><td>1.00%</td><td>50,000</td></tr>
											<tr><td>DSLR</td><td>0.30%</td><td>1.00%</td><td>50,000</td></tr>
											<tr><td>미러리스</td><td>0.30%</td><td>1.00%</td><td>50,000</td></tr>
											<tr><td>냉난방기,에어컨</td><td>0.30%</td><td>1.00%</td><td>50,000</td></tr>
											<tr><td>노트북</td><td>0.80%</td><td>1.00%</td><td>50,000</td></tr>
											<tr><td>TV</td><td>0.30%</td><td>1.00%</td><td>50,000</td></tr>
											<tr><td>일체형PC</td><td>0.80%</td><td>1.00%</td><td>50,000</td></tr>
											<tr><td>데스크탑,미니PC</td><td>0.80%</td><td>1.00%</td><td>50,000</td></tr>
											<tr><td>태블릿PC,전자책</td><td>0.30%</td><td>1.00%</td><td>30,000</td></tr>
											<tr><td>휴대폰,스마트폰</td><td>0.30%</td><td>1.00%</td><td>20,000</td></tr>
											<tr><td>렌즈,필터</td><td>0.30%</td><td>1.00%</td><td>20,000</td></tr>
											<tr><td>골프클럽</td><td>1.00%</td><td>1.00%</td><td>20,000</td></tr>
											<tr><td>침대,매트리스</td><td>0.30%</td><td>1.00%</td><td>20,000</td></tr>
											<tr><td>소파,거실가구</td><td>0.30%</td><td>1.00%</td><td>20,000</td></tr>
											<tr><td>청소기</td><td>0.30%</td><td>1.00%</td><td>10,000</td></tr>
											<tr><td>공기청정기,에어워셔</td><td>0.30%</td><td>1.00%</td><td>10,000</td></tr>
											<tr><td>CPU,쿨러</td><td>0.80%</td><td>1.00%</td><td>10,000</td></tr>
											<tr><td>식탁,주방가구</td><td>0.30%</td><td>1.00%</td><td>10,000</td></tr>
											<tr><td>모니터</td><td>0.80%</td><td>1.00%</td><td>10,000</td></tr>
											<tr><td>커피,차</td><td>1.00%</td><td>1.00%</td><td>10,000</td></tr>
											<tr><td>블랙박스</td><td>0.30%</td><td>1.00%</td><td>5,000</td></tr>
											<tr><td>악기,디지털피아노</td><td>0.20%</td><td>1.00%</td><td>5,000</td></tr>
											<tr><td>게임기,게임SW</td><td>0.80%</td><td>1.00%</td><td>5,000</td></tr>
											<tr><td>의자</td><td>0.30%</td><td>1.00%</td><td>3,000</td></tr>
											<tr><td>휴대용,블루투스 스피커</td><td>0.30%</td><td>1.00%</td><td>3,000</td></tr>
											<tr><td>장롱,행거,침실가구</td><td>0.30%</td><td>1.00%</td><td>3,000</td></tr>
											<tr><td>타이어,스노우체인</td><td>1.00%</td><td>1.00%</td><td>3,000</td></tr>
											<tr><td>이어폰,헤드폰</td><td>0.30%</td><td>1.00%</td><td>3,000</td></tr>
											<tr><td>책상,책장</td><td>0.30%</td><td>1.00%</td><td>3,000</td></tr>
											<tr><td>수납가구,정리용품</td><td>0.30%</td><td>1.00%</td><td>3,000</td></tr>
											<tr><td>SSD,HDD</td><td>0.80%</td><td>1.00%</td><td>3,000</td></tr>
											<tr><td>블루투스,스마트워치</td><td>0.30%</td><td>1.00%</td><td>3,000</td></tr>
											<tr><td>운동화,스니커즈</td><td>1.00%</td><td>1.00%</td><td>3,000</td></tr>
											<tr><td>홍삼,건강식품</td><td>1.00%</td><td>1.00%</td><td>3,000</td></tr>
											<tr><td>건강측정,의료기</td><td>0.30%</td><td>1.00%</td><td>3,000</td></tr>
											<tr><td>태블릿PC용 액세서리</td><td>0.30%</td><td>1.00%</td><td>3,000</td></tr>
											<tr><td>스킨케어,마스크팩</td><td>1.00%</td><td>1.00%</td><td>3,000</td></tr>
											<tr><td>공구,전동드릴</td><td>0.20%</td><td>1.00%</td><td>3,000</td></tr>
											<tr><td>공기청정기,안전용품</td><td>1.00%</td><td>1.00%</td><td>3,000</td></tr>
											<tr><td>향수</td><td>1.00%</td><td>1.00%</td><td>3,000</td></tr>
											<tr><td>램</td><td>0.80%</td><td>1.00%</td><td>3,000</td></tr>
											<tr><td>배터리,멀티소켓</td><td>1.00%</td><td>1.00%</td><td>3,000</td></tr>
											<tr><td>조명,스탠드,전구</td><td>0.30%</td><td>1.00%</td><td>3,000</td></tr>
											<tr><td>복합기</td><td>0.80%</td><td>1.00%</td><td>3,000</td></tr>
											<tr><td>농산물</td><td>1.00%</td><td>1.00%</td><td>3,000</td></tr>
											<tr><td>선케어,메이크업</td><td>1.00%</td><td>1.00%</td><td>3,000</td></tr>
											<tr><td>침구,카페트,홈패브릭</td><td>0.30%</td><td>1.00%</td><td>3,000</td></tr>
											<tr><td>신발,가방,잡화&gt;책가방</td><td>1.50%</td><td>0.50%</td><td>3,000</td></tr>
											<tr><td>남성화장품</td><td>1.00%</td><td>1.00%</td><td>3,000</td></tr>
											<tr><td>메모리카드,카드리더</td><td>0.30%</td><td>1.00%</td><td>1,000</td></tr>
											<tr><td>샴푸,탈모,헤어케어</td><td>1.00%</td><td>1.00%</td><td>1,000</td></tr>
											<tr><td>기저귀</td><td>1.50%</td><td>0.50%</td><td>1,000</td></tr>
											<tr><td>라면,통조림,즉석식품</td><td>1.00%</td><td>1.00%</td><td>1,000</td></tr>
											<tr><td>튜닝용품</td><td>1.00%</td><td>1.00%</td><td>1,000</td></tr>
											<tr><td>분유,이유식,두유</td><td>1.50%</td><td>0.50%</td><td>1,000</td></tr>
											<tr><td>클렌징,바디케어</td><td>1.00%</td><td>1.00%</td><td>1,000</td></tr>
											<tr><td>골프용품</td><td>1.00%</td><td>1.00%</td><td>1,000</td></tr>
											<tr><td>복사용지,사무용지</td><td>0.80%</td><td>1.00%</td><td>1,000</td></tr>
											<tr><td>USB메모리</td><td>0.80%</td><td>1.00%</td><td>1,000</td></tr>
											<tr><td>과자,초콜릿,디저트</td><td>1.00%</td><td>1.00%</td><td>1,000</td></tr>
											<tr><td>생수,음료</td><td>1.00%</td><td>1.00%</td><td>1,000</td></tr>
											<tr><td>신발,가방,잡화&gt;운동화</td><td>1.50%</td><td>0.50%</td><td>1,000</td></tr>
											<tr><td>시트,매트,인테리어</td><td>1.00%</td><td>1.00%</td><td>1,000</td></tr>
											<tr><td>외장용품,캐리어</td><td>1.00%</td><td>1.00%</td><td>1,000</td></tr>
											<tr><td>물티슈</td><td>1.50%</td><td>0.50%</td><td>1,000</td></tr>
											<tr><td>스마트폰용 액세서리</td><td>0.30%</td><td>1.00%</td><td>1,000</td></tr>
											<tr><td>세차,광택,탈취제</td><td>1.00%</td><td>1.00%</td><td>1,000</td></tr>
											<tr><td>램프,LED,HID</td><td>1.00%</td><td>1.00%</td><td>1,000</td></tr>
											<tr><td>엔진오일,첨가제,필터</td><td>1.00%</td><td>1.00%</td><td>1,000</td></tr>
											<tr><td>건전지,소방,산업</td><td>0.20%</td><td>1.00%</td><td>1,000</td></tr>																					
                                        </tbody>
									</table>
								</div>
							</li>
							<li>
							<b>당첨자 발표 및 적립일: <%= dateFormatter.format(prevFormat.parse(dday)) %></b>
							<br>- 에누리 가격비교 APP &gt; 이벤트/기획전탭 &gt; 이벤트혜택 &gt; 하단 '당첨자 발표'에 공지
							</li>
						</ul>
							
						<strong>참여방법 및 유의사항</strong>
						<ul class="txt_indent">
							<li>에누리 가격비교 로그인 → 적립대상 쇼핑몰 이동 → 구매하기 → 이벤트 응모하기</li>
							<li>적립대상 쇼핑몰: G마켓, 옥션, 11번가, 인터파크, 티몬, 위메프, 쿠팡, GS SHOP, CJmall, SSG (신세계몰, 신세계백화점, 이마트몰, 트레이더스), 마이크로소프트 전문관(스마트스토어), SK스토아</li>
							<li>구매금액은 배송비, 설치비, 할인, 쇼핑몰 포인트 등 제외한 상품 결제금액만 반영</li>
							<li>결제 이후 취소/환불/교환/반품한 경우 구매금액에서 제외</li>
							<li>100점 미만은 지급되지 않습니다.</li>
							<li><b class="stress">더블적립 및 무제한 적립 혜택과 중복지급 불가</b></li>
							<li><b class="stress">해외상품 구매건 제외</b></li>
						</ul>
						
						<strong>아래의 경우에는 구매 확인 및 적립이 불가합니다.</strong>
						<ul class="txt_indent">
							<li>에누리 가격비교 앱이 아닌 다른 앱을 통해서 장바구니 또는 관심상품 등록 후 에누리 가격비교 앱으로 결제만 한 경우
								<br>(에누리 가격비교 앱을 통해 쇼핑몰로 이동 후 장바구니/관심상품 등록 후 구매 시에는 가능)</li>
							<li>에누리 가격비교 앱 미 로그인 후 구매한 경우 또는 에누리 가격비교 PC, 모바일 웹에서 구매한 경우<br>
								<b class="stress">※ 티몬의 경우 PC 및 모바일 앱/웹에서 로그인 후 구매시 e머니 적립 가능 </b>
							</li>
						</ul>
						
						<strong>유의사항</strong>
						<ul class="txt_indent">
							<li>부정 참여 시 적립이 취소될 수 있습니다.</li>
							<li>본 이벤트는 당사 사정에 따라 사전고지 없이 변경 또는 종료될 수 있습니다.</li>
						</ul>					
						<a href="javascript:///" class="btn_check_hide">확인</a>
					</div>
				</div>
		<!-- //카테고리 추가적립 유의사항 -->
	</div>
	<!-- //유의사항 WRAPPER -->
</div>
<!-- //앱전용 최대5배 추가적립 -->

<div class="cateplan_wrap">
	<!-- INNER -->
	<div class="inner">
		<!-- 카테고리별 기획전 슬라이드 -->
		<div class="imgbox">
			<img src="http://img.enuri.info/images/event/2019/buy_stamp/mar/m_evt3_head.png" alt="카테고리별 기획전 보러가기" class="imgs">
				<div class="plan_list">
					<ul class="planSlide" id="planSlide"></ul>						
				</div>
		</div>
		<!-- //카테고리별 기획전 슬라이드 -->
	</div>
	<!-- //INNER -->
</div>
<script>
$(function() {
	var template = "";
	var template2 = "";

    $.post( "/mobilefirst/evt/ajax/ajax_plusrsv_promotion_v2.jsp" , { "deviceType" : "M", "sdt" : "<%=numSdt %>" } , function(json) {
    	
    	var plusrsvExh = json.catePromotion;
    	var plusrsvCate = json.targetCate;
	
		$.each(plusrsvExh, function(i,v){
			template += "<li data-promtnId = \"" + v.MOBL_PROMTN_ID + "\">";					
			template += "<a href=\"javascript:///\">";					
			template += "<img src=\"http://img.enuri.gscdn.com/images/mobilefirst/planlist/B_" + v.MOBL_PROMTN_ID + "/B_" + v.MOBL_PROMTN_ID + "_main.png\" alt=\"\" />";					
			template += "</a>";					
			template += "</li>";					
		});
    	
		$.each(plusrsvCate, function(i,v){
			template2 +="<li data-cateno = \""+ v.cate_cd + "\" data-eventTagNm = \""+ v.event_tag_nm + "\">";
			template2 +="    <a href=\"javascript:///\">";
			template2 +="        <span>" + v.event_tag_nm + "</span>";
			//template2 +="        <img src=\"http://imgenuri.enuri.gscdn.com/images/event/2018/buy/june/arrow.png\" alt=\"바로가기\">";
			template2 +="    </a>";
			template2 +="</li>";
		});
    	
    }, "json").done(function(){
    	
    	if(template != "" && '<%=promViewYn%>' == 'Y') {
    		
    		$("#planSlide").html(template).slick({
    			dots: false,infinite: true,speed: 200,slidesToShow: 1,adaptiveHeight: true,autoplay: true,autoplaySpeed: 2000
			}).find("li").click( function() {
				var promtnId = $(this).attr("data-promtnId");
				ga('send', 'event', 'mf_event', '구매 프로모션', '추가적립_' + promtnId );
				window.open("/mobilefirst/planlist.jsp?t=B_" + promtnId);
				return false;
			});
    		$(".cateplan_wrap").show();
		}else{
			$(".cateplan_wrap").hide();
		}
    	if(template2 != "") {
    		$("#targetCate").html(template2).find("li").click(function(){
    			ga('send', 'event', 'mf_event', '구매 프로모션', '추가적립_' + $(this).attr("data-eventTagNm") );
    			window.open("/mobilefirst/list.jsp?cate=" + $(this).attr("data-cateno") + "&freetoken=list");
    			return false;
    		});
    	}
    });
	var isClick = true;
	
	$("#plusRsvClk").click(function(e){
		//if(getCookie("appYN") != 'Y'){
//			onoff('app_only');
	//		return false;
		//} 
		if(!islogin()){
			 alert("로그인 후 이용할 수 있습니다.");
			 
			 if( navigator.userAgent.indexOf("iPhone") > -1 || navigator.userAgent.indexOf("iPod") > -1 || navigator.userAgent.indexOf("iPad") > -1){
			 	location.href = "/mobilefirst/login/login.jsp";
			 }else if(navigator.userAgent.indexOf("Android") > -1){
				 location.href = "/mobilefirst/login/login.jsp?backUrl=/mobilefirst/evt/welcome_event.jsp?freetoken=event&tab=4";
			 }else{
				 location.replace("/mobilefirst/index.jsp"); 
			 }
			 return false;
		}
		var param = {
			"event_start_dt" : '<%=event_start_dt %>',
			"event_end_dt" : '<%=event_end_dt %>',
			"event_id" : '<%=event_id %>',
			"mobileyn" : 'Y'
		};
		if(!isClick){
			return false;
		}
		isClick = false;
		$.ajax({
			type: "GET",
			url: "/mobilefirst/evt/ajax/ajax_plusrsvchk.jsp",
			async: false,
			data: param,
			dataType:"JSON",
			success: function(json){
				var result = json.result;
				
				if(result == -1){
					alert("구매 후 참여 가능합니다!");
				}else if(result == 0){
					alert("이미 신청해주셨습니다!");
				}else if(result == 1){
					alert("신청완료 되었습니다! \n e머니 지급일을 기다려주세요~!");
				}else if(result == 2){
					alert("잘못된 접근입니다.");
				}else if(result == -4){
					alert("SDU 회원은 본인인증 후 참여 가능합니다.\n※ 본인인증은 ‘앱 설정 > 본인인증’ 또는 ‘PC >\n개인정보관리 화면’을 이용해주세요");
				
				}else if(result==-5){
					var r = confirm("본인인증이 되지 않은 SNS 회원은\n이벤트 참여가 불가합니다.\n본인인증 화면으로 이동할까요?");
					if(r){
						location.href = "https://m.enuri.com/mobilefirst/member/myAuth.jsp?cmdType=&f=m&freetoken=login_title";
					}
				
				}else{
					alert("신청이 불가능합니다.");
				}
			}, complete : function() {
				isClick=true;
			}
		});
	});
	// 카테고리 레이어 현재위치에서 열리도록 top 조정
	$("#btnCategory").on("click", function(e){
		var currTop = $(window).scrollTop()+800; // 현재 스크롤
		$("#app_only3 .notice_layer.cate_layer_open").css("top", currTop);
	})
});
</script>
<% } %>