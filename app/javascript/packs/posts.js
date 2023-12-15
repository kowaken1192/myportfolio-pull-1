// ドキュメントが読み込まれた際の処理
document.addEventListener("DOMContentLoaded", function() {
  // クッキーから保存した住所を取得
  let savedAddress = getCookie("selectedAddress");
  let savedCountry = getCookie("selectedCountry");
  let inputPlace = getCookie("inputPlace");
  let savedPrefecture = getCookie("selectedPrefecture");

  // 保存した住所があれば、対応する入力フィールドに値を設定
  if (savedAddress) {
    savedAddress = removeLeadingPunctuation(decodeURIComponent(savedAddress));
    document.getElementById("post_address").value = savedAddress;
  }

  if (savedCountry) {
    savedCountry = removeLeadingPunctuation(decodeURIComponent(savedCountry));
    document.getElementById("post_country").value = savedCountry;
  }

  if (inputPlace) {
    inputPlace = removeLeadingPunctuation(decodeURIComponent(inputPlace));
    document.getElementById("post_name").value = inputPlace;
  }

  if (savedPrefecture) {
    savedPrefecture = removeLeadingPunctuation(decodeURIComponent(savedPrefecture));
    document.getElementById("post_prefecture").value = savedPrefecture;
  }
});

// 文字列の先頭の句読点を削除する関数
function removeLeadingPunctuation(string) {
  if (!string) return string;
  while (string.startsWith('、')) {
    string = string.substring(1);
  }
  return string;
}

// クッキーから値を取得する関数
function getCookie(name) {
  let value = "; " + document.cookie;
  let parts = value.split("; " + name + "=");
  if (parts.length == 2) return parts.pop().split(";").shift();
}

// マップページにリダイレクトする関数
function redirectToMapPage() {
  window.location.href = "/map/index";
}

// Google Mapsの初期化
function initMap() {
  var map = new google.maps.Map(document.getElementById('map'), {
    zoom: 14, // ズームレベルを調整できます
    center: spot
  });

  var marker = new google.maps.Marker({
    position: spot,
    map: map,
    title: '<%= @post.name %>'
  });
}
