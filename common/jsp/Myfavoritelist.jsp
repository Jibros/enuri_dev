<script language="javaScript">
function MyFavoriteListResize(){
	try
	{
		alert(document.getElementById("IFrameMyFavoriteList").contentWindow.document.body.scrollHeight)
	    document.getElementById("IFrameMyFavoriteList").height = document.getElementById("IFrameMyFavoriteList").contentWindow.document.body.scrollHeight;
	    document.getElementById("MyFavoriteLayerMain").height = document.getElementById("IFrameMyFavoriteList").contentWindow.document.body.scrollHeight;
   	}
   	catch(e)
   	{
   	}
}
</script>
<span id="MyFavoriteLayerMain" name="MyFavoriteLayerMain" style="position:absolute;left:910px;top:47px;z-index;0;display:block;">
	<iframe id="IFrameMyFavoriteList" frameborder=0 name="IFrameMyFavoriteList" src="/include/Incmyfavoritelistmain.jsp" style="overflow:auto;background:#000E1D; border:0px;BORDER-COLOR='#000E1D';" width=90 height=100 frameborder=0 onload="MyFavoriteListResize()"></iframe>
</span>
