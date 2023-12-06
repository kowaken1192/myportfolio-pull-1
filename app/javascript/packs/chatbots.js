// Turbolinksのloadイベントに応じて初期化関数を実行
document.addEventListener('turbolinks:load', () => {
  setupFormSubmitHandler(); // フォームのサブミットハンドラーをセットアップ
});

function setupFormSubmitHandler() {
  const form = document.getElementById('chat-form'); // チャットフォームを取得
  if (!form) return; // フォームが存在しない場合は関数を終了

  // イベントリスナーを一度だけ追加
  if (!form.dataset.listenerAttached) {
    form.dataset.listenerAttached = 'true'; // リスナーが追加されたことをマーク
    form.addEventListener('submit', handleFormSubmit); // submitイベントに対するハンドラーを追加
  }
}

function handleFormSubmit(event) {
  event.preventDefault(); // フォームのデフォルトの送信を防止

  const form = event.target; // イベントが発生したフォームを取得
  $.ajax({
    url: form.action, // フォームのアクションURL
    type: form.method, // フォームのメソッド（GET, POSTなど）
    data: $(form).serialize(), // フォームのデータをシリアライズ
    dataType: 'json', // 応答のデータタイプをJSONに設定
    success: updateChatWindow, // 通信成功時のコールバック
    error: (xhr, status, error) => { // 通信失敗時のコールバック
      console.error('エラーが発生しました:', status, error);
    }
  });
}

function updateChatWindow(response) {
  const chatWindow = document.getElementById('chat-window'); // チャットウィンドウを取得
  if (!chatWindow) return; // チャットウィンドウが存在しない場合は関数を終了

  const userMessage = `<div>User: ${$('#chat-input').val()}</div>`; // ユーザーのメッセージをHTMLで作成
  const botMessage = `<div>Bot: ${response.response}</div>`; // ボットの応答をHTMLで作成
  chatWindow.innerHTML += userMessage + botMessage; // チャットウィンドウにメッセージを追加
  chatWindow.scrollTop = chatWindow.scrollHeight; // チャットウィンドウを最下部にスクロール
  $('#chat-input').val(''); // 入力フィールドをクリア
}
