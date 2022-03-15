function calculateOffsetLeft(field) {
  return calculateOffset(field, "offsetLeft");
}

function calculateOffsetTop(field) {
  return calculateOffset(field, "offsetTop");
}

function calculateOffset(field, attr) {
  var offset = 0;
  while(field) {
    offset += field[attr]; 
    field = field.offsetParent;
   }
  return offset;
}

//자동완성 찾기 및 이벤트 체크.
function Tom(){
	this.version="1.0";
	this.name = "AutoComplete Tom";
	this.oForm = null;							//검색어 입력 Form객체
	this.sCollection = null; //콜랙션 정보.		//자동완성 해당 콜랙션
	this.oKeyword = null;						//검색키워드 입력 Text객체
	this.sOldkwd = "";							//이전검색어
	this.sNewkwd = "";							//신규검색어
	this.oAc_lyr = null;						//자동완성 전체레이어객체
	this.oAc_ifr = null;						//자동완성처리 프레임객체
	this.oImg_Toggle = null;					//검색키워드 입력 Text객체의 우측 토글이미지객체
	this.sImg_Toggle_on = "http://img.enuri.gscdn.com/images/main_2007/search_arr_off.gif";
	this.sImg_Toggle_off = "http://img.enuri.gscdn.com/images/main_2007/search_arr_on.gif"; 
	this.sSkipWrd = "ㄱㄴㄷㄹㅁㅂㅅㅇㅈㅊㅋㅌㅍㅎ";	//자동완성 skip단어
	this.bSkipTF = false;						//자동완성 skip단어 기능을 사용할지 여부
	this.TimerInterval = 200; 					//자동완성 체크주기1000이 1초
	this.act =0; 								//자동완성 실행중인지 여부 (0:유휴, 1:실행)
	this.sSubmitFunctionName = "";
	this.isExistSkipwrd = function(){
		var ret = false;
		s = arguments[0]; 
		t = arguments[1];
		for(i=0;i<s.length;i++){
			if(t.indexOf(s.substring(i, i+1)) < 0){
				ret = false;
			}else{
				ret = true;
				break;
			}
		}
		return ret;
	};
	
	this.toggle = function(){
		if(this.oAc_ifr!=null){
			obj = getIFrameDocument(this.oAc_ifr.name);
			obj.Jerry_on_off();
		}
	};
	this.find = function(){
		/*
		if(this.sOldkwd == this.oKeyword.value.trim()){
			return;
		}else{
			if(this.act){
				return;
			}else{
				if(this.bSkipTF){
					if(this.isExistSkipwrd(this.oKeyword.value.trim(), this.sSkipWrd)){
						return;
					}
				}
				this.act=1;
				this.sNewkwd = this.oKeyword.value.trim();
				obj = document.frames(this.oAc_ifr.name);
				obj.Jerry_AutoSearch( this);
				this.sOldkwd = this.sNewkwd;
				this.act=0;
			}
		}
		*/
		if(this.act){
			return;
		}else{
			if(this.bSkipTF){
				if(this.isExistSkipwrd(this.oKeyword.value.trim(), this.sSkipWrd)){
					return;
				}
			}
			this.act=1;
			this.sNewkwd = this.oKeyword.value.trim();
			obj = getIFrameDocument(this.oAc_ifr.name);
			obj.Jerry_AutoSearch( this);
			this.sOldkwd = this.sNewkwd;
			this.act=0;
		}		
	};
}

function getIFrameDocument(aID) { 
	// if contentDocument exists, W3C compliant (Mozilla) 
	if (document.getElementById(aID).contentWindow){
		rv = document.getElementById(aID).contentWindow;
	} else { 
		// IE 
		rv = document.frames[aID];
	}
	return rv; 
};