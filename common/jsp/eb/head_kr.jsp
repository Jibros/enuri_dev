<link rel="stylesheet" type="text/css" href="<%=ConfigManager.ENURI_COMMON%>/common/css/eb/default_kr.css">
<link rel="stylesheet" type="text/css" href="<%=ConfigManager.ENURI_COMMON%>/common/css/eb/common_kr.css">
<style type='text/css'>
	#div_inconv {position:absolute;z-index:150;width:280px;top:185px;left:3px;font-size:11px;}
	#div_inconv * {font-family: "맑은 고딕";color:#000000;}
	#epTop {height:50px;width:280px;background:url('http://img.enuri.gscdn.com/2012/toolbar2/singo_bg_01.png') left top no-repeat;}
	#epTop.formall {background:url('http://img.enuri.gscdn.com/2012/toolbar2/singo_bg_01_1.png') left top no-repeat;}
	#epTop * {display:none;}
	#div_inconv .closeBtn {position:absolute;top:10px;right:10px;width:17px;height:16px;cursor:pointer;}
	#epTitle {height:24px;font-size:14px;font-weight:bold;}
	#epDetail {height:24px;line-height:16px;}
	#epDetail span {color:#800000;}
	#epMain {width:280px;background:url('http://img.enuri.gscdn.com/2012/toolbar2/singo_bg_02.png') repeat;}
	#epMallChk {display:none;}
	#epMallChk ul {width:240px;list-style:none;margin:0 0 0 16px;padding:0;}
	#epMallChk ul li {list-style:none;float:left;width:110px;height:20px;font-size:12px;font-weight:bold;}
	#epFormTitle {clear:both;margin:0 0 0 18px;padding-top:5px;font-size:12px;line-height:16px;}
	#epFormSubInfo {clear:both;margin:0 0 0 18px;font-size:11px;line-height:14px;display:none;}
	#epFormSubInfo div {margin-top:4px;}
	#epfTitle {font-weight:bold;}
	.inconv_txt {width:244px;height:100px;border:1px solid black;margin:5px 0 5px 16px;font-size:12px;ime-mode:active;}
	#epfDetail {margin-left:16px;width:244px;font-size:12px;}
	#epNums { display:none;margin: 5px 0;padding-left:10px;background:url('http://img.enuri.gscdn.com/2012/toolbar2/bu_g.gif') 0 50% no-repeat;}
	#epNums * {color:#5A5A5A;}
	#epnNums {font-weight:bold;}
	#epNumsDummy {width:244px;height:20px;margin:12px 0 0 16px;text-align:right; }
	#epfSubmit {cursor:pointer;}
	#epBottom {width:280px;height:15px;background:url('http://img.enuri.gscdn.com/2012/toolbar2/singo_bg_03.png') left top no-repeat;}
	.anchors_off {overflow:hidden;margin-right:6px;display:inline-block;background:url(http://img.enuri.gscdn.com/images/main/2014/icon_off.gif) no-repeat;width:8px;height:8px;font-size:0px;line-height:1px;cursor:pointer;}
	.anchors_on {overflow:hidden;margin-right:6px;display:inline-block;background:url(http://img.enuri.gscdn.com/images/main/2014/icon_on.gif) no-repeat;width:8px;height:8px;font-size:0px;line-height:1px;cursor:pointer;}
</style>
<!--[if IE 7]>
<link rel="stylesheet" type="text/css" href="<%=ConfigManager.ENURI_COMMON%>/common/css/eb/common7_kr.css">
<![endif]-->
<script type="text/javascript" src="<%=ConfigManager.IMG_ENURI_COM%>/common/js/eb/ui_kr.js?v=1.01"></script>
<script type="text/javascript" src="<%=ConfigManager.ENURI_COMMON%>/common/js/eb/gnbBanner.js"></script>
<script type="text/javascript" src="<%=ConfigManager.ENURI_COMMON%>/common/js/eb/gnbBanner_data.js"></script>
<!--[if lt IE 9]>
<script type="text/javascript" src="<%=ConfigManager.ENURI_COMMON%>/js/eb/html5shiv.min.js"></script>
<![endif]-->
<script language="javascript">
var isServer151 = "<%=(request.getServerName().trim().equals("dev.enuri.com") || request.getServerName().trim().equals("stagedev.enuri.com"))?"1":"0"%>";

function showLoginStatus(){
    if(islogin()){
        document.getElementById("frmMainLogin").style.display="";
        if (getBrowserName().indexOf("msie") >= 0 ){
            document.getElementById("LayerLoginMain").style.top = "5px";
        }else{
            document.getElementById("LayerLoginMain").style.top = "3px";
        }
        /*
        if(document.getElementById("btn_search_main")){
            document.getElementById("LayerLoginMain").style.left = $("#img_main_login").position().left - 50 +"px";
        }else{
            document.getElementById("LayerLoginMain").style.left = 550;
        }
        */
        document.getElementById("LayerLoginMain").style.left = ($("#utilMenuLogout").position().left-100)+"px"
    }else{
        document.getElementById("frmMainLogin").style.display="none";
        document.getElementById("LayerLoginMain").style.display="none";
    }
}


var libType = function(){
    var rtn = "";
    if (typeof(Prototype) != "undefined" ){
        rtn = "PR"
    }else if(typeof(jQuery) != "undefined"){
        rtn = "JQ"
    }
    return rtn;
}
function commonAjaxRequest(url,param,callback){
    if (libType() == "PR"){
        var getInstProd = new Ajax.Request(
            url,
            {
                method:'post',parameters:param,onComplete:callback
            }
        );
    }else if(libType() == "JQ"){
        $.ajax({
            type: "POST",
            url: url,
            data: param,
            success: function(result){
                callback(result);
            }
        });
    }
}

function commonAjaxRequest_async(url,param,callback){
    if (libType() == "PR"){
        var getInstProd = new Ajax.Request(
            url,
            {
                method:'post',parameters:param,onComplete:callback
            }
        );
    }else if(libType() == "JQ"){
        $.ajax({
            type: "POST",
            url: url,
            data: param,
            async: false,
            success: function(result){
                callback(result);
            }
        });
    }
}
function insertLog(logNum){
    var url = "/view/Loginsert.jsp";
    var param = "kind="+logNum;
    commonAjaxRequest(url,param,function(){});
    /*
    var getRec = new Ajax.Request(
        url,
        {
            method:'get',parameters:param
        }
    );
    */
}
function CmdLink(url){
	location.href = url;
}
</script>