var Abtest = function(id){
	this.project_id = id;
	this.enable = true;
	this.page = document.URL.substring(0, document.URL.indexOf("?") > 0 ? document.URL.indexOf("?") : document.URL.length );
	this.refer = document.referrer.substring(0, document.referrer.indexOf("?") > 0 ? document.referrer.indexOf("?") : document.referrer.length );;
}
Abtest.prototype.enable = function(enable){
	Aptest.enable = enable;
}

Abtest.prototype.insert = function(){
	if(this.enable){
		var rtn = "";
	    if (typeof(Prototype) != "undefined" ){
	        rtn = "PR"
	    }else if(typeof(jQuery) != "undefined"){
	        rtn = "JQ"
	    }
	    var url = "/api/abTest.jsp";
	    param = "id="+this.project_id;
	    param += "&page="+this.page;
	    param += "&refer="+this.refer;
		
	    if (rtn == "PR"){
	        var getInstProd = new Ajax.Request(       
	            url,      
	            {  
	                method:'post',parameters:param
	            }
	        );      
	    }else if(rtn == "JQ"){
	        $.ajax({
	            type: "POST",  
	            url: url, 
	            data: param,     
	            success: function(result){
	                
	            }   
	        });     
	    }	    
	}
}
Abtest.prototype.update = function(){
	if(this.enable){
		var rtn = "";
	    if (typeof(Prototype) != "undefined" ){
	        rtn = "PR"
	    }else if(typeof(jQuery) != "undefined"){
	        rtn = "JQ"
	    }
	    var url = "/api/abTest.jsp";
	    param = "id="+this.project_id;
	    param += "&page="+this.page;
	    param += "&refer="+this.refer;
	    param += "&update=y";
		
	    if (rtn == "PR"){
	        var getInstProd = new Ajax.Request(       
	            url,      
	            {  
	                method:'post',parameters:param
	            }
	        );      
	    }else if(rtn == "JQ"){
	        $.ajax({
	            type: "POST",  
	            url: url, 
	            data: param,     
	            success: function(result){
	                
	            }   
	        });     
	    }	    
	}
}

