// Turbolinksのloadイベントに応じて初期化関数を実行
document.addEventListener('turbolinks:load', () => {
  setupFormSubmitHandler();
});

function setupFormSubmitHandler() {
  const form = document.getElementById('chat-form');
  if (!form) return;

  // イベントリスナーを一度だけ追加
  if (!form.dataset.listenerAttached) {
    form.dataset.listenerAttached = 'true';
    form.addEventListener('submit', handleFormSubmit);
  }
}

function handleFormSubmit(event) {
  event.preventDefault();

  const form = event.target;
  $.ajax({
    url: form.action,
    type: form.method,
    data: $(form).serialize(),
    dataType: 'json',
    success: updateChatWindow,
    error: (xhr, status, error) => {
      console.error('エラーが発生しました:', status, error);
    }
  });
}

function updateChatWindow(response) {
  const chatWindow = document.getElementById('chat-window');
  if (!chatWindow) return;

  const userMessage = `<div>User: ${$('#chat-input').val()}</div>`;
  const botMessage = `<div>Bot: ${response.response}</div>`;
  chatWindow.innerHTML += userMessage + botMessage;
  chatWindow.scrollTop = chatWindow.scrollHeight;
  $('#chat-input').val('');
}
