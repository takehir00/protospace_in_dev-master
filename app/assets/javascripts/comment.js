$(function(){
  function buildHTML(comment){
    var html =`<p>
                comment.body
                </p>
                <p>
                comment.user_name
                </p>`
    return html;
  }
  $('#new_comment').on('submit', function(e){
    e.preventDefault();
    var formData = new FormData(this);
    var url = $(this).attr('action');
    $.ajax({
      url: url,
      type: "POST",
      data: formData,
      adataType: 'json',
      processData: false,
      contentType: false
    })
    .done(function(data){
      var html = buildHTML(data);
      $('.comments-list').append(html)
    })
    .fail(function(){
      alert('error');
    })
  })
})
