String.prototype.trim = function() {
	return this.replace(/(^\s*)|(\s*$)|($\s*)/g, "");
}
String.prototype.isid = function() {
	if (this.search(/[^A-Za-z0-9_-]/) == -1)
		return true;
	else 
		return false;
}
String.prototype.isalpha = function() {
	if (this.search(/[^A-Za-z]/) == -1)
		return true;
	else
		return false;
}
String.prototype.isnumber = function() {
	if (this.search(/[^0-9]/) == -1)
		return true;
	else
		return false;
}
String.prototype.isemail = function() {
	var flag, md, pd, i;
	var str;
	
	if ( (md = this.indexOf("@")) < 0 )
	   return false;
	else if ( md == 0 )
	   return false;
	else if (this.substring(0, md).search(/[^.A-Za-z0-9_-]/) != -1)
	   return false;
	else if ( (pd = this.indexOf(".")) < 0 )
	   return false;
	else if ( (pd + 1 )== this.length || (pd - 1) == md )
	   return false;
	else if (this.substring(md+1, this.length).search(/[^.A-Za-z0-9_-]/) != -1)
	   return false;
	else
	   return true;
}
String.prototype.korlen = function() {
	var temp;
	var set = 0;
	var mycount = 0;
	
	for( k = 0 ; k < this.length ; k++ ){
		temp = this.charAt(k);
		if( escape(temp).length > 4 ) {
			mycount += 2; 
		}
		else mycount++;
	}
	return mycount;
}
String.prototype.isssn = function() {
	var first  = new Array(6);
	var second = new Array(7);
	var total = 0;
	var tmp = 0;
   
	if ( this.length != 13 )
		return false;
	else {
		for ( i = 1 ; i < 7 ; i++ )
			first[i] = this.substring(i - 1, i);
   
		for ( i = 1 ; i < 8 ; i++ )
			second[i] = this.substring(6 + i - 1, i + 6);
   
		for ( i = 1 ; i < 7 ; i++ ) {
			if ( i < 3 )
				tmp = Number( second[i] ) * ( i + 7 );
			else if ( i >= 3 )
				tmp = Number( second[i] ) * ( ( i + 9 ) % 10 );
      
			total = total + Number( first[i] ) * ( i + 1 ) + tmp;
		}
		if ( Number( second[7] ) != ((11 - ( total % 11 ) ) % 10 ) ) 
			return false;
   }
   return true;
}

String.prototype.ByteLength = function() {
	var i,ch;
	var strLength = this.length;
	var count = 0;

	for(i=0;i<strLength;i++)
	{
		ch = escape(this.charAt(i));

		if(ch.length > 4)
			count += 2;
		else if(ch!='\r') 
			count++;
	}
	return count;
}
/**
 * 문자열을 형식화(3자리마다 콤마 삽입)된 식으로 반환합니다.
 */
String.prototype.NumberFormat = function() {
	var str = this.replace(/,/g,"");
	var strLength = str.length;

	if (strLength<=3) return str;
	
    var strOutput = "";
    var mod = 3 - (strLength % 3);
	var i;

    for (i=0; i<strLength; i++) 
	{
		strOutput+=str.charAt(i); 
        if (i < strLength - 1) 
		{
			mod++; 
            if ((mod % 3) == 0) 
			{ 
				strOutput +=","; 
                mod = 0; 
			}
		} 
	} 
	return strOutput;
}

/**
 * 3자리수마다 ","처리 삭제 wookki25 2005-09-21
 */
String.prototype.DeNumberFormat = function() {
	var str = this.replace(/,/g,"");
	return str;
}
String.prototype.isKorean = function() {
	Unicode = this.charCodeAt(0);
	if ( !(44032 <= Unicode && Unicode <= 55203) )
		return false;
	else
		return true;
}
String.prototype.isEnglish = function() {
	if (this.search(/[^A-Za-z]/) == -1)
	   return true;
	else
	   return false;
}
String.prototype.lenH = function() {
   var temp;
   var set = 0;
   var mycount = 0;
      
   for( k = 0 ; k < this.length ; k++ ){
      temp = this.charAt(k);
      
      if( escape(temp).length > 4 ) {
         mycount += 2; 
      }
      else mycount++;
   }

   return mycount;
}
 /**
 *  문자열에서 Byte Len만큼 문자열 잘라온다.
 *  ex) var s = MidH("대한민국만세123ABS",0,10);
 */
