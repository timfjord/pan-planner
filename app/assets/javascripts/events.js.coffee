jQuery ->
  $('#event_user_tokens').tokenInput '/users.json'
    prePopulate: $('#event_user_tokens').data('load')