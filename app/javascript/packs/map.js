// Google Mapsのジオコーダーとマーカーオブジェクトの宣言
let geocoder;
let marker;
const display = document.getElementById('display');

// Googleマップを初期化する関数
window.initMap = function() {
  // ジオコーダーオブジェクトを新しく作成
  geocoder = new google.maps.Geocoder();
  // マップオブジェクトの初期化（地図の表示設定）
  map = new google.maps.Map(document.getElementById('map'), {
    center: { lat: 40.7828, lng: -73.9653 }, // 初期中心座標（緯度・経度）
    zoom: 12, // ズームレベル
  });
  // マーカーオブジェクトの初期化（マーカーの位置設定）
  marker = new google.maps.Marker({
    position: { lat: 40.7828, lng: -73.9653 }, // マーカーの初期位置
    map: map // マーカーを表示する地図
  });
};

// 住所をコード化して地図上に表示する関数
window.codeAddress = function() {
  // 入力フィールドから住所を取得
  let inputAddress = document.getElementById('address').value;
  // ジオコーディング処理（住所から座標を取得）
  geocoder.geocode({ 'address': inputAddress, 'language': 'ja' }, function (results, status) {
    if (status == 'OK') {
      // ジオコーディング成功時の処理
      map.setCenter(results[0].geometry.location); // 地図の中心を変更
      marker.setPosition(results[0].geometry.location); // マーカーの位置を更新

      // 郵便番号を除去して住所を整形
      let addressWithoutPostalCode = results[0].formatted_address.replace(/〒\d{3}-\d{4} /, "");
      // 国名を抽出
      let country = results[0].address_components.find(component => component.types.includes("country")).long_name;
      // 国名を除いた住所を抽出
      let addressOnly = addressWithoutPostalCode.replace(country, '').trim();
      // 画面に国名と住所を表示
      display.textContent = "国名：" + country + " 住所：" + addressOnly.replace(/、/g, "");
       // replace(/、/g, "")は、住所内のすべての「、」を空文字列（削除）で置換するために使用
      // 選択した国名、住所、入力した場所をクッキーに保存
      document.cookie = "selectedCountry=" + encodeURIComponent(country) + "; path=/";
      document.cookie = "selectedAddress=" + encodeURIComponent(addressOnly) + "; path=/";
      document.cookie = "inputPlace=" + encodeURIComponent(inputAddress) + "; path=/";

      // 都道府県名を抽出してクッキーに保存
      let prefecture = extractPrefectureFromAddress(addressOnly);
      if(prefecture) {
        document.cookie = "selectedPrefecture=" + encodeURIComponent(prefecture) + "; path=/";
      }
    } else {
      // ジオコーディング失敗時のアラート表示
      alert('該当する結果がありませんでした：' + status);
    }
  });
};

// 与えられた住所から都道府県名を抽出する関数
function extractPrefectureFromAddress(address) {
  const regex = /(北海道|青森県|岩手県|宮城県|秋田県|山形県|福島県|茨城県|栃木県|群馬県|埼玉県|千葉県|東京都|神奈川県|新潟県|富山県|石川県|福井県|山梨県|長野県|岐阜県|静岡県|愛知県|三重県|滋賀県|京都府|大阪府|兵庫県|奈良県|和歌山県|鳥取県|島根県|岡山県|広島県|山口県|徳島県|香川県|愛媛県|高知県|福岡県|佐賀県|長崎県|熊本県|大分県|宮崎県|鹿児島県|沖縄県)/;
  // 住所から正規表現にマッチする部分（都道府県名）を検索
  const match = address.match(regex);
  if (match) {
    return match[0]; // マッチした都道府県名を返す
  } else {
    return null; // マッチしない場合はnullを返す
  }
}
// nextボタンを押した時に呼び出される関数
window.goBackToForm = function() {
  window.location.href = "/posts/new";
}
