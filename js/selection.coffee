# Written at Louisiana State University

$(document).ready () ->
    potentials = "#from_users"
    mailed = "#mail_users"

    selectors = [potentials, mailed]

    clear_selections = () ->
        clear = (index, selector) ->
            $(selector).children(":selected").attr "selected", false

        $(selectors).each clear

    clampmail_changer = () ->
        role = $("#roles").val();

        clear_selections()

        $("#groups").children(":selected").each (outer, group) ->
            $(selectors).each (inner, selector) ->

                $(selector).children("*").each (select, option) ->
                    groups = $(option).data('groups')
                    roles = $(option).data('roles')

                    in_list = (obj, list) ->
                        filter = ->
                            String(this) is obj
                        $(list).filter(filter).length > 0

                    selected = true;
                    if in_list(role, roles) and in_list $(group).val(), groups
                        $(option).attr 'selected', selected;

    move = (from, to, filter) ->
        () ->
            $(from).children(filter).appendTo to
            $(from).children(filter).remove()

    $("#groups").change clampmail_changer
    $("#roles").change clampmail_changer

    $("#add_button").click move(potentials, mailed, ':selected')
    $("#add_all").click move(potentials, mailed, '*')
    $("#remove_button").click move(mailed, potentials, ':selected')
    $("#remove_all").click move(mailed, potentials, '*')

    $('form.mform').on "submit", ->
        mapper = (index, elem) -> $(elem).val().split(' ')[0]

        ids = $(mailed).children("*").map(mapper).get().join ','

        $("input[name=mailto]").val(ids);
        true
