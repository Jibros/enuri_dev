// 맵
CustomMap = function(){
	 this.map = new Object();
	};   
CustomMap.prototype = {   
  put : function(key, value){   
      this.map[key] = value;
  },    
  set : function(key, value){   
      this.map[key] = value;
  },   
  get : function(key){   
      return this.map[key];
  },
  has : function(key){    
   return key in this.map;
  },
  containsKey : function(key){    
   return key in this.map;
  },
  containsValue : function(value){    
   for(var prop in this.map){
    if(this.map[prop] == value) return true;
   }
   return false;
  },
  isEmpty : function(key){    
   return (this.size() == 0);
  },
  clear : function(){   
   for(var prop in this.map){
    delete this.map[prop];
   }
  },
  remove : function(key){    
   delete this.map[key];
  },
  keys : function(){   
      var keys = new Array();   
      for(var prop in this.map){   
          keys.push(prop);
      }   
      return keys;
  },
  values : function(){   
   var values = new Array();   
      for(var prop in this.map){   
       values.push(this.map[prop]);
      }   
      return values;
  },
  size : function(){
    var count = 0;
    for (var prop in this.map) {
      count++;
    }
    return count;
  }
};

//숫자 타입에서 쓸 수 있도록 format() 함수 추가
Number.prototype.format = function(){
    if(this==0) return 0;
 
    var reg = /(^[+-]?\d+)(\d{3})/;
    var n = (this + '');
 
    while (reg.test(n)) n = n.replace(reg, '$1' + ',' + '$2');
 
    return n;
};
 
// 문자열 타입에서 쓸 수 있도록 format() 함수 추가
String.prototype.format = function(){
    var num = parseFloat(this);
    if( isNaN(num) ) return "0";
 
    return num.format();
};

//object를 키 이름으로 정렬하여 반환
function sortObject(o) {
	var sorted = {},
	key, a = [];
	// 키이름을 추출하여 배열에 집어넣음
	for (key in o) {
		if (o.hasOwnProperty(key)) a.push(key);
	}
	// 키이름 배열을 정렬
	a.sort();
	// 정렬된 키이름 배열을 이용하여 object 재구성
	for (key=0; key<a.length; key++) {
		sorted[a[key]] = o[a[key]];
	}
	return sorted;
}

function inputNumberFormat(obj) {
	obj.value = comma(uncomma(obj.value));
}

function comma(str) {
	str = String(str);
	return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
}

function uncomma(str) {
	str = String(str);
	return str.replace(/[^\d]+/g, '');
}

//카드할부 노출 텍스트 변경
//^ 표시 가 있는 경우 포맷 재 조립
//2020.05.27 jinwook
function convertFreeInterest(txt) {
	var retTxt = "";
	retTxt = txt.replaceAll("카드", "");
	// ^ 표기 있는 경우
	if( txt.indexOf("^")>-1) {
		retTxt = retTxt.replace("할부:", "").trim();
		var interestMap = new CustomMap();
		var interestKeyArray = [];
		var arrayCnt = 0;
		var splitTxt = retTxt.split("|");
		for(var i=0;i<splitTxt.length;i++) {
			if(splitTxt[i].indexOf("^")>-1) {
				var splitKeyword = splitTxt[i].split("^");
				var company = splitKeyword[0];
				var range = splitKeyword[1];
				if(interestMap.has(range)) {
					interestMap.set(range, interestMap.get(range)+","+company);
				} else {
					interestMap.set(range, company);
					interestKeyArray[arrayCnt] = range;
					arrayCnt++;
				}
			}
		}
		interestKeyArray.sort();
	
		var formatTxt = "";
		for(var key in interestKeyArray) {
			var keyRange = interestKeyArray[key];
			var keyValue = interestMap.get(keyRange);
			if(key>0) {
				formatTxt += "/";
			}
			formatTxt += keyValue + " 최대 " + keyRange + "개월";
		}
		retTxt = formatTxt;
		
	// 없는 경우
	} else {
		retTxt = txt.replace("할부", "무이자할부");
	}
	
	return retTxt;
}

// 개별로그
function insertLogLSV(logNum, cate, modelno) {
	var url = "/view/Loginsert_2010.jsp"
	var param = "kind="+logNum;
	if(cate && cate.length>0) param += "&cate="+cate;
	if(modelno && modelno.length>0) param += "&modelno="+modelno;
//	else param += "&cate="+gCate;

	$.ajax({
		type: "GET",
		url: url,
		data: param
	});

	//showLogView(logNum);
}

Date.prototype.format = function(f) {
    if (!this.valueOf()) return " ";
    var weekName = ["일요일", "월요일", "화요일", "수요일", "목요일", "금요일", "토요일"];
    var d = this;
    return f.replace(/(yyyy|yy|MM|dd|E|hh|mm|ss|a\/p)/gi, function($1) {
        switch ($1) {
            case "yyyy":
                return d.getFullYear();
            case "yy":
                return (d.getFullYear() % 1000).zf(2);
            case "MM":
                return (d.getMonth() + 1).zf(2);
            case "dd":
                return d.getDate().zf(2);
            case "E":
                return weekName[d.getDay()];
            case "HH":
                return d.getHours().zf(2);
            case "hh":
                return d.getHours().zf(2);
            case "mm":
                return d.getMinutes().zf(2);
            case "ss":
                return d.getSeconds().zf(2);
            case "a/p":
                return d.getHours() < 12 ? "오전" : "오후";
            default:
                return $1;
        }
    });
};
String.prototype.string = function(len) {
    var s = '',
        i = 0;
    while (i++ < len) {
        s += this;
    }
    return s;
};
String.prototype.zf = function(len) {
    return "0".string(len - this.length) + this;
};
Number.prototype.zf = function(len) {
    return this.toString().zf(len);
};

function replaceErrorImg(obj){
	$(obj).on("error",function(){
		$(obj).attr("src","http://img.enuri.info/images/rev/comm_noimg.png");
        $(obj).addClass("is-noimg");
        $(obj).attr("alt","상품이미지가 없습니다.");
    });
   $(obj).attr("src",$(obj).attr("src"));
}
