async function loadMap() {
  const map = "/assets/map-mobile.svg";
  const container = document.querySelector('#map');

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

        // マウスクリック時のイベント
        pref.addEventListener('click', (event) => {
          location.href = `https://example.com/${event.currentTarget.dataset.code}`; // 例（大阪）: https://example.com/27
        });
      });
    }
  } catch (error) {
    console.error("Error loading map:", error);
  }
}

// 関数を呼び出して地図を読み込む
loadMap();
