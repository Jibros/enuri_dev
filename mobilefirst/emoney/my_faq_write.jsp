<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%

	String cUserId = cb.GetCookie("MEM_INFO","USER_ID");
	String cUserNick = cb.GetCookie("MEM_INFO","USER_NICK");
	String match = "[^\uAC00-\uD7A3xfe0-9a-zA-Z\\s]";

	cUserId = cUserId.replaceAll(match, "").trim();
	Cookie[] carr = request.getCookies();
	String strAppyn = "";
	String strVerios = "";
	String strVerand = "";
	String strAd_id = "";
	int intVerios = 0;
	int intVerand = 0;

	try {
		for(int i=0;i<carr.length;i++){
		    if(carr[i].getName().equals("appYN")){
		    	strAppyn = carr[i].getValue();
		    	break;
		    }
		}
		for(int i=0;i<carr.length;i++){
		    if(carr[i].getName().equals("verand")){
		    	strVerand = carr[i].getValue();
		    	break;
		    }
		}
		for(int i=0;i<carr.length;i++){
		    if(carr[i].getName().equals("verios")){
		    	strVerios = carr[i].getValue();
		    	break;
		    }
		}
		for(int i=0;i<carr.length;i++){
		    if(carr[i].getName().equals("adid")){
		    	strAd_id = carr[i].getValue();
		    	break;
		    }
		}
	} catch(Exception e) {
	}

	if(!strVerand.equals("")){
		intVerand = Integer.parseInt(strVerand.replace(".",""));
	}

	String szRemoteHost = request.getRemoteHost().trim();
	if(!strAppyn.equals("Y") && szRemoteHost.indexOf("58.234.199.")<0){
		//response.sendRedirect("/mobilefirst/Index.jsp");
	}
%>

<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no" />
	<meta property="og:title" content="에누리 가격비교">
	<meta property="og:description" content="에누리 모바일 가격비교">
	<meta property="og:image" content="<%=ConfigManager.IMG_ENURI_COM%>/images/mobilefirst/images/logo_enuri.png">
	<meta name="format-detection" content="telephone=no" />
	<link rel="stylesheet" type="text/css" href="/css/swiper.css"/>
	<link rel="stylesheet" type="text/css" href="/css/mobile_v2/common.css"/>
	<link rel="stylesheet" type="text/css" href="/css/mobile_v2/cs.css"/>
	<script type="text/javascript" src="/mobilefirst/js/lib/jquery-2.1.3.min.js"></script>
	<script type="text/javascript" src="/js/swiper.min.js"></script>
	<script type="text/javascript" src="/mobilefirst/js/utils.js"></script>
	<script>
     (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
           (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
          m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
          })(window,document,'script','//www.google-analytics.com/analytics.js','ga');
           //런칭할때 UA-52658695-3 으로 변경
           ga('create', 'UA-52658695-3', 'auto');
     </script>
