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
      display.textContent = "国名：" + country + " 住所：" + addressOnly.replace(/、/g, "");
      document.cookie = "selectedCountry=" + encodeURIComponent(country) + "; path=/";
      document.cookie = "selectedAddress=" + encodeURIComponent(addressOnly) + "; path=/";
      document.cookie = "inputPlace=" + encodeURIComponent(inputAddress) + "; path=/";

      let prefecture = extractPrefectureFromAddress(addressOnly);
      if(prefecture) {
        document.cookie = "selectedPrefecture=" + encodeURIComponent(prefecture) + "; path=/";
      }
    } else {
      alert('該当する結果がありませんでした：' + status);
    }
  });
}

function extractPrefectureFromAddress(address) {
  const regex = /(東京都|北海道|京都府|大阪府|愛知県|岐阜県|静岡県|三重県|埼玉県|千葉県|神奈川県|新潟県|富山県|石川県|福井県|山梨県|長野県|岩手県|宮城県|福島県|茨城県|栃木県|群馬県|滋賀県|兵庫県|奈良県|和歌山県|鳥取県|島根県|岡山県|広島県|山口県|徳島県|香川県|愛媛県|高知県|福岡県|佐賀県|長崎県|熊本県|大分県|宮崎県|鹿児島県|沖縄県)/;

  const match = address.match(regex);
  if (match) {
    return match[0];
  } else {
    return null;
  }
}

function goBackToForm() {
  window.location.href = "/posts/new";
}
