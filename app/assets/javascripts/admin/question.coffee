jQuery ->

  $("#question_q_type")
    .on 'change', (evt) ->
        if $(this).val() == "填空"
          $('.question_options').hide();
        else
          $('.question_options').show();
      
  window.add_option = (link, association, rule) ->
    regexp = new RegExp('new_' + association, 'g')
    count = $('.question_options').children('div').length
    $('.question_options').append(rule.replace(regexp, count));
    
  window.remove_fields = (link) ->
    $(link).prev("input[type=hidden]").val("1");
    $(link).closest(".fields").hide();
    
