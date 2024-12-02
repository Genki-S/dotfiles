function logError(msg) {
  console.log("[witchcraft] Failed to insert sakura checker link: " + msg);
}

window.addEventListener("load", () => {
  const reviewLink = document.querySelector("#acrCustomerReviewLink");
  if (!reviewLink) {
    logError("no review link found")
    return
  }

  const urlPath = window.location.pathname;
  const productId = urlPath.substring(urlPath.lastIndexOf('/') + 1);
  if (productId == "") {
    logError("no product ID found")
    return
  }

  const sakuraCheckerLink = document.createElement("a");
  sakuraCheckerLink.href = "https://sakura-checker.jp/search/" + productId;
  sakuraCheckerLink.textContent = "Sakura Checker↗";
  sakuraCheckerLink.target = "_blank";
  sakuraCheckerLink.style.marginLeft = "10px";

  reviewLink.insertAdjacentElement("afterend", sakuraCheckerLink);
})
