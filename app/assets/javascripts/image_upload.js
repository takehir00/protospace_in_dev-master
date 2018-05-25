$(document).on('turbolinks:load', function(){
  $('.col-md-12').on('change','input[type="file"]', function(e){
    var file = e.target.files[0],
          reader = new FileReader();
          $image = $(this).siblings('img');
          t = this;
      if(file.type.indexOf("image") < 0){
        return false;
      }
      reader.onload = (function(file) {
        return function(e) {
          $image.attr({
                    src: e.target.result,
                    height: "100%",
                    class: "preview",
                    title: file.name,
                });
        };
      })(file);
      reader.readAsDataURL(file);
  });
})
