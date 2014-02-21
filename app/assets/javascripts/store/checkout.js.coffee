//= require jquery.payment

Spree.disableSaveOnClick = ->
  ($ 'form.edit_order').submit ->
    ($ this).find(':submit, :image').attr('disabled', true).removeClass('primary').addClass 'disabled'

Spree.ready ($) ->
  Spree.Checkout = {}
  $(".cardNumber").payment('formatCardNumber')
  $(".cardExpiry").payment('formatCardExpiry')
  $(".cardCode").payment('formatCardCVC')

  $(".cardNumber").change ->
    $(this).parent().siblings(".ccType").val($.payment.cardType(@value))

  if ($ '#checkout_form_address').is('*')
    ($ '#checkout_form_address').validate()

    getCountryId = (region) ->
      $('#' + region + 'country select').val()

    updateState = (region) ->
      countryId = getCountryId(region)
      if countryId?
        unless Spree.Checkout[countryId]?
          $.get Spree.routes.states_search, {country_id: countryId}, (data) ->
            Spree.Checkout[countryId] =
              states: data.states
              states_required: data.states_required
            fillStates(Spree.Checkout[countryId], region)
        else
          fillStates(Spree.Checkout[countryId], region)

    fillStates = (data, region) ->
      statesRequired = data.states_required
      states = data.states

      statePara = ($ '#' + region + 'state')
      stateSelect = statePara.find('select')
      stateInput = statePara.find('input')
      stateSpanRequired = statePara.find('state-required')
      if states.length > 0
        selected = parseInt stateSelect.val()
        stateSelect.html ''
        statesWithBlank = [{ name: '', id: ''}].concat(states)
        $.each statesWithBlank, (idx, state) ->
          opt = ($ document.createElement('option')).attr('value', state.id).html(state.name)
          opt.prop 'selected', true if selected is state.id
          stateSelect.append opt

        stateSelect.prop('disabled', false).show()
        stateInput.hide().prop 'disabled', true
        statePara.show()
        stateSpanRequired.show()
        stateSelect.addClass('required') if statesRequired
        stateSelect.removeClass('hidden')
        stateInput.removeClass('required')
      else
        stateSelect.hide().prop 'disabled', true
        stateInput.show()
        if statesRequired
          stateSpanRequired.show()
          stateInput.addClass('required')
        else
          stateInput.val ''
          stateSpanRequired.hide()
          stateInput.removeClass('required')
        statePara.toggle(!!statesRequired)
        stateInput.prop('disabled', !statesRequired)
        stateInput.removeClass('hidden')
        stateSelect.removeClass('required')

    ($ '#bcountry select').change ->
      updateState 'b'

    ($ '#scountry select').change ->
      updateState 's'

    updateState 'b'

    order_use_shipping = ($ 'input#order_use_shipping ')
    order_use_shipping .change ->
      update_billing_form_state order_use_shipping 

    update_billing_form_state = (order_use_shipping ) ->
      if order_use_shipping .is(':checked')
        ($ '#billing .inner').hide()
        ($ '#billing .inner input, #billing .inner select').prop 'disabled', true
      else
        ($ '#billing .inner').show()
        ($ '#billing .inner input, #billing .inner select').prop 'disabled', false
        updateState('s')
    
    update_billing_form_state order_use_shipping

  if ($ '#checkout_form_payment').is('*')
    ($ 'input[type="radio"][name="order[payments_attributes][][payment_method_id]"]').click(->
      ($ '#payment-methods li').hide()
      ($ '#payment_method_' + @value).show() if @checked
    )

    ($ document).on('click', '#cvv_link', (event) ->
      windowName = 'cvv_info'
      windowOptions = 'left=20,top=20,width=500,height=500,toolbar=0,resizable=0,scrollbars=1'
      window.open(($ this).attr('href'), windowName, windowOptions)
      event.preventDefault()
    )

    # Activate already checked payment method if form is re-rendered
    # i.e. if user enters invalid data
    ($ 'input[type="radio"]:checked').click()
