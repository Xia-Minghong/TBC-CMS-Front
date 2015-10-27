/**
 * Created by qikunxiang on 22/10/15.
 */
var map;

function initMap() {
    setTimeout(function () {
        var container = document.getElementById('crisis-google-map');

        if (container != null) {
            map = new google.maps.Map(container,
                {
                    center: {lat: 1.359907, lng: 103.816726},
                    zoom: 11,
                    disableDefaultUI: true,
                    minZoom: 11
                });

            setTimeout(function() {
                // bounds of the desired area
                var allowedBounds = map.getBounds();
                var lastValidCenter = map.getCenter();

                google.maps.event.addListener(map, 'center_changed', function() {
                    if (allowedBounds.contains(map.getCenter())) {
                        // still within valid bounds, so save the last valid position
                        lastValidCenter = map.getCenter();
                        return;
                    }

                    // not valid anymore => return to last valid position
                    map.panTo(lastValidCenter);
                });
            }, 300);

            var ntu = new google.maps.Marker({
                position: {lat: 1.348304, lng: 103.683134},
                map: map,
                title: "NTU"
            });

            var changi = new google.maps.Marker({
                position: {lat: 1.364688, lng: 103.991509},
                map: map,
                title: "Changi International Airport"
            });

            var mbs = new google.maps.Marker({
                position: {lat: 1.283816, lng: 103.860715},
                map: map,
                title: "Marina Bay Sands"
            });
        }

        container = document.getElementById('location-selector-google-map');

        if (container != null) {
            map = new google.maps.Map(container,
                {
                    center: {lat: 1.359907, lng: 103.816726},
                    zoom: 11,
                    disableDefaultUI: true,
                    minZoom: 11
                });

            setTimeout(function() {
                // bounds of the desired area
                var allowedBounds = map.getBounds();
                var lastValidCenter = map.getCenter();

                google.maps.event.addListener(map, 'center_changed', function() {
                    if (allowedBounds.contains(map.getCenter())) {
                        // still within valid bounds, so save the last valid position
                        lastValidCenter = map.getCenter();
                        return;
                    }

                    // not valid anymore => return to last valid position
                    map.panTo(lastValidCenter);
                });
            }, 300);
        }
    }, 600);
}