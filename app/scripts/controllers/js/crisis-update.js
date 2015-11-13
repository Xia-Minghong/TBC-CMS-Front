/**
 * Created by qikunxiang on 27/10/15.
 */
function crisisUpdateInit() {
    setTimeout(function() {
        var timeConvert = function(d) {
            return moment(d).format("YYYY-MM-DDTHH:mm:ssZ");
        };

        var timepicker = $('#timePicker.timepicker');
        timepicker.timepicker({
            showInputs: true
        });

        timepicker.on("changeTime.timepicker", function(event) {
            var time = event.time;
            var t = new Date();
            t.setHours(time.hours + (time.meridian == "AM" ? 0 : 12), time.minutes, 0);
            $("input#timeHidden").val(timeConvert(t)).trigger("change");
        });

        window.setTimeout(function() {
            var date = new Date();
            date.setSeconds(0);
            $("input#timeHidden").val(timeConvert(date)).trigger("change");
        },500);

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
    }, 200);
}