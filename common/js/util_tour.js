function only_number() {
	if ((event.keyCode>=48 && event.keyCode<=57) || (event.keyCode>=96 && event.keyCode<=105) || (event.keyCode==9) || (event.keyCode==8) || (event.keyCode==46) || (event.keyCode==37) || (event.keyCode==39)) {

	}
	else {
		event.returnValue=false;
	}
}

//체크박스배열 전체선택, 선택해제 : check = true or false
function checkAll(frmname,boxname,check) {
	var frm = eval("document." + frmname);
    for(i = 0; i < frm.elements.length; ++i) {
		var ele = frm.elements[i];
        if(ele.name == boxname && ele.disabled != true){
			ele.checked = check;
		}
    }
}

// 자동필드이동 사용예 : onKeyUp="return auto_tab(this, 3, event);"
var isNN = (navigator.appName.indexOf("Netscape")!=-1);
function auto_tab(input,len, e) 
{
	var keyCode = (isNN) ? e.which : e.keyCode; 
	var filter = (isNN) ? [0,8,9] : [0,8,9,16,17,18,37,38,39,40,46];
	if(input.value.length >= len && !containsElement(filter,keyCode)) {
		input.value = input.value.slice(0, len);
		input.form[(getIndex(input)+1) % input.form.length].focus();
	}
	function containsElement(arr, ele) 
	{
		var found = false, index = 0;
		while(!found && index < arr.length)
		if(arr[index] == ele)
			found = true;
		else
			index++;
		return found;
	}
	function getIndex(input) 
	{
		var index = -1, i = 0, found = false;
		while (i < input.form.length && index == -1)
		if (input.form[i] == input)index = i;
		else i++;
		return index;
	}
	return true;
}


// 업로드한 이미지 미리보기(IE5.5 이상)
function onErrors(img_id) {
  eval(img_id).style.display = 'none';
}

function onChanges(img_id) {
  var photoimg = event.srcElement.value;
  if(photoimg.indexOf("'") != -1) {
    alert("파일의 이름에 \" ' \" 문자를 사용할 수 없습니다.");
    return;
  }

  eval(img_id).style.display = '';
  eval(img_id).src=photoimg;
}

//selectbox에서 선택한 값 제거하기
function selectboxRemove(f,idx) {
	var fcount = f.length;
	for(var i=idx;i<=fcount-2;i++) {
		f.options[i].text = f.options[i+1].text;
		f.options[i].value = f.options[i+1].value;
	}
	f.length = fcount - 1;
}

//selectbox에 값 추가하기
function selectboxAdd(f,text,value) {
	var fcount = f.length;
	f.length = fcount + 1;
	f.options[fcount].text = text;
	f.options[fcount].value = value;
	f.selectedIndex = fcount;
}

//두개의 selectbox에서 선택한 값 옮기기
function selectboxMove(fromf, tof) {
	var boxLength = fromf.length;
	var selectedIndex;

	for (var i=0; i<boxLength; i++) {
		if (fromf.options[i].selected) selectedIndex = i;
	}

	if (selectedIndex==null) return;

	var text = fromf[selectedIndex].text;
	var value = fromf[selectedIndex].value;

	selectboxRemove(fromf,selectedIndex);
	selectboxAdd(tof,text,value);
}

//개체의 갯수 리턴 : boxCnt('frm','bx')
function boxCnt(fname,ename) {
	var f = eval("document."+fname);
	var bxcount = 0;
	for (i = 0; i < f.elements.length; i++ ) {
		var el = f.elements[i];
		if (el.getAttribute("NAME") == ename) {
			bxcount++;
		}
	}
	return bxcount;
}

//체크 박스가 한개라도 존재할때 체크된 갯수 리턴
function selectboxCheckCnt2(bx) {
	var fcount = bx.length;
	var chcount = 0;
	for(var i=0;i<fcount;i++) {
		if (bx[i].checked) chcount++;
	}
	return chcount;
}

//체크 박스가 한개도 없을수도 있을때 체크된 갯수 리턴 : selectboxCheckCnt('frm','bx')
function selectboxCheckCnt(fname,ename) {
	var f = eval("document."+fname);
	var bx = eval("document."+fname+"."+ename);
	var chcount = 0;
	var bxcount = 0;
	for (i = 0; i < f.elements.length; i++ ) {
		var el = f.elements[i];
		if (el.getAttribute("NAME") == ename) {
			bxcount++;
		}
	}
	if (bxcount==1)	{
		if (bx.checked) {
			chcount = 1;
		}
	}
	if (bxcount > 1) {
		chcount = selectboxCheckCnt2(bx);
	}
	return chcount;
}

//라디오 박스가 한개라도 존재할때 선택된 인덱스 리턴
function selectboxCheckIndex2(bx) {
	var fcount = bx.length;
	var chidx = -1;
	for(var i=0;i<fcount;i++) {
		if (bx[i].checked) {
			chidx = i;
			break;
		}
	}
	return chidx;
}

//라디오 박스가 한개도 없을수도 있을때 선택된 인덱스 리턴 : selectboxCheckIndex(document.frm,document.frm.bx,'bx')
function selectboxCheckIndex(f,bx,ename) {
	var chidx = 0;
	var bxcount = 0;
	for (i = 0; i < f.elements.length; i++ ) {
		var el = f.elements[i];
		if (el.getAttribute("NAME") == ename) {
			bxcount++;
		}
	}
	if (bxcount==1)	{
		if (bx.checked) {
			chidx = 0;
		} else {
			chidx = -1;
		}
	}
	if (bxcount > 1) {
		chidx = selectboxCheckIndex2(bx);
	}
	return chidx;
}

function getCookie(name) {
	var nameOfCookie = name + "=";
	var x = 0;
	while ( x <= document.cookie.length ) {
		var y = (x+nameOfCookie.length);
		if ( document.cookie.substring( x, y ) == nameOfCookie ) {
			if ( (endOfCookie=document.cookie.indexOf( ";", y )) == -1 )
				endOfCookie = document.cookie.length;
			return unescape( document.cookie.substring( y, endOfCookie ) );
		}
		x = document.cookie.indexOf( " ", x ) + 1;
		if ( x == 0 )
			break;
	}
	return "";
}


function ReadCookie(name){	// 쿠키 기능을 정의 하는 자바입니다.
	var label = name + "=" ;
	var labelLen = label.length ;
	var cLen = document.cookie.length
	var i = 0
	while (i < cLen){
		var j = i + labelLen
		if (document.cookie.substring(i,j) == label) {
			var cEnd = document.cookie.indexOf(";",j)
			if (cEnd == -1){
				cEnd = document.cookie.length
			}
			return unescape(document.cookie.substring(j,cEnd))
		}
	i++
	}
	return ""
}

function clearCookie(name){
	var today=new Date();
	today.setTime(today.getTime() - 1);
	var cval=ReadCookie(name);
	document.cookie=name + "= " + cval + "; expires=" + today.toGMTString();
} 

function setCookie (name, value, expiredays) { 
   var todayDate = new Date (); 
   todayDate.setDate (todayDate.getDate () + expiredays); 
   document.cookie = name + "=" + escape (value) + "; path=/; expires=" + todayDate.toGMTString () + ";" 
} 