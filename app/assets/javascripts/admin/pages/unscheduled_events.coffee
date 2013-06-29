jQuery () ->
  $list = $("ul.unscheduled_events")
  if $list.length > 0
    $list.sortable
      axis: "y"
      dropOnEmpty: false
      cursor: "crosshair"
      items: "li"
      opacity: 0.4
      scroll: true
      update: (event, ui) ->
        $.ajax
          type: "post"
          url: "/admin/unscheduled_events/"+ui.item.data('id')+"/sort"
          data:
            position: ui.item.index()
          dataType: "script"
          beforeSend: (xhr) -> xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))

setTimeout (() -> document.location.reload()), 60000
