	// wookki25 2005.09.13
	// �α����� �ʿ��� ���� �α��� ó���� ��ũ��Ʈ
	function kbLoginCase(loginCase)
	{
		if(islogin())
		{
			// �α��� ������ �� ��Ȳ�� �Լ� ����.
			// �� ��Ȳ�� �Լ��� �ּ��� �ִ� �� ���Ͽ� �ڵ� �Ǿ�����.
			switch(loginCase)
			{
				case "write"		:	document.frmGoWrite.submit();	break; // �������� �۾��� 	/knowbox/kbList.asp
				case "modelwrite"	:	document.location.reload();	break; // Ư���� �۾��� 	/knowbox/kbList_model.asp
				case "reply"		:	document.location.reload();	break; // ��۾���		/knowbox/kbList_model.asp

				case "save"		:	openPopWin();			break; // �����ϱ�		/knowbox/kbRead.asp
				case "mail"		:	openSelfWin();			break; // ��õ����		/knowbox/kbRead.asp
				case "useful"		:	openPopWin();			break; // ����üũ		/knowbox/kbRead.asp
				case "modify"		:	openPopWin();			break; // �����ϱ�		/knowbox/kbRead.asp
				case "movedel"		:	openPopWin();			break; // ���� �̵�+����	/knowbox/kbRead.asp
				case "delete"		:	openPopWin();			break; // ��ۻ���		/knowbox/kbRead.asp

				case "alam"		:	CmdSendE();			break; // �ҷ��̿��� �Ű�	/knowbox/profile_popup.asp
				case "mykb"		:	viewMyKb();			break; // My ������		/knowbox/kbMenu.asp
				case "boardinsert"	:	exeBoardInsert();		break; // ������Խ���		/knowbox/incBoard/kbBoard.asp
				case "boardupdate"	:	exeBoardUpdate();		break; // ������Խ���		/knowbox/incBoard/kbBoard.asp

				case "writepop"		:	document.location.reload();	break; // ���������� ����	/knowbox/Kbwrite_popup.asp

				default			:	break;
			}
		}
		else
		{
			// �α���â �����!!
			var obj = window.open("/login/Loginpop.jsp?cmd=knowbox&kblogincase="+loginCase,"ENURI_LOGIN","width=372, height=230; resizable=yes;left=0;top=0;");
			obj.focus();
		}
	}