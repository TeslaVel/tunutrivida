// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import Chartkick from "chartkick"
import Chart from "chart.js"


import "jquery"
import 'popper.js'
import 'bootstrap';
import 'bootstrap/dist/css/bootstrap.css';


global.toastr = require("toastr")
global.$ = jQuery;

Rails.start()
Turbolinks.start()
ActiveStorage.start()
Chartkick.use(Chart)

// datatable(window, $)
// datatableBS4(window, $)

import '@fortawesome/fontawesome-free/js/all'
// import datatable from 'imports-loader?define=>false!datatables.net'
// import datatableBS4 from 'imports-loader?define=>false!datatables.net-bs4'
import './shared/sb-admin-2'
import './shared/functions'


import './shared/charts'

// import './shared/demo/datatables-demo'
// import './shared/demo/chart-area-demo'
// import './shared/demo/chart-bar-demo'
// import './shared/demo/chart-pie-demo'

let found_class_date = $('.datetime').val();
if (found_class_date)
{
	$('.datetime').datepicker({
	    uiLibrary: 'bootstrap4'
	});
}
