/**
 * Created by qikunxiang on 22/10/15.
 */
var map;
var incidents = {
    fire: [],
    haze: [],
    crash: [],
    dengue: []
};
var incidentMarkers = {
    fire: [],
    haze: [],
    crash: [],
    dengue: []
};


function initMap($rootScope) {
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

                resetMarkers($rootScope);

            }, 300);

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

function resetMarkers($rootScope) {
    // Clear global lists
    incidents = {
        fire: [],
        haze: [],
        crash: [],
        dengue: []
    };

    incidentMarkers = {
        fire: [],
        haze: [],
        crash: [],
        dengue: []
    };

    var incidentList = $rootScope.pushes.incidents;

    for (var i = 0; i < incidentList.length; i++) {
        var incident = incidentList[i];
        var marker = new google.maps.Marker({
            position: {lat: parseFloat(incident.latitude), lng: parseFloat(incident.longitude)},
            title: incident.name,
            icon: 'images/' + incident.type + '-pin-' + Math.min(5, incident.severity) + '.png'
        });
        incident["marker"] = marker;
        marker.incident = incident;

        switch (incident.type) {
            case "fire":
                incidents.fire.push(incident);
                incidentMarkers.fire.push(marker);
                break;
            case "haze":
                incidents.haze.push(incident);
                incidentMarkers.haze.push(marker);
                break;
            case "crash":
                incidents.crash.push(incident);
                incidentMarkers.crash.push(marker);
                break;
            case "dengue":
                incidents.dengue.push(incident);
                incidentMarkers.dengue.push(marker);
                break;
        }

        marker.setMap(map);

        google.maps.event.addListener(marker, "click", function(event) {
            $rootScope.openMapModal(this.incident.id);
        });
    }

    var toggleMarkers = function(list, show) {
        for (var i = 0; i < list.length; i++) {
            list[i].setMap(show ? map : null);
        }
    };

    $("div#map-label-all").click(function() {
        toggleMarkers(incidentMarkers.fire, true);
        toggleMarkers(incidentMarkers.haze, true);
        toggleMarkers(incidentMarkers.crash, true);
        toggleMarkers(incidentMarkers.dengue, true);
        $("div.map-label").removeClass("active");
        $(this).addClass("active");
    });

    $("div#map-label-fire").click(function() {
        toggleMarkers(incidentMarkers.fire, true);
        toggleMarkers(incidentMarkers.haze, false);
        toggleMarkers(incidentMarkers.crash, false);
        toggleMarkers(incidentMarkers.dengue, false);
        $("div.map-label").removeClass("active");
        $(this).addClass("active");
    }).find("div.map-label-number").text(incidents.fire.length);

    $("div#map-label-haze").click(function() {
        toggleMarkers(incidentMarkers.fire, false);
        toggleMarkers(incidentMarkers.haze, true);
        toggleMarkers(incidentMarkers.crash, false);
        toggleMarkers(incidentMarkers.dengue, false);
        $("div.map-label").removeClass("active");
        $(this).addClass("active");
    }).find("div.map-label-number").text(incidents.haze.length);

    $("div#map-label-crash").click(function() {
        toggleMarkers(incidentMarkers.fire, false);
        toggleMarkers(incidentMarkers.haze, false);
        toggleMarkers(incidentMarkers.crash, true);
        toggleMarkers(incidentMarkers.dengue, false);
        $("div.map-label").removeClass("active");
        $(this).addClass("active");
    }).find("div.map-label-number").text(incidents.crash.length);

    $("div#map-label-dengue").click(function() {
        toggleMarkers(incidentMarkers.fire, false);
        toggleMarkers(incidentMarkers.haze, false);
        toggleMarkers(incidentMarkers.crash, false);
        toggleMarkers(incidentMarkers.dengue, true);
        $("div.map-label").removeClass("active");
        $(this).addClass("active");
    }).find("div.map-label-number").text(incidents.dengue.length);
}
