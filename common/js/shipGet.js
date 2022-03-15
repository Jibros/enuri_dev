function shipgetLoad(){
	
	var divShipGetInfo = document.createElement("DIV");
	divShipGetInfo.innerHTML = "쉽겟 사용자 가이드";
	divShipGetInfo.style.position = "fixed";
	divShipGetInfo.style.left = "0px";
	divShipGetInfo.style.bottom = "0px";
	divShipGetInfo.style.width = "100%";
	divShipGetInfo.style.height = "30px";
	divShipGetInfo.style.background="#4079ae";
	divShipGetInfo.style.color="#fff";
	divShipGetInfo.style.zIndex = 99999;
	document.body.appendChild(divShipGetInfo);

	

	if (document.getElementById("submit.add-to-cart-announce")){
		document.getElementById("submit.add-to-cart-announce").textContent = "장바구니에 담기";
	}
	if (document.getElementById("enterAddressFullName")){
		document.getElementById("enterAddressFullName").value = "이주현";
	}

	
		
}

shipgetLoad();