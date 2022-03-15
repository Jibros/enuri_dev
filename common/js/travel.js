function inputFlash(vId, vUri, vWidth, vHeight, vWmode, vFlashVar) {
	var str = "";
	str = '<object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" id="' + vId + '" VIEWASTEXT width="' + vWidth + '" height="' + vHeight + '" align="middle">';
	str += '<param name="allowScriptAccess" value="always" />';
	str += '<param name="allowFullScreen" value="false" />';
	str += '<param name="quality" value="best" />';
	str += '<param name="wmode" value="' + vWmode + '" />';
	str += '<param name="bgcolor" value="#ffffff" />';
	str += '<param name="movie" value="' + vUri + '" />';
	str += '<param name="FlashVars" value="' + vFlashVar + '" />';
	str += '<embed src="' + vUri + '" quality="high" wmode="' + vWmode + '" bgcolor="#ffffff" width="' + vWidth +'" height="' + vHeight + '" id="' + vId + '" name="' + vId + '" align="middle" swLiveConnect=true allowScriptAccess="always" type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/shockwave/download/index.cgi?P1_Prod_Version=ShockwaveFlash" /></embed>';
	str += '</object>';
	document.writeln(str);
}

function resizeObj(objId, w, h){
	if (document.getElementById(objId)){
		document.getElementById(objId).style.width = w;
		document.getElementById(objId).style.height = h;
	}
}

function openNewsAd(adno, adDate, adNewspaper, adAgency){
	var wWidth = screen.availWidth;
	var wHeight = screen.availHeight;
	if (parseInt(wWidth,10)>1024){
		wWidth = 1024;
	}
	var win = window.open("/travel/Travel_Ad.jsp?adno="+adno+"&addate="+adDate+"&adnewspaper="+adNewspaper+"&adagency="+adAgency,"TravelAd","width="+wWidth+",height="+wHeight+",left=0,top=0,toolbar=no,directories=no,status=yes,scrollbars=yes,resizable=no,menubar=no");
	win.focus();
}

function cmdTravelGuide(){
	CmdLink("/travel/Travel_Guide_Airline1.jsp");
}

function cmdTravelTab(){
	if ($("div_searchflash").style.display=="none"){ //���̱�
		bsShow(); //�⺻���Ǽ��� �÷��� ����߸���
	}else{
		bsHidden(); //�⺻���Ǽ��� �÷��� ��ֱ�
	}
}
/* ��� ��߽ð����Ľ� ���γ��� ���̾� */
function cmdShowListDownInfo(){
	if ($("rightListDownDesc").style.display=="none"){
		$("rightAirlineDesc").style.display = "none";
		$("rightListDownDesc").style.display = "block";
	}else{
		$("rightListDownDesc").style.display = "none";
	}
}
/* �װ�� �ΰ� ���� */
function cmdShowAirline(){
	if ($("rightAirlineDesc").style.display=="none"){
		$("rightListDownDesc").style.display = "none";
		$("rightAirlineDesc").style.display = "block";
	}else{
		$("rightAirlineDesc").style.display = "none";
	}
}
function cmdHideAirline(){
	$("rightAirlineDesc").style.display = "none";
}

