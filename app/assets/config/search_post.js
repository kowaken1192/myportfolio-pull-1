async function loadMap() {
  const map = document.querySelector('#search_map').getAttribute('data-map-path');
  const container = document.querySelector('#search_map');

  try {
    const res = await fetch(map);

    if (res.ok) {
      const svg = await res.text();
      container.innerHTML = svg;
      const prefs = document.querySelectorAll('.geolonia-svg-map .prefecture');

      prefs.forEach((pref) => {
        // マウスオーバーで色を変える
        pref.addEventListener('mouseover', (event) => {
          event.currentTarget.style.fill = "#ff0000";
        });

        // マウスが離れたら色をもとに戻す
        pref.addEventListener('mouseleave', (event) => {
          event.currentTarget.style.fill = "";
        });

        // クリックイベントの追加
        const titleElement = pref.querySelector('title');
        if (titleElement) {
          const prefectureName = titleElement.textContent.split(' / ')[0]; // "群馬 / Gunma"のような形式から都道府県名を取得
          pref.dataset.pref = prefectureName;

          // ここでクリックイベントにリダイレクトの処理を追加することもできます
          pref.addEventListener('click', () => {
            location.href = `/search_post/show?q[address_cont]=${encodeURIComponent(prefectureName)}`;
          });
        }
      });
    }
  } catch (error) {
    console.error("Error loading search_map:", error);
  }
}

// 関数を呼び出して地図を読み込む
loadMap();