</head>
<body>
<!-- start -->
<div id="wrap">
	<form name="faq_write" id="faq_write" action="my_faq_write_proc.jsp" method="post" onSubmit="return false;" enctype="multipart/form-data">
		<fieldset>
			<input type='hidden' name="userid" value="<%=cb.GetCookie("MEM_INFO", "USER_ID")%>">
			<input type='hidden' name="orddate">
			<input type='hidden' name="sel_type" value="2">
			<input type='hidden' name="kind" value="8">
			<input type='hidden' name="title">
			<header id="header" class="page_header" style="display:none;">
				<div class="header_top">
					<div class="wrap">
						<button class="btn__sr_back comm__sprite2"><i class="icon_arrow_back comm__sprite2">뒤로</i></button>
						<div class="header_top_page_name">문의 하기</div>
					</div>
				</div>
			</header>
		    <!-- // 헤더 -->

			<section id="container">

		        <div class="my__cont_sub my__cs_cnt">

		            <!-- 문의내역 - 글쓰기 -->
		            <div class="write_wrap">
		                <fieldset class="write_form">
		                    <legend class="blind">문의내역 - 글쓰기</legend>
		                    <!--
		                        반드시 입력받아야 하는 값은 .write_inp_row.isRequired 클래스를 붙여주세요
		                        input / select / textarea의 값이 입력되면 부모 .write_inp_row에 .written 클래스를 붙여주세요.
		                        반대로 비워지면 written 클래스 제거해주세요.
		                        입력영역의 타이틀과 placeholder를 겸하는 영역은 .write_inp_row의 css pusdo클래스로 입력되어 있으니 class명은 변경하시면 안됩니다.
		                    -->
		                    <!-- 제목작성 -->
		                    <div class="write_inp_row row_title isRequired">
		                        <input type="text" id="faq_title" maxlength="101">
		                    </div>
		                    <!-- 문의유형 -->
		                    <div class="write_inp_row row_type isRequired">
		                        <select id="sel_type">
		                            <option></option>
		                            <option value="1">일반서비스</option>
		                            <option value="2">구매 후 e머니 적립</option>
		                            <option value="3">이벤트 e머니 적립</option>
		                            <option value="4">쿠폰 문의</option>
		                            <option value="5">기타 문의</option>
		                        </select>
		                        <i class="ico_select"></i>
		                    </div>
		                    <!-- 확장 : 문의유형(sel_type) vaule가  2, 3일때 -->
		                    <div class="write_inp_row_extend">
		                        <span class="extend_tit">적립내역 확인을 위해 필요한 항목입니다.</span>
		                        <div class="write_inp_group">
		                            <!-- 구매년도 -->
		                            <div class="write_inp_row row_date row_date_y">
		                                <select name="sel_date_y" id="sel_date_y">
		                                </select>
		                                <i class="ico_select"></i>
		                            </div>
		                            <!-- 구매월 -->
		                            <div class="write_inp_row row_date row_date_m">
		                                <select name="sel_date_m" id="sel_date_m">
		                                </select>
		                                <i class="ico_select"></i>
		                            </div>
		                            <!-- 구매일 -->
		                            <div class="write_inp_row row_date row_date_d">
		                                <select name="sel_date_d" id="sel_date_d">
		                                </select>
		                                <i class="ico_select"></i>
		                            </div>
		                        </div>
		                        <!-- 쇼핑몰 이름-->
		                        <div class="write_inp_row row_mall">
		                            <input type="text" id='faq_ord_shop_name' name="shopname">
		                        </div>
		                        <!-- 주문번호-->
		                        <div class="write_inp_row row_ordernum">
		                            <input type="text" id='faq_ord_id' name="ordid">
		                        </div>
		                        <!-- 상품번호-->
		                        <div class="write_inp_row row_goodsnum">
		                            <input type="text" id='faq_ord_goods_code' name="goodscode">
		                        </div>
		                    </div>
		                    <!-- // -->
		                    <!-- 내용입력 -->
		                    <div class="write_inp_row row_comm isRequired">
		                        <textarea id="faq_content" name="content" rows="5"></textarea>
		                    </div>
		                    <!-- 이미지 등록 -->
		                    <div class="write_inp_row row_image">
		                        <% if(strAppyn.equals("Y") && strVerios.equals("") && intVerand >= 330){ %>
									<input type="text" class="upload_image" id="faq_file1_app" name="faq_file1_app" value="이미지 선택(5MB이하)" readonly onclick="appfileclick();"/>
			                        <label for="faq_file1_app">등록하기</label>
								<% }else{ %>
			                        <input class="upload_image" value="이미지 선택(5MB이하)" disabled="disabled">
									<input type="file" class="upload_image_hidden" id="faq_file1" name="faq_file1" accept="image/*" onchange="file_up();"/>
			                        <label for="faq_file1">등록하기</label>
								<% } %>
		                    </div>
		                    <!-- 전화번호 -->
		                    <div class="write_inp_row row_tel">
		                        <input type="tel" maxlength="11" id="faq_tel" name="tel">
		                        <script>
		                            $(function(){//전화번호 숫자만 입력
		                                $(".row_tel input[type='tel']").keyup(function(event){
		                                    var inputVal = $(this).val();
		                                    $(this).val(inputVal.replace(/[^0-9]/gi,''));

		                                });
		                            })
		                        </script>
		                    </div>
		                    <!-- 버튼 -->
		                    <div class="button_row">
		                        <button class="btn_cancel" id="removeBtn">취소</button>
		                        <button class="btn_confirm" id="submitBtn">문의하기</button>
		                    </div>
		                </fieldset>

		                <script>
		                    $(function(){ //
		                        var $inpRow = $(".write_inp_row input, .write_inp_row select, .write_inp_row textarea"); // 제목, 내용 등 입력
		                        var $btnWrite = $(".button_row .btn_confirm"); // 문의하기 버튼
		                        var $btnCancel = $(".button_row .btn_cancel"); // 취소 버튼

		                        $inpRow.on("change keyup paste",function(e){
		                            var $parent = $(this).closest('.write_inp_row');
		                            if ( $(this).prop("tagName") == 'INPUT' || $(this).prop("tagName") == 'TEXTAREA' ){
		                                $(this).val().length ? $parent.addClass('written') : $parent.removeClass('written') // 작성완료 여부 체크
		                                $parent.removeClass("error");
		                            }else if ( $(this).prop("tagName") == 'SELECT' ){
		                                var _value = parseInt($(this).val(),10);
		                                _value ? $parent.addClass('written') : $parent.removeClass('written'); // 작성완료 여부 체크
		                                ( _value == 2 || _value == 3 ) ? $parent.addClass("extend") :  $parent.removeClass("extend"); // 문의유형 2,3일때 추가입력 영역 확장
		                                $parent.removeClass("error");
		                            }
		                        })

		                        $btnCancel.click(function(){ //취소하기
		                            var cf = confirm('입력한 내용을 취소하고 전페이지로 돌아갑니다.');
		                            if ( cf ){
			                            if(vApp != 'Y' ){	// 웹에서 호출
			                    			history.back(-1);
			                    		}else{
			                    			// 앱에서 호출
			                    			if(window.android){		// 안드로이드
			                    				window.location.href = "close://";
			                    			}else{					// 아이폰에서 호출
			                    				window.location.href = "close://";
			                    			}
			                    		}
		                            }
		                        })

		                        $btnWrite.on("click",function(){ // 문의하기
		                            var _check = true;
		                            $inpRow.each(function(e){
		                                var $parent = $(this).closest('.write_inp_row');
		                                if ( $parent.hasClass("isRequired") ){
		                                    if ( $(this).prop("tagName") == 'INPUT' || $(this).prop("tagName") == 'TEXTAREA' ){
		                                        if ( !$.trim($(this).val()).length ){
		                                            $parent.addClass("error");
		                                            _check = false;
		                                        }
		                                    }else if ( $(this).prop("tagName") == 'SELECT' ){
		                                        if ( !$parent.hasClass("written") ){
		                                            $parent.addClass("error");
		                                            _check = false;
		                                        }
		                                    }
		                                }
		                            })
		                        })
		                    })
		                </script>
		            </div>

				</div>

				<%@ include file="/my/include/m_appDownload.jsp"%>
			</section>
			<%@ include file="/my/include/m_footer.jsp"%>
		</fieldset>
	</form>
