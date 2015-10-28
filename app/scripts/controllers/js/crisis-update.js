/**
 * Created by qikunxiang on 27/10/15.
 */
function crisisUpdateInit() {
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
}