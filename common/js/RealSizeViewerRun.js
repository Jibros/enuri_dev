
		//***************************************************************
		//* RunRealSize(pcode)  : RealSize Viewer를 실행
		//***************************************************************
		//  ㅁ 파라메터
		//     rsetcode : 리얼사이즈로 등록된 제품코드로 크기비교일 경우 ,로 구분 (type:string)
		//
		//     예)
		//       - 실제크기보기 : 상품코드가 PD_0001 인 제품 실제크기보기 호출시

		//         RunRealSize('PD_0001') 로 호출하면 됨.
		//
		//       - 실제크기비교 보기 : 상품코드 PD_0001 인 제품과 상품코드 PD_0002 인 두개의 제품을 크기비교로 호출할 경우
		//         RunRealSize('PD_0001,PD_0002')로 호출하면 됨.
		//***************************************************************
	
		function RunRealSize(pcode) {
			/*
			if(pcode == "" || pcode == null) {
				alert("실제크기보기를 위한 해당 제품코드가 없습니다.");
				return false;
			}
			insertLog(153);
			var win_domain = 'http://rsiimage.enuri.info';        //리얼사이즈가 장착된 서버의 도메인 또는 IP
			var win_url =  win_domain + '/RealSize/Applications/RSIViewerRun.htm';
			var winPopWidth = 330;
			var winPopHeight = 210;
			var winLeft = (screen.width - winPopWidth) / 2 ;
			var winTop = (screen.height - winPopHeight) / 2 ;
			
			var ary_setcode = pcode.split(',');
			for(var i=1 ; i<=ary_setcode.length ; i++){
				if(i==1){
					win_url +=  '?pcode' + i + '=' + escape(ary_setcode[i-1]) ;
				}else{
					win_url +=  '&pcode' + i + '=' + escape(ary_setcode[i-1]) ;
				}
			}
			
			var win_name = 'winRealSize' ;
			var win_prop = 'width=' + winPopWidth + ',height=' + winPopHeight + ',top=' + winTop + ',left=' + winLeft + ',toobar=0,scrollbars=0,menubar=0,status=0,directories=0' ;
			
			var winObjPopup = window.open(win_url, win_name , win_prop) ;
			if(winObjPopup == null) {
				alert('차단된 팝업을 허용해 주세요.');
			}
			*/
			//alert("1")
			var newWin = window.open("/view/realgallery/Realgallery_Flex.jsp?guid="+pcode,"realgallery","top=100,left=100,width=1000,height=740, scrollbars=no,resizable=no");
			newWin.focus();
			//alert("3")
		}