var remove_bill_address = 'Rimuovi indirizzo di fatturazione';
var remove_ship_address = 'Rimuovi indirizzo di consegna';
var add_bill_address = 'Aggiungi indirizzo di fatturazione';
var add_ship_address = 'Aggiungi indirizzo di consegna';

(function ($) {
    $(document).ready(function () {
        //$('#new-customer #shipping .inner').css('display','initial');
        //$('.edit-user #shipping .inner').css('display','initial');
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

