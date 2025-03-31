function addSearchButton() {
  let emailHeader = document.querySelector(".adn .gD");
  if (!emailHeader) return;

  let senderEmail = emailHeader.getAttribute("email");
  if (!senderEmail) return;

  if (document.getElementById("unread-search-btn")) return;

  let btn = document.createElement("button");
  btn.id = "unread-search-btn";
  btn.innerText = "🔍 Unread from Sender";
  btn.style.cssText = `
        background: #1a73e8; color: white; border: none;
        padding: 5px 10px; border-radius: 4px; cursor: pointer;
        margin-left: 10px; font-size: 12px;
    `;

  btn.onclick = function () {
    let searchQuery = `in:inbox is:unread from:${senderEmail}`;
    let searchUrl = `https://mail.google.com/mail/u/0/#search/${encodeURIComponent(searchQuery)}`;
    window.location.href = searchUrl;
  };

  emailHeader.parentElement.appendChild(btn);
}

// Run when an email is opened
let observer = new MutationObserver(addSearchButton);
observer.observe(document.body, { childList: true, subtree: true });

addSearchButton();
