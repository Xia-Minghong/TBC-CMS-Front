/**
 * Created by qikunxiang on 24/10/15.
 */
function createCrisisInit() {
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
        searchField.val(text);
        clearSearchField.on("click", function (event) {
            event.stopPropagation();

            searchField.val('');
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
    });
}