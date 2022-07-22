function saveStorage(key, data) {
	if(key.length>0) {
		//cusSto.setItem(key, data);
		setCookie(key,data,365);
	}
}

function loadStorage(key) {
	if(key.length>0) {
		//var rtnValue = cusSto.getItem(key);
		var rtnValue = getCookie(key);
		
		if(rtnValue==null) rtnValue = "";

		return rtnValue;
	}
	return null;
}

function removeStorage(key) {
	if(key.length>0) {
		setCookie(key,"",365);
	}
}

function getCookie(c_name) {
	var i,x,y,ARRcookies=document.cookie.split(";");
	for(i=0;i<ARRcookies.length;i++) {
		x = ARRcookies[i].substr(0,ARRcookies[i].indexOf("="));
		y = ARRcookies[i].substr(ARRcookies[i].indexOf("=")+1);
		x = x.replace(/^\s+|\s+$/g,"");
		if(x==c_name) {
			return unescape(y);
		}
	}
}

function setCookie(c_name, value, exdays) {
	var exdate=new Date();
	exdate.setDate(exdate.getDate() + exdays);
	var c_value=escape(value) + ((exdays==null) ? "" : "; expires="+exdate.toUTCString());
	c_value += "; domain=" + document.domain;
	c_value += "; path=/ ";

	document.cookie=c_name + "=" + c_value;
}
/*
function getStorage() {
	var storageImpl;

	try { 
		localStorage.setItem("storage", ""); 
		localStorage.removeItem("storage");
		storageImpl = localStorage;
	} catch(err) { 
		storageImpl = new LocalStorageAlternative();
	}

	return storageImpl;

}

function LocalStorageAlternative() {
	var structureLocalStorage = {};

	this.setItem = function (key, value) {
		structureLocalStorage[key] = value;
	}

	this.getItem = function (key) {
		if(typeof structureLocalStorage[key] != 'undefined' ) {
			return structureLocalStorage[key];
		} else {
			return null;
		}
	}

	this.removeItem = function (key) {
		structureLocalStorage[key] = undefined;
	}
}
*/
// 로컬 스토리지 초기화
//cusSto = getStorage();



//상품을 저장하고 삭제하는 함수들 : 최근본과 찜의 둘다 사용함
//로컬스토리지에 최근 본 상품 추가
//type=G:모델 번호가 있는 상품 "G:modelnl"형태로 저장
//type=P:모델 번호가 없는 웹상품(plno를 사용함) "P:pl_no"형태로 저장
//최근본 상품은 50개까지 저장 가능
var resentMaxCnt = 50;
function addStorageGoods(storageName, product, type) {
	var resentListStr = getGoodsListStorage(storageName);

	// 실제로 저장되는 상품의 형식, 맨끝의 ,는 type와 함께 상품번호를 구분하기 위해 필요
	var prodectStr = type + ":" + product + ",";

	if(resentListStr==null) resentListStr = "";

	// 이전에 저장된적이 있으면 삭제
	if(resentListStr.indexOf(prodectStr)>-1) {
		resentListStr = resentListStr.split(prodectStr).join("");
	}
	// 가장 최근상품으로 저장
	resentListStr = prodectStr + resentListStr;

	var tempResentListStr = "";
	var resentListAry = resentListStr.split(",");

	for(var i=0; i<resentMaxCnt; i++) {
		if(resentListAry[i]!=null && resentListAry[i].length>0) {
			tempResentListStr += resentListAry[i] + ",";
		}
	}
	
	// 스토리지에 저장
	setGoodsListStorage(storageName, tempResentListStr);
}

//로컬스토리지에 최근 본 상품 삭제
function deleteStorageGoods(storageName, product, type) {
	var resentListStr = getGoodsListStorage(storageName);
	// 실제로 저장되는 상품의 형식, 맨끝의 ,는 type와 함께 상품번호를 구분하기 위해 필요
	var prodectStr = type + ":" + product + ",";

	if(resentListStr.indexOf(prodectStr)>-1) {
		resentListStr = resentListStr.split(prodectStr).join("");
	}

	// 스토리지에 저장
	setGoodsListStorage(storageName, resentListStr);
}

