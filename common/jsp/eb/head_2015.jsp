<%
    String strIsMain = "";
    boolean isEvent = false;

    if (request.getServletPath().trim().toUpperCase().indexOf("INDEX") >= 0 && request.getServletPath().trim().indexOf("Tour_Index.jsp") < 0){
        strIsMain = "_main";
    }
%>
<%
    String strGkind_h     = ChkNull.chkStr(cb.GetCookie("GATEP","GKIND"),"");
    if (strGkind_h.equals("11") || strGkind_h.equals("5") || strGkind_h.equals("1") || strGkind_h.equals("37") || strGkind_h.equals("38") || strGkind_h.equals("39") || strGkind_h.equals("45") ){
        if(request.getServletPath().trim().indexOf("eventMassMaketingMain.jsp") < 0){
%>
<link rel="stylesheet" type="text/css" href="<%=ConfigManager.ENURI_COMMON%>/common/css/gateevent.css?v=20190304">
<%
       }
    }
%>
<link rel="stylesheet" type="text/css" href="<%=ConfigManager.IMG_ENURI_COM%>/common/css/eb/default<%=strIsMain%>.css?v=20190304">
<%if(request.getServerName().indexOf("dev.enuri.com") > -1){ %>
<link rel="stylesheet" type="text/css" href="/common/css/eb/common<%=strIsMain%>.css?v=20190304">
<%}else{%>
<link rel="stylesheet" type="text/css" href="<%=ConfigManager.IMG_ENURI_COM%>/common/css/eb/common<%=strIsMain%>.css?v=20190304">
<%} %>
<style type='text/css'>
#div_inconv {position:absolute;z-index:1010;width:280px;top:185px;left:3px;font-size:11px;}
#div_inconv * {font-family: "ë§ì ê³ ë";color:#000000;}
#epTop {height:50px;width:280px;background:url('<%=ConfigManager.IMG_ENURI_COM%>/2012/toolbar2/singo_bg_01.png') left top no-repeat;}
#epTop.formall {background:url('<%=ConfigManager.IMG_ENURI_COM%>/2012/toolbar2/singo_bg_01_1.png') left top no-repeat;}
#epTop * {display:none;}
#div_inconv .closeBtn {position:absolute;top:10px;right:10px;width:17px;height:16px;cursor:pointer;}
#epTitle {height:24px;font-size:14px;font-weight:bold;}
#epDetail {height:24px;line-height:16px;}
#epDetail span {color:#800000;}
#epMain {width:280px;background:url('<%=ConfigManager.IMG_ENURI_COM%>/2012/toolbar2/singo_bg_02.png') repeat;}
#epMallChk {display:none;}
#epMallChk ul {width:240px;list-style:none;margin:0 0 0 16px;padding:0;}
#epMallChk ul li {list-style:none;float:left;width:110px;height:20px;font-size:12px;font-weight:bold;}
#epFormTitle {clear:both;margin:0 0 0 18px;padding-top:5px;font-size:12px;line-height:16px;}
#epFormSubInfo {clear:both;margin:0 0 0 18px;font-size:11px;line-height:14px;display:none;}
#epFormSubInfo div {margin-top:4px;}
#epfTitle {font-weight:bold;}
.inconv_txt {width:244px;height:100px;border:1px solid black;margin:5px 0 5px 16px;font-size:12px;ime-mode:active;}
#epfDetail {margin-left:16px;width:244px;font-size:12px;}
#epNums { display:none;margin: 5px 0;padding-left:10px;background:url('<%=ConfigManager.IMG_ENURI_COM%>/2012/toolbar2/bu_g.gif') 0 50% no-repeat;}
#epNums * {color:#5A5A5A;}
#epnNums {font-weight:bold;}
#epNumsDummy {width:244px;height:20px;margin:12px 0 0 16px;text-align:right; }
#epfSubmit {cursor:pointer;}
#epBottom {width:280px;height:15px;background:url('<%=ConfigManager.IMG_ENURI_COM%>/2012/toolbar2/singo_bg_03.png') left top no-repeat;}
.anchors_off {overflow:hidden;margin-right:6px;display:inline-block;background:url(<%=ConfigManager.IMG_ENURI_COM%>/images/main/2014/icon_off.gif) no-repeat;width:8px;height:8px;font-size:0px;line-height:1px;cursor:pointer;}
.anchors_on {overflow:hidden;margin-right:6px;display:inline-block;background:url(<%=ConfigManager.IMG_ENURI_COM%>/images/main/2014/icon_on.gif) no-repeat;width:8px;height:8px;font-size:0px;line-height:1px;cursor:pointer;}
</style>
<!-- 로그인 광고용 css. -->
<style>
.loginArea{margin:-135px auto 0 -270px}
.right_ad{position:absolute; right:-282px; top:-1px; border: 1px solid #575c67; height:238px; box-shadow: 0px 1px 2px 0px #000;}
.bottom_ad{position:absolute; left:-1px; bottom:-57px; border: 1px solid #575c67; width:657px; height:50px; background:#7cd3e7; text-align:center; z-index:1000000}

.wingbnr{margin-bottom:6px; overflow:hidden; }
.wingbnr img{float:left; }
.fix_leftt {position:fixed; top:50%; left:0; margin-top:-249px; height:498px; z-index:100;}
.fix_right {position:fixed; top:50%; right:0; margin-top:-270px; height:543px; z-index:100;}
</style>
<!-- 로그인 광고용 script -->
<script language=javascript src="http://imgenuri.enuri.gscdn.com/common/js/Log_Header.js?v=2018123103"></script>
<script type = "text/javascript" src = "/mobiledepart/js/lib/jquery-ui.min.js"></script>

<script type='text/javascript'>
function get_render_loginlayer_tag(jsonval, key, aclassname, width,height, imgclassname, opentag,closetag, effect){
	var ret = '';
	try{
		var adlist = jsonval[key];
		for (var i=0;i<adlist.length;i++){
			var name = adlist[i]['name'];
			var img = adlist[i]['img'];
			var link = adlist[i]['link'];

			var inlinestyle = "style='display:none;'";
			var inlineattr = "idx='" + i + "'";
			var tagid = aclassname + "_" + i.toString();

			var opentagreplace = opentag.replace('class="', 'class="' + aclassname + ' ');
			ret += opentagreplace + " id='" + tagid + "'" + inlinestyle + " >" +  "<a href='" + link + "' target='_blank' " + inlineattr + " ><img alt='" + name + "' src='" + img + "' width='" + width + "' height='" + height + "' class='" + imgclassname + "' /></a>" + closetag;

			// 첫번째 이미지에 대해서 effect.
			if (i == 0){
				function effectinterval(){
					if ($('#' + tagid).length > 0){
						effect(tagid);
					}else{
						setTimeout(function(){
							effectinterval();
						},300);
					}
				}

				effectinterval();
			}
		}

		// 3초에 한번씩 같은 슬롯의 이미지 롤링.

		setInterval(function(){
			try{
				var selectedidx = 0;
				$("." + aclassname).each(function(idx,item){
					if ($(item).css('display') == 'block'){
						selectedidx = idx + 1;
					}
				});

				if (selectedidx >= $("." + aclassname).length){
					selectedidx = 0;
				}

				$("." + aclassname).each(function(idx,item){
					if (idx == selectedidx){
						//effect( $(item).attr('id'));
						//$(item).slideDown(1000);
						$(item).show();
					}else{
						$(item).hide();
					}
				});
			}catch(err){
				//console.log(err);
			}
		},3000);
	}catch(err){
		console.log(err);
	}
	return ret;
}

function load_loginlayer_ad__nouse(){
	var ret = '';
	jQuery.ajax({
		url : "/login/login_ad.jsp",
		dataType : 'json',
		async : false,
		success:function(result){
			ret = result;
		}
	});

	var fadein = function(tagid){$('#' + tagid).fadeIn("slow");};
	var slideleft = function(tagid){ setTimeout(function(){ $('#' + tagid).show('slide', {direction:'left'}, 1200);}, 1000);};
	var slideright = function(tagid){ setTimeout(function(){ $('#' + tagid).show('slide', {direction:'right'}, 1200);}, 1000);};

	//slideleft = function(tagid){};
	//slideright = function(tagid){};

	var ads = [
		get_render_loginlayer_tag(ret, "position_1", 'loginlayer_ad_dimback_1','280','238', 'img_init', '<div class="right_ad"','</div>', fadein),
		get_render_loginlayer_tag(ret, "position_2", 'loginlayer_ad_dimback_2','100%','46', '', '<div class="bottom_ad"','</div>', fadein),
		get_render_loginlayer_tag(ret, "position_3", 'loginlayer_ad_dimback_3','130','120', '','<p class="wingbnr"','</p>', slideleft),
		get_render_loginlayer_tag(ret, "position_4", 'loginlayer_ad_dimback_4','130','120', '','<p class="wingbnr"','</p>', slideleft),
		get_render_loginlayer_tag(ret, "position_5", 'loginlayer_ad_dimback_5','130','120', '','<p class="wingbnr"','</p>', slideleft),
		get_render_loginlayer_tag(ret, "position_6", 'loginlayer_ad_dimback_6','210','175', '','<p class="wingbnr"','</p>', slideright),
		get_render_loginlayer_tag(ret, "position_7", 'loginlayer_ad_dimback_7','210','175', '','<p class="wingbnr"','</p>', slideright),
		get_render_loginlayer_tag(ret, "position_8", 'loginlayer_ad_dimback_8','210','175', '','<p class="wingbnr"','</p>', slideright)
    ];

	return ads;
}
</script>
<script>
var isServer151 = "<%=(request.getServerName().trim().equals("dev.enuri.com") || request.getServerName().trim().equals("stagedev.enuri.com"))?"1":"0"%>";
function CmdLink(url){    location.href = url;}
</script>