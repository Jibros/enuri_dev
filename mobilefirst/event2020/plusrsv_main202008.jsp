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
	String event_dtl_id ="";
	
	JSONObject jSONObject = new JSONObject();
	String server_type = request.getServerName().contains("dev") ? "dev" : "real";
	try{ 
		jSONObject = new Event_PlusRsv_Proc().getPlusRsvData_v2(server_type, numSdt, "R");
		
		if( !jSONObject.isNull("event_id") ){
			event_id			= jSONObject.getString("event_id");
			promViewYn			= jSONObject.getString("view_yn");				//프로모션 노출여부
			title_img_url_nm	= jSONObject.getString("title_img_url_nm");		//이벤트 정보
			emoney_img_nm  		= jSONObject.getString("emoney_img_nm");
			
			event_dtl_id 		= jSONObject.getString("event_dtl_id");
			
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


<!-- 앱전용 최대5배 추가적립 -->
<div id="tab4" class="maxfive_wrap">
	<!-- INNER -->
	<div class="inner">
		<div class="imgbox">
		
			<div class="top_area">
				<h2>최대 3천점 추가 적립 -받고 또 받는 기간 한정 카테고리 혜택!</h2>
			</div>

			<div class="maxfive__cont">
				<img src="http://img.enuri.info/images/event/2020/buy_stamp/aug/evt2_cont.png" alt="최대 3,000점">
			</div>
			
			<a href="javascript:///" id="plusRsvClk" >
				<img src="http://img.enuri.info/images/event/2019/buy_stamp/jul/m_btn_apply.png" alt="신청하기">
			</a>
			<div class="info_list">
				<ul>
					<li>· 이벤트 기간 : 2020년 8월 19일 ~ 8월 31일</li>
					<li>· 혜택 지급일 : 2020년 10월 22일</li>
					<li>· 카테고리별 적립률 및 적립액은 유의사항에서 확인하세요.</li>
				</ul>
			</div>
            <a class="btn_cate" id="btnCategory" href="javascript:///" onclick="onoff('categoryLayer'); return false;">
            	<img src="<%=ConfigManager.IMG_ENURI_COM%>/images/event/2020/buy_stamp/jul/btn_cate.png" alt="카테고리 확인하기" />
            </a>
            <div class="notice catelayer" id="categoryLayer" style="display: none;">
				<div class="dim"></div>
				<div class="notice_layer cate_layer_open">
					<h4><span class="eico"> e머니</span>추가적립 카테고리</h4>
					<div class="cont">
						<ul id="targetCate">
						</ul>
					</div>
					<a class="btn layclose2" href="javascript:void(0);" onclick="onoff('categoryLayer');return false"><em>팝업 닫기</em></a>
				</div>
			</div>
		</div>
	</div>
	<!-- //INNER -->
	<!-- 유의사항 WRAPPER -->
	<div class="com__evt_notice">
		<div class="evt_notice--btn_area"><button class="btn__evt_notice" data-laypop-id="slidePop2"><span>꼭! 확인하세요</span></button></div> <!-- 열기 : 유의사항 열기 -->
	</div>
	<div id="slidePop2" class="evt_notice--slide">
		<div class="evt_notice--inner"> <!-- .wide - 넓은 케이스 -->
			<div class="evt_notice--head">유의사항</div>
			<div class="evt_notice--cont">
				<div class="evt_notice--continner">
					<dl>								
						<dt>이벤트 대상 및 혜택</dt>
						<dd>
							<ul>
								<li>이벤트 대상 : 이벤트 기간 내 대상 카테고리 상품 구매 후 추가적립 이벤트 신청한 고객 (※ 대상 카테고리 확인)</li>
								<li>이벤트 기간 : 2020년 8월 19일 ~ 8월 31일</li>
								<li>이벤트 혜택 : 카테고리별 차등 추가 적립(최대 e머니 3,000점)</li>
								<li>혜택 지급일 :&nbsp;2020년 10월 22일<br>
									- 에누리 가격비교 APP &gt; 이벤트/기획전탭 &gt; 이벤트혜택 &gt; 하단 [당첨자/공지]
								</li>
								<li>
									<span class="stress">e머니 유효기간 : 적립일로부터 15일 (유효기간 만료 후 재적립 불가)</span><br>
									※ 적립된 e머니는 e쿠폰 스토어에서 다양한 쿠폰으로 교환가능합니다.
								</li>
								
								<li>
									카테고리별 적립률 및 최대 적립액<br>
									<table class="evt_noti_tb">
										<colgroup>
											<col width="40%"><col width="20%"><col width="20%"><col width="20%">
										</colgroup>
										<tbody>
											<tr>
												<th>대상 카테고리</th>
												<th>기본 적립률</th>
												<th>추가 적립률</th>
												<th>최대 적립액</th>
											</tr>
											<tr><td>커피,차</td><td>1.0%</td><td>1.0%</td><td>3,000</td></tr>
											<tr><td>홍삼,건강식품</td><td>1.0%</td><td>1.0%</td><td>3,000</td></tr>
											<tr><td>과자,초콜릿,디저트</td><td>1.0%</td><td>1.0%</td><td>1,000</td></tr>
											<tr><td>물티슈</td><td>1.5%</td><td>0.5%</td><td>1,000</td></tr>
										</tbody>
									</table>
								</li>
								<!-- // -->
							</ul>
						</dd>
					</dl>

					<dl>
						<dt>이벤트 참여방법 및 유의사항</dt>
						<dd>
							<ul>
								<li>참여방법 : 에누리 가격비교 모바일 앱 로그인 → 적립대상 쇼핑몰 이동 →&nbsp;<span class="stress">대상 카테고리 구매</span>&nbsp;→ 추가적립 이벤트 신청<br>
									※ 이벤트 참여의 경우 PC 및 모바일 앱/웹에서 로그인 후에도 가능합니다. 
								</li>
								<li>적립대상 쇼핑몰 : G마켓, 옥션, 11번가, 인터파크, 티몬, 위메프, 쿠팡, GS SHOP, CJmall, SSG (신세계몰, 신세계백화점, 이마트몰, 트레이더스), SK스토아, 홈플러스<br>
									<span class="stress">※ 구매 유의사항 및 구매적립 제외 카테고리는 이벤트 페이지 하단 'e머니 구매혜택' 유의사항을 꼭 확인하세요.</span>
								</li>
								<li>대상 카테고리는 에누리 가격비교 카테고리 기준 입니다.</li>
								<li>추가적립금이 100원 미만의 경우 혜택 지급되지 않습니다.</li>
								<li>구매금액은 배송비, 설치비, 할인, 쇼핑몰 포인트 등 제외한 금액만 반영됩니다.</li>
								<li>
									<span class="stress">이벤트 대상 제외 :</span> 아래의 경우에는 이벤트 대상 및 혜택 지급에서 제외됩니다. <br>
									<ul class="sub">
										<li>- 이벤트 신청하지 않은 경우</li>
										<li>- 실제 구매금액이 1만원 미만의 구매일 경우</li>
										<li>- 구매적립 제외 카테고리 구매일 경우 </li>
										<li>- 구매 후 취소/환불/교환/반품한 경우</li>
										<li>- 해외직구 상품 구매일 경우</li>
										<li class="stress">- 동일한 이벤트 기간의 더블적립 및 무제한 적립 이벤트 혜택받은 경우 (중복 지급 불가)</li>
									</ul>
								</li>
							</ul>
						</dd>
					</dl>
					<dl>
						<dt>공통 이벤트 유의사항</dt>
						<dd>
							<ul>
								<li>부정 참여 시 본 이벤트 대상 제외 및 혜택 지급이 취소될 수 있습니다.</li>
								<li>본 이벤트는 당사 사정에 따라 사전고지 없이 변경 또는 종료될 수 있습니다.</li>
							</ul>
						</dd>
					</dl>
				</div>
			</div>
			<div class="evt_notice--foot">						
				<button class="btn__evt_confirm">확인</button> <!-- 닫기 : 유의사항 닫기 -->
			</div>
		</div>
	</div>
	<div class="commingsoon">
		<p class="blind">
			더 강력한 ‘가전’ 추가적립 혜택이 찾아옵니다. Coming Soon 
		</p>
	</div>
	<!-- //유의사항 WRAPPER -->
</div>
<!-- //앱전용 최대5배 추가적립 -->

<!-- <div class="cateplan_wrap">
	INNER
	<div class="inner">
		카테고리별 기획전 슬라이드
		<div class="imgbox">
			<img src="http://img.enuri.info/images/event/2019/buy_stamp/mar/m_evt3_head.png" alt="카테고리별 기획전 보러가기" class="imgs">
				<div class="plan_list">
					<ul class="planSlide" id="planSlide"></ul>						
				</div>
		</div>
		//카테고리별 기획전 슬라이드
	</div>
	//INNER
</div> -->
<script>
$(function() {
	var template = "";
	var template2 = "";

    $.post( "/mobilefirst/evt/ajax/ajax_plusrsv_promotion_v2.jsp" , { "deviceType" : "M", "sdt" : "<%=numSdt %>", "event_dtl_id": <%=event_dtl_id%> } , function(json) {
    	
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
		
		var ostpcd = getOsType();
		
		var param = {
			"event_start_dt" : '<%=event_start_dt %>',
			"event_end_dt" : '<%=event_end_dt %>',
			"event_id" : '2020080108',
			"mobileyn" : 'Y',
			"ostpcd":ostpcd
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