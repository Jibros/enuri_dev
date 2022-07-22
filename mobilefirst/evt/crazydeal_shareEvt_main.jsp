<%@ page contentType="text/html; charset=utf-8" %>
<!-- 무조건 쏜다 이벤트 : 2018-07-04 추가 -->
<div id="con2" class="ssonda">
	<div class="content">
		<div class="tit">
			<h2 class="blind">매주당첨, [무조건 쏜다! CRAZY 이벤트!] 이번 주 꼭! 구매하고 싶은 상품에 투표하면 추첨을 통해 선물을 드립니다.</h2>
		</div>
		<div class="ssonda_con" id = "ssonda_con">
		</div>

		<div class="btn_group">
			<a href="javascript:///" class="btn_viewp sprite" >상품보기</a>
			<a href="javascript:///" class="btn_share sprite" onclick="openShareLayer();">공유하기</a>
		</div>

		<a href="javascript:///" class="btn_check"><span>!</span><u>꼭! 확인하세요</u></a>

		<!-- 유의사항 -->
		<div class="moreview">
			<div class="txt">
				<dl>
					<dt>이벤트 참여방법</dt>
					<dd>SNS로 이번주 크레이지딜 상품 공유하기 </dd>
					<dd>공유한 SNS 링크를 댓글로 남기기! (카카오톡으로 공유한 경우 ‘공유완료!’ 댓글만 남겨도 OK!)</dd>
					<dd>SNS 공유와 댓글 모두 참여할 경우에만 이벤트 응모로 집계되며, 둘 중 하나만 참여할 경우에는 당첨시 제외됩니다.</dd>
					<dd>SNS 공유는 횟수 제한없이 참여 가능하며, 댓글은 1일 1회 참여 가능합니다.</dd>
				</dl>
				<dl>
					<dt>경품</dt>
					<dd>e쿠폰으로 교환 가능한 e머니로 적립되며, e쿠폰 스토어에서 교환 가능합니다.</dd>
					<dd>경품은 제휴처 사정에 따라 해당 쿠폰 품절, 단종, 가격변동 있을 수 있습니다.</dd>
				</dl>
				<dl>
					<dt>당첨자 발표 및 경품지급일</dt>
					<dd>매월 마지막 주 목요일 (발표일정은 사전고지 없이 변경될 수 있습니다.)</dd>
					<dd>e머니 적립 후 App Push 메시지 발송 (Push 알림 미동의자 제외) </dd>
					<dd>e머니 유효기간 : 적립일로부터 15일</dd>
				</dl>
				<dl>
					<dt>유의사항</dt>
					<dd>부정 참여 시 적립이 취소될 수 있습니다.</dd>
					<dd>본 이벤트는 당사 사정에 따라 사전고지 없이 변경 또는 종료될 수 있습니다.</dd>
				</dl>
			</div>
		</div>
		<!-- //유의사항 -->
	</div>
</div>
<!-- //무조건 쏜다 이벤트 : 2018-07-04 추가 -->

<!-- 2018-07-04 SNS 공유 댓글 영역 -->
<div class="boardWrap">
	<div class="content">
		<div class="write_head">
			<h3 class="tit stripe">SNS로 공유하고 댓글로 남겨주세요!<br />추첨을 통해 선물을 드립니다!</h3>
			<div class="box_info" id = "box_info">
			</div>
		</div>
		<div class="write_area">
			<div class="input">
				<textarea id="" class="txt_area" maxlength="150" placeholder="SNS에 공유 후 댓글을 남겨주세요!"></textarea>
				<button id="replyRegist" class="btn regist sprite">등록하기</button>
			</div>
		</div>
		<div class="view_area">
			<ul id="body_list">
			</ul>
		</div>
		<div class="paging" id="paginate">
		</div>
	</div>
