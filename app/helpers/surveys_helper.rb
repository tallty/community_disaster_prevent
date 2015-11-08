module SurveysHelper

  def question_builder(question, index)
    result = ""
    index += 1
    case question.q_type
    when '填空'
      result = "<div class='row col-xs-12'><h4>#{index}. #{question.q_title}</h4></div><div class=' col-xs-11 col-xs-offset-1'><input id='q_result_#{question.id}' name='q[result][#{question.id}]' type='text' class='form-control input'/></div>"
    else
      option_type = {'多选' => 'checkbox', '单选' => 'radio'}
      result = "<div class='row col-xs-12'><h4>#{index}. #{question.q_title}</h4></div><div class='col-xs-10 col-xs-offset-1'>#{question.q_digest}</div>"
      question.options.each do |o|
        result << "<div class='col-xs-10' style='margin-left: 10px;'><label><input name='q[result][#{question.id}][]' value='#{o.id}' type='#{option_type[question.q_type]}'/>#{o.option_title}</label></div>"  
      end
    end
    result
  end
  
end
