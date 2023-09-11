// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

Rails.start()
Turbolinks.start()
ActiveStorage.start()

document.addEventListener("DOMContentLoaded", function() {
    const input = document.getElementById('post_address');
    const autocomplete = new google.maps.places.Autocomplete(input);

    autocomplete.addListener('place_changed', function() {
        const place = autocomplete.getPlace();
        input.value = place.formatted_address;
    });
});

function initMap() {
    var center = {lat: -34.397, lng: 150.644}; 
    var map = new google.maps.Map(document.getElementById('map'), {
      zoom: 8,
      center: center
    });
  }