/* ������ �� ���� */
function cmdTravelDetailTab(tab){
	cmdSearchEmptyBalloonHide();
	if (tab || tab==0){
		var obj = $("travel_detail"+tab);
		if (obj.style.display=="none"){
			$("img_travel_detail_tab"+tab).src = $("img_travel_detail_tab"+tab).src.replace("_stab0"+tab+".gif","_stab0"+tab+"ov.gif");
		}else{
			$("img_travel_detail_tab"+tab).src = $("img_travel_detail_tab"+tab).src.replace("_stab0"+tab+"ov.gif","_stab0"+tab+".gif");
		}
		if (obj.style.display=="none"){
			obj.style.display = "block";
		}else{
			obj.style.display = "none";
		}
		var fobj = document.frmTravel;
		if (tab==0){ //����Ⱓ
			resetAppointFlag();
			resetTravelTime();
			resetTravelPrice();
			resetFactory();
			resetAirline();
		}else if (tab==1){ //�������
			resetTravelPeriod();
			resetTravelTime();
			resetTravelPrice();
			resetFactory();
			resetAirline();
		}else if (tab==2){ //�װ�ð�
			resetTravelPeriod();
			resetAppointFlag();
			resetTravelPrice();
			resetFactory();
			resetAirline();
		}else if (tab==3){ //���ݴ�
			getPriceCnt();
			resetTravelPeriod();
			resetAppointFlag();
			resetTravelTime();
			resetFactory();
			resetAirline();
		}else if (tab==4){ //�����
			getFactoryCnt();
			getAirCnt();
			resetTravelPeriod();
			resetAppointFlag();
			resetTravelTime();
			resetTravelPrice();
		}
		for (i=0; i<5; i++){
			if (i!=tab){
				$("img_travel_detail_tab"+i).src = $("img_travel_detail_tab"+i).src.replace("_stab0"+i+"ov.gif","_stab0"+i+".gif");
				$("travel_detail"+i).style.display = "none";
				$("img_travel_detail"+i+"_go").style.display = "none";
				$("img_travel_detail"+i+"_default").style.display = "block";
			}
		}
	}else{
		for (i=0; i<5; i++){
			$("img_travel_detail_tab"+i).src = $("img_travel_detail_tab"+i).src.replace("_stab0"+i+"ov.gif","_stab0"+i+".gif");
			$("travel_detail"+i).style.display = "none";
		}
	}
	parent.syncHeightListFrame();
}
/* ����Ⱓ ���� */
function cmdTravelDetail0(param){
	var obj = document.frmTravel;
	var spday = obj.spday.value;
	var exists = 0;
	var new_spday = "";
	var arrSpday = spday.split(",");
	
	if (param=="all"){ //��ü�Ⱓ ����
		$("img_travel_detail0_all").style.backgroundImage = $("img_travel_detail0_all").style.backgroundImage.replace("all.gif","all_ov_ovx.gif");
		for (i=3; i<=10; i++){
			if ($("td_travel_detail0_"+i)){
				$("td_travel_detail0_"+i).className = "detail_period";
			}
		}
		new_spday = "";
	}else{ //�Ⱓ����
		$("img_travel_detail0_all").style.backgroundImage = $("img_travel_detail0_all").style.backgroundImage.replace("all_ov.gif","all.gif");
		for (i=0; i<arrSpday.length; i++){
			if (param == arrSpday[i]){
				exists = 1;
			}else{
				if (new_spday==""){
					new_spday = arrSpday[i];
				}else{
					new_spday += "," + arrSpday[i];
				}
			}
		}
		if (exists==1){ //�̹� ���õǾ� �ִ� ��¥�� ��������
			$("td_travel_detail0_"+param).className = "detail_period";
			if (new_spday==""){
				$("img_travel_detail0_all").style.backgroundImage = $("img_travel_detail0_all").style.backgroundImage.replace("all.gif","all_ov.gif");
			}
		}else{
			if (new_spday==""){
				new_spday = param;
			}else{
				new_spday += "," + param;
			}
			$("td_travel_detail0_"+param).className = "detail_period_circle_ovx";
			tourBackImgOver($("td_travel_detail0_"+param));
		}
	}
	obj.spday.value = new_spday;
	cmdEffectBtnGo(0);
}
/* ������� ���� */
function cmdTravelDetail1(param){
	var obj = document.frmTravel;
	var sappoint = obj.sappoint.value;
	var exists = 0;
	var new_sappoint = "";
	var arrSappoint = sappoint.split(",");
	
	if (param=="all"){ //��ü���� ����
		$("img_travel_detail1_all").style.backgroundImage = $("img_travel_detail1_all").style.backgroundImage.replace("all.gif","all_ov_ovx.gif");
		$("img_travel_detail1_1").src = $("img_travel_detail1_1").src.replace("_ov.gif", ".gif");
		$("img_travel_detail1_2").src = $("img_travel_detail1_2").src.replace("_ov.gif", ".gif");
		$("img_travel_detail1_3").src = $("img_travel_detail1_3").src.replace("_ov.gif", ".gif");
		new_sappoint = "";
	}else{ //Ư������ ����
		$("img_travel_detail1_all").style.backgroundImage = $("img_travel_detail1_all").style.backgroundImage.replace("all_ov.gif","all.gif");
		for (i=0; i<arrSappoint.length; i++){
			if (param == arrSappoint[i]){
				exists = 1;
			}else{
				if (new_sappoint==""){
					new_sappoint = arrSappoint[i];
				}else{
					new_sappoint += "," + arrSappoint[i];
				}
			}
		}
		if (exists==1){ //�̹� ���õǾ� �ִ� ���¸� ��������
			$("img_travel_detail1_"+param).src = $("img_travel_detail1_"+param).src.replace("_ovx.gif", ".gif");
			$("img_travel_detail1_"+param).src = $("img_travel_detail1_"+param).src.replace("_ov.gif", ".gif");
			if (new_sappoint==""){
				$("img_travel_detail1_all").style.backgroundImage = $("img_travel_detail1_all").style.backgroundImage.replace("all.gif","all_ov.gif");
			}
		}else{
			if (new_sappoint==""){
				new_sappoint = param;
			}else{
				new_sappoint += "," + param;
			}
			$("img_travel_detail1_"+param).src = $("img_travel_detail1_"+param).src.replace(".gif", "_ov_ovx.gif");
		}
	}
	obj.sappoint.value = new_sappoint;
	cmdEffectBtnGo(1);
}
/* �װ�ð� ����1 */
function cmdTravelDetail2Click(startend, idx){
	var hm, hmbox1, hmbox2;
	var obj = document.frmTravel;
	var stime = obj.stime.value;
	var existtimes = obj.existtimes.value;

	if (startend=="all"){ //���ð���
		$("img_travel_detail2_all").style.backgroundImage = $("img_travel_detail2_all").style.backgroundImage.replace("all.gif","all_ov_ovx.gif");
		removeTimeBgImg();
		obj.stimetype.value = "";
		obj.stime.value = "";
	}else{
		if (idx==0){
			hm = "0004";
		}else if (idx==1){
			hm = "0408";
		}else if (idx==2){
			hm = "0812";
		}else if (idx==3){
			hm = "1216";
		}else if (idx==4){
			hm = "1620";
		}else if (idx==5){
			hm = "2024";
		}
		if (startend=="start"){
			if ($("detail_time_0_"+idx).innerHTML=="-"){
				return false;
			}
			hm = "S" + hm;
		}else if (startend=="end"){
			if ($("detail_time_1_"+idx).innerHTML=="-"){
				return false;
			}
			hm = "E" + hm;
		}
		if (obj.stimetype.value=="T" || stime==""){ //��ü�ð��뿡�� �Ǵ� �����Է¿��� ����
			stime = hm;
			if (startend=="start"){
				$("detail_time_0_"+idx).className = "detail_timebox_circle_ovx";
			}else if (startend=="end"){
				$("detail_time_1_"+idx).className = "detail_timebox_circle_ovx";
			}
		}else if (obj.stimetype.value!="T" && stime.indexOf(hm)>=0){ //�̹� ���õǾ� �ִ� ���¿��� ��������
			stime = stime.replace(","+hm,"");
			stime = stime.replace(hm+",","");
			stime = stime.replace(hm,"");
			if (startend=="start"){
				$("detail_time_0_"+idx).className = "detail_timebox";
			}else if (startend=="end"){
				$("detail_time_1_"+idx).className = "detail_timebox";
			}
		}else{ //�߰�����
			stime += "," + hm;
			if (startend=="start"){
				$("detail_time_0_"+idx).className = "detail_timebox_circle_ovx";
			}else if (startend=="end"){
				$("detail_time_1_"+idx).className = "detail_timebox_circle_ovx";
			}
		}
		$("img_travel_detail2_all").style.backgroundImage = $("img_travel_detail2_all").style.backgroundImage.replace("all_ov.gif","all.gif");
		if (stime==""){ //�ƹ��͵� ���� �ȵ� �����̸� ��ü�ð���� ����
			$("img_travel_detail2_all").style.backgroundImage = $("img_travel_detail2_all").style.backgroundImage.replace("all.gif","all_ov.gif");
			removeTimeBgImg();
		}
		obj.stime.value = stime;
		obj.stimetype.value = "B";
	}
	$("travel_detail2_1").selectedIndex = 0;
	$("travel_detail2_2").selectedIndex = 0;
	$("travel_detail2_3start").checked = true;
	$("travel_detail2_3end").checked = false;
	$("img_travel_detail2_select").src = $("img_travel_detail2_select").src.replace("time_direct_bt_ov.gif","time_direct.gif");
	cmdTravelDetail2Info();
	cmdTravelDetail2SelectShow(false);
	cmdEffectBtnGo(2);
}
/* �װ�ð� ����2 : �����Է� */
function cmdTravelDetail2Select(){
	$("img_travel_detail2_all").style.backgroundImage = $("img_travel_detail2_all").style.backgroundImage.replace("all_ov.gif","all.gif");
	$("img_travel_detail2_select").src = $("img_travel_detail2_select").src.replace("time_direct.gif","time_direct_bt_ov.gif");
	var startend = "";
	var hms = $("travel_detail2_1").value;
	var hme = $("travel_detail2_2").value;
	
	if ($("travel_detail2_3start").checked) startend = "start";
	if ($("travel_detail2_3end").checked) startend = "end";
	
	var hm = hms + "" + hme;
	var obj = document.frmTravel;
	if (startend=="start"){
		hm = "S" + hm;
	}else{
		hm = "E" + hm;
	}
	obj.stime.value = hm;
	obj.stimetype.value = "T";
	removeTimeBgImg();
	cmdTravelDetail2Info();
	cmdEffectBtnGo(2);
}
/* �װ�ð� �����Է� ���̱� */
function cmdTravelDetail2SelectShow(flag){
	var stimetype = document.frmTravel.stimetype.value;
	var src = $("img_travel_detail2_select").src;
	if (flag){ //���̱�
		$("img_travel_detail2_selectdot").style.display = "inline";
		$("tbl_travel_detail2_select").style.display = "block";
		$("img_travel_detail2_select").style.cursor = "default";
		if (stimetype=="T"){
			src = src.replace("time_direct.gif","time_direct_bt_ov.gif");
			src = src.replace("time_direct_bt.gif","time_direct_bt_ov.gif");
			$("img_travel_detail2_select").src = src;
		}else{
			src = src.replace("time_direct_bt_ov.gif","time_direct.gif");
			src = src.replace("time_direct_bt.gif","time_direct.gif");
			$("img_travel_detail2_select").src = src;
		}
	}else{ //���߱�
		$("img_travel_detail2_selectdot").style.display = "none";
		$("tbl_travel_detail2_select").style.display = "none";
		$("img_travel_detail2_select").style.cursor = "pointer";
		src = src.replace("time_direct.gif","time_direct_bt.gif");
		src = src.replace("time_direct_bt_ov.gif","time_direct_bt.gif");
		$("img_travel_detail2_select").src = src;
	}
}

