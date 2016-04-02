// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery.turbolinks
//= require jquery_ujs
//= require turbolinks
//= require_tree .
//= require angular
//= require bootstrap




(function(angular) {
'use strict';

angular.module("bcApp", [])
	.controller('infoController', ['$scope', function($scope) {
		$scope.data = {
			print_method_id: "0",
			ink_color_id: "0",
			bleed_id: "1",
			raised_ink_id: "1",
			dimensions_id: "1",
			paper_type_id: "0",
			coating_id: "1",
			quantity_id: "0",
			box_count_id: "0",
			metal_id: "1"
		};
	}]);
	})(window.angular);