</div>

<!-- end -->
<script type="text/javascript">
var vTitle = "문의하기";
var vApp = "<%=strAppyn%>";
if(vApp != "Y") $('#header').show();

//title생성
try{
	window.android.getEmoneyTitle(vTitle);
}catch(e){}

$(function(){
	setYearMonthDay();
	$("#removeBtn").click(function(){
		event.preventDefault();

		$("form").each(function() {
            this.reset();
         });
	});

	$("#submitBtn").click(function(){
		event.preventDefault();

		frmsubmit();
	});

	//헤더 뒤로가기
	$("#header .btn__sr_back").click(function(){
		if(vApp != 'Y' ){	// 웹에서 호출
			history.back(-1);
		}else{
			// 앱에서 호출
			if(window.android){		// 안드로이드
				window.location.href = "close://";
			}else{					// 아이폰에서 호출
				window.location.href = "close://";
			}
		}
	});
});
function setYearMonthDay(){
	var date = new Date();
	var year = date.getFullYear();
	var month = date.getMonth()+1;

	var html ="<option></option>";
	for(var i=2015;i<year+1;i++){
		html +="<option value="+i+">"+i+"</option>";
	}
	$("#sel_date_y").html(html);

	var html ="<option></option>";
	for(var i=1;i<13;i++){
		html +="<option value="+i+">"+i+"</option>";
	}
	$("#sel_date_m").html(html);
	$("#sel_date_m").change(function(){
		var year = $("#sel_date_y").val();
		var month = $("#sel_date_m").val();
		setDay(year,month);
	});
}
function setDay(year,month){
	var html ="<option></option>";

	var days = 32 - new Date(year, month-1, 32).getDate();
	for(var i=1;i<days+1;i++){
		html +="<option value="+i+">"+i+"</option>";
	}
	$("#sel_date_d").html(html);
}
function file_up(){
	var x = document.getElementById("faq_file1");
	var txt = "";
	var thumbext = x.value;
	thumbext = thumbext.slice(thumbext.lastIndexOf(".") + 1).toLowerCase();
	if(thumbext != "jpg" && thumbext != "png" &&  thumbext != "gif" &&  thumbext != "bmp" &&  thumbext != "jpeg"){
		alert('이미지 파일(jpg, png, gif, bmp, jpeg)만 등록 가능합니다.');
		return false;
	}else{
		if ('files' in x) {
			for (var i = 0; i < x.files.length; i++) {
				var file = x.files[i];
				if ('name' in file) {
					txt += file.name + " ";
				}
				if ('size' in file) {
					if(file.size >= 5242880){
						alert('이미지 등록은 5메가 이하만 가능합니다.');
						return false;
					}else{
						setFileName();
					}
				}
			}
		}
	}
}

