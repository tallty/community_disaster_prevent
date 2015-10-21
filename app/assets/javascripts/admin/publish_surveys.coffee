$("#publish_survey_district").change ->
  $.ajax get_streets_path,
    type: 'get'
    data: { district: $(this).val() }
