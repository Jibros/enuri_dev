	// wookki25 2005.09.13
	// 로그인이 필요한 서비스 로그인 처리용 스크립트
	function kbLoginCase(loginCase)
	{
		if(islogin())
		{
			// 로그인 성공시 각 상황별 함수 실행.
			// 각 상황별 함수는 주석에 있는 각 파일에 코딩 되어있음.
			switch(loginCase)
			{
				case "write"		:	document.frmGoWrite.submit();	break; // 전반적인 글쓰기 	/knowbox/kbList.asp
				case "modelwrite"	:	document.location.reload();	break; // 특정모델 글쓰기 	/knowbox/kbList_model.asp
				case "reply"		:	document.location.reload();	break; // 답글쓰기		/knowbox/kbList_model.asp

				case "save"		:	openPopWin();			break; // 저장하기		/knowbox/kbRead.asp
				case "mail"		:	openSelfWin();			break; // 추천메일		/knowbox/kbRead.asp
				case "useful"		:	openPopWin();			break; // 유익체크		/knowbox/kbRead.asp
				case "modify"		:	openPopWin();			break; // 수정하기		/knowbox/kbRead.asp
				case "movedel"		:	openPopWin();			break; // 원글 이동+삭제	/knowbox/kbRead.asp
				case "delete"		:	openPopWin();			break; // 답글삭제		/knowbox/kbRead.asp

				case "alam"		:	CmdSendE();			break; // 불량이용자 신고	/knowbox/profile_popup.asp
				case "mykb"		:	viewMyKb();			break; // My 지식통		/knowbox/kbMenu.asp
				case "boardinsert"	:	exeBoardInsert();		break; // 지식통게시판		/knowbox/incBoard/kbBoard.asp
				case "boardupdate"	:	exeBoardUpdate();		break; // 지식통게시판		/knowbox/incBoard/kbBoard.asp

				case "writepop"		:	document.location.reload();	break; // 전문가에게 질문	/knowbox/Kbwrite_popup.asp

				default			:	break;
			}
		}
		else
		{
			// 로그인창 띄우자!!
			var obj = window.open("/login/Loginpop.jsp?cmd=knowbox&kblogincase="+loginCase,"ENURI_LOGIN","width=372, height=230; resizable=yes;left=0;top=0;");
			obj.focus();
		}
	}