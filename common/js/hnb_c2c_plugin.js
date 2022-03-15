document.writeln("<OBJECT ID=HnbC2CPlugin CLASSID=CLSID:1DC9702B-B26D-4E47-8875-F732931A3479 CodeBase=http://www.hanaescrow.com/cab/CPWebP235.cab#version=1,0,0,235 width=2 height=2></OBJECT>");

var server_info = "www.hanaescrow.com";
var server_port = "80";
var cert_text = "";
var url = "";
var url2 = "";
var svr_cert_url = "http://www.hanaescrow.com/crt/svr.cert";
var svr_time_url = "http://www.hanaescrow.com/crt/Time.jsp";
var main_url = "/ctoc";
var escrow_cd = "81";
var c2c_result = "";
var status_cd = "";

var PKCS7SignTitle = "하나은행 전자서명(C2C)";
var PKCS7SignInfo = "";

var tid = "";
var vir_acct = "";

var bank_nm = "";
var acc = "";
var affl_shop_no = "";

var h_err_frm = "";
var h_err_cd = "";
var h_err_msg = "";

function c2c_reg_mem(){

	if(HnbC2CPlugin.object == null){
		OnErr();
   	}else{
		//url = document.cpay_reg_mem_fm.url.value;
       	//svr_cert_url = document.cpay_reg_mem_fm.svr_cert_url.value;
       	//svr_time_url = document.cpay_reg_mem_fm.svr_time_url.value;
       	//main_url = document.cpay_reg_mem_fm.main_url.value;
       	//escrow_cd = document.cpay_reg_mem_fm.escrow_cd.value;
       	
       	url2 = "/cert_service_sign_hs_c2c.jsp";
       	PKCS7SignInfo = "C2C 회원등록시 수행되는 전자서명 값";

   		//document.HnbC2CPlugin.setTest();
   		
   		document.HnbC2CPlugin.setOpt("cert_yn","n");
   	
		document.HnbC2CPlugin.setDomain(server_info);
		document.HnbC2CPlugin.setServiceUrl(url2);
        document.HnbC2CPlugin.setSvrCertUrl(svr_cert_url);
        document.HnbC2CPlugin.setSvrTimeUrl(svr_time_url);
        document.HnbC2CPlugin.setMainUrl(main_url);
       	document.HnbC2CPlugin.setEscrowCD(escrow_cd);

		if (document.cpay_reg_mem_fm.shop_nm_loc.value == null ||
			document.cpay_reg_mem_fm.shop_nm_loc.value == "")
		{
			status_cd = "[PGN:0033]고객명 설정 오류";
			UserDefine();
			return;
		}

		document.HnbC2CPlugin.set("affl_grp_id", document.cpay_reg_mem_fm.affl_grp_id.value);
		document.HnbC2CPlugin.set("shop_nm_loc", document.cpay_reg_mem_fm.shop_nm_loc.value);
		document.HnbC2CPlugin.set("shop_bsn_no", document.cpay_reg_mem_fm.shop_bsn_no.value);
		document.HnbC2CPlugin.set("cert_yn_settle", document.cpay_reg_mem_fm.cert_yn_settle.value);
		document.HnbC2CPlugin.set("cert_settle_amt", document.cpay_reg_mem_fm.cert_settle_amt.value);
		document.HnbC2CPlugin.set("cert_yn_final", document.cpay_reg_mem_fm.cert_yn_final.value);
		document.HnbC2CPlugin.set("cert_final_amt", document.cpay_reg_mem_fm.cert_final_amt.value);
		document.HnbC2CPlugin.set("hp_yn_final", document.cpay_reg_mem_fm.hp_yn_final.value);
		document.HnbC2CPlugin.set("hp_final_amt", document.cpay_reg_mem_fm.hp_final_amt.value);
		document.HnbC2CPlugin.set("stl_mtd_cd", document.cpay_reg_mem_fm.stl_mtd_cd.value);
		document.HnbC2CPlugin.set("corp_cd", document.cpay_reg_mem_fm.corp_cd.value);
		document.HnbC2CPlugin.set("zipno_bsnp", document.cpay_reg_mem_fm.zipno_bsnp.value);
		document.HnbC2CPlugin.set("zipno_adr_bsnp", document.cpay_reg_mem_fm.zipno_adr_bsnp.value);
		document.HnbC2CPlugin.set("zipno_adr2_bsnp", document.cpay_reg_mem_fm.zipno_adr2_bsnp.value);
		document.HnbC2CPlugin.set("telno_bsnp", document.cpay_reg_mem_fm.telno_bsnp.value);
		document.HnbC2CPlugin.set("faxno_bsnp", document.cpay_reg_mem_fm.faxno_bsnp.value);
		document.HnbC2CPlugin.set("rsnt_nm_loc", document.cpay_reg_mem_fm.rsnt_nm_loc.value);
		document.HnbC2CPlugin.set("chg_nm", document.cpay_reg_mem_fm.chg_nm.value);
		document.HnbC2CPlugin.set("emal_chg_psn", document.cpay_reg_mem_fm.emal_chg_psn.value);
		document.HnbC2CPlugin.set("telno_chg_psn", document.cpay_reg_mem_fm.telno_chg_psn.value);
		document.HnbC2CPlugin.set("mblno_chg_psn", document.cpay_reg_mem_fm.mblno_chg_psn.value);

   		c2c_result = document.HnbC2CPlugin.exec("2001");

		bank_nm = document.HnbC2CPlugin.getRespParam("bank_nm");
		acc = document.HnbC2CPlugin.getRespParam("acc");
		affl_shop_no = document.HnbC2CPlugin.getRespParam("affl_shop_no");

		h_err_frm = c2c_result.substring(0,3);
		h_err_cd = c2c_result.substring(3,7);
		h_err_msg = c2c_result.substring(7);

		if (h_err_cd == "0000")
		{
			status_cd = "SUCCESS";
		}
		else if (h_err_cd == "0001")
		{
			status_cd = "CANCEL";
		} else {
                       if(h_err_frm == "PNG" && h_err_cd == "9000") {
                        
                                status_cd = "["+h_err_frm+":"+h_err_cd+"]통신상의 장애로 잠시 서비스 이용이 불가능 합니다. 잠시후에 다시 시도해 주시기 바랍니다.";
                        } else {
                                status_cd = "["+h_err_frm+":"+h_err_cd+"]"+h_err_msg;
                        }
		}
		UserDefine();
	}
}