/* �װ�ð� ���ó��� �ϴܿ� ǥ�� */
function cmdTravelDetail2Info(){
	var obj = document.frmTravel;
	var stime = obj.stime.value;
	var stimetype = obj.stimetype.value;
	var arrStime = stime.split(",");
	var stimeInfo = "";
	var stimeStartInfo = "";
	var stimeEndInfo = "";
	var stimeStartCnt = 0;
	var stimeEndCnt = 0;

	if (stime!=""){
		stimeInfo = "<font style='font-size:9pt'>��</font> ";
		if (stimetype=="B"){ //�̹�����ư���� ����
			for (i=0; i<arrStime.length; i++){
				if (arrStime[i].substring(0,1)=="S"){
					if (stimeStartInfo!="") stimeStartInfo += " �Ǵ� ";
					stimeStartInfo += "<u>" + arrStime[i].substring(1,3) + "~" + arrStime[i].substring(3,5) + "��</u>";
					stimeStartCnt++;
				}else if (arrStime[i].substring(0,1)=="E"){
					if (stimeEndInfo!="") stimeEndInfo += " �Ǵ� ";
					stimeEndInfo += "<u>" + arrStime[i].substring(1,3) + "~" + arrStime[i].substring(3,5) + "��</u>";
					stimeEndCnt++;
				}
			}
			if (stimeStartCnt==6){
				stimeStartInfo = "<u>00~24��</u>";
			}
			if (stimeEndCnt==6){
				stimeEndInfo = "<u>00~24��</u>";
			}
			if (stime.indexOf("S")>=0){
				stimeStartInfo += "�� <font color='blue'>���</font>";
			}
			stimeInfo += stimeStartInfo;
			if (stime.indexOf("E")>=0){
				if (stimeStartInfo!=""){
					stimeInfo += "�ϰ�,<br>&nbsp;&nbsp;&nbsp;&nbsp;";
				}
				stimeEndInfo += "�� <font color='blue'>����</font>";
			}
			stimeInfo += stimeEndInfo + "�ϴ� ��ǰ�� �����߽��ϴ�.";
		}else if (stimetype=="T"){ //�����Է����� ����
			stimeInfo += stime.substring(1,3) + "~" + stime.substring(3,5) + "�ÿ� ";
			if (stime.substring(0,1)=="S"){
				stimeInfo += "<font color='blue'>���</font>";
			}else{
				stimeInfo += "<font color='blue'>����</font>";
			}
			stimeInfo += "�ϴ� ��ǰ�� �����߽��ϴ�.";
		}
	}else{
		stimeInfo = "<font style='font-size:9pt'>��</font> ��� �ð��� ��ǰ�� �����߽��ϴ�.";
	}
	$("travel_detail2_info").innerHTML = stimeInfo;
}
function cmdTravelDetail4Circle(oid,flg,cflag){
	if (flg){
		var oid_width = 0;
		if ($(oid)){
			oid_width = Element.getDimensions($(oid)).width;
			//$("temp").innerText = "width:"+oid_width;
			if (oid_width%10 > 0 && oid_width%10<=5){
				oid_width = parseInt(oid_width/10,10)*10 + 5;
			}else if (oid_width%10 > 5 && oid_width%10<=9){
				oid_width = parseInt(oid_width/10,10)*10 + 10;
			}
			if (oid_width<35){
				oid_width = 35;
			}
			$("p_"+oid).className = "detail_factory_circle_"+oid_width;
			if (cflag){
				tourFactoryCircleOver($("p_"+oid));
			}
		}
	}else{
		$("p_"+oid).className = "";
	}
}
/* ����� ���� */
function cmdTravelDetail4Click(idx){
	var obj = document.frmTravel;
	var sfactory = obj.sfactory.value; //������ �˻����� �����

	if (idx=="all"){ //��ü����� ����
		cmdTravelDetail4Circle("td_detail_factory_all",true,true);
		for(i=0; i<30; i++){
			if ($("detail_factoryname_"+i).innerHTML=="") break;
			cmdTravelDetail4Circle("td_detail_factory_"+i,false);
		}
		sfactory = "";
	}else{ //Ư������� ����
		var clickFactoryName = $("detail_factoryname_"+idx).innerHTML; //Ŭ���� ������
		var clickFactoryCnt = $("detail_factorycnt_"+idx).innerHTML; //Ŭ���� ������� ��ǰ����
		
		cmdTravelDetail4Circle("td_detail_factory_all",false);
		if (sfactory.indexOf(clickFactoryName)>=0){ //���õ� ����� �ٽ� Ŭ��
			cmdTravelDetail4Circle("td_detail_factory_"+idx,false);
			sfactory = sfactory.replace(","+clickFactoryName,"");
			sfactory = sfactory.replace(clickFactoryName+",","");
			sfactory = sfactory.replace(clickFactoryName,"");
			if (sfactory==""){
				cmdTravelDetail4Circle("td_detail_factory_all",true);
			}
		}else{ //���þȵ� ����� ����
			cmdTravelDetail4Circle("td_detail_factory_"+idx,true,true);
			if (sfactory.indexOf(clickFactoryName)<0){
				if (sfactory!="") sfactory += ",";
				sfactory += clickFactoryName;
			}
		}
	}
	obj.sfactory.value = sfactory;
	cmdEffectBtnGo(4);
}
/* �װ�� ���� */
function cmdTravelDetail4AirClick(idx){
	var obj = document.frmTravel;
	var sairline = obj.sairline.value; //������ �˻����� �װ��

	if (idx=="all"){ //��ü�װ�� ����
		cmdTravelDetail4Circle("td_detail_air_all",true,true);
		for(i=0; i<80; i++){
			if ($("detail_airname_"+i).innerHTML=="") break;
			cmdTravelDetail4Circle("td_detail_air_"+i,false);
		}
		sairline = "";
	}else{ //Ư���װ�� ����
		var clickAirCode = $("detail_airname_"+idx).code; //Ŭ���� �װ���ڵ�
		var clickAirCnt = $("detail_aircnt_"+idx).innerHTML; //Ŭ���� �װ���� ��ǰ����
		
		cmdTravelDetail4Circle("td_detail_air_all",false);
		if (sairline.indexOf(clickAirCode)>=0){ //���õ� �װ�� �ٽ� Ŭ��
			cmdTravelDetail4Circle("td_detail_air_"+idx,false);
			sairline = sairline.replace(","+clickAirCode,"");
			sairline = sairline.replace(clickAirCode+",","");
			sairline = sairline.replace(clickAirCode,"");
			if (sairline==""){
				cmdTravelDetail4Circle("td_detail_air_all",true);
			}
		}else{ //���þȵ� �װ�� ����
			cmdTravelDetail4Circle("td_detail_air_"+idx,true,true);
			if (sairline.indexOf(clickAirCode)<0){
				if (sairline!="") sairline += ",";
				sairline += clickAirCode;
			}
		}
	}
	obj.sairline.value = sairline;
	cmdEffectBtnGo(4);
}
/* ����Ⱓ ��μ��� ���·� */
function resetTravelPeriod(){
	var obj = document.frmTravel;
	obj.spday.value = obj.spday.defaultValue;
	var spday = obj.spday.value;
	if (spday==""){ //��ü�Ⱓ ����
		$("img_travel_detail0_all").style.backgroundImage = $("img_travel_detail0_all").style.backgroundImage.replace("all.gif","all_ov.gif");
		for (i=3; i<=10; i++){
			if ($("td_travel_detail0_"+i)){
				$("td_travel_detail0_"+i).className = "detail_period";
			}
		}
	}else{ //Ư���Ⱓ ���û�
		$("img_travel_detail0_all").style.backgroundImage = $("img_travel_detail0_all").style.backgroundImage.replace("all_ov.gif","all.gif");
		for (i=3; i<=10; i++){
			if (spday.indexOf(i)>=0){
				if ($("td_travel_detail0_"+i)){
					$("td_travel_detail0_"+i).className = "detail_period_circle";
				}
			}else{
				if ($("td_travel_detail0_"+i)){
					$("td_travel_detail0_"+i).className = "detail_period";
				}
			}
		}
	}
}
/* ������� ���� */
function resetAppointFlag(){
	var obj = document.frmTravel;
	obj.sappoint.value = obj.sappoint.defaultValue;
	var sappoint = obj.sappoint.value;
	if (sappoint==""){
		$("img_travel_detail1_all").style.backgroundImage = $("img_travel_detail1_all").style.backgroundImage.replace("all.gif","all_ov.gif");
		$("img_travel_detail1_1").src = $("img_travel_detail1_1").src.replace("1_ov.gif", "1.gif");
		$("img_travel_detail1_2").src = $("img_travel_detail1_2").src.replace("2_ov.gif", "2.gif");
		$("img_travel_detail1_3").src = $("img_travel_detail1_3").src.replace("3_ov.gif", "3.gif");
	}else{
		$("img_travel_detail1_all").style.backgroundImage = $("img_travel_detail1_all").style.backgroundImage.replace("all_ov.gif","all.gif");
		for (i=1; i<=3; i++){
			if (sappoint.indexOf(i)>=0){
				$("img_travel_detail1_"+i).src = $("img_travel_detail1_"+i).src.replace(i+".gif", i+"_ov.gif");
			}else{
				$("img_travel_detail1_"+i).src = $("img_travel_detail1_"+i).src.replace("_ov.gif", ".gif");
			}
		}
	}
}
/* �װ�ð� ���� ���� */
function resetTravelTime(){
	var hm, hmbox1, hmbox2;
	var obj = document.frmTravel;
	obj.stimetype.value = obj.stimetype.defaultValue;
	obj.stime.value = obj.stime.defaultValue;
	var stimetype = obj.stimetype.value;
	var stime = obj.stime.value;
	var existtimes = obj.existtimes.value;
	$("travel_detail2_info").innerHTML = strStartTimeInfo;

	if (stimetype=="" || stimetype=="B"){
		if (stime==""){ //���ð���
			$("img_travel_detail2_all").style.backgroundImage = $("img_travel_detail2_all").style.backgroundImage.replace("all.gif","all_ov.gif");
			removeTimeBgImg();
			obj.stimetype.value = "";
		}else{
			for (i=0; i<6; i++){
				if (i==0){
					hm = "0004";
				}else if (i==1){
					hm = "0408";
				}else if (i==2){
					hm = "0812";
				}else if (i==3){
					hm = "1216";
				}else if (i==4){
					hm = "1620";
				}else if (i==5){
					hm = "2024";
				}
				
				if ($("detail_time_0_"+i).innerHTML=="-"){
					$("detail_time_0_"+i).className = "detail_timebox_empty";
				}else{
					if (stime.indexOf("S"+hm)>=0){
						$("detail_time_0_"+i).className = "detail_timebox_circle";
					}else{
						$("detail_time_0_"+i).className = "detail_timebox";
					}
				}
			}
			for (i=0; i<6; i++){
				if (i==0){
					hm = "0004";
				}else if (i==1){
					hm = "0408";
				}else if (i==2){
					hm = "0812";
				}else if (i==3){
					hm = "1216";
				}else if (i==4){
					hm = "1620";
				}else if (i==5){
					hm = "2024";
				}
				
				if ($("detail_time_1_"+i).innerHTML=="-"){
					$("detail_time_1_"+i).className = "detail_timebox_empty";
				}else{
					if (stime.indexOf("E"+hm)>=0){
						$("detail_time_1_"+i).className = "detail_timebox_circle";
					}else{
						$("detail_time_1_"+i).className = "detail_timebox";
					}
				}
			}
		}
		$("travel_detail2_1").selectedIndex = 0;
		$("travel_detail2_2").selectedIndex = 0;
		$("travel_detail2_3start").checked = true;
		$("travel_detail2_3end").checked = false;
		$("img_travel_detail2_select").src = $("img_travel_detail2_select").src.replace("time_direct_bt_ov.gif","time_direct.gif");
	}else{
		$("img_travel_detail2_all").style.backgroundImage = $("img_travel_detail2_all").style.backgroundImage.replace("all_ov.gif","all.gif");
		$("img_travel_detail2_select").src = $("img_travel_detail2_select").src.replace("time_direct.gif","time_direct_bt_ov.gif");

		if (stime!=""){
			if (stime.substring(0,1)=="S"){
				$("travel_detail2_3start").checked = true;
				$("travel_detail2_3end").checked = false;
			}else if (stime.substring(0,1)=="E"){
				$("travel_detail2_3start").checked = false;
				$("travel_detail2_3end").checked = true;
			}
			for (i=0; i<24; i++){
				if (i==parseInt(stime.substring(1,3),10)){
					$("travel_detail2_1").selectedIndex = i;
				}
				if (i==parseInt(stime.substring(3,5),10)){
					$("travel_detail2_2").selectedIndex = i;
				}
			}
		}
		removeTimeBgImg();
	}
}

