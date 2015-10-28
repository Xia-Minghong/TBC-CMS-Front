/**
 * Created by qikunxiang on 24/10/15.
 */
function createCrisisInit($scope) {
    $('select#eventType.select2').val(null).select2({
        placeholder: "Select event type"
    });

    $('input[type="checkbox"].flat-red, input[type="radio"].flat-red').iCheck({
        checkboxClass: 'icheckbox_flat-red',
        radioClass: 'iradio_flat-red'
    });

    $('div#severity div.iradio_flat-red input, div#severity div.iradio_flat-red ins').css({
        display: 'none'
    });

    $('div#severity div.iradio_flat-red').click(function(e) {
        var i, sev;
        e.preventDefault();
        e.stopPropagation();
        sev = parseInt($(e.target).find('input[type="radio"]').attr('name').replace('sev', ''));

        $('input#severityHidden').val(sev).trigger("change");

        $('div#severity div.iradio_flat-red').removeClass('checked');
        i = 1;
        while (i <= sev) {
            $('div#severity input[type="radio"][name="sev' + i + '"]').parent().addClass('checked');
            i++;
        }
    });

    var timepicker = $('#timePicker.timepicker');
    timepicker.timepicker({
        showInputs: true
    });

    timepicker.on("changeTime.timepicker", function(event) {
        var time = event.time;
        var t = new Date();
        t.setHours(time.hours + (time.meridian == "AM" ? 0 : 12), time.minutes, 0);
        $("input#timeHidden").val(t.toUTCString()).trigger("change");
    });

    var select = $('select#locationAddress');
    select.placecomplete({
        placeholderText: "Enter address",
        multiple: true,
        allowClear: false,
        maximumSelectionSize: 1,
        requestParams: {
            types: [],
            componentRestrictions: {
                country: "SG"
            }
        }

    });
    var searchField = $('input.select2-search__field');
    var clearSearchField = $('<span class="select2-selection__clear-custom">×</span>');
    clearSearchField.css({position: "relative"});
    searchField.parent().prepend(clearSearchField);


    window.marker = null;

    select.on("placecomplete:selected", function (event, placeResult) {
        var text = placeResult["display_text"];

        $("input#locationHidden").val(text).trigger("change");
        searchField.val(text);
        clearSearchField.on("click", function (event) {
            event.stopPropagation();

            searchField.val('');

            $("input#locationHidden").val(null).trigger("change")
            $('input#locationlngHidden').val(null).trigger("change");
            $('input#locationlatHidden').val(null).trigger("change");
        });

        searchField.on("click", function (event) {
            event.preventDefault();
            event.stopPropagation();
        });

        var loc = placeResult.geometry.location
        map.panTo(loc);
        map.setZoom(16);
        if (marker) {
            marker.setMap(null);
        }
        marker = new google.maps.Marker({
            position: loc,
            map: map,
            title: "Event",
            animation: google.maps.Animation.DROP,
            draggable: true,
            icon: 'images/blue-pin.png'
        });

        $('input#locationlngHidden').val(marker.position.lng()).trigger("change");
        $('input#locationlatHidden').val(marker.position.lat()).trigger("change");

        google.maps.event.addListener(marker, "dragend", function(event) {
            $('input#locationlngHidden').val(this.position.lng()).trigger("change");
            $('input#locationlatHidden').val(this.position.lat()).trigger("change");
        });
    });
}