function c2c_reg_mem_market(){

	if(HnbC2CPlugin.object == null){
		OnErr();
   	}else{
       	
       	url2 = "/cert_service_sign_hs_c2c_market.jsp";
       	PKCS7SignInfo = "C2C 회원등록(장터)시 수행되는 전자서명 값";

   		//document.HnbC2CPlugin.setTest();
   	
   		document.HnbC2CPlugin.setOpt("cert_yn","n");
   	
		document.HnbC2CPlugin.setDomain(server_info);
		document.HnbC2CPlugin.setServiceUrl(url2);
        document.HnbC2CPlugin.setSvrCertUrl(svr_cert_url);
        document.HnbC2CPlugin.setSvrTimeUrl(svr_time_url);
        document.HnbC2CPlugin.setMainUrl(main_url);
       	document.HnbC2CPlugin.setEscrowCD(escrow_cd);

		if (document.cpay_reg_mem_fm.shop_nm_loc.value == null ||
			document.cpay_reg_mem_fm.shop_nm_loc.value == "")
		{
			status_cd = "[PGN:0033]고객명 설정 오류";
			UserDefine();
			return;
		}

		document.HnbC2CPlugin.set("affl_grp_id", document.cpay_reg_mem_fm.affl_grp_id.value);
		document.HnbC2CPlugin.set("shop_nm_loc", document.cpay_reg_mem_fm.shop_nm_loc.value);
		document.HnbC2CPlugin.set("shop_bsn_no", document.cpay_reg_mem_fm.shop_bsn_no.value);
		document.HnbC2CPlugin.set("cert_yn_final", document.cpay_reg_mem_fm.cert_yn_final.value);
		document.HnbC2CPlugin.set("cert_final_amt", document.cpay_reg_mem_fm.cert_final_amt.value);
		document.HnbC2CPlugin.set("hp_yn_final", document.cpay_reg_mem_fm.hp_yn_final.value);
		document.HnbC2CPlugin.set("hp_final_amt", document.cpay_reg_mem_fm.hp_final_amt.value);
		
		document.HnbC2CPlugin.set("auto_trn_flag", document.cpay_reg_mem_fm.auto_trn_flag.value);
		document.HnbC2CPlugin.set("adst_tp", document.cpay_reg_mem_fm.adst_tp.value);
		document.HnbC2CPlugin.set("adst_ccl", document.cpay_reg_mem_fm.adst_ccl.value);
		document.HnbC2CPlugin.set("adst_dt", document.cpay_reg_mem_fm.adst_dt.value);
		document.HnbC2CPlugin.set("rfnd_fee_tp", document.cpay_reg_mem_fm.rfnd_fee_tp.value);
		document.HnbC2CPlugin.set("auto_cfrm_trm", document.cpay_reg_mem_fm.auto_cfrm_trm.value);
		document.HnbC2CPlugin.set("domain_nm", document.cpay_reg_mem_fm.domain_nm.value);
		
		document.HnbC2CPlugin.set("corp_cd", document.cpay_reg_mem_fm.corp_cd.value);
		document.HnbC2CPlugin.set("zipno_bsnp", document.cpay_reg_mem_fm.zipno_bsnp.value);
		document.HnbC2CPlugin.set("zipno_adr_bsnp", document.cpay_reg_mem_fm.zipno_adr_bsnp.value);
		document.HnbC2CPlugin.set("zipno_adr2_bsnp", document.cpay_reg_mem_fm.zipno_adr2_bsnp.value);
		document.HnbC2CPlugin.set("telno_bsnp", document.cpay_reg_mem_fm.telno_bsnp.value);
		document.HnbC2CPlugin.set("faxno_bsnp", document.cpay_reg_mem_fm.faxno_bsnp.value);
		document.HnbC2CPlugin.set("rsnt_nm_loc", document.cpay_reg_mem_fm.rsnt_nm_loc.value);
		document.HnbC2CPlugin.set("chg_nm", document.cpay_reg_mem_fm.chg_nm.value);
		document.HnbC2CPlugin.set("emal_chg_psn", document.cpay_reg_mem_fm.emal_chg_psn.value);
		document.HnbC2CPlugin.set("telno_chg_psn", document.cpay_reg_mem_fm.telno_chg_psn.value);
		document.HnbC2CPlugin.set("mblno_chg_psn", document.cpay_reg_mem_fm.mblno_chg_psn.value);
		document.HnbC2CPlugin.set("auth_mtd", "00");

   		c2c_result = document.HnbC2CPlugin.exec("2001");

		bank_nm = document.HnbC2CPlugin.getRespParam("bank_nm");
		acc = document.HnbC2CPlugin.getRespParam("acc");
		affl_shop_no = document.HnbC2CPlugin.getRespParam("affl_shop_no");

		h_err_frm = c2c_result.substring(0,3);
		h_err_cd = c2c_result.substring(3,7);
		h_err_msg = c2c_result.substring(7);

		if (h_err_cd == "0000")
		{
			status_cd = "SUCCESS";
		}
		else if (h_err_cd == "0001")
		{
			status_cd = "CANCEL";
		} else {
                       if(h_err_frm == "PNG" && h_err_cd == "9000") {
                        
                                status_cd = "["+h_err_frm+":"+h_err_cd+"]통신상의 장애로 잠시 서비스 이용이 불가능 합니다. 잠시후에 다시 시도해 주시기 바랍니다.";
                        } else {
                                status_cd = "["+h_err_frm+":"+h_err_cd+"]"+h_err_msg;
                        }
		}
		UserDefine();
	}
}

