var IMG_ENURI_COM = "http://img.enuri.info";

$(function(){
	// 페이지 로드 기본 세팅
	loadBasic();
});

function loadBasic() {
	setFolderSelectList();

	$("#folderAddBtn").click(function (e) {
		createFolderAction();
	});
}

//폴더 정보를 읽어옴
//folder_use:로컬 스토리지에 폴더가 사용중인지 정보를 저장함
var folder_id = 1; // 현재 선택된 폴더, 디폴트는 1
var maxFolderCnt = 5;
var nowFolderCnt = 0;
var folderNameAry = ["찜폴더1", "찜폴더2", "찜폴더3", "찜폴더4", "찜폴더5"];
var folderItemsCnt = [0, 0, 0, 0, 0]; // 폴더가 생성되면 -1보다 큼 첫번째 폴더는 데이터의 유무에 상관없이 보임
var folderShowFlag = [1, 0, 0, 0, 0]; // 폴더가 있으면 1 없으면 0 로컬스토리지와 연동해야함
var folderItemsMaxCnt = [50, 50, 50, 50, 50];

//찜 폴더와 폴더의 개수를 읽어오는 함수
//folderItemsCnt 배열에 찜의 개수를 저장함
function setFolderSelectList() {
	var loadUrl = "/view/resentzzim/ajax/Ajax_zzimFolderList.jsp";

	$.getJSON(loadUrl, null, function(data) {
		folderJsonObj = data["folderList"];

		for(var i=0; i<5; i++) {
			folderShowFlag[i] = 0;
			folderItemsCnt[i] = 0;
		}

		try {
			zzimFolderCnt = parseInt(data["folderCnt"]);
		} catch(e) {}

		$.each(folderJsonObj, function(indexI, folderListObj) {
			var tempFolder_id = folderListObj["folder_id"];
			var tempFolder_cnt = folderListObj["folder_cnt"];
			var intTempFolder_id = 0;
			var intTempFolder_cnt = 0;
			try {
				intTempFolder_id = parseInt(tempFolder_id);
			} catch(e) {}
			try {
				intTempFolder_cnt = parseInt(tempFolder_cnt);
			} catch(e) {}
			// 폴더의 아이템개수 세팅
			try {
				if(intTempFolder_cnt>0) {
					folderItemsCnt[intTempFolder_id-1] = intTempFolder_cnt;
				}
			} catch(e) {}
			folderShowFlag[intTempFolder_id-1] = 1;
		});

		setFolderUI();
	});
}


function setFolderUI() {
	var choiceFolderListObj = $("#container .choiceFolderList");
	var folderTotalCnt = 0;

	var htmlTxt = "";
	nowFolderCnt = 0;
	for(var i=0; i<folderShowFlag.length; i++) {
		if(folderShowFlag[i]==1) {

			htmlTxt += "<li id=\"zzimFolder"+(i+1)+"\">";
			if(i==0) {
				htmlTxt += "	<span>찜폴더"+(i+1)+"(기본)</span>";
			} else {
				htmlTxt += "	<span>찜폴더"+(i+1)+"</span>";
			}
			htmlTxt += "	<span><strong>"+folderItemsCnt[i]+"건</strong>/"+folderItemsMaxCnt[i]+"건</span>";
			if(i>0) {
				htmlTxt += "	<button id=\"folderDel"+(i+1)+"\" type=\"button\" class=\"btnTxt folderDelBtn\">삭제</button>";
			}
			htmlTxt += "</li>";

			nowFolderCnt++;
		}
	}
	choiceFolderListObj.html(htmlTxt);
	
	$(".folderDelBtn").unbind();
	$(".folderDelBtn").click(function (e) {
		var thisId = $(this).attr("id");
		var idNum = thisId.replace("folderDel", "");
		var intIdNum = -1;
		try {
			intIdNum = parseInt(idNum);
		} catch(e) {}

		if(intIdNum>-1) deleteFolderAction(intIdNum);
	});
}


//폴더 생성
function createFolderAction() {
	if(nowFolderCnt>=5) {
		alert("폴더는 5개까지만 생성 가능합니다.");
		return;
	}

	var url = "/view/resentzzim/ajax/Ajax_createGoodsFolder.jsp";
	var param = "";

	$.ajax({
		type : "post",
		url : url,
		data : param, 
		dataType : "html",
		success : function(ajaxResult) {
			alert("새 폴더가 생성되었습니다.");

			setFolderSelectList();
		}
	});
}

//현재 선택된 폴더를 삭제함
function deleteFolderAction(folder_id) {
	// 현재 리스트의 아이템 개수가 0보다 크면 삭제 문구 생성
	if(folderItemsCnt[folder_id-1]>0) {
		if(!confirm("해당 폴더에 담긴 상품이 모두 삭제됩니다.\n삭제하시겠습니까?")) {
			return;
		}
	}

	var url = "/view/resentzzim/ajax/Ajax_deleteGoodsFolder.jsp";
	var param = "folder_id="+folder_id;

	$.ajax({
		type : "post",
		url : url,
		data : param, 
		dataType : "html",
		success : function(ajaxResult) {
			alert("폴더가 삭제되었습니다.");

			setFolderSelectList();
		}
	});
}
