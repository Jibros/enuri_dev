	var arrayVase = "390|| 6600|| 19100|| 38750|| 67910|| 111440";
	var arrayUse = "57.9||120.2||179.4||267.8||398.7||677.3";
	var BaseRate = arrayVase.split("||");
	var UseRate = arrayUse.split("||");
 
	var varRusult = 0;
	var varRusult_e = 0;
	
	//에어컨
	function sum_on()
	{
		var Result = 0;
		var obj = document.getElementById("elec_1");
		var param = document.getElementById("elec_1").value;
		param = param.split(",").join("");
		
		var kwh; // 전력량
		var basefee; // 기본료
		//var open_chg = document.fee.open_win.options[document.fee.open_win.selectedIndex].value;
		var wind_power;
		if(document.getElementById("watt").value == "입력" ||document.getElementById("elec_1").value == "입력"|| document.getElementById("hour").value == "입력") {
		alert("숫자를 입력해주세요");
		return;
		}
		if (document.getElementById("elec_1").value == "" || document.getElementById("watt").value == ""|| document.getElementById("hour").value == "") {  
			alert("숫자를 입력해주세요");
		}else if (document.getElementById("elec_1").value == "입력하세요" || document.getElementById("watt").value == "입력하세요"|| document.getElementById("hour").value == "입력하세요")  {
			alert("숫자를 입력해주세요");  
		}else{
			if(param <= 7010){
			varRusult = (Number(param) / 1.137 - Number(BaseRate[0])) / Number(UseRate[0]);
		}else if(param <= 21230){
			varRusult = (Number(param) / 1.137 - Number(BaseRate[1])) / Number(UseRate[1]) + 100;
		}else if(param <= 42370){
			varRusult = (Number(param) / 1.137 - Number(BaseRate[2])) / Number(UseRate[2]) + 200;
		}else if(param <= 75270){
			varRusult = (Number(param) / 1.137 - Number(BaseRate[3])) / Number(UseRate[3]) + 300;
		}else if(param <= 124340){
			varRusult = (Number(param) / 1.137 - Number(BaseRate[4])) / Number(UseRate[4]) + 400;
		}else if(param > 124341){
			varRusult = (Number(param) / 1.137 - Number(BaseRate[5])) / Number(UseRate[5]) + 500;
		}

	}
		varRusult = Math.floor(varRusult);
		var watt = document.getElementById("watt").value;
		watt = watt.split(",").join("");
		var ev_open = eval(document.getElementById("hour").value) * 30  * eval(watt) + 1; 	
		varRusult_2 = varRusult + ev_open;
		
		if (document.getElementById("elec_1").value == "" || document.getElementById("watt").value == ""|| document.getElementById("hour").value == "") {  
			alert("숫자를 입력해주세요");
		}else if (document.getElementById("elec_1").value == "입력하세요" || document.getElementById("watt").value == "입력하세요"|| document.getElementById("hour").value == "입력하세요")  {
			alert("숫자를 입력해주세요");  
		}else{
			if(varRusult_2 <= 100){
			varRusult_e = [(Number(varRusult_2) * Number(UseRate[0])) + Number(BaseRate[0])] * 1.137;
		}else if(varRusult_2 <= 200){
			varRusult_e = [(Number(varRusult_2)-100) *  Number(UseRate[1]) + Number(BaseRate[1])] * 1.137;
		}else if(varRusult_2 <= 300){
			varRusult_e = [(Number(varRusult_2)-200)  *  Number(UseRate[2]) + Number(BaseRate[2])] * 1.137;
		}else if(varRusult_2 <= 400){
			varRusult_e = [(Number(varRusult_2)-300)  *  Number(UseRate[3]) + Number(BaseRate[3])] * 1.137;
		}else if(varRusult_2 <= 500){
			varRusult_e = [(Number(varRusult_2)-400)  *  Number(UseRate[4]) + Number(BaseRate[4])] * 1.137;
		}else if(varRusult_2 > 500){
			varRusult_e = [(Number(varRusult_2)-500)  *  Number(UseRate[5]) + Number(BaseRate[5])] * 1.137;
		}
		
			varRusult_e = Math.round(varRusult_e);
			document.getElementById("total").value = set_comma(""+varRusult_e);
			document.getElementById('field_1').style.display = 'none'
			document.getElementById('field_2').style.display = 'inline'
		}
		document.getElementById("elec_1").readOnly = true;
		document.getElementById("watt").readOnly = true;
		document.getElementById("hour").readOnly = true;
		
		textReadonlyFlag = true;
		
	}
	