function c2c_chg_acc(){

	if(HnbC2CPlugin.object == null){
		OnErr();
   	}else{
		//url = document.cpay_chg_acc_fm.url.value;
       	//svr_cert_url = document.cpay_chg_acc_fm.svr_cert_url.value;
       	//svr_time_url = document.cpay_chg_acc_fm.svr_time_url.value;
       	//main_url = document.cpay_chg_acc_fm.main_url.value;
       	//escrow_cd = document.cpay_chg_acc_fm.escrow_cd.value;
       	
       	url2 = "/cert_service_sign_hs_acct_chg.jsp";
       	PKCS7SignInfo = "C2C 계좌변경시 수행되는 전자서명 값";

   		//document.HnbC2CPlugin.setTest();
   		
   		document.HnbC2CPlugin.setOpt("cert_yn","n");
   		document.HnbC2CPlugin.setOpt("affl_grp_id",document.cpay_chg_acc_fm.affl_grp_id.value);
   	
		document.HnbC2CPlugin.setDomain(server_info);
		document.HnbC2CPlugin.setServiceUrl(url2);
       	document.HnbC2CPlugin.setSvrCertUrl(svr_cert_url);
       	document.HnbC2CPlugin.setSvrTimeUrl(svr_time_url);
       	document.HnbC2CPlugin.setMainUrl(main_url);
       	document.HnbC2CPlugin.setEscrowCD(escrow_cd);

		document.HnbC2CPlugin.set("affl_grp_id", document.cpay_chg_acc_fm.affl_grp_id.value);
		document.HnbC2CPlugin.set("shop_bsn_no", document.cpay_chg_acc_fm.shop_bsn_no.value);

   		c2c_result = document.HnbC2CPlugin.exec("2002");

		bank_nm = document.HnbC2CPlugin.getRespParam("bank_nm");
		acc = document.HnbC2CPlugin.getRespParam("acc");

		h_err_frm = c2c_result.substring(0,3);
		h_err_cd = c2c_result.substring(3,7);
		h_err_msg = c2c_result.substring(7);

		if (h_err_cd == "0000")
		{
			status_cd = "SUCCESS";
		}
		else if (h_err_cd == "0001")
		{
			status_cd = "CANCEL";
		} else {
                       if(h_err_frm == "PNG" && h_err_cd == "9000") {
                        
                                status_cd = "["+h_err_frm+":"+h_err_cd+"]통신상의 장애로 잠시 서비스 이용이 불가능 합니다. 잠시후에 다시 시도해 주시기 바랍니다.";
                        } else {
                                status_cd = "["+h_err_frm+":"+h_err_cd+"]"+h_err_msg;
                        }
		}
		UserDefine();
	}
}


