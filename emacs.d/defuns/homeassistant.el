(defun genki/home-assistant-webhook (webhook_id)
  "Send POST request to Home Assistant Webhook API"
  (let ((url (concat (getenv "HOME_ASSISTANT_URL") "/api/webhook/" webhook_id))
        (payload "{\"key\": \"value\"}"))
    (with-temp-buffer
      (call-process "curl" nil t nil
                    "-X" "POST"
                    "-H" "Content-Type: application/json"
                    "-d" payload
                    url))))
