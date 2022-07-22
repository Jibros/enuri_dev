<link rel="stylesheet" type="text/css" href="/css/mobile_v2/footer.css">
<%@ include file="/m/include/footer.jsp" %>
<%/* %>
<link rel="stylesheet" type="text/css" href="/mobilefirst/css/footer.css?ver=20190918"/>
    <footer>
        <div class="cominfo_txt" >

            <section>
				<p class="law_tit">법적고지</p>
				<p class="info">㈜써머스플랫폼은 통신판매 정보제공자로서 통신판매의 거래당사자가 아니며, 상품의
				<a>주문/배송</a>/환불에 대한 의무와 책임은 각
				<a>쇼핑몰</a> <%//출석 %>
				(판매자)에게 있습니다.</p>
				<p><strong>㈜써머스플랫폼</strong>
					대표이사 : 김기범<span>|</span>사업자등록번호 : 206-81-18164<br>
					통신판매신고 : 2015-서울중구-1046호<br>
					<span>서울특별시</span><%//구매일반 %>
					<span>중구</span> <%//생일 %>
					<span> 퇴계로 </span>  <%//친구초대 %>
					18(남대문로<span>5가</span>)
					<span onclick="goTest()" >9층</span><br>
					<span>문의</span><%//vip %> : 02-6354-3601<span>|</span>
					<a href="mailto:master@enuri.com">master@enuri.com</a>
				</p>
			</section>
            <ul class="rule">
                <li><a href="javascript:openTermsWrap()" id="agree">이용약관</a></li>
                <li><a href="javascript:openPrivacyWrap()">개인정보처리방침</a></li>
                <li><a href="javascript:openRuleWrap()">법적고지</a></li>
                <li><a href="javascript:goPcEnuri();insertLog('11004')">PC버전</a></li>
            </ul>
        </div>
    </footer>
<!--// 푸터 -->
<script language="javascript">
function goTest(){
	window.location.href = "/mobilefirst/event2020/tmon2020evt.jsp?freetoken=event";
	return false;
}
//법적고지
function openRuleWrap(){
	var nowUrl = document.URL;
	var cssType = "";

	if(nowUrl.indexOf("/mobiledepart/") > -1)		cssType = "mobiledepart";
	else										    cssType = "agreeWrap";
	window.open("/mobilefirst/login/ruleWrap.jsp?cssType="+cssType);
}
//개인정보 취급방침
function openPrivacyWrap(){
	var nowUrl = document.URL;
	var cssType = "";

	if(nowUrl.indexOf("/mobiledepart/") > -1){
		cssType = "mobiledepart";
	}else{
		cssType = "agreeWrap";
	}
	//window.open("/mobilefirst/login/privacyWrapFooter.jsp?cssType="+cssType);
	window.open("/mobilefirst/login/policy.jsp?param=2&freetoken=event");
}
//이용약관
function openTermsWrap(){
	var nowUrl = document.URL;
	var cssType = "";

	if(nowUrl.indexOf("/mobiledepart/") > -1){
		cssType = "mobiledepart";
	}else{
	   cssType = "agreeWrap";
	}
	window.open("/mobilefirst/login/policy.jsp?param=1&freetoken=event");
//	window.open("/mobilefirst/login/termsWrap.jsp?cssType="+cssType);
}
function goPcEnuri(){
    ga('send', 'event', 'mf_footer', 'footer', 'footer_pc');
    location.href = "http://www.enuri.com/Index.jsp?from=mo";
}
function getNowTime(){
   	var today = new Date();
	var dd = today.getDate();
	var mm = today.getMonth()+2; //January is 0!
	var yyyy = today.getFullYear();

	if(dd<10) 	    dd='0'+dd
	if(mm<9){
		mm='0'+mm;
	}
	today = yyyy+''+mm+''+dd;
	//var today = 20200102
	return 	today;
}
</script>
<%*/ %>