function MidH(str, n, len){
	//n : 시작점;
	//len : ByteLength; 
	var ret="";
	var tmp = str.substring(n, str.length);
	var s="";
	var j=0;
	if(tmp.length>0){
		for(i=0; i< tmp.length; i++){
			if(j <= len){
				s = tmp.substring(i,i+1);
				if(s.lenH()==2){
					j = j+2;
				}else{
					j++;
				}
				ret = ret + s;
			}else{
				break;
			}
		}
	}
	return ret;
}
/**
 *  문자열이 존재하는지 체크합니다. (복수 가능)
 *  ex) StrMultiExists(id,"sysadmin","admin"...);
 */
function StrMultiExists(str){
	var i;
	var argCount = arguments.length;
	if (argCount==0) return false;
	var regStr = "";

	for(i=1; i<argCount; i++) {
		regStr+="("+arguments[i].replace(/([\^\\\$\*\+\?\.])/g,"\\$1")+")|";
	}

	if (str.search(eval("/"+regStr.replace(/\|$/g,"")+"/g"))==-1) return false;
	else return true;
}
/**
 *  문자열을 특정 문자열을 나눠 배열형태의 값으로 반환합니다.
 */
function StringTokenizer(str,separator) {
	arrayOfStrings = str.split(separator);
	return arrayOfStrings;
}
/**
 * 올바른 메일형식인지 체크합니다.
 */
function isValidEmail(str) {
	var re=new RegExp("^[_a-z0-9-]+(\.[_a-z0-9-]+)*@[a-z0-9-]+(\.[a-z0-9-]+)*(\.[a-z]{2,3})$","gi");
	if (str.match(re)) return true;
	else return false;
}
/**
 * 올바른 홈페이지형식인지 체크합니다.
 */
function isValidHomepage(str) {
	var re=new RegExp("^((ht|f)tp:\/\/)((([a-z0-9-]+(\.[a-z0-9-]+)*(\.[a-z]{2,3}))|(([0-9]{1,3}\.){3}([0-9]{1,3})))((\/|\\?)[a-z0-9~#%&'_\+=:\?\.-]*)*)$","gi");
	if (str.match(re)) return true;
	else return false;
}
/**
 * 올바른 주민등록번호인지 체크합니다.
 */
function IsResidentRegistrationNumber(str1, str2) {
	if (isNull(str1)) return false;
	if (isNull(str2)) return false;

	var Sum = 0;
	var i, j;

	for (i=0, j=2 ; i<=5 ;i++,j++)
	{
		Sum += parseInt(str1.charAt(i)) * j;
	}

	for (i=0, j=8;i<=5;i++, j++)
	{
		Sum += parseInt(str2.charAt(i)) * j;
		if (j==9) j=1;
	}

	if ((Sum=11-(Sum%11))>9) Sum=Sum%10;

	if (parseInt(str2.charAt(6)) != Sum) return false;
	return true;
}

/**
 * 알파벳만으로 구성된 문자열인지 체크합니다.
 */
function isAlphabet(str) {
	if (str.search(/[^a-zA-Z]/g)==-1) return true;
	else return false;
}

/**
 * 한글로만 구성된 문자열인지 체크합니다.
 */
function isKorean(str) {
	var strLength = str.length;
	var i;
	var Unicode;

	for (i=0;i<strLength;i++) {
		Unicode = str.charCodeAt(i);
		if ( !(44032 <= Unicode && Unicode <= 55203) ) return false;	
	}
	return true;
}

/**
 * 숫자만으로 구성된 문자열인지 체크합니다.
 */
function isDigit(str) {
	if (str.search(/[^0-9]/g)==-1) return true;
	else return false;
}

/**
 * 문자열이 NULL인지 체크합니다.
 */
function isNull(str) {
    if (str == null || str == "") return true;
    else return false;
}

/**
 * 문자열에 한칸이상의 스페이스 입력이 있는지를 체크합니다.
 */
function isValidSpace(str) {
	if (str.search(/[\s]{2,}/g)!=-1) return false;
	else return true;
}
