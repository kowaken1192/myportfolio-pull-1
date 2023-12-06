import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

Rails.start()
Turbolinks.start()
ActiveStorage.start()

import "./users"
import './chatbots'

// turbolinks:load イベントリスナーを追加。Turbolinksはページの高速読み込みを助けるライブラリ。
document.addEventListener('turbolinks:load', () => {

  // ナビゲーションバーのバーガーアイコン（モバイルビューでのメニューボタン）のトグル機能を設定
  const navbarBurgers = Array.prototype.slice.call(document.querySelectorAll('.navbar-burger'), 0);
  if (navbarBurgers.length > 0) {
    // 各バーガーアイコンに対してイベントリスナーを設定
    navbarBurgers.forEach(el => {
      el.addEventListener('click', () => {
        const target = el.dataset.target; // 対象となるメニューのIDを取得
        const targetElement = document.getElementById(target); // 対象となるメニュー要素を取得
        el.classList.toggle('is-active'); // バーガーアイコンのアクティブ/非アクティブ状態を切り替え
        targetElement.classList.toggle('is-active'); // メニューの表示/非表示を切り替え
      });
    });
  }

  // 画面が一定幅以上のとき、ドロップダウンメニューを持つナビゲーションリンクの動作を制御
  const navbarLink = document.querySelector('.navbar-link');
  navbarLink.addEventListener('click', (event) => {
    if (window.innerWidth >= 465) {
      // 画面幅が465ピクセル以上の場合、デフォルトのクリックイベントを無効化
      event.preventDefault();
      event.stopPropagation();
    }
  });

  // ページ遷移時にナビゲーションメニューを閉じる関数
  const closeNavbarMenu = () => {
    const activeBurgers = document.querySelectorAll('.navbar-burger.is-active');
    activeBurgers.forEach(burger => {
      const target = burger.dataset.target; // 対象となるメニューのIDを取得
      const targetElement = document.getElementById(target); // 対象となるメニュー要素を取得
      burger.classList.remove('is-active'); // バーガーアイコンのアクティブ状態を解除
      targetElement.classList.remove('is-active'); // メニューの表示を解除
    });
  }

  // ページアンロード時とTurbolinksによるページ遷移前にナビゲーションメニューを閉じるイベントリスナーを設定
  window.addEventListener('beforeunload', closeNavbarMenu);
  document.addEventListener('turbolinks:before-render', closeNavbarMenu);
});
