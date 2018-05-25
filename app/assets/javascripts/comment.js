$(function(){
  function buildHTML(comment){
    var html =`<div class="comments-contents">
                <h5 class="comments-list__username">
                  ${comment.user_name}
                </h5>
                <p class="comments-list__body">
                  ${comment.body}
                </p>
                <div class="comments-list__edit">
                  <a href="/prototypes/${comment.prototype_id}/comments/${comment.id}/edit">EDIT</a>
                </div>
                <div class="comments-list__destroy">
                  <a rel="nofollow" data-method="delete" href="/prototypes/${comment.prototype_id}/comments/${comment.id}">DESTROY</a>
                </div>
              </div>`
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
      dataType: 'json',
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
