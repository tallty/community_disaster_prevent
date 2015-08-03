$("#article_manager_keyword").change ->
  if ($(this).val() == "社区风险")
    $.ajax get_streets_path,
      type: 'get'
    $("#community-select").show()
  else
    $("#community-select").hide()

$("#article_manager_street").change ->
  $.ajax get_districts_path,
    type: 'get'
    data: { street: $(this).val() }
