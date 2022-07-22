//검색어 특수 문자 제거
function schKeyword(schWrd){
	var schWord;
	schWord = schWrd;
	$keyword = schWord; 
	schWord = replace2(schWord,"'");
	schWord = replace2(schWord,"\\");
	schWord = replace2(schWord,"^");
	//schWord = replace2(schWord,"&");
	schWord = replace2(schWord,"~");
	schWord = replace2(schWord,"!");
	schWord = replace2(schWord,"@");
	schWord = replace2(schWord,"$");
	schWord = replace2(schWord,"%");
	schWord = replace2(schWord,"*");
	schWord = replace2(schWord,"+");
	schWord = replace2(schWord,"=");
	schWord = replace2(schWord,"{");
	schWord = replace2(schWord,"}");
	schWord = replace2(schWord,"[");
	schWord = replace2(schWord,"]");
	//schWord = replace2(schWord,":");
	schWord = replace2(schWord,";");
	schWord = replace2(schWord,"/");
	schWord = replace2(schWord,"<");
	schWord = replace2(schWord,">");
	schWord = replace2(schWord,",");
	schWord = replace2(schWord,"?");
	schWord = replace2(schWord,"(");
	schWord = replace2(schWord,")");
	schWord = replace2(schWord,"'");
	schWord = replace2(schWord,"_");
	schWord = replace2(schWord,"-");
	schWord = replace2(schWord,"`");
	schWord = replace2(schWord,"|");
    schWord = jQuery.trim(schWord);
    if (schWord == "상품 검색" || schWord == "검색어 입력" ){
    	schWord = "";
    }
	function replace2(src, delWrd){
		var newSrc = "";
		for(var i=0;i<src.length;i++){
			if(src.charAt(i) == delWrd) {
				newSrc = newSrc + " ";
			}else{
				newSrc = newSrc + src.charAt(i);
			}			
		}
		return newSrc;
	}	    
    return schWord;
} 

//콤마 옵션
function commaNum(num) {  
    var len, point, str;  

    num = num + "";  
    point = num.length % 3  
    len = num.length;  

    str = num.substring(0, point);  
    while (point < len) {  
        if (str != "") str += ",";  
        str += num.substring(point, point + 3);  
        point += 3;  
    }  
    return str;  
} 
