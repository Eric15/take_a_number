jQuery () ->
  $select = $("#scheduled_event_requested")

  if $select.length > 0
    $select.select2()
