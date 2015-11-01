function initMapIncidentModal($scope) {
    var timeStr = $scope.incident.time;
    var mmt = moment(timeStr, "YYYY-MM-DDThh:mm:ssZ");
    $scope.incident.time = mmt.format("DD/MM/YYYY hh:mm");

    var dispatches = $scope.incident['dispatch_set'];

    for (var i = 0; i < dispatches.length; i++) {
        timeStr = dispatches[i].time;
        mmt = moment(timeStr, "YYYY-MM-DDThh:mm:ssZ");
        dispatches[i].time = mmt.format("hh:mm");
    }

    var updates = $scope.incident['inciupdate_set'];

    for (var i = 0; i < updates.length; i++) {
        timeStr = updates[i].time;
        mmt = moment(timeStr, "YYYY-MM-DDThh:mm:ssZ");
        updates[i].time = mmt.format("hh:mm");
    }

    setTimeout(function() {
        var ichecks = $('div#event-severity-check input[type="checkbox"].flat-red, input[type="radio"].flat-red');
        ichecks.iCheck({
            checkboxClass: 'icheckbox_flat-red',
            radioClass: 'iradio_flat-red',
            disabledClass: 'non-clickable'
        });

    }, 200);
}