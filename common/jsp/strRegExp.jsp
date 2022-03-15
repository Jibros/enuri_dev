<%!
	/**
	 * 자음만 존재 유무
	 * @param str
	 * @return true or false
	 */
	public boolean getConSonNatCheck(String str){
		String regExp = "[ㄱ-ㅎ]{0,}";
		return getRegExpBooleanReturn(str, regExp);
	}

	/**
	 * 모음만 존재 유무
	 * @param str
	 * @return true or false
	 */
	public boolean getVowelCheck(String str){
		String regExp = "[ㅏ-ㅣ]{0,}";
		return getRegExpBooleanReturn(str, regExp);
	}

	/**
	 * 완성 한글 포함 글자수 return
	 * @param str
	 * @return
	 */
	public int getReviewWordCount(String str){
		String regExp = "[가-힣]";
		return getRegExpCountReturn(str, regExp);
	}

	/**
	 * 지마켓 및 특정 문자열 제거 함수
	 * @param strContent
	 * @return
	 */
	public String setReviewContentToReplace(String str){
		ArrayList<String> replaceList = reviewReplaceWordArray();
		for(int i = 0 ; i < replaceList.size(); i++ ){
			if(str.indexOf(replaceList.get(i)) > -1 ){
				str = str.replaceAll(replaceList.get(i), "");
			}
		}
		return str;
	}

	/**
	 * 특수문자 제거
	 * @param strContent
	 * @return
	 */
	public String setReviewCodeToReplace(String str){
		String retData = "";
		String match = "[^\uAC00-\uD7A3xfe0-9a-zA-Z\\s]";
		retData =str.replaceAll(match, " ");
		return retData;
	}

	public boolean getRegExpBooleanReturn(String str, String regexp){
		boolean retData = false;
		if(str.matches(regexp)) {
			retData = true;
		}
		return retData;
	}

	public int getRegExpCountReturn(String str, String regexp){
		int retData = 0;
		String returnData = "";

		Pattern pt = Pattern.compile(regexp);
		Matcher mc = pt.matcher(str);

		while (mc.find()) {
			if(mc.group(0).length() > 0 ){
				retData++;
			}
		}
		return retData;
	}

	public ArrayList<String> reviewReplaceWordArray(){
		ArrayList<String> list = new ArrayList<String>();

		list.add("G마켓 안드로이드 앱에서 작성");
		list.add("G마켓 아이폰 앱에서 작성");
		list.add("옥션 안드로이드 앱으로 작성");
		return list;
	}

	public boolean getReviewPhoto(int shop_code, String url){
		boolean retData = false;
		if(shop_code==49 || shop_code==6547 || shop_code==7455){ //롯데ON,엘롯데(롯데백화점),롯데마트
			if(url.indexOf("https://contents.lotteon.com/reviewimage/")==0 || url.indexOf("https://contents.lotteon.com/review/ctnts/")==0){
				retData = true;
			}
		}else if(shop_code==55){ //인터파크
			if(url.indexOf("http://openimage.interpark.com/milti/usedwritten/")==0){
				retData = true;
			}
		}else if(shop_code==57){ //현대Hmall
			if(url.indexOf("http://media.hyundaihmall.com/hmall/co/editor/")==0){
				retData = true;
			}
		}else if(shop_code==90){ //akmall
			if(url.indexOf("http://photo.akmall.com/image0/goods_comment")==0){
				retData = true;
			}
		}else if(shop_code==536){ //지마켓
			if(url.indexOf("http://image.gmarket.co.kr/gP_rvw/premiumImg/")==0){
				retData = true;
			}else if(url.indexOf("http://bampic.gmarket.co.kr/")==0){
				retData = true;
			}
		}else if(shop_code==663){ //롯데홈쇼핑
			if(url.indexOf("http://image.lotteimall.com/upload/")==0){
				retData = true;
			}
		}else if(shop_code==806){ //cjmall
			if(url.indexOf("http://image.cjmall.net/cjupload/valbbs")==0){
				retData = true;
			}
		}else if(shop_code==974){ //nsmall
			if(url.indexOf("http://image.nsmall.com/ec_custimages/itemval")==0){
				retData = true;
			}
		}else if(shop_code==4027){ //옥션
			if(url.indexOf("http://img.iacstatic.co.kr/feedback/a/")==0){
				retData = true;
			}else if(url.indexOf("http://bampic.auction.co.kr/v1/")==0){
				retData = true;
			}
		}else if(shop_code==6361){ //홈플러스
			if(url.indexOf("http://image.homeplus.co.kr/UserFiles/product/")==0){
				retData = true;
			}else if(url.indexOf("https://image.homeplus.co.kr/UserFiles/product/")==0){
				retData = true;
			}else if(url.indexOf("https://image.homeplus.kr/us/")==0){
				retData = true;
			}
		}else if(shop_code==6620){ //갤러리아몰
			if(url.indexOf("https://image.galleria.co.kr/C00001/itemEval")==0){
				retData = true;
			}
		}else if(shop_code==7935){ //공영홈쇼핑
			if(url.indexOf("https://img.publichs.com/ECMCFO/upload/review/")==0){
				retData = true;
			}
		}else if(shop_code==8365){ //홈플러스더클럽
			if(url.indexOf("http://image.homeplus.co.kr/UserFiles/club/prd/review/")==0){
				retData = true;
			}
		}
		return retData;
	}
	//<tagname> 찾아 삭제하기
	public String getRemoveTag(String inputs, String tag){
		String output = "";

		Pattern p = Pattern.compile("(?ix)<"+tag+"([^>]*)>", Pattern.CASE_INSENSITIVE);
		Matcher m = p.matcher(inputs);
		StringBuffer sb = new StringBuffer();
		boolean r = m.find();
		while(r){
			m.appendReplacement(sb, "");
			r = m.find();
		}
		m.appendTail(sb);
		output = sb.toString();

		return output;
	}
%>
