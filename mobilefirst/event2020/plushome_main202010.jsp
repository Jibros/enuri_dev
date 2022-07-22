<%@page import="org.json.JSONObject"%>
<%@page import="com.enuri.bean.event.Event_PlusRsv_Proc"%>
<%
	boolean eventViewYn2 = false;
	String promViewYn2 = "";
	String event_id2 = "";
	String title_img_url_nm2 = "";
	String emoney_img_nm2 = "";
	String event_start_dt2 = "";
	String event_start_dt2_str = "";
	String event_end_dt2 = "";
	String event_end_dt2_str = "";
	String plus_rsv_rt_cts2 = "";
	String wrok_note2 = "";
	String event_dtl_id2 = "";
	
	JSONObject jSONObject2 = new JSONObject();
	String server_type2 = request.getServerName().contains("dev") ? "dev" : "real";
	try{ 
		jSONObject2 = new Event_PlusRsv_Proc().getPlusRsvData_v2(server_type2, numSdt,"H");
		
		if( !jSONObject2.isNull("event_id") ){
			event_id2			= jSONObject2.getString("event_id");
			promViewYn2			= jSONObject2.getString("view_yn");				//프로모션 노출여부
			title_img_url_nm2	= jSONObject2.getString("title_img_url_nm");		//이벤트 정보
			emoney_img_nm2  		= jSONObject2.getString("emoney_img_nm");
			event_dtl_id2		= jSONObject2.getString("event_dtl_id");
			event_start_dt2  	= jSONObject2.getString("event_start_dt");
			event_end_dt2  		= jSONObject2.getString("event_end_dt");
			
			event_start_dt2_str	= event_start_dt2.substring(0, 4)+"년 "+event_start_dt2.substring(4, 6)+"월 "+event_start_dt2.substring(6, 8)+"일";
			event_end_dt2_str  	= event_end_dt2.substring(0, 4)+"년 "+event_end_dt2.substring(4, 6)+"월 "+event_end_dt2.substring(6, 8)+"일";
			
			plus_rsv_rt_cts2  	= jSONObject2.getString("plus_rsv_rt_cts");
			wrok_note2  			= jSONObject2.getString("wrok_note");
			
			eventViewYn2 = true;
		}
 	}catch(Exception e){
		System.out.println(e.getMessage());
	}