</div>
<!-- //2018-07-04 SNS 공유 댓글 영역 -->
<!-- 딤레이어 : 무조건쏜다 이벤트 공유 2018-07-04 추가 -->
<div class="layer_back" style="display:none" id="popShare">
	<div class="noteLayer popshare">
		<div class="inner">
			<h3 class="tit sprite">친구에게 공유하기!</h3>
			<div class="cont">
				<ul class="list_share">
					<li>
						<a href="javascript:///" class="icon_share icon_fb"><img src="<%=ConfigManager.IMG_ENURI_COM %>/images/event/2017/crazydeal/micon_share_fb.jpg" alt="페이스북 공유하기" /></a>
					</li>
					<li>
						<a href="javascript:///" id = "kakao-link-btn2" class="icon_share icon_kt"><img src="<%=ConfigManager.IMG_ENURI_COM %>/images/event/2017/crazydeal/micon_share_kt.jpg" alt="카카오톡 공유하기" /></a>
					</li>
					<li>
						<a href="javascript:///" class="icon_share icon_uc"  data-clipboard-text = "http://m.enuri.com/mobilefirst/evt/mobile_deal.jsp?flow=share"><img src="<%=ConfigManager.IMG_ENURI_COM %>/images/event/2017/crazydeal/micon_share_uc.jpg" alt="URL 복사" /></a>
					</li>
				</ul>
				<div class="btn_area">
					<a class="btn sprite" href="javascript:///" onclick="$('#popShare').hide();">닫기</a>
				</div>
			</div>
			<!-- //popup_box -->

			<a href="javascript:///" class="btn_close sprite" onclick="$('#popShare').hide();">창닫기</a>
		</div>
	</div>
</div>

<script src="/mobilefirst/js/lib/clipboard.min.js"></script>
<script type="text/javascript" src="/common/js/paging_crazydeal.js"></script>
<script type="text/javascript">

var PAGENO = 1;
var PAGESIZE = 5;
var BLOCKSIZE = 5;
var totalcnt = 0;


