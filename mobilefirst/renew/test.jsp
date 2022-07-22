<%@page import="com.enuri.bean.event.DBWrap"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="com.enuri.bean.event.DBDataTable"%>
<%@page import="com.enuri.util.seed.Seed_Proc"%>
<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%
	Seed_Proc seed_Proc = new Seed_Proc();
	/*
	String tel1_1 = seed_Proc.DePass("EDwM");
	String tel2_1 = seed_Proc.DePass("Mjkw!Q6A!Q6M");
	String tel3_1 = seed_Proc.DePass("MTEw!Q6A!Q6O");
	
	String tel1_2 = seed_Proc.DePass("EDwM");
	String tel2_2 = seed_Proc.DePass("NjIw!Q6Q!Q6M");
	String tel3_2 = seed_Proc.DePass("NDQ0!Q6w!Q6N");
	
	String tel1_3 = seed_Proc.DePass("EDwM");
	String tel2_3 = seed_Proc.DePass("NDc4!Q6Q!Q6O");
	String tel3_3 = seed_Proc.DePass("NDU5!Q6A!Q6O");
	
	String tel1_4 = seed_Proc.DePass("EDwM");
	String tel2_4 = seed_Proc.DePass("MDUy!Q6Q!Q6O");
	String tel3_4 = seed_Proc.DePass("NjIz!Q6A!Q6M");
	
	String tel1_5 = seed_Proc.DePass("EDwM");
	String tel2_5 = seed_Proc.DePass("OTk2!Q6Q!Q6O");
	String tel3_5 = seed_Proc.DePass("NDMz!Q6Q!Q6N");
	
    out.println(" k773059     이용민  "+tel1_1 + tel2_1 + tel3_1 + "<br>");
    out.println(" qszwax3156  이동준  "+tel1_2 + tel2_2 + tel3_2 + "<br>");
    out.println(" whc103      김정식  "+tel1_3 + tel2_3 + tel3_3 + "<br>");
    out.println(" ydi222      이용민  "+tel1_4 + tel2_4 + tel3_4 + "<br>");
    out.println(" zelgad      이다인  "+tel1_5 + tel2_5 + tel3_5 + "<br>");
	*/
    /*
	create table TB_MEMBERS_TEMP_PASS_LOG (
			 seqno bigint identity(1,1) not null primary key
			 , userid varchar(40) not null
			 , tel1_p varchar(255) null
			 , tel2_p varchar(255) null
			 , tel3_p varchar(255) null
			 , userip varchar(20) null
			 , ins_dtm datetime not null default(getdate())
			)
	
	*/
	
	String userIp = "";
	userIp = ChkNull.chkStr(ConfigManager.szConnectIp(request), "");
	
	DBWrap insert =	new DBWrap("member");
	
	insert.addSimpleParameter("userid", )
	.addSimpleParameter("tel1_p", )
	.addSimpleParameter("tel2_p", )
	.addSimpleParameter("tel3_p", )
	.addSimpleParameter("userip", userIp)
	.simpleInsert("TB_MEMBERS_TEMP_PASS_LOG", "");

	
	
	
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>Swiper demo</title>
    <!-- Link Swiper's CSS -->
    <link rel="stylesheet" href="/mobilefirst/css/home/swiper.css">

    <!-- Demo styles -->
    <style>
    body {
        background: #eee;
        font-family: Helvetica Neue, Helvetica, Arial, sans-serif;
        font-size: 14px;
        color:#000;
        margin: 0;
        padding: 0;
    }
    .swiper-container {
        width: 500px;
        height: 300px;
        margin: 20px auto;
    }
    .swiper-slide {
        text-align: center;
        font-size: 18px;
        background: #fff;
        
        /* Center slide text vertically */
        display: -webkit-box;
        display: -ms-flexbox;
        display: -webkit-flex;
        display: flex;
        -webkit-box-pack: center;
        -ms-flex-pack: center;
        -webkit-justify-content: center;
        justify-content: center;
        -webkit-box-align: center;
        -ms-flex-align: center;
        -webkit-align-items: center;
        align-items: center;
    }
    </style>
</head>
<body>
    <!-- Swiper -->
    <div class="swiper-container">
        <div class="swiper-wrapper">
            <div class="swiper-slide">Slide 1</div>
            <div class="swiper-slide">Slide 2</div>
            <div class="swiper-slide">Slide 3</div>
            <div class="swiper-slide">Slide 4</div>
            <div class="swiper-slide">Slide 5</div>
            <div class="swiper-slide">Slide 6</div>
            <div class="swiper-slide">Slide 7</div>
            <div class="swiper-slide">Slide 8</div>
            <div class="swiper-slide">Slide 9</div>
            <div class="swiper-slide">Slide 10</div>
        </div>
    </div>
	<%
	String query = " select USERID , USERNM , INS_DTM , ZIP, PHONE , ADDR1 , ADDR2 , OSTYPE ,  GETDATE()  tt From TBL_EVENT_USER_ADDR with (nolock)";
	
	DBDataTable dt = new DBWrap("member").setQuery(query).selectAllTry();	
	%>
	<h1>vip 신청 리스트</h1>
	<br>
	<br>
	<table border="1">
			<%	for (int i=0 ; i < dt.count();i++){	%>
				<tr>
				<td><%=dt.parse(i, "USERID","") %></td>
				<td><%=dt.parse(i, "USERNM","") %></td>
				<td><%=dt.parse(i, "tt","") %></td>
				</tr>
			<%}%>
	</table>
	<br>
	<br>
	<br>
	<br>
	<br>
    <!-- Swiper JS -->
    <script src="/mobilefirst/js/lib/swiper.min.js"></script>

    <!-- Initialize Swiper -->
    <script>
    var swiper = new Swiper('.swiper-container',{
    	slidesPerView: 1,
	    paginationClickable: true,
	    spaceBetween: 0,
	    loop: true,
	    lazyLoading: true,
	    autoHeight: true,
	    shortSwipes: false,
        longSwipes: true,
        longSwipesMs:100
    });

    </script>
</body>
</html>