function frmsubmit(){
	var f = document.faq_write;
	var year = f.sel_date_y.value;
	var month = f.sel_date_m.value;
	var day = f.sel_date_d.value;

	if(month < 10){
		month = "0" + month;
	}
	if(day < 10) {
		day = "0" + day;
	}

	var orddate = year + month + day;

	if(f.faq_title.value == ""){
		alert("제목을 입력해주세요.");
		return false;
	}

	var target = document.getElementById("sel_type");

	if(target.options[target.selectedIndex].value == 0){
		alert("문의유형을 선택해주세요.");
		return false;
	}

	if(f.faq_content.value == ""){
		alert("내용을 입력하세요.");
		return false;
	}

	f.title.value = "["+target.options[target.selectedIndex].text+"] "+f.faq_title.value;
	f.orddate.value = orddate;

	if(f.faq_tel.value != ""){
		if(!jQuery.isNumeric(f.faq_tel.value)){
			alert("숫자만 입력해 주세요.");
			return false;
		}
	}

	if (confirm("작성하신 내용을 등록 하시겠습니까?") == true){
		f.submit();
	}else{
	   return false;
	}
}
function telchk(){
	var g_tel = $("#faq_tel").val();
	var regTel=	/^(02.{0}|^01.{1}|[0-9]{3})([0-9]+)([0-9]{4})$/;
	var regTel2 = /([0-9]{4})([0-9]{4})/;
	var regTel3=/^(02.{0}|^01.{1}|[0-9]{3})-?([0-9]+)-?([0-9]{4})$/;
	var r_tel2 = g_tel.replace(regTel2, "$1-$2");
	var r_tel = g_tel.replace(regTel,"$1-$2-$3");
	regTel.test(g_tel);


	if($.isNumeric(g_tel)){

		if(g_tel.length == 11  || g_tel.length == 10) $("#faq_tel").val(r_tel);
		else if(g_tel.length == 8) $("#faq_tel").val(r_tel2);
		else {
			alert("전화번호를 올바르게 입력해 주세요");
			$("#faq_tel").val("");
		}
	}
	else if(g_tel=="") return;
	else if(regTel3.test(g_tel)) $("#faq_tel").val(r_tel);
	else{
			alert("전화번호를 올바르게 입력해 주세요");
			$("#faq_tel").val("");
	}
	//$("#g_tel").css("border","1px solid red");
}
function appfileclick(){
	/**
     * 고객문의에서 이미지 파일 올리기 버튼 클릭시 호출되는 javascript
     * web->app
     */
	if(window.android){
		window.android.callAndroidImageLoader();
	}
}

function sendAndroidImageFileName(strRename, strReq_file){
    /**
	    * 앱에서 ftp에 올린 파일명을 페이지에 자바스크립트로 세팅한다
	    * app->web
    */
	$("#faq_file1_app").val(strRename);
}

//이미지 등록 시 파일명 가져오기
function setFileName(){
	var fileTarget = $('.row_image .upload_image_hidden');
    fileTarget.on('change', function () {
        if (window.FileReader) {
            var filename = $(this)[0].files[0].name;
        } else {
            var filename = $(this).val().split('/').pop().split('\\').pop();
        }
        $(this).siblings('.upload_image').val(filename);
    });
}
</script>
</body>
</html>