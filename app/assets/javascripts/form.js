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

// .replace(regexp, time)
