
function submitMenu(menuKey)
{
  menu_state_obj =  jQuery.parseJSON( $("#menu_state").val() );
  menu_state_obj['clicked_menu_key'] = menuKey;
  $("#menu_state").val(JSON.stringify(menu_state_obj));
  $('#menu_form').submit();
}

$(document).ready(function () {
	$(".message > .dismiss > a").live("click", function (event) {
		var value = $(this).attr("href");
		var id = value.substring(value.indexOf('#') + 1);

		$("#" + id).fadeOut('slow', function () { });

		return false;
	});

	$("#menu h6 a").click(function () {
		var link = $(this);
		var value = link.attr("href");
		var id = value.substring(value.indexOf('#') + 1);

		var heading = $("#h-menu-" + id);
		var list = $("#menu-" + id);

    menu_state_obj =  jQuery.parseJSON( $("#menu_state").val() );

		if (list.attr("class") == "closed") {
      menu_state_obj[id] = "opened";
			heading.attr("class", "selected");
			list.attr("class", "opened");
		} else {
      menu_state_obj[id] = "";
			heading.attr("class", "");
			list.attr("class", "closed");
		}
    $("#menu_state").val(JSON.stringify(menu_state_obj));
	});

	$("#menu li a[class~=collapsible]").click(function () {
		var element = $(this);

		if (element.attr("class") == "collapsible plus") {
			element.attr("class", "collapsible minus");
		} else {
			element.attr("class", "collapsible plus");
		}

		var list = element.next();
    id = list.attr("id");
    menu_state_obj =  jQuery.parseJSON( $("#menu_state").val() );

		if (list.attr("class") == "collapsed") {
			list.attr("class", "expanded");
      menu_state_obj[id] = "opened";
		} else {
			list.attr("class", "collapsed");
      menu_state_obj[id] = "closed";
		}
    $("#menu_state").val(JSON.stringify(menu_state_obj));
	});

});
