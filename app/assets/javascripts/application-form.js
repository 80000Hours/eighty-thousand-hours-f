// from http://stackoverflow.com/questions/149055/how-can-i-format-numbers-as-money-in-javascript
Number.prototype.formatMoney = function(c, d, t){
  var n = this, c = isNaN(c = Math.abs(c)) ? 2 : c, d = d == undefined ? "," : d, t = t == undefined ? "." : t, s = n < 0 ? "-" : "", i = parseInt(n = Math.abs(+n || 0).toFixed(c)) + "", j = (j = i.length) > 3 ? j % 3 : 0;
 return s + (j ? i.substr(0, j) + t : "") + i.substr(j).replace(/(\d{3})(?=\d)/g, "$1" + t) + (c ? d + Math.abs(n - i).toFixed(c).slice(2) : "");
};

function initialise_slider( name, range, min, max, step, start, display )
{
  // default identity for display function
  if(typeof(display)==='undefined')
  {
    var display = function(val) { return val; };
  }

  $(name + "_slider").slider({
    range: range,
    value: start,
    min: min,
    max: max, 
    step: step,
    slide: function(event, ui) { 
      $(name).val(ui.value);
      $(name + "_display").html(display(ui.value));
    }
  });
  $(name).val(start);
  $(name + "_display").html(display(start));
}

$(document).ready(function() {
  // get current value from hidden element
  init_val = $('#user_etkh_profile_attributes_donation_percentage').val();
  initialise_slider("#user_etkh_profile_attributes_donation_percentage", "min", 0, 100, 5, init_val);
  //initialise_slider("#etkh_profile_hic_activity_hours", "min", 0, 168, 5, 10);
  //initialise_slider("#etkh_profile_average_income", "min", 10000, 5000000, 10000, 100000, function(x){ return x.formatMoney(0,'.',','); } );
});
