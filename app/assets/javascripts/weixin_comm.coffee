$("#subscriber_street").change ->
  $.ajax get_districts_path,
    type: 'get'
    data: { street: $(this).val() }