function c2c_assign_vtacc(){

	if(HnbC2CPlugin.object == null){
		OnErr();
   	}else{
		//url = document.cpay_assign_vtacc_fm.url.value;
       	//svr_cert_url = document.cpay_assign_vtacc_fm.svr_cert_url.value;
       	//svr_time_url = document.cpay_assign_vtacc_fm.svr_time_url.value;
       	//main_url = document.cpay_assign_vtacc_fm.main_url.value;
       	//escrow_cd = document.cpay_assign_vtacc_fm.escrow_cd.value;

		url2 = "/cert_service_sign_hs_acct_asg.jsp";
		PKCS7SignInfo = "C2C 계좌배정시 수행되는 전자서명 값";

   		//document.HnbC2CPlugin.setTest();
   	
		document.HnbC2CPlugin.setDomain(server_info);
		document.HnbC2CPlugin.setServiceUrl(url2);
       	document.HnbC2CPlugin.setSvrCertUrl(svr_cert_url);
       	document.HnbC2CPlugin.setSvrTimeUrl(svr_time_url);
       	document.HnbC2CPlugin.setMainUrl(main_url);
       	document.HnbC2CPlugin.setEscrowCD(escrow_cd);

		document.HnbC2CPlugin.set("affl_grp_id", document.cpay_assign_vtacc_fm.affl_grp_id.value);
		document.HnbC2CPlugin.set("cust_emal", document.cpay_assign_vtacc_fm.cust_emal.value);
		document.HnbC2CPlugin.set("cust_mblno", document.cpay_assign_vtacc_fm.cust_mblno.value);
		document.HnbC2CPlugin.set("cust_nm_loc", document.cpay_assign_vtacc_fm.cust_nm_loc.value);
		document.HnbC2CPlugin.set("del_trm", document.cpay_assign_vtacc_fm.del_trm.value);
		document.HnbC2CPlugin.set("stl_mtd_cd", document.cpay_assign_vtacc_fm.stl_mtd_cd.value);
		document.HnbC2CPlugin.set("order_no", document.cpay_assign_vtacc_fm.order_no.value);
		document.HnbC2CPlugin.set("fst_prop_dt", document.cpay_assign_vtacc_fm.fst_prop_dt.value);
		document.HnbC2CPlugin.set("s_email", document.cpay_assign_vtacc_fm.s_email.value);
		document.HnbC2CPlugin.set("s_handphone", document.cpay_assign_vtacc_fm.s_handphone.value);
		document.HnbC2CPlugin.set("b_rdnt_no", document.cpay_assign_vtacc_fm.b_rdnt_no.value);
		document.HnbC2CPlugin.set("s_rdnt_no", document.cpay_assign_vtacc_fm.s_rdnt_no.value);
		document.HnbC2CPlugin.set("b_rdnt_no", document.cpay_assign_vtacc_fm.b_rdnt_no.value);

   		c2c_result = document.HnbC2CPlugin.exec("2003");

		tid = document.HnbC2CPlugin.getRespParam("tid");
		vir_acct = document.HnbC2CPlugin.getRespParam("vir_acct");

		h_err_frm = c2c_result.substring(0,3);
		h_err_cd = c2c_result.substring(3,7);
		h_err_msg = c2c_result.substring(7);

		if (h_err_cd == "0000")
		{
			status_cd = "SUCCESS";
		}
		else if (h_err_cd == "0001")
		{
			status_cd = "CANCEL";
		} else {
                       if(h_err_frm == "PNG" && h_err_cd == "9000") {
                        
                                status_cd = "["+h_err_frm+":"+h_err_cd+"]통신상의 장애로 잠시 서비스 이용이 불가능 합니다. 잠시후에 다시 시도해 주시기 바랍니다.";
                        } else {
                                status_cd = "["+h_err_frm+":"+h_err_cd+"]"+h_err_msg;
                        }
		}
		UserDefine();
	}
}

