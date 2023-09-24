let map;
let geocoder;
let marker; 
const display = document.getElementById('display');

function initMap() {
  geocoder = new google.maps.Geocoder();
  map = new google.maps.Map(document.getElementById('map'), {
    center: { lat: 40.7828, lng: -73.9653 },
    zoom: 12,
  });
  marker = new google.maps.Marker({
    position: { lat: 40.7828, lng: -73.9653 },
    map: map
  });
}

function codeAddress() {
  let inputAddress = document.getElementById('address').value;
  geocoder.geocode({ 'address': inputAddress, 'language': 'ja' }, function (results, status) {
    if (status == 'OK') {
      map.setCenter(results[0].geometry.location);

      marker.setPosition(results[0].geometry.location);

      let addressWithoutPostalCode = results[0].formatted_address.replace(/〒\d{3}-\d{4} /, "");
      let country = results[0].address_components.find(component => component.types.includes("country")).long_name;
      let addressOnly = addressWithoutPostalCode.replace(country, '').trim();
      display.textContent = "国名：" + country + " 住所：" + addressOnly.replace(/^、/, "");
      document.cookie = "selectedCountry=" + encodeURIComponent(country) + "; path=/";
      document.cookie = "selectedAddress=" + encodeURIComponent(addressOnly) + "; path=/";
      document.cookie = "inputPlace=" + encodeURIComponent(inputAddress) + "; path=/";
    } else {
      alert('該当する結果がありませんでした：' + status);
    }
  });
}

function goBackToForm() {
  window.location.href = "/posts/new";
}