var textReadonlyFlag = false;	
		function text_none(thisObj) {
		if(!textReadonlyFlag &&thisObj.value=='입력') {
			thisObj.value='';
			thisObj.style.color = "#000000";
			thisObj.style.fontFamily = "맑은고딕";
			thisObj.style.fontWeight = "bold";  
			thisObj.style.fontSize = "13px";  
		}
	}
	
	function text_view(thisObj) {
		if(thisObj.value=='') {
			thisObj.value='입력';
			thisObj.style.color = "#888888";
			thisObj.style.fontFamily = "돋움";
			thisObj.style.fontWeight = "normal";  
			thisObj.style.fontSize = "11px";  
		}
	}
	
	
		
function hanCheck() { 
	//for(i=0;i<x.user_id.value.length;i++) { 
	//	var a=x.user_id.value.charCodeAt(i); 
	//	if (a > 128) { 
	//		alert('한글 입력 금지'); 
	//		x.user_id.value=""; 
	//		x.user_id.focus(); 
	//		return; 
	//	} 
	//}
	e = window.event;
	
	if (e.keyCode == 13) {
		cmdUnitCalculate();
	}

	if( e.keyCode < 48 || e.keyCode > 57){
		if(e.keyCode == 46 ){
		}else{
			e.keyCode=0;
		}
	}
	
} 
function cmdUnitCalculate(){
	
	//var result = document.getElementById("Check_box").value;
	//if(result.length>1 && result.substring(0,1)=="0"){
		//document.getElementById("Check_box").value = result.substring(1);
	//}
	
	
	result = document.getElementById("Check_box").value;
	if(result.length>4){
		document.getElementById("Check_box").value = result.substring(0,4);
	}

	var input;
	var output
	
	input = 0;
	output= 0;

	var bChk = new RegExp(/^[0-9]+\.?[0-9]*$/);
	if(bChk.test(document.getElementById("Check_box").value)){
	}else{	
		if(document.getElementById("Check_box").value=="") {
		document.getElementById("Result_box").value = "";	
		}
		//alert('소수점(.) 1개만 입력이 가능합니다.');
		document.getElementById("Check_box").focus();
		return;
	}
	input = Number(document.getElementById("Check_box").value);

		output = input * 0.3025;
		//alert("output="+output);
	
	document.getElementById("Result_box").innerText = Math.round(output*10)/10;

}

function re_reset() {
document.getElementById("elec_1").value = "";
text_view(document.getElementById("elec_1"));
document.getElementById("watt").value = "";
text_view(document.getElementById("watt"));
document.getElementById("hour").value = "";
text_view(document.getElementById("hour"));
document.getElementById("elec_1").readOnly = false;
document.getElementById("watt").readOnly = false;
document.getElementById("hour").readOnly = false;

textReadonlyFlag = false;

document.getElementById('field_1').style.display = 'inline'
document.getElementById('field_2').style.display = 'none'
document.getElementById("elec_1").focus();
}



function layer_open() {
	if(document.getElementById("elec_air").style.display == "none"){
		document.getElementById("elec_air").style.display = "";
	}else if(document.getElementById("elec_air").style.display == ""){
		document.getElementById("elec_air").style.display = "none";
	}
}


function layer_close() {
document.getElementById("elec_air").style.display = "none";
}


function set_Value(thisObj) {
	var rtnVal = thisObj.value;
	
	rtnVal = rtnVal.split(",").join("");

	rtnVal = set_comma(rtnVal);

	thisObj.value = rtnVal;
}

function set_comma(value) {
/*
	var n = value;
	if(n.length>2) {
		var cnt=0;
		var rtnVal = "";
		for(var i=n.length; i>=0; i--) {
			cnt++;
			if(i<n.length && i>0 && cnt>1 && cnt%3==0) {
				rtnVal = "," + rtnVal;
			}
			rtnVal = n.substring(i-1, i) + rtnVal;
		}
		n = rtnVal;
	}
*/
  var reg = /(^[+-]?\d+)(\d{3})/;
  var n = value;
  while(reg.test(n)) {
   n = n.replace(reg, '$1' + ',' + '$2');
  }

  return n;
}

