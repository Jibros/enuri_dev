<%
//part1 : 선택가능 항목정보
if(strTabinfoYn.equals("Y")){
	String tabyn_open = ""; //오픈마켓
	String tabyn_dlv0 = ""; //무료배송
	String tabyn_junggo = ""; //전시/중고
	String tabyn_return = ""; //반품/리퍼
	String tabyn_tariffree = ""; //세금/배송비무료(해외쇼핑)
	String tabyn_auth = ""; //제조사인증
	String tabyn_auth_nm = ""; //제조사인증 업체명
	String tabyn_realprice = ""; //판매가쇼핑몰
	String tabyn_aircon_1 = ""; //기본설치비(스탠드+벽걸이) 포함
	String tabyn_aircon_2 = ""; //기본설치비(스탠드+벽걸이+진공비) 포함
	String tabyn_aircon_4 = ""; //기본설치비+진공비 포함
	String tabyn_tirefree = ""; //전국무료장착(타이어)
	String tabyn_depart = ""; //백화점몰
	String tabyn_card = ""; //카드할인
	String tabyn_cardfree = ""; //무이자
	String tabyn_etcmall = "";	//홈쇼핑/전문몰 (2015.03.20 생성)

	boolean phonePriceAllFlag = false; //휴대폰 여부
	phonePriceAllFlag = checkPhonePriceAllFlag(strCategory, goods_data_pop.getModelnm());
	// 현재 리스트에 나오는 상품들 중에 배송비가 있는 것이 확실한 상품의 개수를 구함
	int deliveryType1Num2 = 0;

	if(strCategory.length() >= 2 && ControlUtil.compareValOR(new String[]{CutStr.cutStr(strCategory,2),"14"})){
		tabyn_dlv0 = "Y";
	}
	//if(CutStr.cutStr(strCategory,6).equals("033308") || CutStr.cutStr(strCategory,6).equals("080710") || CutStr.cutStr(strCategory,8).equals("03330501")) {
	if(CutStr.cutStr(strCategory,6).equals("033308") || CutStr.cutStr(strCategory,6).equals("080710") || CutStr.cutStr(strCategory,6).equals("165410") || CutStr.cutStr(strCategory,8).equals("03330501")) {
		tabyn_open = "Y";
	}
	if(ControlUtil.compareValOR(new int[]{intModelno,1248637,1720032,1720028,1247170,1248620,1248888,1248623,1370212,1370216,1267468,1248613,1267467,1248860,1243685})
		|| ControlUtil.compareValOR(new String[]{CutStr.cutStr(strCategory,8),"03330501"})
		|| CutStr.cutStr(strCategory,4).equals("0304")
		|| CutStr.cutStr(strCategory,8).equals("02332217")
		|| ControlUtil.compareValOR(new String[]{CutStr.cutStr(strCategory,4),"0404","2401"})
	){
		tabyn_open = "Y";
	}
	if(goods_data_pop.getModelnm().indexOf("[")>=0 && goods_data_pop.getModelnm().indexOf("]")>=0 && goods_data_pop.getModelnm().indexOf("[렌탈")>=0){
		tabyn_open = "Y";
	}
	if(ControlUtil.compareValOR(new String[]{CutStr.cutStr(strCategory,4),"0527"}) && goods_data_pop.getModelnm().indexOf("약정조건")>=0) {
		tabyn_open = "Y";
	}
	if(ControlUtil.compareValOR(new String[]{CutStr.cutStr(strCategory,6),"033316","033317","033318","033319","033305","033308","090813","090816","090817"})
		|| (ControlUtil.compareValOR(new String[]{CutStr.cutStr(strCategory,6),"033301"}) && goods_data_pop.getModelnm().indexOf("PIN번호")>-1)
		|| (ControlUtil.compareValOR(new String[]{CutStr.cutStr(strCategory,4),"1647"}) && goods_data_pop.getModelnm().indexOf("PIN번호")>-1)
		|| (ControlUtil.compareValOR(new String[]{CutStr.cutStr(strCategory,4),"1647"}) && goods_data_pop.getSpec().indexOf("모바일상품권")>-1)
		|| (ControlUtil.compareValOR(new String[]{CutStr.cutStr(strCategory,4),"1647"}) && goods_data_pop.getSpec().indexOf("모바일쿠폰")>-1)
	){
		tabyn_open = "Y";
	}
	if(ControlUtil.compareValOR(new String[]{CutStr.cutStr(strCategory,8),"02010109","02010110"})) {
		tabyn_dlv0 = "Y";
	}
	if(ControlUtil.compareValOR(new String[]{CutStr.cutStr(strCategory,6),"090503","090504","090505","090506","090508","090509","090511","090519"})) {
		tabyn_dlv0 = "Y";
	}
	if(ControlUtil.compareValOR(new String[]{CutStr.cutStr(strCategory,4),"0502","1242","2406","2403","0602"})) {
		tabyn_dlv0 = "Y";
	}
	if(ControlUtil.compareValOR(new String[]{CutStr.cutStr(strCategory,4),"0405","0503","0527","0601","0604","0621","1220","1201","1202","1203","1204","1205","1207"})
		|| ControlUtil.compareValOR(new String[]{CutStr.cutStr(strCategory,6),"031502","031503"})
	){
		tabyn_dlv0 = "Y";
	}
	if(ControlUtil.compareValOR(new int[]{intModelno,1248637,1720032,1720028,1247170,1248620,1248888,1248623,1370212,1370216,1267468,1248613,1267467,1248860,1243685})
		|| ControlUtil.compareValOR(new int[]{intModelno_group,1248637,1720032,1720028,1247170,1248620,1248888,1248623,1370212,1370216,1267468,1248613,1267467,1248860,1243685})
	) {
		tabyn_dlv0 = "";
	}
	//에어컨
	String airconFlag = "";
	if(CutStr.cutStr(strCategory,4).equals("2401")){
		//airconFlag = Goods_Search.getAirconFlag(intModelno);
		if(!airconFlag.equals("") && !airconFlag.equals("3")){
			if(airconFlag.equals("1")){ //멀티형 - 인버터X
				tabyn_aircon_1 = "Y";
			}else if(airconFlag.equals("2")){ //멀티형 - 인버터
				tabyn_aircon_2 = "Y";
			}else if(airconFlag.equals("4")){ //벽걸이,스탠드형 - 인버터
				tabyn_aircon_4 = "Y";
			}
		}
	}
	// 전시,중고,반품/리퍼 구분이 있는지 확인
	boolean jungoModelFind = false;
	int junggoShowType = 0;
	try {
		if(!phonePriceAllFlag && goods_data_pop.getModelnm().indexOf("[")>-1 && goods_data_pop.getModelnm().substring(goods_data_pop.getModelnm().indexOf("[")).indexOf("중고")>-1 && !((ControlUtil.compareValOR(new String[]{CutStr.cutStr(strCategory,4),"0304","0305"}) || CutStr.cutStr(strCategory,8).equals("02332217")) && goods_data_pop.getModelnm().indexOf("해외쇼핑")>-1)) {
			jungoModelFind = true;
		}
	} catch(Exception e) {}
	//해외쇼핑 관세기준
	if(goods_data_pop.getModelnm().indexOf("[")>-1 && goods_data_pop.getModelnm().substring(goods_data_pop.getModelnm().indexOf("[")).indexOf("해외쇼핑")>-1){
		if(mMinPrice>=100000){
			tabyn_tariffree = "Y";
			jungoModelFind = false;
		}else{
			tabyn_dlv0 = "";
		}
	}
	if(aszPlist!=null) {
		for(int i=0; i<aszPlist.length; i++) {
			// 제조사 인증 공식판매자 여부 확인
			if(!tabyn_auth.equals("Y") && !aszPlist[i].getOption_flag2().equals("1") && aszPlist[i].getAuthflag().equals("Y")) {
				if(!getAuthLogoCheck(strCategory, strFactory).equals("")){
					tabyn_auth = "Y";
				}
			}
			if(aszPlist[i].getPrice_flag().equals("0") && ( CutStr.cutStr(strCategory,4).equals("0304") || CutStr.cutStr(strCategory,4).equals("0305") ) ){ //price_flag로만 체크
				tabyn_realprice = "Y";
			}
			//타이어 분류 무료장착
			if(!tabyn_tirefree.equals("Y") && CutStr.cutStr(strCategory,4).equals("2115") && aszPlist[i].getAirconfeetype().equals("2")){
				//tabyn_tirefree = "Y";
			}
			//중고/전시
			if(jungoModelFind && junggoShowType!=3) {
				if(aszPlist[i].getAirconfeetype().equals("3")) junggoShowType = 3;
				if(aszPlist[i].getAirconfeetype().equals("4")) junggoShowType = 3;
			}
			
			//if(aszPlist[i].getShop_code()==75){
			//	System.out.println("aszPlist[i].getPrice_card()>>>"+aszPlist[i].getPrice_card());
			//	System.out.println("aszPlist[i].getOption_flag2()>>>"+aszPlist[i].getOption_flag2());
			//	System.out.println("cardShopCodes>>>"+cardShopCodes);
			//	System.out.println("aszPlist[i].getShop_code()>>>"+aszPlist[i].getShop_code());
				
			//	System.out.println("aszPlist[i].getGoodsnm()>>>"+aszPlist[i].getGoodsnm());
			//	System.out.println("aszPlist[i].getPrice()>>>"+aszPlist[i].getPrice());
			//	System.out.println("strCategory>>>"+strCategory);
			//}
			
			// 신용카드 특가 설정 부분
			if(!tabyn_card.equals("Y") && aszPlist[i].getPrice_card()>0 && !aszPlist[i].getOption_flag2().equals("1")) {
				if(cardShopCodes.indexOf("|"+aszPlist[i].getShop_code())>-1 && checkEventCard(cardNameHash, aszPlist[i].getShop_code()+"", aszPlist[i].getGoodsnm(), aszPlist[i].getPrice(), strCategory)){
					if(!aszPlist[i].getGoodsfactory().equals("쇼핑지원금") && aszPlist[i].getShop_code()==75 && aszPlist[i].getPrice()<50000) {
					}else{
						tabyn_card = "Y";
					}
				}
			}
			//백화점몰
			//if(!tabyn_depart.equals("Y") && ControlUtil.compareValOR(new int[]{aszPlist[i].getShop_code(),6547})){
			/*if(!tabyn_depart.equals("Y") && ControlUtil.compareValOR(new int[]{aszPlist[i].getShop_code(),90,57,47,6620,6547})){
				tabyn_depart = "Y";
			}*/
			//무이자할부
			if(!tabyn_cardfree.equals("Y") && !getForceFreeInterest2(aszPlist[i].getShop_code(), strCategory, aszPlist[i].getFreeinterest(), aszPlist[i].getPrice(), cardFreeAry).equals("")){
				tabyn_cardfree = "Y";
			}
			// 현재 리스트에 나오는 상품들 중에 배송비가 있는 것이 확실한 상품의 개수를 구함
			if(aszPlist[i].getDeliverytype2()==1 && aszPlist[i].getDeliveryinfo2()  == 0) {
				deliveryType1Num2++;
			}

			//홈쇼핑 & 전문몰 = 일반쇼핑몰에서 백화점몰을 뺀 나머지 tabyn_etcmall
			//if(ControlUtil.compareValOR(new int[]{aszPlist[i].getShop_code(),47,49,55,57,75,90,374,536,663,806,974,1878,4027,5910,6252,6665,7692,6547})) {
			/*if(ControlUtil.compareValOR(new int[]{aszPlist[i].getShop_code(),47,55,57,90,536,4027,5910,6620,6547,6508,6641,6688,7692})) {

			} else {
				tabyn_etcmall = "Y";
			}*/
		}
		if(!phonePriceAllFlag && deliveryType1Num2>0){
			tabyn_dlv0 = "Y";
		}
		// 배송비탭 보이지 않음
		if(ControlUtil.compareValOR(new int[]{intModelno,1248637,1720032,1720028,1247170,1248620,1248888,1248623,1370212,1370216,1267468,1248613,1267467,1248860,1243685})) {
			tabyn_dlv0 = "";
		}
		if(ControlUtil.compareValOR(new String[]{CutStr.cutStr(strCategory,6),"033316","033317","033318","033319","033305","033308","090813","090816","090817"})
			|| (ControlUtil.compareValOR(new String[]{CutStr.cutStr(strCategory,6),"033301"}) && goods_data_pop.getModelnm().indexOf("PIN번호")>-1)
			|| (ControlUtil.compareValOR(new String[]{CutStr.cutStr(strCategory,4),"1647"}) && goods_data_pop.getModelnm().indexOf("PIN번호")>-1)
			|| (ControlUtil.compareValOR(new String[]{CutStr.cutStr(strCategory,4),"1647"}) && goods_data_pop.getSpec().indexOf("모바일상품권")>-1)
			|| (ControlUtil.compareValOR(new String[]{CutStr.cutStr(strCategory,4),"1647"}) && goods_data_pop.getSpec().indexOf("모바일쿠폰")>-1)
		){
			tabyn_dlv0 = "";
		}
		//중고/전시,반품/리퍼
		if(junggoShowType==3){
			for(int i=0; i<aszPlist.length && !tabyn_junggo.equals("Y"); i++) {
				if(aszPlist[i].getAirconfeetype().equals("3")) {
					tabyn_junggo = "Y";
				}
			}
			
			for(int i=0; i<aszPlist.length && !tabyn_return.equals("Y"); i++) {
				if(aszPlist[i].getAirconfeetype().equals("4")) {
					tabyn_return = "Y";
				}
			}
		}
		//제조사인증 업체명
		if(tabyn_auth.equals("Y")){
			tabyn_auth_nm = getAuthLogoText(strCategory, strFactory);
		}
		// 신용카드 특가를 무조건 안보여주기
		if(CutStr.cutStr(strCategory,6).equals("033301")) {
			tabyn_card = "";
		}
	}
	strTabinfoYnString = "";
	if(tabyn_open.equals("Y")){ //오픈마켓
		if(!strTabinfoYnString.equals("")) strTabinfoYnString += ",";
		strTabinfoYnString += "\"tabyn_open\":\"Y\"";
	}
	if(tabyn_dlv0.equals("Y")){ //무료배송
		if(!strTabinfoYnString.equals("")) strTabinfoYnString += ",";
		strTabinfoYnString += "\"tabyn_dlv0\":\"Y\"";
	}
	if(tabyn_junggo.equals("Y")){ //전시/중고
		if(!strTabinfoYnString.equals("")) strTabinfoYnString += ",";
		strTabinfoYnString += "\"tabyn_junggo\":\"Y\"";
	}
	if(tabyn_return.equals("Y")){ //반품/리퍼
		if(!strTabinfoYnString.equals("")) strTabinfoYnString += ",";
		strTabinfoYnString += "\"tabyn_return\":\"Y\"";
	}
	if(tabyn_tariffree.equals("Y")){ //세금/배송비무료(해외쇼핑)
		if(!strTabinfoYnString.equals("")) strTabinfoYnString += ",";
		strTabinfoYnString += "\"tabyn_tariffree\":\"Y\"";
	}
	if(tabyn_auth.equals("Y")){ //제조사인증
		if(!strTabinfoYnString.equals("")) strTabinfoYnString += ",";
		strTabinfoYnString += "\"tabyn_auth\":\"Y\"";
	}
	if(tabyn_auth_nm.equals("Y")){ //제조사인증 업체명
		if(!strTabinfoYnString.equals("")) strTabinfoYnString += ",";
		strTabinfoYnString += "\"tabyn_auth_nm\":\"Y\"";
	}
	if(tabyn_realprice.equals("Y")){ //판매가쇼핑몰
		if(!strTabinfoYnString.equals("")) strTabinfoYnString += ",";
		strTabinfoYnString += "\"tabyn_realprice\":\"Y\"";
	}
	if(tabyn_aircon_1.equals("Y")){ //기본설치비(스탠드+벽걸이) 포함
		if(!strTabinfoYnString.equals("")) strTabinfoYnString += ",";
		strTabinfoYnString += "\"tabyn_aircon_1\":\"Y\"";
	}
	if(tabyn_aircon_2.equals("Y")){ //기본설치비(스탠드+벽걸이+진공비) 포함
		if(!strTabinfoYnString.equals("")) strTabinfoYnString += ",";
		strTabinfoYnString += "\"tabyn_aircon_2\":\"Y\"";
	}
	if(tabyn_aircon_4.equals("Y")){ //기본설치비+진공비 포함
		if(!strTabinfoYnString.equals("")) strTabinfoYnString += ",";
		strTabinfoYnString += "\"tabyn_aircon_4\":\"Y\"";
	}
	if(tabyn_tirefree.equals("Y")){ //전국무료장착(타이어)
		if(!strTabinfoYnString.equals("")) strTabinfoYnString += ",";
		//strTabinfoYnString += "\"tabyn_tirefree\":\"Y\"";
	}
	if(tabyn_depart.equals("Y")){ //백화점몰
		if(!strTabinfoYnString.equals("")) strTabinfoYnString += ",";
		strTabinfoYnString += "\"tabyn_depart\":\"Y\"";
	}
	if(tabyn_card.equals("Y")){ //카드할인
		if(!strTabinfoYnString.equals("")) strTabinfoYnString += ",";
		strTabinfoYnString += "\"tabyn_card\":\"Y\"";
	}
	if(tabyn_cardfree.equals("Y")){ //무이자
		if(!strTabinfoYnString.equals("")) strTabinfoYnString += ",";
		strTabinfoYnString += "\"tabyn_cardfree\":\"Y\"";
	}
	if(tabyn_etcmall.equals("Y")){ //홈쇼핑&전문몰
		if(!strTabinfoYnString.equals("")) strTabinfoYnString += ",";
		strTabinfoYnString += "\"tabyn_etcmall\":\"Y\"";
	}




}
//part2 : 선탁항목 필터링

