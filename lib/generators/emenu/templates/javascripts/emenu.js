function post_to_server(id, state)
{
  state_map = {}
  state_map['id'] = id;
  state_map['state'] = state;
  $.post('/emenu_state', state_map);
}

function open(id)
{
  post_to_server(id, "opened");
}

function close(id)
{
  post_to_server(id, "closed");
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


		if (list.attr("class") == "closed") {
      open(id);
			heading.attr("class", "selected");
			list.attr("class", "opened");
		} else {
      close(id);
			heading.attr("class", "");
			list.attr("class", "closed");
		}
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

		if (list.attr("class") == "collapsed") {
			list.attr("class", "expanded");
      open(id);
		} else {
			list.attr("class", "collapsed");
      close(id);
		}
	});

});
