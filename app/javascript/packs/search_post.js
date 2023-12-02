// 地図を非同期で読み込むための関数
async function loadMap() {
  // 地図のパスをHTML要素から取得
  const map = document.querySelector('#search_map').getAttribute('data-map-path');
  const container = document.querySelector('#search_map');

  try {
    // 地図のSVGデータを取得
    const res = await fetch(map);

    // レスポンスが正常であれば、SVGデータをページに挿入
    if (res.ok) {
      const svg = await res.text();
      container.innerHTML = svg;

      // 投稿数データをサーバーから取得
      const countsRes = await fetch('/search_post/count_by_prefecture');
      const countsData = await countsRes.json();

      // 地図上の都道府県要素をすべて取得
      const prefs = document.querySelectorAll('.geolonia-svg-map .prefecture');

      // 各都道府県要素にイベントリスナーを設定
      prefs.forEach((pref) => {
        // マウスオーバー時のイベント：色を黒に変更
        pref.addEventListener('mouseover', (event) => {
          event.currentTarget.style.fill = "black";
        });

        // マウスアウト時のイベント：元の色に戻す
        pref.addEventListener('mouseleave', (event) => {
          event.currentTarget.style.fill = getColor(event.currentTarget.dataset.pref, countsData);
        });

        // クリック時のイベント：特定のURLに遷移
        const titleElement = pref.querySelector('title');
        if (titleElement) {
          const prefectureName = titleElement.textContent.split(' / ')[0];
          pref.dataset.pref = prefectureName;

          // 初期の色を設定
          pref.style.fill = getColor(prefectureName, countsData);

          // クリック時に検索結果ページに遷移
          pref.addEventListener('click', () => {
            location.href = `/search_post/result?q[address_cont]=${encodeURIComponent(prefectureName)}`;
          });
        }
      });
    }
  } catch (error) {
    // エラー発生時の処理：コンソールにエラーメッセージを出力
    console.error("Error loading search_map:", error);
  }
}

// 都道府県名と投稿数データを基に色を取得する関数
function getColor(prefName, countsData) {
  const count = countsData[prefName] || 0;
  if (count >= 10) return 'red'; // 投稿数が10以上の場合は赤色
  if (count >= 5) return 'blue'; // 投稿数が5以上の場合は青色
  if (count > 0) return 'pink'; // 投稿数が1以上の場合はピンク色
  return 'white'; // 投稿数が0の場合は白色
}

// 地図の読み込みを実行
loadMap();
