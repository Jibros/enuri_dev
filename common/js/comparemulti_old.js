var viewtab = 1; //화면 노출상태 (1:가격비교, 2:큰사진)
var ieversion = 0;
var cmp_url = "http://www.enuri.com/view/Comparemulti.jsp?chkNo="+chkNo;
var shar_obj = [];

if (/MSIE (\d+\.\d+);/.test(navigator.userAgent)) {
	ieversion = new Number(RegExp.$1);
	var trident = navigator.userAgent.match(/Trident\/(\d.\d)/i);
	if(ieversion==7 && trident != null && trident[1] == "6.0"){ //ie10에서 호환성보기
		ieversion = 10;
	}
}
var IS_VISTA=0;
if(navigator.appName == "Microsoft Internet Explorer") {
	var Agent = navigator.userAgent
	Agent = Agent.toLowerCase();
	if(Agent.indexOf("nt 6.")>0 || Agent=="mozilla/4.0 (compatible; msie 6.0)") {
		IS_VISTA=1;
	}
}
self.moveTo(0,0);
function resizeWinByUnit(){
	var selfW = window.screen.width;
	var selfH = screen.availHeight;
	var tW = 80+25; //총 넓이
	if(viewtab==1){ //가격비교보기
		tW = 293*compareCnt + tW;
	}else{ //큰사진
		for(i=1; i<=compareMaxCnt; i++){
			if(document.getElementById("cpm_bigimg_"+i)){
				tW += $("cpm_bigimg_"+i).getWidth();
				tW += 5;
			}
		}
	}
	if(selfW > tW){
		selfW = tW;
	}
	if (IS_VISTA == 1 ){
		selfW = selfW + 10;
	}
	selfW = selfW + 5;
	self.resizeTo(selfW, selfH);
}
resizeWinByUnit();

