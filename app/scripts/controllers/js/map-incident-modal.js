function initMapIncidentModal($scope) {
    console.log($scope.incident);
    var timeStr = $scope.incident.time;
    var mmt = moment(timeStr, "YYYY-MM-DDThh:mm:ssZ");
    $scope.incident.formattedTime = mmt.format("DD/MM/YYYY hh:mm");

    var dispatches = $scope.incident['dispatch_set'];
    var dispatchList = [];

    for (var i = 0; i < dispatches.length; i++) {
        if (!dispatches[i]["is_approved"]) {
            continue;
        }
        var dispatch = dispatches[i];
        timeStr = dispatch.time;
        mmt = moment(timeStr, "YYYY-MM-DDThh:mm:ssZ");
        dispatch.formattedTime = mmt.format("hh:mm");
        dispatchList.push(dispatch);
    }
    $scope.incident['dispatch_set'] = dispatchList;

    var updates = $scope.incident['inciupdate_set'];
    var updateList = [];

    for (var i = 0; i < updates.length; i++) {
        if (!updates[i]['is_approved']) {
            continue;
        }
        var update = updates[i];
        timeStr = update.time;
        mmt = moment(timeStr, "YYYY-MM-DDThh:mm:ssZ");
        update.formattedTime = mmt.format("hh:mm");
        updateList.push(update);
    }
    $scope.incident['inciupdate_set'] = updateList;

    setTimeout(function() {
        var ichecks = $('div#event-severity-check input[type="checkbox"].flat-red, input[type="radio"].flat-red');
        ichecks.iCheck({
            checkboxClass: 'icheckbox_flat-red',
            radioClass: 'iradio_flat-red',
            disabledClass: 'non-clickable'
        });

    }, 200);
}