// 'DOMContentLoaded' イベントが発生したときに実行される関数を設定
document.addEventListener('DOMContentLoaded', () => {
  // ドキュメント内のすべての '.notification .delete' 要素を取得し、それらに対して処理を行う
  (document.querySelectorAll('.notification .delete') || []).forEach(($delete) => {
    // 削除ボタンの親要素（通知要素）を取得
    const $notification = $delete.parentNode;

    // 削除ボタンにクリックイベントリスナーを追加
    $delete.addEventListener('click', () => {
      // クリックされたときに通知要素をDOMから削除
      $notification.parentNode.removeChild($notification);
    });
  });
});