function init(){
	insertLog(5300);
	setTimeout("setBodyHeight()",1000);

	// 비교창의 개수가 4개 이상일 경우 로그 넣음
	try {
		if(chkNo.indexOf("P:")>-1) {
			insertLog(10250);
		}
		/*
		var chkNoAry = chkNo.split(",");
		for(var i=0; i<chkNoAry.length; i++) {
			if(chkNoAry[i].indexOf("P:")>-1) {
				insertLog(10250);
			}
		}
		*/
	} catch(e) {}
}
function loadSimpleView(obj,idx){
	var varFrmSimpleViewDoc = obj.contentWindow;
	varFrmSimpleViewDoc.document.body.setAttribute("bgcolor", "#d9d9d9");
	if(varFrmSimpleViewDoc.document.getElementById("menu1")){
		varFrmSimpleViewDoc.document.getElementById("menu1").onclick = function(){
			for(j=1; j<=compareMaxCnt; j++){
				if(j!=idx && document.getElementById("frmSimpleView_"+j)){
					document.getElementById("frmSimpleView_"+j).contentWindow.menuSelectNum(1);
				}
			}
		}
	}
	if(varFrmSimpleViewDoc.document.getElementById("menu11")){
		varFrmSimpleViewDoc.document.getElementById("menu11").onclick = function(){
			for(j=1; j<=compareMaxCnt; j++){
				if(j!=idx && document.getElementById("frmSimpleView_"+j)){
					document.getElementById("frmSimpleView_"+j).contentWindow.menuSelectNum(1);
				}
			}
		}
	}
	if(varFrmSimpleViewDoc.document.getElementById("menu2")){
		varFrmSimpleViewDoc.document.getElementById("menu2").onclick = function(){
			for(j=1; j<=compareMaxCnt; j++){
				if(j!=idx && document.getElementById("frmSimpleView_"+j)){
					document.getElementById("frmSimpleView_"+j).contentWindow.menuSelectNum(2);
				}
			}
		}
	}
	if(varFrmSimpleViewDoc.document.getElementById("menu3")){
		varFrmSimpleViewDoc.document.getElementById("menu3").onclick = function(){
			for(j=1; j<=compareMaxCnt; j++){
				if(j!=idx && document.getElementById("frmSimpleView_"+j)){
					document.getElementById("frmSimpleView_"+j).contentWindow.menuSelectNum(3);
				}
			}
		}
	}
	/*
var OSName = "Unknown";
if (window.navigator.userAgent.indexOf("Windows NT 6.2") != -1) OSName="Windows 8";
if (window.navigator.userAgent.indexOf("Windows NT 6.1") != -1) OSName="Windows 7";
if (window.navigator.userAgent.indexOf("Windows NT 6.0") != -1) OSName="Windows Vista";
if (window.navigator.userAgent.indexOf("Windows NT 5.1") != -1) OSName="Windows XP";
if (window.navigator.userAgent.indexOf("Windows NT 5.0") != -1) OSName="Windows 2000";
if (window.navigator.userAgent.indexOf("Mac")!=-1) OSName="Mac/iOS";
if (window.navigator.userAgent.indexOf("X11")!=-1) OSName="UNIX";
if (window.navigator.userAgent.indexOf("Linux")!=-1) OSName="Linux";
	 */
	var IsWin8 = false;
	if (window.navigator.userAgent.indexOf("NT 6.2")>0 || window.navigator.userAgent.indexOf("NT 6.3")>0) IsWin8 = true;

	//if(compareCnt>2 || ieversion>=10){
	if(compareCnt>2 || IsWin8){
		varFrmSimpleViewDoc.$("#defaultInfo .closeBtn").removeClass("comp_1");
		varFrmSimpleViewDoc.document.getElementById("defaultInfo").getElementsByTagName("span")[0].onclick = function(){
			if(compareCnt<=1){
				window.close();
			}else{
				var varModelNo = varFrmSimpleViewDoc.orgModelno;
				//닫은 모델정보는 모델번호 나열에서 제거
				chkNo = "";
				for(i=0; i<chkNo2.length; i++){
					if(varModelNo==chkNo2[i]){
						chkNo2[i] = "";
					}else{
						if(chkNo!="") chkNo += ",";
						chkNo += chkNo2[i];
					}
				}
				// ,가 여러개 발생하는 요류 생김, 일단 그냥 지움
				for(var c=0; c<20; c++) {
					if(chkNo.indexOf(",,")>-1) {
						chkNo = chkNo.split(",,").join(",");
					} else {
						break;
					}
				}
				cmp_url = "http://www.enuri.com/view/Comparemulti.jsp?chkNo="+chkNo;
				try{
					document.getElementById("cpm_unit_"+idx).removeNode(true);
				}catch(e){
					document.getElementById("cpm_unit_"+idx).parentNode.removeChild(document.getElementById("cpm_unit_"+idx));
				}
				try{
					document.getElementById("cpm_bigimg_"+idx).removeNode(true);
				}catch(e){
					document.getElementById("cpm_bigimg_"+idx).parentNode.removeChild(document.getElementById("cpm_bigimg_"+idx));
				}
				insertLog(2023);
				compareCnt--;
				if(compareCnt<=2 && !IsWin8){
					for(i=1; i<=compareMaxCnt; i++){
						if(document.getElementById("frmSimpleView_"+i)){
							document.getElementById("frmSimpleView_"+i).contentWindow.$("#defaultInfo .closeBtn").addClass("comp_1");
						}
					}
				}
				resizeWinByUnit();
			}
		}
	}
	varFrmSimpleViewDoc.moveMall = function(){
		var varMoveMallObj = varFrmSimpleViewDoc.moveMall.arguments[0][0];
		var varModelNo = varFrmSimpleViewDoc.modelno;
		var varCate = varFrmSimpleViewDoc.strCate;
		var varModelName = varFrmSimpleViewDoc.modelName;
		simpleGotoMall(varMoveMallObj.getAttribute("plno"),varMoveMallObj.getAttribute("shopcode"),varModelNo,varCate,varModelName,varMoveMallObj.getAttribute("price"));
	}
}
function simpleGotoMall(plno,vcode,modelno,cate,modelnm,price){
	if (plno != null && plno != "" && typeof(plno) != "undefined"){
		//===================로그 분석================================================================================
		try{
			_trk_flashEnvView("_TRK_PI=ODR","_TRK_OP="+modelnm+"","_TRK_OA="+price,"_TRK_OE=1");
		} catch (e){}
		var w = window.screen.width;
		var h = screen.availHeight;
		var strMoveTargetUrl = moveUrl;
		var varTargetUrl = strMoveTargetUrl+"?cmd=move_link&from=detail&cmd=move_"+plno+"&vcode="+vcode+"&modelno="+modelno+"&pl_no="+plno+"&cate="+cate;
		var k = window.open("/_pre_detail_.jsp", "_blank");
		k.location.href = varTargetUrl;
		k.focus();
		insertLog(8473);
	}
}
var setBodyHeightTimer = null;
function setBodyHeight(){
	var maxH = 0;
	var unitH = [];
	var clientH = getBodyClientHeight();
	var tmp = "";
	if(viewtab==2){ //큰사진 보기중
		for(i=1; i<=compareMaxCnt; i++){
			if(document.getElementById("cpm_bigimg_"+i)){
				var iH = $("cpm_bigimg_"+i).getHeight();
				unitH[i-1] = iH;
				if(iH>maxH){
					maxH = iH;
				}
				//tmp += " unit" + i + " : "+(unitH[i-1]);
			}
		}
		if(clientH>maxH+10) maxH = clientH-10;
		if(maxH>0){
			for(i=1; i<=compareMaxCnt; i++){
				if(document.getElementById("cpm_bigimg_"+i)){
					document.getElementById("bigimg_"+i).style.height = (maxH-50) + "px";
				}
			}
		}
	}else{ //가격비교보기중
		for(i=1; i<=compareMaxCnt; i++){
			if(document.getElementById("frmSimpleView_"+i)){
				try{
					var iH = document.getElementById("frmSimpleView_"+i).contentWindow.$("body").height()+1;
					unitH[i-1] = iH;
					if(iH>maxH){
						maxH = iH;
					}
				}catch(e){}
			}
		}
		if(clientH>maxH+10) maxH = clientH-10;
		if(maxH>0){
			for(i=1; i<=compareMaxCnt; i++){
				if(document.getElementById("frmSimpleView_"+i)){
					//tmp += " unit" + i + " : "+(unitH[i-1]);
					//tmp += " unit" + i + "` : "+(maxH-unitH[i-1]);
					try{
						if(maxH-unitH[i-1]>0){
							var sH = parseInt(document.getElementById("frmSimpleView_"+i).contentWindow.document.getElementById("scrollView").style.height);
							if(maxH-unitH[i-1]>0){
								document.getElementById("frmSimpleView_"+i).contentWindow.document.getElementById("scrollView").style.height = (sH+maxH-unitH[i-1])+"px";
							}
						}
						document.getElementById("cpm_unit_"+i).style.height = (maxH+5) + "px";
						document.getElementById("frmSimpleView_"+i).style.height = maxH + "px";
					}catch(e){}
				}
			}
		}
	}
	$("tmp").innerHTML = tmp;
	setBodyHeightTimer = setTimeout("setBodyHeight()",1000);
}
function scrollViewHeightInit(){
	for(i=1; i<=compareMaxCnt; i++){
		if(document.getElementById("frmSimpleView_"+i)){
			try{
				document.getElementById("frmSimpleView_"+i).contentWindow.scrollViewHeightInit();
			}catch(e){}
		}
	}
}
function viewBigImg(){
	document.getElementById("btn_bigimg").style.display = "none";
	document.getElementById("btn_detail").style.display = "block";
	for(i=1; i<=compareMaxCnt; i++){
		if(document.getElementById("frmSimpleView_"+i)){
			document.getElementById("cpm_unit_"+i).style.display = "none";
			document.getElementById("cpm_bigimg_"+i).style.display = "block";
		}
	}
	insertLog(2031);
	viewtab = 2;
	resizeWinByUnit();
	closeAllLayer();
}
function viewUnit(){
	document.getElementById("btn_detail").style.display = "none";
	document.getElementById("btn_bigimg").style.display = "block";
	for(i=1; i<=compareMaxCnt; i++){
		if(document.getElementById("frmSimpleView_"+i)){
			document.getElementById("cpm_unit_"+i).style.display = "block";
			document.getElementById("cpm_bigimg_"+i).style.display = "none";
		}
	}
	insertLog(2036);
	viewtab = 1;
	resizeWinByUnit();
	closeAllLayer();
}
function closeAllLayer(){
	if (document.getElementById("compareShare")){
		document.getElementById("compareShare").style.display = "none";
	}
	hideShareMenu();
}
function overImg(obj){
	if(obj.src.indexOf("_ov.gif")<0){
		obj.src = obj.src.replace(".gif", "_ov.gif");
	}
}
function outImg(obj){
	if(obj.src.indexOf("_ov.gif")>0){
		obj.src = obj.src.replace("_ov.gif", ".gif");
	}
}
function openShareMenu(){
	var divLayerLeft = Position.cumulativeOffset($("btn_share"))[0];
	var divLayerTop = Position.cumulativeOffset($("btn_share"))[1];
	if (document.getElementById("compareShare")){
		if (document.getElementById("compareShare").style.display != "block"){
			document.getElementById("compareShare").style.top = (divLayerTop+29+5)+"px";
			document.getElementById("compareShare").style.left = divLayerLeft+"px";
			document.getElementById("compareShare").style.position = "absolute";
			document.getElementById("compareShare").style.display = "block";
		}else{
			document.getElementById("compareShare").style.display = "none";
		}
	}
	if (!document.getElementById("zeroClicp")){
		var sc=document.createElement('script');
		sc.setAttribute('type','text/javascript');
		sc.setAttribute('id','zeroClicp');
		sc.setAttribute('src',''+'/common/js/zeroclipboard/ZeroClipboard_2010.js?'+(new Date()).getMilliseconds+'');
		document.body.appendChild(sc);
	}
	setTimeout(function(){
		var isIE = true;
		if(navigator.userAgent.indexOf("MSIE")<0 && (navigator.userAgent.indexOf("Gecko")>0 || navigator.userAgent.indexOf("Firefox")>0 || navigator.userAgent.indexOf("Netscape")>0)) {
			isIE = false;
		}
		if(!isIE){
			var clipStr = "<a href='"+cmp_url+"' target='_blank'><img src='http://img.enuri.info/images/view/get_info/link_img_120827.gif' align='absmiddle' border='0'></a>";
			initClipBoard('svs_copy_url',cmp_url,"해당 상품비교의 URL이 복사되었습니다.");
			initClipBoard('svs_copy_html',clipStr,"HTML글 작성시 붙여넣으면 링크버튼이 생성됩니다.");
		}
	},500);
}
function hideShareMenu(){
	if(document.getElementById("compareShare")){
		document.getElementById("compareShare").style.display = "none";
		for (var i=0;i<shar_obj.length;i++){
			shar_obj[i].destroy();
		}
	}
}
function initClipBoard(btnid,clipstr,clipalert){
	var clipBoard = new ZeroClipboard.Client();
	//cursor hand type
	clipBoard.setHandCursor( true );
	//swf화일 경로 설정.
	ZeroClipboard.setMoviePath("/common/js/zeroclipboard/ZeroClipboard.swf");
	//버튼 활성화
	clipBoard.glue(btnid);
	//마우스 클릭시에 이벤트 발생. - 저장한다.
	clipBoard.addEventListener('mouseOver', function (client) {
		clipBoard.setText(clipstr);
	});
	//COPY완료시에 발생할 CALLBACK함수.
	clipBoard.addEventListener('complete', function (client) {
		alert(clipalert+"\n원하는 곳에 CTRL + V 를 해주세요!");
	});
	clipBoard.setFixed();
	shar_obj[shar_obj.length] = clipBoard;
}
function shareCmd(param){
	if (param == 1){
		insertLog(2046);
		var bResult = window.clipboardData.setData("Text",cmp_url);
		if (bResult){
			alert("해당 상품비교의 URL이 복사되었습니다.\n원하는 곳에 CTRL + V 를 해주세요!");
		}
	}else if(param == 2){
		insertLog(2047);
		if (window.sidebar){ // 파폭
			window.sidebar.addPanel("에누리▒상품비교", cmp_url, "");
		}else if (document.all){ // IE
			try{
				window.external.AddFavorite(cmp_url, "에누리▒상품비교");
			}catch(e){
				alert("이 브라우저에서는 즐겨찾기를 추가 할수 없습니다.")
			}
		}else if (navigator.appName=="Netscape") { //크롬
			alert("이 브라우저에서는 즐겨찾기를 추가 할수 없습니다.")
		}
	}else if(param == 3){
		insertLog(2045);
		var clipStr = "<a href='"+cmp_url+"' target='_blank'><img src='http://img.enuri.info/images/view/get_info/link_img_120827.gif' align='absmiddle' border='0'></a>";
		var bResult = window.clipboardData.setData("Text",clipStr);
		if (bResult){
			alert("HTML글 작성시 붙여넣으면 링크버튼이 생성됩니다..\n원하는 곳에 CTRL + V 를 해주세요!");
		}
	}
	hideShareMenu();
}
function goCpmSnsLink(type) {
	var content1 = encodeURIComponent("에누리▒상품비교");
	var url1 = encodeURIComponent(cmp_url);
	// 트위터
	if(type==1) {
		insertLog(8775);
		window.open("http://twitter.com/intent/tweet?text="+content1+"&url="+url1, "_new");
	}
	// 페이스북
	if(type==2) {
		insertLog(8776);
		window.open("http://www.facebook.com/sharer.php?u="+url1+"&t="+content1+"");
	}
	// 미투데이
	if(type==3) {
		insertLog(8777);
		window.open("http://me2day.net/posts/new?new_post[body]="+content1+" "+url1);
	}
}
function CmdGotoURL(urltype, cmd, sCode, sName, mNo, mName, mFactory, mPrice, multiFlag, iPlNo, sPlGoodsNm, sUrl, sDelivery, sCoupon){
	var location = "yes";
	var k = "";
	if(urltype!=0){
		location = "no";
	}
	var w = window.screen.width;
	var h = screen.availHeight;
	var varTargetUrl = moveUrl+"?cmd="+cmd+"&vcode="+sCode+"&modelno="+mNo+"&price="+mPrice+"&multiflag="+multiFlag+"&pl_no="+iPlNo+"&factory="+mFactory+"&modelnm="+mName+"&urltype="+urltype+"&coupon="+sCoupon;
	k = window.open (varTargetUrl,"_blank");
	k.focus();
	insertLog(8473);
	return;
}
function adultReload(){
	document.location.reload();
}
//로그인후 호출
function afterLoginLayer(uid, unick){
	try{
		top.opener.top.cmdMyAreaReload();
		top.opener.top.showLoginStatus();
		top.opener.top.cmdAfterLoginKbTop();
	}catch(e){}
}
function cmdAlert(msg){
	alert(msg);
}