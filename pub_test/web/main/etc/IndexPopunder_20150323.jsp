<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko-KR" XMLNS:IE>
<%@ page contentType="text/html; charset=utf-8" %>\
<%@ include file="/include/Base_Inc_2010.jsp"%>
<head>
<title>에누리 가격비교</title>
<style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}

/* 20150323 팝언더 하단 분리 */
.pop_bottom {position:relative; width:375px; height:34px; border-top:1px solid #fff;; background-color:#ececec;}
.pop_bottom .openNo {position:absolute; left:10px; top:8px; margin:0; cursor:pointer;}
.pop_bottom .openNo input {vertical-align:-1px;}
.pop_bottom .openNo em {overflow:hidden;position:absolute;left:-1000%;top:0;width:0;height:0;font-size:0;line-height:0;}
.pop_bottom .btn_close {position:absolute; right:10px; top:10px; width:12px; height:11px; display:inline-block; text-indent:-999em; background:url(http://img.enuri.gscdn.com/images/detail/popbtn_close.gif) no-repeat 0 0;}

-->
</style>
<script src="/common/js/lib/jquery-1.9.1.min.js"></script>
<script language="javaScript" TYPE="text/javascript">

$(document).ready(function() {
    try {
		window.blur();
		window.opener.focus();
	} catch (e) {
    } 
    setTimeout("fnResize();", 1000);
});
 
function fnResize(){
     
    var nWidth = 0;
    var nHeight = 0;
     
    if(undefined != window.opener) {    //window.open
         var nMenuWidth = 0;
         var nMenuHeight = 0;
          
         if(window.outerHeight) {
             nMenuWidth = window.outerWidth - window.innerWidth;
             nMenuHeight = window.outerHeight - window.innerHeight + 1;
         } else {
             // ie8 이하
             var nDocWidth = $(document).outerWidth();
             var nDocHeight = $(document).outerHeight();
              
             window.resizeTo ( nDocWidth, nDocHeight );
              
             nMenuWidth = nDocWidth - $(window).width();
             nMenuHeight = nDocHeight - $(window).height();
         }
 		if(navigator.userAgent.indexOf("Chrome") >0 ){
	 		 nWidth = $("#tbl_IndexPopunder").outerWidth() + nMenuWidth+3;
	         nHeight = $("#tbl_IndexPopunder").outerHeight() + nMenuHeight+3;
 		}else{
	         nWidth = $("#tbl_IndexPopunder").outerWidth() + nMenuWidth;
	         nHeight = $("#tbl_IndexPopunder").outerHeight() + nMenuHeight;
        }
         self.resizeTo(nWidth, nHeight); 
    }
}

function fnEverSetCookie( name, value, expiredays )
{
	var todayDate = new Date();
	todayDate.toGMTString()
	todayDate.setDate( todayDate.getDate() + expiredays );
	document.cookie = name + "=" + escape( value ) + "; path=/; expires=" + todayDate.toGMTString() + ";"
}

function fnEverGetCookie( name )
	{
	    var nameOfCookie = name + "=";
	    var x = 0;
	    while ( x <= document.cookie.length )
	    {
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


function fnCookieCheck()
	{
	    fnEverSetCookie("linker_popup", "CHECKED", 1);
	    window.close();
	}
	
function logInsert2014(kind) {

	var urlStr = "/view/Loginsert.jsp?kind="+kind;
	
	$.ajax ({
		url: urlStr 
	});
}	

</script>
</head>
<body onload="">
<div id="tbl_IndexPopunder" style="width:375px;height:347px" >
	<table width="370" height="357" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td bgcolor="#CCD9E5">
				<div width="340px" style="border:1px solid gray; background-color:#ffffff;margin:10px 10px 10px 10px;">
				<%
					if(DateUtil.getDaysDiff(DatetimeStr.nowStr("yyyy-MM-dd"),"2015-02-06") >= 0  && DateUtil.getDaysDiff(DatetimeStr.nowStr("yyyy-MM-dd"),"2015-02-12") <= 0){
				%>
			    	<img style="margin:7px 7px 7px 7px;cursor:pointer;" src="http://img.enuri.gscdn.com/images/detail/150305.jpg" border="0" onclick="logInsert2014(11482);window.open('http://www.enuri.com/event/eventDiscount2Main.jsp','_blank','')"  align="absmiddle">
			    <%
					}else if(DateUtil.getDaysDiff(DatetimeStr.nowStr("yyyy-MM-dd"),"2015-02-13") >= 0 ){
				%>
					<img style="margin:7px 7px 7px 7px;cursor:pointer;" src="http://img.enuri.gscdn.com/images/detail/150305.jpg" border="0" onclick="logInsert2014(11482);window.open('http://www.enuri.com/event/eventDiscount2Main.jsp','_blank','')"  align="absmiddle">
				<%
					}   
				%>	
			    </div>
			    <div width="340px"  style="border:1px solid gray; background-color:#ffffff;margin:10px 10px 10px 10px;">
			        <img style="margin:7px 7px 7px 7px;cursor:pointer;" src="http://img.enuri.gscdn.com/images/detail/20150213.png" border="0" onclick="logInsert2014(11481);window.open('http://www.anycardirect.com/CR_MyAnycarWeb/overture_index.jsp?OTK=A1501AF0062','_blank','')"  align="absmiddle">
			    </div>
			   <!-- 20150323 팝언더 하단 분리 -->
				<div class="pop_bottom" >
			        <p class="openNo"><span class="chk"><img src="http://img.enuri.gscdn.com/images/detail/pop_chk.gif"   onClick="procChkButton(this);" value="" /></span><em>오늘 하루 이 창을 열지 않음</em></p>
					<a href="#" class="btn_close">닫기</a>
			    </div>
				<!-- //20150323 팝언더 하단 분리 -->

				<!--<div width="375" height="25" style="align:center;">
			        <img width="375" src="http://img.enuri.gscdn.com/images/detail/1119_close.jpg" border="0" usemap="#sMap4"></td>
			    </div>-->
			</td>
		</tr>
	</table>
</div>
	<!--<map name="sMap4">
		<area shape="rect" coords="313,4,366,22"  href="#" onclick="javascript:window.close();" style="cursor:hand"/>
		<area shape="rect" coords="7,3,135,22"  href="#" onclick="fnCookieCheck();"style="cursor:hand"/>
	</map>-->


<script language="javascript">
							<!--
									function procChkButton(img) {
											if(img.checked) {
													img.checked = false;
													img.src="http://img.enuri.gscdn.com/images/detail/pop_chk.gif"
											} else {
													img.checked = true;
												img.src="http://img.enuri.gscdn.com/images/detail/pop_chk_on.gif"
											}
									}
							-->
							</script>
</body>
</html>