/* �װ�ð� ��μ��� ���·� */
function resetTimeBgImg(){
	for(i=0; i<6; i++){
		if ($("detail_time_0_"+i).innerHTML=="-"){
			$("detail_time_0_"+i).className = "detail_timebox_empty";
		}else{
			$("detail_time_0_"+i).className = "detail_timebox_circle";		
		}
		if ($("detail_time_1_"+i).innerHTML=="-"){
			$("detail_time_1_"+i).className = "detail_timebox_empty";
		}else{
			$("detail_time_1_"+i).className = "detail_timebox_circle";		
		}
	}
}
/* �װ�ð� ���� �̹��� ���� */
function removeTimeBgImg(){
	for(i=0; i<6; i++){
		if ($("detail_time_0_"+i).innerHTML=="-"){
			$("detail_time_0_"+i).className = "detail_timebox_empty";
		}else{
			$("detail_time_0_"+i).className = "detail_timebox";		
		}
		if ($("detail_time_1_"+i).innerHTML=="-"){
			$("detail_time_1_"+i).className = "detail_timebox_empty";
		}else{
			$("detail_time_1_"+i).className = "detail_timebox";		
		}
	}
}
/* ���ݴ� ���� */
function resetTravelPrice(){
	var obj = document.frmTravel;
	var spricef = obj.spricef.value;
	var spricet = obj.spricet.value;
	if (spricef==0 && spricet==0){
		$("travel_detail3_min").value = intTravelMinPrice;
		$("travel_detail3_max").value = intTravelMaxPrice;
	}else{
		$("travel_detail3_min").value = $("travel_detail3_min").defaultValue;
		$("travel_detail3_max").value = $("travel_detail3_max").defaultValue;
	}
}

