jQuery ->
  editor = CKEDITOR.replace('article_content', { height: '512px'})
  $("#my-file-input").ace_file_input();
  $("#my-file-input").fileupload
    method:'post'
    url:"/upload_file"
    done: (e,result) ->
      $("#head_pic").attr("src", "../../" + result.result.pic_name).show();
      $('#article_thumb_media_url').val(result.result.pic_name)