function CmdGotoPurchaseGuide2(url){
	//var wWidth = 1014;
	/*
	var wWidth = 734+30+6;
	if (typeof(kind)=="number" && kind==20) wWidth = wWidth+35;
	var wHeight = screen.availHeight;
	var win = window.open(url,"GuideLayer","width="+wWidth+",height="+wHeight+",left=0,top=0,toolbar=no,directories=no,status=yes,scrollbars=yes,resizable=no,menubar=no");
	win.focus();
	*/
	 
	/*
	if (window.knowBoxWin == null){
		window.knowBoxWin = window.open(url);
	}else{
		try{
			if(tyopeof(window.knowBoxWin.location.href) != "undefined"){
				window.knowBoxWin.location.href = url;
			}else{
				window.knowBoxWin = window.open(url);
			}
		}catch(e){
			window.knowBoxWin = window.open(url);
		}
	}
	*/
	
	//window.knowBoxWin = window.open(url,"knowBoxWin");
	//window.knowBoxWin.focus();
	var selfH = screen.availHeight ;
	//==============================================================
	//鍮꾩뒪? ?щ? 泥댄겕
	//==============================================================
	var IS_VISTA = "0";
	var vistaWidth = 0;
	if(navigator.appName == "Microsoft Internet Explorer") {
		var Agent = navigator.userAgent
		Agent = Agent.toLowerCase();
		if(Agent.indexOf("nt 6.")>0 || Agent=="mozilla/4.0 (compatible; msie 6.0)") {
			IS_VISTA="1";
			// 鍮꾩뒪??쇨꼍?곕뒗 width瑜?10???뷀븿
			// vistaWidth = 10;
		}
	}
	var strNo = 0;
	strNo = url.lastIndexOf("/knowbox/");
	if(strNo == -1) strNo = 0;
	url = url.substr(strNo,url.length);
	var win = window.open(url,"knowBoxWin","toolbar=yes,location=yes,left=0,top=0,directories=yes,status=yes,scrollbars=yes,resizable=yes,menubar=yes,personalbar=yes");
	try{
		if(IS_VISTA=="1") {
			win.resizeTo(1040, eval(selfH));
		}else {
			win.resizeTo(1030, eval(selfH));
		}
	}catch(e){
	}
	win.focus();
}
var knowBoxWin2 = null;

//에어컨
function Link_num(){
document.location.href="/purchaseguide/pop/Air_pop.jsp","Air_pop", "width=400, top=0, left=0, ,toolbar=no, directories=no, status=yes, scrollbars=yes, resizable=no, menubar=no"
}

//선풍기
function FanLink_num(){
document.location.href="/purchaseguide/pop/Fan_pop.jsp","Fan_pop", "width=400, top=0, left=0, ,toolbar=no, directories=no, status=yes, scrollbars=yes, resizable=no, menubar=no"
}

//가습기
function HumLink_num(){
document.location.href="/purchaseguide/pop/Hum_pop.jsp","Hum_pop", "width=400, top=0, left=0, ,toolbar=no, directories=no, status=yes, scrollbars=yes, resizable=no, menubar=no"
}

//TV
function TVLink_num(){
document.location.href="/purchaseguide/pop/TV_pop.jsp","TV_pop", "width=400, top=0, left=0, ,toolbar=no, directories=no, status=yes, scrollbars=yes, resizable=no, menubar=no"
}

//다리미
function IronLink_num(){
document.location.href="/purchaseguide/pop/Iron_pop.jsp","Iron_pop", "width=400, top=0, left=0, ,toolbar=no, directories=no, status=yes, scrollbars=yes, resizable=no, menubar=no"
}

//전기히터 
function HeaterLink_num(){
document.location.href="/purchaseguide/pop/Heater_pop.jsp","Heater_pop", "width=400, top=0, left=0, ,toolbar=no, directories=no, status=yes, scrollbars=yes, resizable=no, menubar=no"
}

//전기장판
function PadLink_num(){
document.location.href="/purchaseguide/pop/Pad_pop.jsp","Pad_pop", "width=400, top=0, left=0, ,toolbar=no, directories=no, status=yes, scrollbars=yes, resizable=no, menubar=no"
}

//냉장고
function RefriLink_num(){
document.location.href="/purchaseguide/pop/Refri_pop.jsp","Refri_pop", "width=400, top=0, left=0, ,toolbar=no, directories=no, status=yes, scrollbars=yes, resizable=no, menubar=no"
}

//김치냉장고
function KimchiLink_num(){
document.location.href="/purchaseguide/pop/Kimchi_pop.jsp","Kimchi_pop", "width=400, top=0, left=0, ,toolbar=no, directories=no, status=yes, scrollbars=yes, resizable=no, menubar=no"
}

//전자레인지
function RangeiLink_num(){
document.location.href="/purchaseguide/pop/Rangei_pop.jsp","Rangei_pop", "width=400, top=0, left=0, ,toolbar=no, directories=no, status=yes, scrollbars=yes, resizable=no, menubar=no"
}

//전기밥솥
function potLink_num(){
document.location.href="/purchaseguide/pop/Pot_pop.jsp","Pot_pop", "width=400, top=0, left=0, ,toolbar=no, directories=no, status=yes, scrollbars=yes, resizable=no, menubar=no"
}

//음식물처리기
function FoodLink_num(){
document.location.href="/purchaseguide/pop/Food_pop.jsp","Food_pop", "width=400, top=0, left=0, ,toolbar=no, directories=no, status=yes, scrollbars=yes, resizable=no, menubar=no"
}

//전기자전거
function BycLink_num(){
document.location.href="/purchaseguide/pop/BycLink_pop.jsp","BycLink_pop", "width=400, top=0, left=0, ,toolbar=no, directories=no, status=yes, scrollbars=yes, resizable=no, menubar=no"
}


function Link_num1(){
CmdGotoPurchaseGuide2('/knowbox/List.jsp?cate=0501&kbno=220003');
}

