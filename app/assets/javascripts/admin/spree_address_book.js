//= require jquery.validate/jquery.validate.min

(function($){
  $(document).ready(function(){
    if($('.user_form_address').is('*')){

      $('.user_form_address').validate();

      var get_states = function(region){
        country = $('div#' + region + 'country' + ' span#' + region + 'country-selection :only-child').val();
        return state_mapper[country];
      }

      var update_state = function(region) {
        states = get_states(region);

        state_select = $('div#' + region + 'state select');
        state_input = $('div#' + region + 'state input');

        if(states) {
          selected = parseInt(state_select.val());
          state_select.html('');
          states_with_blank = [["",""]].concat(states);
          $.each(states_with_blank, function(pos,id_nm) {
            var opt = $(document.createElement('option'))
                      .attr('value', id_nm[0])
                      .html(id_nm[1]);
            if(selected==id_nm[0]){
              opt.prop("selected", true);
            }
            state_select.append(opt);
          });
          state_select.prop("disabled", false).show();
          state_input.hide().prop("disabled", true);

        } else {
          state_input.prop("disabled", false).show();
          state_select.hide().prop("disabled", true);
        }

      };

      $('div#bcountry select').change(function() { update_state('b'); });
      $('div#scountry select').change(function() { update_state('s'); });
      update_state('b');
      update_state('s');

		$('input#user_save_bill').click(function() {
			if (($(this)).is(':checked')) {
				$('#billing .inner').show();
				$('#billing .inner input, #billing .inner select').prop('disabled', false);
				if (get_states('s')) {
					return $('span#bstate input').hide().prop('disabled', true);
				} else {
					return $('span#bstate select').hide().prop('disabled', true);
				}
			} else {
				$('#billing .inner').hide();
				return $('#billing .inner input, #billing .inner select').prop('disabled', true);
			}
		}).triggerHandler('click');
		
		$('input#user_save_ship').click(function() {
			if (($(this)).is(':checked')) {
				$('#shipping .inner').show();
				$('#shipping .inner input, #shipping .inner select').prop('disabled', false);
				if (get_states('s')) {
					return $('span#bstate input').hide().prop('disabled', true);
				} else {
					return $('span#bstate select').hide().prop('disabled', true);
				}
			} else {
				$('#shipping .inner').hide();
				return $('#shipping .inner input, #shipping .inner select').prop('disabled', true);
			}
		}).triggerHandler('click');
		
    }
	
  });
})(jQuery);