/* ����缱�� ���� */
function resetFactory(){
	var obj = document.frmTravel;
	obj.sfactory.value = obj.sfactory.defaultValue;
	sfactory = obj.sfactory.value;
	if (sfactory==""){ //��ü����� ����
		cmdTravelDetail4Circle("td_detail_factory_all",true);
	}else{
		cmdTravelDetail4Circle("td_detail_factory_all",false);
	}
	for(i=0; i<30; i++){
		if ($("detail_factoryname_"+i).innerHTML=="") break;
		if (sfactory.indexOf($("detail_factoryname_"+i).innerHTML)>=0){
			cmdTravelDetail4Circle("td_detail_factory_"+i,true);
		}else{
			cmdTravelDetail4Circle("td_detail_factory_"+i,false);
		}
	}
}

/* �װ�缱�� ���� */
function resetAirline(){
	var obj = document.frmTravel;
	obj.sairline.value = obj.sairline.defaultValue;
	sairline = obj.sairline.value;
	if (sairline==""){ //��ü����� ����
		cmdTravelDetail4Circle("td_detail_air_all",true);
	}else{
		cmdTravelDetail4Circle("td_detail_air_all",false);
	}
	for(i=0; i<80; i++){
		if ($("detail_airname_"+i).innerHTML=="") break;
		if (sairline.indexOf($("detail_airname_"+i).code)>=0){
			cmdTravelDetail4Circle("td_detail_air_"+i,true);
		}else{
			cmdTravelDetail4Circle("td_detail_air_"+i,false);
		}
	}
}
function cmdEffectBtnGo(tab){
	if ($("img_travel_detail"+tab+"_default").style.display=="block"){
		$("img_travel_detail"+tab+"_default").style.display = "none";
		$("img_travel_detail"+tab+"_go").style.display = "block";
	}
	/*
	if (!$("img_travel_detail"+tab+"_go").visible()){
		var varDetail0GoLeft = Position.cumulativeOffset($("td_travel_detail"+tab+"_go"))[0]-15;
		var varDetail0GoTop = Position.cumulativeOffset($("td_travel_detail"+tab+"_go"))[1]+15;
		if (tab==0){
			varDetail0GoLeft += 20;
		}else if (tab==1){
		
		}else if (tab==2){
			varDetail0GoLeft -= 40;
			varDetail0GoTop -= 20;
		}else if (tab==3){
			varDetail0GoTop += 10;
		}
		$("img_travel_detail"+tab+"_go").style.left = varDetail0GoLeft-80;
		$("img_travel_detail"+tab+"_go").style.top = varDetail0GoTop;
		new Effect.Parallel(
		    [ 
				new Effect.Appear( $("img_travel_detail"+tab+"_go")),
				new Effect.MoveBy( $("img_travel_detail"+tab+"_go"), varDetail0GoTop, varDetail0GoLeft , {duration: 0.5,  transition: Effect.Transitions.sinoidal,mode:'absolute'})
				
			],
		    {duration: 1,  transition: Effect.Transitions.sinoidal,mode:'absolute'}
		);
	}else{
		if (tab!=3){
			new Effect.Pulsate($("img_travel_detail"+tab+"_go"),{duration: 0.5,pulses:3,afterFinish:function(){Element.setOpacity($("img_travel_detail"+tab+"_go"), 1);}});
		}
	}
	*/
}
function CmdLink(url){
	location.href = url;
}
function CmdPopLink(url){
	var w = window.screen.width;
	var h = screen.availHeight ;
	var win = window.open(url,"","width="+w+" height="+h+" top=0 left=0 toolbar=yes,location=yes,directories=yes,status=yes,scrollbars=yes,resizable=yes,menubar=yes,personalbar=yes");
	win.focus();
}
function cmdTravelRedirect(param, nocpc){
	var w = window.screen.width;
	var h = screen.availHeight ;
	if (nocpc){
		var win = window.open("/move/Redirect_Travel.jsp?model_subno="+param+"&nocpc=Y","","width="+w+" height="+h+" top=0 left=0 toolbar=yes,location=yes,directories=yes,status=yes,scrollbars=yes,resizable=yes,menubar=yes,personalbar=yes");
	}else{
		var win = window.open("/move/Redirect_Travel.jsp?model_subno="+param,"","width="+w+" height="+h+" top=0 left=0 toolbar=yes,location=yes,directories=yes,status=yes,scrollbars=yes,resizable=yes,menubar=yes,personalbar=yes");
	}
	win.focus();
}
function fnGetCookie( name ){

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
function fnSetTravelCookie(){
	var maxage = 7;
	var todayDate = new Date();
	todayDate.toGMTString()
	todayDate.setDate( todayDate.getDate() + maxage );
	document.cookie = "DetailInfoTravel" + "=" + escape( "CHECKED" ) + "; path=/; expires=" + todayDate.toGMTString() + ";";
	if ($("div_map_detail_info_travel")){
		$("div_map_detail_info_travel").style.display = "none";
	}else if (parent.$("div_map_detail_info_travel")){
		parent.$("div_map_detail_info_travel").style.display = "none";
	}
	return;
}
function syncHeightTravelFrame(el) {
	try{
		$("travelListFrame").height = $("travelListFrame").contentWindow.document.body.scrollHeight;
		tourScroll();
   	}catch(e){}
}
function syncHeightListFrame(){
	setTimeout("syncHeightTravelFrame()",300);
}

function cmdRemoveSpchar(param){
	var schWrdExp = param;
	schWrdExp = replaceSpchar(schWrdExp, "'");		
	schWrdExp = replaceSpchar(schWrdExp, "\"");	
    schWrdExp = replaceSpchar(schWrdExp, "~");
    schWrdExp = replaceSpchar(schWrdExp, "!");
    schWrdExp = replaceSpchar(schWrdExp, "@");
    schWrdExp = replaceSpchar(schWrdExp, "#");
    schWrdExp = replaceSpchar(schWrdExp, "$");
    schWrdExp = replaceSpchar(schWrdExp, "%");
    schWrdExp = replaceSpchar(schWrdExp, "^");
    schWrdExp = replaceSpchar(schWrdExp, "&");        
    schWrdExp = replaceSpchar(schWrdExp, "*");
    schWrdExp = replaceSpchar(schWrdExp, "+");
    schWrdExp = replaceSpchar(schWrdExp, "=");
    schWrdExp = replaceSpchar(schWrdExp, "\\");
    schWrdExp = replaceSpchar(schWrdExp, "{");
    schWrdExp = replaceSpchar(schWrdExp, "}");
    schWrdExp = replaceSpchar(schWrdExp, "[");
    schWrdExp = replaceSpchar(schWrdExp, "]");
    schWrdExp = replaceSpchar(schWrdExp, ":");
    schWrdExp = replaceSpchar(schWrdExp, ";");
    schWrdExp = replaceSpchar(schWrdExp, "/");
    schWrdExp = replaceSpchar(schWrdExp, "<");
    schWrdExp = replaceSpchar(schWrdExp, ">");
    schWrdExp = replaceSpchar(schWrdExp, "."); 
    schWrdExp = replaceSpchar(schWrdExp, "?");
    schWrdExp = replaceSpchar(schWrdExp, "(");
    schWrdExp = replaceSpchar(schWrdExp, ")");
    schWrdExp = replaceSpchar(schWrdExp, "'");
    schWrdExp = replaceSpchar(schWrdExp, "_");
    schWrdExp = replaceSpchar(schWrdExp, "-");
    schWrdExp = replaceSpchar(schWrdExp, "`");
    schWrdExp = replaceSpchar(schWrdExp, "|");
    schWrdExp = schWrdExp.trim();
	schWrdExp = schWrdExp.replace(","," ");
	
	if (schWrdExp.length>0){
		var arrWrd = schWrdExp.split(" ");
		if (arrWrd.length>0){
			schWrdExp = "";
			for (i=0; i<arrWrd.length; i++){
				if (arrWrd[i].trim()!=""){
					if (schWrdExp.length>0) schWrdExp += " ";
					schWrdExp += arrWrd[i].trim();
				}
			}
		}
	}

	var schLen = schWrdExp.length;	
	var varExpKeyWord = "";

	if(schLen < 2){
		if (schLen == 1 && varExpKeyWord.indexOf(schWrdExp) >= 0 ){
			return schWrdExp;
		}else{
			alert("2�� �̻��� �˻�� ��������.\t\t\r\n\Ư�����ڴ� ���� �˴ϴ�.");
			return schWrdExp;
		}
	}else{
		return schWrdExp;
	}
}
function replaceSpchar(src, delWrd){
	var newSrc = "";
	var i;
	for(i=0; i<src.length; i++){
		if(src.charAt(i) != delWrd) {
			newSrc = newSrc + src.charAt(i);
		}			
	}
	return newSrc;
}
function insertSession(sname, sval){
	var url = "/travel/SetTravelSession.jsp";
	var param = "sname="+sname+"&svalue="+sval;
	var getRec = new Ajax.Request(
		url,
		{
			method:'get',parameters:param
		}
	);
}
// ������ ����� ���� üũ�ϴ� ��ü ���� �Լ�
function objDetectBrowser() {
	var strUA, s, i;
	this.isIE = false;  // ���ͳ� �ͽ��÷η������� ��Ÿ���� �Ӽ�
	this.isNS = false;  // �ݽ������������� ��Ÿ���� �Ӽ�
	this.version = null; // ������ ������ ��Ÿ���� �Ӽ�
	// Agent ������ ��� �ִ� ���ڿ�.
	// �� ���� �ñ��� ����� alert ���� �̿��Ͽ� strUA ���� Ȯ���ϱ� �ٶ���!
	strUA = navigator.userAgent; 
	
	s = "MSIE";
	// Agent ���ڿ�(strUA) "MSIE"�� ���ڿ��� ��� �ִ��� üũ
	if ((i = strUA.indexOf(s)) >= 0) {
		this.isIE = true;
		// ���� i���� strUA ���ڿ� �� MSIE�� ���۵� ��ġ ���� ����ְ�,
		// s.length�� MSIE�� ���� ��, 4�� ��� �ִ�.
		// strUA.substr(i + s.length)�� �ϸ� strUA ���ڿ� �� MSIE ������ 
		// ������ ���ڿ��� �߶�´�.
		// �� ���ڿ��� parseFloat()�� ��ȯ�ϸ� ������ �˾Ƴ� �� �ִ�.
		this.version = parseFloat(strUA.substr(i + s.length));
		return;
	}
	
	s = "Netscape6/";
	// Agent ���ڿ�(strUA) "Netscape6/"�̶� ���ڿ��� ��� �ִ��� üũ
	if ((i = strUA.indexOf(s)) >= 0) {
		this.isNS = true;
		this.version = parseFloat(strUA.substr(i + s.length));
		return;
	}
	
	// �ٸ� "Gecko" ������� NS 6.1�� ���.
	s = "Gecko";
	if ((i = strUA.indexOf(s)) >= 0) {
		this.isNS = true;
		this.version = 6.1;
		return;
	}
}

var objDetectBrowser = new objDetectBrowser();

// ���� Ȱ��ȭ�� ��ư�� �����ϱ� ���� �� ����.
var gvActiveButton = null;

// ��ư�� �ƴ� �ٸ� ���� ���콺�� Ŭ���ϸ� Ȱ��ȭ�� ��ư�� ��Ȱ��ȭ�� ����.
if (objDetectBrowser.isIE)
	document.onmousedown = mousedownPage;
if (objDetectBrowser.isNS)
	document.addEventListener("mousedown", mousedownPage, true);

function mousedownPage(event) {
	var objElement;
	
	// Ȱ��ȭ�� ��ư�� ������ ������ ���� ����.
	if (!gvActiveButton)
		return;
	
	// ���� ���õ� ��ü ��Ҹ� ��� ��.
	if (objDetectBrowser.isIE)
		objElement = window.event.srcElement;
	if (objDetectBrowser.isNS)
		objElement = (event.target.className ? event.target : event.target.parentNode);
	
	// ���� ���� Ȱ��ȭ�� ��ư�� Ŭ���ߴٸ� �׳� ������ ���� ����.
	if (objElement == gvActiveButton)
		return;
	
	// ���� Ŭ���� ��Ұ� �޴� ��ư, �޴� ������ ���� �ƴϸ� Ȱ��ȭ�� �޴��� ��Ȱ��ȭ ��Ŵ.
	
	if (objElement.className != "menuButton"  && objElement.className != "menuItem" && objElement.className != "menuItem2" &&
		objElement.className != "menuItemSep" && objElement.className != "menu")
		resetButton(gvActiveButton);
}

function mouseoverButton(objMnuButton, strMenuName) {
	// ���� �ٸ� �޴� ��ư�� Ȱ��ȭ�Ǿ� �ִٸ� ��Ȱ��ȭ ��Ų ��
	// ���� ���콺 ������ �޴��� Ȱ��ȭ ��Ų��.
	if (gvActiveButton && gvActiveButton != objMnuButton) {
		resetButton(gvActiveButton);
	if (strMenuName)
		clickButton(objMnuButton, strMenuName);
	}
}

function clickButton(objMnuButton, strMenuName) {
	// ��ũ �ֺ��� �ƿ������� ���.
	objMnuButton.blur();
	// �� �޴� ��ư�� ���� Ǯ�ٿ� �޴� ��ü�� ������
	// menu �� �̸��� ��ü ��
	if (!objMnuButton.menu)
		objMnuButton.menu = document.getElementById(strMenuName);
	// ���� Ȱ��ȭ�� �޴� ��ư�� ó�� ���·� �ǵ���.
	if (gvActiveButton && gvActiveButton != objMnuButton)
		resetButton(gvActiveButton);	
	// �޴� ��ư Ȱ��ȭ ���ο� ��� Ȱ��ȭ/��Ȱ��ȭ ���.
	if (gvActiveButton){
		resetButton(objMnuButton);
	}
	else{
		pulldownMenu(objMnuButton);
	}  
	return false;
}

function pulldownMenu(objMnuButton) {
	// ���� ���õ� ��ü�� Ŭ������ "Ȱ��ȭ" Ŭ������ ����
	objMnuButton.className = "menuButtonActive";
	
	// �ͽ��÷η��� ���, ù ��° �޴� �����ۿ� ���� ��Ȯ�� ���� ����� �ֵ��� �Ѵ�.
	// ���� �� �κ��� �������� ������ ���콺�� �޴� ������ ������ �ؽ�Ʈ ���� �÷����� ����
	// ����ȴ�. ���� �ؽ�Ʈ�� �ƴ� �޴� ������ ���� ���θ� ���� ���� �����Ű����
	// �� �κ��� ������ ��� �Ѵ�.
	if (objDetectBrowser.isIE && !objMnuButton.menu.firstChild.style.width) {
	  objMnuButton.menu.firstChild.style.width = objMnuButton.menu.firstChild.offsetWidth + "px";
	}
	
	// ������� ���� ȯ�濡 �´� ��� �ٿ� �޴��� ��ġ�� 
	// ������ ��� �Ѵ�.
	x = objMnuButton.offsetLeft;
	y = objMnuButton.offsetTop + objMnuButton.offsetHeight;
	
	if (objDetectBrowser.isIE) {
		x += -1;
		y += 1;
	}
	if (objDetectBrowser.isNS && objDetectBrowser.version < 6.1)
		y--;
	
	// ��ġ ���� �� Ǯ�ٿ� �޴��� ������
	objMnuButton.menu.style.left = x + "px";
	objMnuButton.menu.style.top  = y + "px";
	objMnuButton.menu.style.visibility = "visible";
	
	// ���� Ȱ��ȭ�� �޴� ��ü�� �����ϴ� ��� gvActiveButon��
	// ���� ���õ� �޴� ��ü�� ����
	gvActiveButton = objMnuButton;
}

function resetButton(objMnuButton) {
	// �� ��Ÿ�Ϸ� �ǵ���
	objMnuButton.className = "menuButton";
	// ������ Ǯ�ٿ� �޴��� ������
	if (objMnuButton.menu)
	objMnuButton.menu.style.visibility = "hidden";
	// ���� Ȱ��ȭ�� �޴� ��ư�� ��� ������ ����
	gvActiveButton = null;
}

function resetButton2(obj) {
	// �� ��Ÿ�Ϸ� �ǵ���
	obj.style.display = "none";
	// ���� Ȱ��ȭ�� �޴� ��ư�� ��� ������ ����
	gvActiveButton = null;
}

function CmdMouseOver(Obj,n){
	if(n==1){ //onmouseover
		Obj.style.backgroundColor="#08246B";
		Obj.style.color="#FFFFFF";
	}else{
		Obj.style.backgroundColor="#FFFFFF";
		Obj.style.color="#000000";
	}
}
/* �̹��� ��ĥ�� ����ó�� */
function setPng24(obj) { 
    obj.width=obj.height=1; 
    obj.className=obj.className.replace(/\bpng24\b/i,''); 
    obj.style.filter = 
    "progid:DXImageTransform.Microsoft.AlphaImageLoader(src='"+ obj.src +"',sizingMethod='image');" 
    obj.src='';
    return '';
}
function MM_swapImgRestore() { //v3.0
  var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
}
function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}

