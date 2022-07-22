
function getGateTest(strGno, strGkind){
	var vData = {tg_id : strGno , tg_from : strGkind};
    var sTag_id;
	$.ajax({
        type: "POST",
        async : false,
        url: "/mobilefirst/ajax/gate_getList.jsp",		        
        data : vData ,
        dataType: "JSON",
        success: function(data){
        	sTag_id = data.gatelist;
        },
		error: function (xhr, ajaxOptions, thrownError) {
			alert(xhr.status);
			alert(thrownError);
		}
	});

	return sTag_id;
}

