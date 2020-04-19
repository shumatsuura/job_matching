$(document).on('turbolinks:load', function(){
  $('form').on('click', '.remove_fields', function(event){
    $(this).prev('input[type=hidden]').val('1');
    $(this).closest('fieldset').hide();
    event.preventDefault();
  });

  $('form').on('click', '.add_fields', function(event){
    users_child_index = Number($(this).parent().find('.users_child_index:last').text()) + 1
    // education_index = Number($('.educations_index:last').text()) + 1;

    var time = new Date().getTime();
    var regexp = new RegExp($(this).data('id'), 'g');
    $(this).before($(this).data('fields').replace(regexp, time));
    event.preventDefault();

    $(this).parent().find('.users_child_index:last').text(users_child_index);

    });
  });

// プレビュー表示
$(document).on('turbolinks:load', function() {
  function readURL(input) {
    if (input.files && input.files[0]) {
      var reader = new FileReader();

      reader.onload = function (e) {
        $('#avatar_img_prev').attr('src', e.target.result);
      }
      reader.readAsDataURL(input.files[0]);
    }
  }

  $("#post_img").change(function(){
    $('#avatar_img_prev').removeClass('d-none');
    $('.avatar_present_img').remove();
    readURL(this);
  });
});
// プレビュー表示(company_header_image)
$(document).on('turbolinks:load', function() {
  function readURL(input) {
    if (input.files && input.files[0]) {
      var reader = new FileReader();

      reader.onload = function (e) {
        $('#header_img_prev').attr('src', e.target.result);
      }
      reader.readAsDataURL(input.files[0]);
    }
  }

  $("#post_header_img").change(function(){
    $('#header_img_prev').removeClass('d-none');
    $('.header_present_img').remove();
    readURL(this);
  });
});
// .replace(regexp, time)
