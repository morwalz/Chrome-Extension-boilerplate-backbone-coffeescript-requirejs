define([], ->
  window.SERVER_URL = "http://localhost:8080"
  # 48 hrs = 172800000 ms
  window.UNAVAILABLE_NOTIFICATION_TRIGGER_DURATION = 600000
  window
)