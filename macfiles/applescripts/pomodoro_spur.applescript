tell application "AppleScript Runner"
  set pomodoroStatus To (do shell script "cat ~/.org-pomodoro-status | head -n1")
  set pomodoroEndtime to (do shell script "cat ~/.org-pomodoro-status | tail -n1") as integer
  if pomodoroStatus is ":none" then
    set now to (do shell script "date +%s") as integer
    if now - pomodoroEndtime > 300 then
      display alert "No Pomodoro" message "What are you doing?" giving up after 60
    end if
  end if
end tell