function c2c_add_goods_info(name, price, num){
	if(HnbC2CPlugin.object == null){
		OnErr();
   	}else{
   		//document.HnbC2CPlugin.setTest();
   		
		document.HnbC2CPlugin.addGoods(name, price, num);
	}	
}

function c2c_buy(){

	if(HnbC2CPlugin.object == null){
		OnErr();
   	}else{
   		//document.HnbC2CPlugin.setTest();
   		
		document.HnbC2CPlugin.setDomain(server_info);
		document.HnbC2CPlugin.setServiceUrl(url);
       	document.HnbC2CPlugin.setSvrCertUrl(svr_cert_url);
       	document.HnbC2CPlugin.setSvrTimeUrl(svr_time_url);
       	document.HnbC2CPlugin.setMainUrl(main_url);
       	document.HnbC2CPlugin.setEscrowCD(escrow_cd);

		//document.HnbC2CPlugin.set("site_code", document.cpay_buy_fm.site_code.value);
		//document.HnbC2CPlugin.set("fkb_tid", document.cpay_buy_fm.fkb_tid.value);
		//document.HnbC2CPlugin.set("purchase_yn", document.cpay_buy_fm.purchase_yn.value);		
		//document.HnbC2CPlugin.set("refusal_rson", document.cpay_buy_fm.refusal_rson.value);		
		//document.HnbC2CPlugin.set("ret_info", document.cpay_buy_fm.ret_info.value);		

   		//c2c_result = document.HnbC2CPlugin.c2cBuy();
   		c2c_result = document.HnbC2CPlugin.doCert();

		h_err_frm = c2c_result.substring(0,3);
		h_err_cd = c2c_result.substring(3,7);
		h_err_msg = c2c_result.substring(7);

		if (h_err_cd == "0000")
		{
			status_cd = "SUCCESS";
		}
		else if (h_err_cd == "0001")
		{
			status_cd = "CANCEL";
		} else {
                       if(h_err_frm == "PNG" && h_err_cd == "9000") {
                        
                                status_cd = "["+h_err_frm+":"+h_err_cd+"]통신상의 장애로 잠시 서비스 이용이 불가능 합니다. 잠시후에 다시 시도해 주시기 바랍니다.";
                        } else {
                                status_cd = "["+h_err_frm+":"+h_err_cd+"]"+h_err_msg;
                        }
		}
		UserDefine();
	}
}