function MM_findObj(n, d) { //v4.01
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
  if(!x && d.getElementById) x=d.getElementById(n); return x;
}

function MM_swapImage() { //v3.0
  var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3)
   if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}
}
function tourBackImgOver(obj){
	var bimg = obj.style.backgroundImage;
	if (bimg && bimg.indexOf("_ov")>0 && bimg.indexOf("_ovx.gif")<0){
		obj.style.backgroundImage = bimg.replace(".gif", "_ovx.gif");
	}
}
function tourBackImgOut(obj){
	var bimg = obj.style.backgroundImage;
	if (bimg && bimg.indexOf("_ovx.gif")>0){
		obj.style.backgroundImage = bimg.replace("_ovx.gif", ".gif");
	}
}
function tourImgOver(obj){
	var bimg = obj.src;
	if (bimg && bimg.indexOf("_ov")>0 && bimg.indexOf("_ovx.gif")<0){
		obj.src = bimg.replace(".gif", "_ovx.gif");
	}
}
function tourImgOut(obj){
	var bimg = obj.src;
	if (bimg && bimg.indexOf("_ovx.gif")>0){
		obj.src = bimg.replace("_ovx.gif", ".gif");
	}
}
function tourFactoryCircleOver(obj){
	if (obj && obj.className!="" && obj.className.indexOf("_circle")>0 && obj.className.indexOf("_ovx")<0){
		obj.className = obj.className + "_ovx";
	}
}
function tourFactoryCircleOut(obj){
	if (obj && obj.className!="" && obj.className.indexOf("_circle")>0 && obj.className.indexOf("_ovx")>0){
		obj.className = obj.className.replace("_ovx","");
	}
}