%>
<%if(eventViewYn2) {%>
<div id="tab3" class="elecsave_wrap">
	<!-- INNER -->
	<div class="inner">
		<div class="imgbox">
			<div class="top_area">
				<h2>구매혜택 02, 가전X10배 적립 - 단 한 달만! 모든 가전 상품 구매 시 10배 추가적립 혜택!</h2>
			</div>
			
			<div class="elecsave__cont">
				<img src="http://img.enuri.info/images/event/2020/buy_stamp/sep/m_evt2_cont.png" alt="e머니 0.3% 구매적립, e머니 3% 추가적립">
			</div>
			
			<a href="javascript:void(0);" id="plusHomeClk"><img src="http://img.enuri.info/images/event/2019/buy_stamp/jul/m_btn_apply.png" alt="신청하기"></a>
			
			<div class="info_list">
				<ul>
					<li>· 이벤트 기간 : 2020년 10월 5일 ~ 11월 1일</li>
					<li>· 혜택 지급일 : 2020년 12월 24일</li>
					<li>· 카테고리별 적립률 및 적립액은 유의사항에서 확인하세요.</li>
				</ul>
			</div>   
			<!-- // -->

			<!-- 200608 이미지 경로 변경 -->
			<a id="btnCategory" class="btn_cate" href="#" onclick="onoff('categoryLayer'); return false;"><img src="http://img.enuri.info/images/event/2020/buy_stamp/sep/btn_cate_elec.png" alt="가전 대상 카테고리 확인하기"></a>
			<!-- // -->
                  		            
            <!-- 추가적립 카테고리 레이어 -->
            <div class="notice catelayer" id="categoryLayer" style="display:none;">
				<div class="dim"></div>
				<div class="notice_layer cate_layer_open">
					<h4><span class="eico"> e머니</span>가전 대상 카테고리</h4>
					<div class="cont">
						<ul id="targetCate2">
						</ul>
					</div>
					<a class="btn layclose2" href="javascript:void(0);" onclick="onoff('categoryLayer');return false"><em>팝업 닫기</em></a>
				</div>
			</div>
		</div>
	</div>			
	<!-- //INNER -->
	
	<!-- 버튼 : 꼭 확인하세요 -->
	<div class="com__evt_notice">
		<div class="evt_notice--btn_area"><button class="btn__evt_notice" data-laypop-id="slidePop3"><span>꼭! 확인하세요</span></button></div> <!-- 열기 : 유의사항 열기 -->
	</div>
	<div id="slidePop3" class="evt_notice--slide">
		<div class="evt_notice--inner"> <!-- .wide - 넓은 케이스 -->
			<div class="evt_notice--head">유의사항</div>
			<div class="evt_notice--cont">
				<div class="evt_notice--continner">
					<dl>								
						<dt>이벤트 대상 및 혜택</dt>
						<dd>
							<ul>
								<li>이벤트 대상 : 이벤트 기간 내 가전 대상 카테고리 상품 구매 후 가전x10배 적립 이벤트 신청한 고객(※ 대상 카테고리 확인)</li>
								<li>이벤트 기간 : 2020년 10월 5일 ~ 11월 1일</li>
								<li>이벤트 혜택 : 추가 적립률 3% (최대 e머니 5,000점)</li>
								<li>혜택 지급일 :&nbsp;2020년 12월 24일<br>
									- 에누리 가격비교 APP &gt; 이벤트/기획전탭 &gt; 이벤트혜택 &gt; 하단 [당첨자/공지]
								</li>
								<li>
									<span class="stress">e머니 유효기간 : 적립일로부터 15일 (유효기간 만료 후 재적립 불가)</span><br>
									※ 적립된 e머니는 e쿠폰 스토어에서 다양한 쿠폰으로 교환가능합니다.
								</li>
								
								<li>
									가전 대상 카테고리<br>
									<table class="evt_noti_tb">
										<tbody>
											<tr>
												<th colspan="3">가전 대상 카테고리</th>
											</tr>
											<tr><td>세탁기</td><td>의류건조,관리기</td><td>오븐,전자레인지</td></tr>
											<tr><td>청소기</td><td>전기밥솥</td><td>에어컨,냉난방기</td></tr>
											<tr><td>다리미,재봉,보풀제거</td><td>냉장고</td><td>선풍기,공기순환기</td></tr>
											<tr><td>드라이기,고데기,헤어케어</td><td>식기세척,살균건조기</td><td>제습기,가습기</td></tr>
											<tr><td>안마의자,안마기</td><td>가스,전기레인지</td><td>온수매트,전기장판</td></tr>
											<tr><td>면도기,제모기</td><td>커피메이커,머신</td><td>보일러,온수기,난방가전</td></tr>
											<tr><td>도어록,비디오폰,보안</td><td>믹서,분쇄기,원액기</td><td>공기청정기,에어워셔</td></tr>
											<tr><td>비데,전동칫솔,연수기</td><td>전기포트,그릴,튀김기</td><td>TV</td></tr>
											<tr><td>건강측정,의료기</td><td>김치냉장고</td><td>오디오,카세트,라디오</td></tr>
											<tr><td>피부관리기</td><td>정수기,냉온수기</td><td>홈시어터,HiFi</td></tr>
											<tr><td>전화기,무전기</td><td>웰빙 주방가전</td><td>블루레이,DVD,DivX</td></tr>
										</tbody>
									</table>
								</li>
							</ul>
						</dd>
					</dl>

					<dl>
						<dt>이벤트 참여방법 및 유의사항</dt>
						<dd>
							<ul>
								<li>참여방법 : 에누리 가격비교 모바일 앱 로그인 → 적립대상 쇼핑몰 이동 →&nbsp;<span class="stress">가전 대상 카테고리 구매</span>&nbsp;→ 가전x10배 적립 이벤트 신청<br>
									※ 이벤트 신청의 경우 PC 및 모바일 앱/웹에서 로그인 후에도 가능합니다. 
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
	<!-- // -->
</div>
<script>

$(function() {
	var template = "";
	var template2 = "";

	$.post( "/mobilefirst/evt/ajax/ajax_plusrsv_promotion_v2.jsp" , { "deviceType" : "M", "sdt" : "<%=numSdt %>", "event_dtl_id" : "<%=event_dtl_id2%>" } , function(json) {
		
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
		
		if(template != "" && '<%=promViewYn2%>' == 'Y') {
			
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
			$("#targetCate2").html(template2).find("li").click(function(){
				ga('send', 'event', 'mf_event', '구매 프로모션', '추가적립_' + $(this).attr("data-eventTagNm") );
				window.open("/mobilefirst/list.jsp?cate=" + $(this).attr("data-cateno") + "&freetoken=list");
				return false;
			});
		}
	});
});
var isClick = true;
$("#plusHomeClk").click(function(e){
	if(!islogin()){
		 alert("로그인 후 이용할 수 있습니다.");
		 
		 if( navigator.userAgent.indexOf("iPhone") > -1 || navigator.userAgent.indexOf("iPod") > -1 || navigator.userAgent.indexOf("iPad") > -1){
		 	location.href = "/mobilefirst/login/login.jsp";
		 }else if(navigator.userAgent.indexOf("Android") > -1){
			 location.href = "/mobilefirst/login/login.jsp?backUrl=/mobilefirst/evt/smart_benefits.jsp?freetoken=event&tab=4";
		 }else{
			 location.replace("/mobilefirst/index.jsp"); 
		 }
		 return false;
	}
	
	var ostpcd = getOsType();
	
	var param = {
/* 		"event_start_dt" : '20201005',
		"event_end_dt" : '20201101',
		"event_id" : '2020100109',
		"mobileyn" : 'Y',
		"ostpcd":ostpcd */
		"event_start_dt" : '<%=event_start_dt2 %>',
		"event_end_dt" : '<%=event_end_dt2 %>',
		"event_id" : '<%=event_id2 %>',
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
</script>
<% } %>