// 이벤트 api 호출
shareEvtCall({procCode:1, sdt : <%=sdt%>},function(data){

	var jsonData = data;
	if(!jsonData.GD_MODEL_NM) {
		$("#con2, .boardWrap").hide();
		return false;
	}
	//댓글 api
	getEventList(PAGENO, PAGESIZE);

	var _html = "<div class=\"s_img\">";
	_html += "	<span class=\"s_numb sprite\"><span class=\"blind\">선착순</span><em>"+ jsonData.GD_CNT +"</em></span>";
	_html += "	<img src=\"http://storage.enuri.gscdn.com/Web_Storage"+ jsonData.GD_IMG_URL+"\" alt=\"상품이미지\" />";
	_html += "</div>";
	_html += "<div class=\"s_info\">";
	_html += "	<p class=\"model_name\">"+ jsonData.GD_MODEL_NM +"</p>";
	_html += "	<div class=\"model_price\">";
	_html += "		<span class=\"per\"><em>"+ jsonData.GD_DC_RT +"</em>%</span>";
	_html += "		<span class=\"price\"><em>"+ commaNum(jsonData.GD_DC_PRC) +"</em>원</span>";
	_html += "		<span class=\"strike\"><em>"+ commaNum(jsonData.GD_PRC) +"</em>원</span>";
	_html += "	</div>";
	_html += "</div>";

	var _przHtml = "<span class=\"tit_info sprite\"><em>"+ jsonData.PZWR_CNT +"명</em></span>";
	_przHtml += "<span class=\"img_info\"><img src=\"http://storage.enuri.gscdn.com/Web_Storage"+ jsonData.PRIZE_IMG_URL +"\" alt=\"상품이미지\" /></span>";
	_przHtml += "<p class=\"txt_info\">"+ jsonData.PRIZE_NM1 +"<br>"+ jsonData.PRIZE_NM2 +"</p>";
	_przHtml += "<p class=\"blind\">※ 경품은 e머니로 지급됩니다.</p>";

	$("#ssonda_con").html(_html);
	$("#box_info").html(_przHtml);
	$("a.btn_viewp.sprite").click(function(e){
		dealGA("신규딜 상품보기");
		adClickGa();
		window.open("/mobilefirst/detail.jsp?modelno=" + data.GD_MODEL_NO);
	});
	var shareUrl = "http://" + location.host + "/mobilefirst/evt/mobile_deal.jsp?flow=share";

	// 페이스북, 카카오톡 공유
	$(".list_share li").click(function(){
		var idx = $(this).index();
		switch(idx) {
			case 0 :
				window.open("http://www.facebook.com/sharer.php?u=" + shareUrl);
				shareInsert(idx+1);
				break;
			case 1 :
				try{
					Kakao.Link.createDefaultButton({
						container: '#kakao-link-btn2',
						objectType: 'feed',
						content: {
							title: jsonData.SHARE_TL + "\n" + jsonData.SHARE_DS,
							imageUrl: "http://storage.enuri.gscdn.com/Web_Storage"+ jsonData.GD_IMG_URL,
							link: {
								mobileWebUrl: shareUrl,
								webUrl: shareUrl
							}
						},
						buttons: [
							{
								title: '에누리 가격비교 열기',
								link: {
									mobileWebUrl: shareUrl,
									webUrl: shareUrl
								}
							}
						]
					});
					shareInsert(idx+1);
				}catch(e){
					//alert("카카오 톡이 설치 되지 않았습니다.");
					alert(e.message);
				}
				break;
		}
	});

	//url 복사
	var clipboard = new ClipboardJS('.icon_share.icon_uc');
	clipboard.on('success', function(e) {
		alert("복사가 완료되었습니다!");
		 shareInsert(3);
 	}).on('error', function(e) {
		prompt("아래의 URL을 길게 누르면 복사할 수 있습니다.", shareUrl);
		shareInsert(3);
 	});

	//댓글등록
	$("#replyRegist").click(function(e){
		adClickGa();
	    var replyMsg = $(".txt_area").val();
	    if(replyMsg == "") {
	    	alert("내용을 입력해주세요!");
	    	return false;
	    }
		shareEvtCall({procCode:4, replyMsg : replyMsg, osType : getOsType()}, function(data){
			if (data.result == true) {
        		getEventList(1, PAGESIZE);
        		alert("등록되었습니다!");
        		$(".txt_area").val("");
			}else if (data.result == -5) {
        		var r = confirm("본인인증이 되지 않은 SNS 회원은\n이벤트 참여가 불가합니다.\n본인인증 화면으로 이동할까요?");
				if(r){
					location.href = "/mobilefirst/member/myAuth.jsp?cmdType=&f=m";
				}
			} else {
				alert("오늘은 이미 참여해 주셨습니다! \n내일 또 참여해주세요~");
			}
		});
	});

	//2018-07-04 추가
	$('.ssonda .btn_check').click(function(){
		if ($(this).hasClass("more_on")) {
			$(this).removeClass("more_on");
		} else {
			$(this).addClass("more_on");
		};
		$('.ssonda .moreview').toggle();
		 if($('.ssonda .moreview').is(':visible')) {
			$(this).val('Hide');
		} else {
			$(this).val('Show');
		};
	});
	function shareInsert(param) {
		shareEvtCall({procCode:3, shareType : param , osType : getOsType()}, function(data){});
	}
});
function getEventList(varPageNo, varPageSize) {
	shareEvtCall({procCode:2, sdt : <%=sdt%>, pageno: varPageNo, pagesize : varPageSize},function(data){
		$("#body_list").html(null);
		var json = data.eventlist;

		if(json){
			var template = "";
			for(var i=0;i<json.length;i++){
				if(i==0){
					totalcnt = json[i].totalcnt;
				}
				var reply_date = json[i].reply_date;
				var year = reply_date.substring(0,4);
				var month = reply_date.substring(6,4);
				var day = reply_date.substring(8,6);
				var user_id = json[i].user_id;
				template += "<li>";
				template += "	<p class='user'>" + user_id.substring(0, user_id.length-2) + "** &nbsp;<span class='date'>" + year +"-"+ month +"-"+ day + "</span></p>";
				template += "	<p class='cont'>비밀 댓글입니다.</p>";
				template += "</li>";

			}
			$("#board_cnt").text(totalcnt);
			$("#body_list").html(template);
			$("#txt_area").keyup(function() {
				$("#word_num").text($(this).val().length);
				if ($("#txt_area").val().length >= 50) {
					alert("50자 이상 입력할 수 없습니다.");
					return false;
				}
			});
			if (totalcnt == 0) {
			} else { // get navigation
				// params : nCurrentPage , nRecordSize, nBlockSize, nTotalRecordSize, target, fName
				var paging2 = new paging(varPageNo, varPageSize, BLOCKSIZE, totalcnt, 'paginate','goPage');
			  	paging2.calcPage();
			  	paging2.getPaging();
			}
		}
	});
}
function goPage(pageno) {
	getEventList(pageno, PAGESIZE);
}
function openShareLayer() {
	dealGA('신규딜 공유하기');
	adClickGa();
	if(!islogin()){
		alert("로그인 후 이용 가능합니다.");
		goLogin();
		return false;
	}
	onoff('popShare');
	return false;
}

function shareEvtCall(param, callback) {
	if(param.procCode > 2) {
		if(!islogin()){
			alert("로그인 후 이용 가능합니다.");
			goLogin();
			return false;
		}

		if(!isClick) {
	    	return false;
	    }
	    isClick = false;
	}

	$.post("/mobilefirst/evt/ajax/crazydeal_shareEvt_proc.jsp", param, callback, "json")
	.done(function(){
		isClick = true;
	});
}
</script>