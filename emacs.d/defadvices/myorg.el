(defadvice read-char-exclusive (after set-read-char-exclusive-last-input)
           (setq read-char-exclusive-last-input (char-to-string ad-return-value)))
(ad-activate 'read-char-exclusive)