// 최근 본이나 찜을 입력하는 함수
// itemType==1 최근본, itemType==2 찜
function addResentZzimItem(itemType, productType, modelno) {
	if(itemType==1) {
		addStorageGoods("resentList", modelno, productType);

		try {
			loadResentImages();
			if(window.android) {
				loadResentZzimCntAnd();
			} else {
				loadResentZzimCnt();
			}
		} catch(e) {}
	}

	if(itemType==2) {
		if(IsLogin()==true) {
		
			var url = "/mobilefirst/ajax/resentZzim/insertSaveGoodsProc.jsp";
			var param = "modelnos="+productType+":"+modelno;
			
			$.ajax({
				type : "post",
				url : url,
				data : param, 
				dataType : "json",
				success : function(ajaxResult) {
					setZzimImages();

					try {
						if(window.android) {
							loadResentZzimCntAnd();
						} else {
							loadResentZzimCnt();
						}
					} catch(e) {
					}
				}
			}); 

		} else {
		}
	}
}

//입력된 상품들이 찜 상품인지 확인하는 함수
var nowFolderCnt = 0;
function IsZzimGoods(modelnos) {
	var rtnValue = "";

	if(strID.length>0) {
		var url = "/mobile2/resentzzim/ajax/IsZzimFind_ajax.jsp";
		var param = "modelnos="+modelnos;

		$.ajax({
			type : "post",
			url : url,
			data : param, 
			dataType : "json",
			success : function(ajaxResult) {
				rtnValue = ajaxResult["rtnValue"];

				return rtnValue;
			}
		}); 

	} else {
		var zzimFolderList = "";

		for(var i=0;i<5; i++) {
			var tempFolderList = getGoodsListStorage("zzimList"+(i+1));
			zzimFolderList += tempFolderList;
		}
		zzimFolderList = "," + zzimFolderList;

		var modelnosAry = modelnos.split(",");

		for(var i=0; i<modelnosAry.length; i++) {
			if(zzimFolderList.indexOf(":"+modelnosAry[i]+",")>-1) {
				rtnValue += "1";
			} else {
				rtnValue += "0";
			}
			rtnValue += ",";
		}

		return rtnValue;
	}
	
}


//최근본과 찜 리스트
//resentList, zzimList1, zzimList2, zzimList3, zzimList4, zzimList5
function getGoodsListStorage(name) {
	return loadStorage(name);
}

function setGoodsListStorage(name, listStr) {
	saveStorage(name, listStr);
}

// 상품창 여는 함수
// 모델번호, 최근본에 입력여부, 새창으로 띄울것인지
function goGoodsPage(GoodsNum, cate, resentFlag, newPageFlag, app, url, shop_code, photo, goodscode, minprice) {
	// 모델명이 있는 상품창일 경우
	if(GoodsNum.indexOf("G:")>-1) {
		var Dns; 
		Dns = location.href;  
		Dns = Dns.split("//"); 
		Dns = "http://"+Dns[1].substr(0,Dns[1].indexOf("/"));
		
		var modelno = GoodsNum.replace("G:", "");
		var detailUrl = "/mobile/detail_new.jsp?modelno="+modelno+"&resentFlag="+resentFlag+"&cate="+cate+"&app="+app+"&photo="+photo;
		if(newPageFlag==1) {
			try {
				window.android.android_Detail_Activity(Dns+detailUrl);
			} catch(e) {
				window.open(detailUrl);
			}

		} else {
			document.location.href = detailUrl;
		}
	}

	// 검색 상품의 경우
	if(GoodsNum.indexOf("P:")>-1) {
		var modelno = GoodsNum.replace("P:", "");
		var mobile_url = url;
		var vcode = shop_code;
		var goodscode = goodscode;
		var minprice = minprice;
		ctu_func(vcode, goodscode, minprice, cate);
		CmdGoRedirect(modelno, mobile_url, vcode, cate, 'ex');
	}
}

// 최근본 상품의 개수를 구함
function getResentCnt() {
	var resentListStr = getGoodsListStorage("resentList");
	var resentListStrAry = null;
	var rtnValue = 0;
	
	if(resentListStr!=null) {
		resentListStrAry = resentListStr.split(",");
		if(resentListStrAry!=null) {
			try {
				for(var i=0; i<resentListStrAry.length; i++) {
					if(resentListStrAry[i].length>0) {
						rtnValue++;
					}
				}
			} catch(e) {}
		}
	}
	
	return rtnValue;
}

//찜 상품의 개수를 구함
function getZzimCnt() {
}

