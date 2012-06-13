var remove_bill_address = 'Rimuovi indirizzo di fatturazione';
var remove_ship_address = 'Rimuovi indirizzo di consegna';
var add_bill_address = 'Aggiungi indirizzo di fatturazione';
var add_ship_address = 'Aggiungi indirizzo di consegna';


(function ($) {

    $(document).ready(function () {

        $('#new-customer #shipping .inner').css('display','initial');
        $('.edit-user #shipping .inner').css('display','initial');
        // TODO make multilanguage
        $('#add_ship_address').click(function () {
            $('#shipping').toggle();

            if ($('#shipping').css('display') == 'none') {
                $('#add_ship_address').html(add_ship_address);
                $('#delete_ship_address').val('true');
            } else {
                $('#add_ship_address').html(remove_ship_address);
                $('#delete_ship_address').val('false');
            }
            return false;
        });

        $('#add_bill_address').click(function () {
            $('#billing').toggle();
            if ($('#billing').css('display') == 'none') {
                $('#add_bill_address').html(add_bill_address);
                $('#delete_bill_address').val('true');
            } else {
                $('#add_bill_address').html(remove_bill_address);
                $('#delete_bill_address').val('false');
            }
            return false;
        });




        // need for populate state select
        if ($('#user_new').is('*') || $('.edit_user').is('*')) {


            var get_states = function (region) {
                country = $('p#' + region + 'country' + ' span#' + region + 'country :only-child').val();
                return state_mapper[country];
            }

            var update_state = function (region) {
                states = get_states(region);

                state_select = $('p#' + region + 'state select');
                state_input = $('p#' + region + 'state input');

                if (states) {
                    selected = state_select.val();
                    state_select.html('');
                    states_with_blank = [
                        ["", ""]
                    ].concat(states);
                    $.each(states_with_blank, function (pos, id_nm) {
                        var opt = $(document.createElement('option'))
                            .attr('value', id_nm[0])
                            .html(id_nm[1]);
                        if (selected == id_nm[0]) {
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

            $('p#bcountry select').change(function () {
                update_state('b');
            });
            $('p#scountry select').change(function () {
                update_state('s');
            });
            update_state('b');
            update_state('s');
        }

        // Visible or hide address if is present
        if ($('.edit_user').is('*')) {
            if (!is_present('bill')) {
                $('#billing').toggle();
            } else {
                $('#add_bill_address').html(remove_bill_address);
            }
            if (!is_present('ship')) {
                $('#shipping').toggle();
            } else {
                $('#add_ship_address').html(remove_ship_address);
            }
        }

        $('#new-customer #shipping').toggle();
        $('#new-customer #billing').toggle();
    });
})(jQuery);

function is_present(prefix) {
    var count = 0;
    if ($('#user_' + prefix + '_address_attributes_firstname').val() == '') {
        count++;
    }
    if ($('#user_' + prefix + '_address_attributes_lastname').val() == '') {
        count++;
    }
    if ($('#user_' + prefix + '_address_attributes_address1').val() == '') {
        count++;
    }
    if ($('#user_' + prefix + '_address_attributes_city').val() == '') {
        count++;
    }
    if ($('#user_' + prefix + '_address_attributes_zipcode').val() == '') {
        count++;
    }
    if ($('#user_' + prefix + '_address_attributes_phone').val() == '') {
        count++;
    }

    if (count == 6) {
        return false;
    } else {
        return true;
    }
}