Pricelist_Data[] aszDelPlist = (Pricelist_Data[])aszPlist.clone();
int newPricelistCnt = 0;
boolean[] isMatch = new boolean[aszPlist.length];

if(aszPlist!=null) {
	for(int deli=0; deli<aszDelPlist.length; deli++) {
		isMatch[deli] = true;

		if(tab_open.equals("Y") && isMatch[deli]){ //오픈마켓
			if(CutStr.cutStr(strCategory,4).equals("0304") || CutStr.cutStr(strCategory,8).equals("02332217")) {
				if(ControlUtil.compareValOR(new int[]{aszDelPlist[deli].getShop_code(),47,49,55,57,75,90,374,536,663,806,974,1878,4027,5910,6252,6665,7692})) {

				} else {
					isMatch[deli] = false;
				}
			}else{
				if(((aszDelPlist[deli].getScale().equals("1") || aszDelPlist[deli].getScale().equals("2")) || aszDelPlist[deli].getAuth().equals("5")) && !aszDelPlist[deli].getJobtype().equals("2")) {

				}else{
					isMatch[deli] = false;
				}
			}
		}
		if(tab_dlv0.equals("Y") && isMatch[deli]){//무료배송
			if(aszDelPlist[deli].getDeliverytype2()==1 && aszDelPlist[deli].getDeliveryinfo2()==0) {

			}else{
				isMatch[deli] = false;
			}
		}
		if(tab_junggo.equals("Y") && isMatch[deli]){//전시/중고
			if(aszDelPlist[deli].getAirconfeetype().equals("3")) {

			}else{
				isMatch[deli] = false;
			}
		}
		if(tab_return.equals("Y") && isMatch[deli]){//반품/리퍼
			if(aszDelPlist[deli].getAirconfeetype().equals("4")) {
				
			}else{
				isMatch[deli] = false;
			}
		}
		if(tab_tariffree.equals("Y") && isMatch[deli]){//세금/배송비무료(해외쇼핑)
			if(aszDelPlist[deli].getAirconfeetype().equals("5")) {

			}else{
				isMatch[deli] = false;
			}
		}
		if(tab_auth.equals("Y") && isMatch[deli]){//제조사인증
			if(aszDelPlist[deli].getAuthflag().equals("Y")) {

			}else{
				isMatch[deli] = false;
			}
		}

		if(tab_realprice.equals("Y") && isMatch[deli]){ //판매가쇼핑몰
			if(aszDelPlist[deli].getPrice_flag().equals("0")) {

			}else{
				isMatch[deli] = false;
			}
		}

		if(tab_aircon_1.equals("Y") && isMatch[deli]){//기본설치비(스탠드+벽걸이) 포함
			if(aszDelPlist[deli].getAirconfeetype().equals("1")){

			}else{
				isMatch[deli] = false;
			}
		}
		if(tab_aircon_2.equals("Y") && isMatch[deli]){//기본설치비(스탠드+벽걸이+진공비) 포함
			if(aszDelPlist[deli].getAirconfeetype().equals("1")){

			}else{
				isMatch[deli] = false;
			}
		}
		if(tab_aircon_4.equals("Y") && isMatch[deli]){//기본설치비+진공비 포함
			if(aszDelPlist[deli].getAirconfeetype().equals("1")){

			}else{
				isMatch[deli] = false;
			}
		}
		//if(tab_tirefree.equals("Y") && isMatch[deli]){//전국무료장착(타이어)
		//	if(CutStr.cutStr(strCategory,4).equals("2115") && aszDelPlist[deli].getAirconfeetype().equals("2")){
//
		//	}else{
		//		isMatch[deli] = false;
		//	}
		//}
		if(tab_depart.equals("Y") && isMatch[deli]){//백화점몰
			//if(ControlUtil.compareValOR(new int[]{aszDelPlist[deli].getShop_code(),6547})){
			if(ControlUtil.compareValOR(new int[]{aszDelPlist[deli].getShop_code(),90,57,47,6620,6547})){

			}else{
				isMatch[deli] = false;
			}
		}
		if(tab_card.equals("Y") && isMatch[deli]){//카드할인
			if(aszDelPlist[deli].getPrice_card()>0 && cardShopCodes.indexOf("|"+aszDelPlist[deli].getShop_code())>-1 && checkEventCard(cardNameHash, aszDelPlist[deli].getShop_code()+"", aszDelPlist[deli].getGoodsnm(), aszDelPlist[deli].getPrice(), strCategory)) {

			}else{
				isMatch[deli] = false;
			}
		}
		if(tab_cardfree.equals("Y") && isMatch[deli]){//무이자
			if(!getForceFreeInterest2(aszDelPlist[deli].getShop_code(), strCategory, aszDelPlist[deli].getFreeinterest(), aszDelPlist[deli].getPrice(), cardFreeAry).equals("")){

			}else{
				isMatch[deli] = false;
			}
		}

		if(tab_etcmall.equals("Y") && isMatch[deli]){//홈쇼핑&전문몰
			//if(ControlUtil.compareValOR(new int[]{aszDelPlist[deli].getShop_code(),47,49,55,57,75,90,374,536,663,806,974,1878,4027,5910,6252,6665,7692,6547})){
			if(ControlUtil.compareValOR(new int[]{aszDelPlist[deli].getShop_code(),47,55,57,90,536,4027,5910,6620,6547,6508,6641,6688,7692})){
				isMatch[deli] = false;
			}else{

			}
		}

		if(isMatch[deli]) {
			newPricelistCnt++;
		}
	}
}
if(newPricelistCnt>0) {
	aszPlist = new Pricelist_Data[newPricelistCnt];
	int aszCnt = 0;
	for(int deli=0; deli<aszDelPlist.length; deli++) {
		if(isMatch[deli]) {
			aszPlist[aszCnt] = aszDelPlist[deli].cloneMe();
			aszCnt++;
		}
	}
} else {
	aszPlist = null;
}
%>