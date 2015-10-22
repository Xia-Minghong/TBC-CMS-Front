/**
 * Created by qikunxiang on 22/10/15.
 */
var map;

function initMap() {
    map = new google.maps.Map(document.getElementById('crisis-google-map'),
        {
            center: {lat: 1.359907, lng: 103.816726},
            zoom: 11,
            disableDefaultUI: true
        });
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