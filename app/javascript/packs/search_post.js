async function loadMap() {
  const map = document.querySelector('#search_map').getAttribute('data-map-path');
  const container = document.querySelector('#search_map');

  try {
    const res = await fetch(map);

    if (res.ok) {
      const svg = await res.text();
      container.innerHTML = svg;

      // 投稿数データを取得
      const countsRes = await fetch('/search_post/count_by_prefecture');
      const countsData = await countsRes.json();

      const prefs = document.querySelectorAll('.geolonia-svg-map .prefecture');

      prefs.forEach((pref) => {
        // マウスオーバーで色を変える
        pref.addEventListener('mouseover', (event) => {
          event.currentTarget.style.fill = "black";
        });

        // マウスが離れたら色をもとに戻す
        pref.addEventListener('mouseleave', (event) => {
          event.currentTarget.style.fill = getColor(event.currentTarget.dataset.pref, countsData);
        });

        // クリックイベントの追加
        const titleElement = pref.querySelector('title');
        if (titleElement) {
          const prefectureName = titleElement.textContent.split(' / ')[0];
          pref.dataset.pref = prefectureName;

          // 初期の色を設定
          pref.style.fill = getColor(prefectureName, countsData);

          pref.addEventListener('click', () => {
            location.href = `/search_post/result?q[address_cont]=${encodeURIComponent(prefectureName)}`;
          });
        }
      });
    }
  } catch (error) {
    console.error("Error loading search_map:", error);
  }
}

function getColor(prefName, countsData) {
  const count = countsData[prefName] || 0;
  if (count >= 10) return 'red';  
  if (count >= 5) return 'blue';
  if (count > 0) return 'pink';
  return 'white';  
}
// 関数を呼び出して地図を読み込む
loadMap();