// 반품승인
function c2c_retd_confirm(){

	if(HnbC2CPlugin.object == null){
		OnErr();
   	}else{
		//url = document.cpay_retd_confirm_fm.url.value;
       	//svr_cert_url = document.cpay_retd_confirm_fm.svr_cert_url.value;
       	//svr_time_url = document.cpay_retd_confirm_fm.svr_time_url.value;
       	//main_url = document.cpay_retd_confirm_fm.main_url.value;
       	//escrow_cd = document.cpay_retd_confirm_fm.escrow_cd.value;
       	
       	url2 = "/CPpluginRtgd_c2c.jsp";
       	PKCS7SignInfo = "C2C 반품승인시 수행되는 전자서명 값";
	
   		//document.HnbC2CPlugin.setTest();
   		
   		document.HnbC2CPlugin.setOpt("cert_yn","n");
   		
		document.HnbC2CPlugin.setDomain(server_info);
		document.HnbC2CPlugin.setServiceUrl(url2);
		document.HnbC2CPlugin.setInfoUrl("/plugin/Init_Final_Decision_c2c.jsp");
       	document.HnbC2CPlugin.setSvrCertUrl(svr_cert_url);
       	document.HnbC2CPlugin.setSvrTimeUrl(svr_time_url);
       	document.HnbC2CPlugin.setMainUrl(main_url);
       	document.HnbC2CPlugin.setEscrowCD(escrow_cd);

		document.HnbC2CPlugin.set("tid", document.cpay_retd_confirm_fm.tid.value);
		document.HnbC2CPlugin.set("rtgd_id", document.cpay_retd_confirm_fm.rtgd_id.value);
		document.HnbC2CPlugin.set("rtgd_nm", document.cpay_retd_confirm_fm.rtgd_nm.value);
		document.HnbC2CPlugin.set("rtgd_req_dt", document.cpay_retd_confirm_fm.rtgd_req_dt.value);
		document.HnbC2CPlugin.set("rtgd_req_tm", document.cpay_retd_confirm_fm.rtgd_req_tm.value);
		document.HnbC2CPlugin.set("rtgd_gb", document.cpay_retd_confirm_fm.rtgd_gb.value);
		document.HnbC2CPlugin.set("order_no", document.cpay_retd_confirm_fm.order_no.value);
		document.HnbC2CPlugin.set("trx_dt", document.cpay_retd_confirm_fm.trx_dt.value);
		document.HnbC2CPlugin.set("b_user_nm", document.cpay_retd_confirm_fm.b_user_nm.value);
		document.HnbC2CPlugin.set("b_user_email", document.cpay_retd_confirm_fm.b_user_email.value);
		document.HnbC2CPlugin.set("b_user_telno", document.cpay_retd_confirm_fm.b_user_telno.value);
		document.HnbC2CPlugin.set("s_user_nm", document.cpay_retd_confirm_fm.s_user_nm.value);
		document.HnbC2CPlugin.set("s_user_email", document.cpay_retd_confirm_fm.s_user_email.value);
		document.HnbC2CPlugin.set("s_user_telno", document.cpay_retd_confirm_fm.s_user_telno.value);
		document.HnbC2CPlugin.set("auth_mtd", "00");

   		//c2c_result = document.HnbC2CPlugin.doCert();
   		c2c_result = document.HnbC2CPlugin.exec("2004");

		h_err_frm = c2c_result.substring(0,3);
		h_err_cd = c2c_result.substring(3,7);
		h_err_msg = c2c_result.substring(7);

		if (h_err_cd == "0000")
		{
			status_cd = "SUCCESS";
		}
		else if (h_err_cd == "0001")
		{
			status_cd = "CANCEL";
		} else {
                       if(h_err_frm == "PNG" && h_err_cd == "9000") {
                        
                                status_cd = "["+h_err_frm+":"+h_err_cd+"]통신상의 장애로 잠시 서비스 이용이 불가능 합니다. 잠시후에 다시 시도해 주시기 바랍니다.";
                        } else {
                                status_cd = "["+h_err_frm+":"+h_err_cd+"]"+h_err_msg;
                        }
		}
		UserDefine();
	}
}

function urlEncode(str) {
	return document.HnbC2CPlugin.urlEncode(str);
}

function OnErr()
{
	alert("플러그인 로딩 중 에러가 발생하였습니다. \n\n 브라우저에서 [새로고침]버튼을 클릭하신 후 [보안경고]창이 나타나면 [예]버튼을 클릭하세요.");
}
