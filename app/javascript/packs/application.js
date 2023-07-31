// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
import '../stylesheets/index.js.erb';
import './mainstyle.js';
import 'jquery';
import 'bootstrap';
import './bootstrap-notify.js';
import "@fortawesome/fontawesome-free/js/all";
import $ from 'jquery'




require("bootstrap")
require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("trix")
require("@rails/actiontext")
require("channels")
require("controllers/index") // Stimulus JS


// require("stylesheets/application.css")

$(document).on("turbolinks:render", () => {
    $('[data-toggle="tooltip"]').tooltip();

	if ($('[name="alert"]')[0]) {
		$.notify({
			icon: "nc-icon nc-bell-55",
			message: $('[name="alert"]')[0].content

		}, {
			type: 'warning',
			timer: 2000,
			placement: { from: 'top', align: 'right' }
		});
	}

	if ($('[name="notice"]')[0]) {
		$.notify({
			icon: "nc-icon nc-bell-55",
			message: $('[name="notice"]')[0].content

		}, {
			type: 'info',
			timer: 2000,
			placement: { from: 'top', align: 'right' }
		});
	}

	var action = $("body").data("action"),
		controller = $("body").data("controller")
	
	if($(`#nav-${controller}-${action}`).length > 0) {
		$("ul.nav>li.active").removeClass("active")
		$(`#nav-${controller}-${action}`).addClass('active');
	} else if ($(`#nav-${controller}`).length > 0) {
		$("ul.nav>li.active").removeClass("active")
		$(`#nav-${controller}`).addClass('active');
	}

	setTimeout(() => {
		$("html").removeClass("nav-open")
		$(".navbar-toggler").removeClass("toggled")
		paperDashboard.misc.navbar_menu_visible = 0
	}, 580)
	

	// $toggle = $(this), 1 == paperDashboard.misc.navbar_menu_visible ? ($("html").removeClass("nav-open"), paperDashboard.misc.navbar_menu_visible = 0, setTimeout(function () {
	// 	$toggle.removeClass("toggled"), $("#bodyClick").remove()
	// }, 550)) : (setTimeout(function () {
	// 	$toggle.addClass("toggled")
	// }, 580), div = '<div id="bodyClick"></div>', $(div).appendTo("body").click(function () {
	// 	$("html").removeClass("nav-open"), paperDashboard.misc.navbar_menu_visible = 0, setTimeout(function () {
	// 		$toggle.removeClass("toggled"), $("#bodyClick").remove()
	// 	}, 550)
	// }), $("html").addClass("nav-open"), paperDashboard.misc.navbar_menu_visible = 1)
	
	


	console.log("WIth action", $(`#nav-${controller}-${action}`))
	console.log("Only controller", $(`#nav-${controller}`))

	$('.remote-modal').on('show.bs.modal', function (e) {
		
		var button = $(e.relatedTarget);
		var modal = $(this);
		console.log(button[0].href)
		console.log(modal.find('.modal-body'))
		
		// load content from HTML string
		//modal.find('.modal-body').html("Nice modal body baby...");
		
		// or, load content from value of data-remote url
		modal.find('.modal-body').load(button[0].href);
		
	});
	$('.remote-modal').on('hidden.bs.modal', function (e) {
	});

})


// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

import "controllers"

require("trix")
require("@rails/actiontext")


require('./nested-forms/addFields')
require('./nested-forms/removeFields')


// import DataTable from 'datatable.net'

