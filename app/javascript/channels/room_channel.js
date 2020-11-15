import consumer from "./consumer"

// turbolinks の読み込みが終わった後にidを取得しないと，エラーが出ます。
document.addEventListener('turbolinks:load', () => {

  // js.erb 内で使用できるように変数を定義しておく
  window.messageContainer = document.getElementById('message-container')

  // 以下のプログラムが他のページで動作しないようにしておく
  if (messageContainer === null) {
      return
  }

  consumer.subscriptions.create("RoomChannel", {
    connected() {
      // Called when the subscription is ready for use on the server
    },

    disconnected() {
      // Called when the subscription has been terminated by the server
    },

    received(data) {
      messageContainer.insertAdjacentHTML('beforeend', data['message'])
    }
  });

  // ページ開いた際一番下に移動
  const documentElement = document.documentElement
  // js.erb 内でも使用できるように変数を決定
  window.messageContent = document.getElementById('message_content')
  // 一番下まで移動する関数。js.erb 内でも使用できるように変数を決定
  window.scrollToBottom = () => {
      window.scroll(0, documentElement.scrollHeight)
  }

  // 最初にページ一番下へ移動させる
  scrollToBottom()

  // 送信ボタン設定
  const messageButton = document.getElementById('message-button')

  // 空欄でなければボタンを有効化，空欄なら無効化する関数
  const button_activation = () => {
      if (messageContent.value === '') {
          messageButton.classList.add('disabled')
      } else {
          messageButton.classList.remove('disabled')
      }
  }

  // フォームに入力した際の動作
  messageContent.addEventListener('input', () => {
      button_activation()
  })

  // 送信ボタンが押された時にボタンを無効化
  messageButton.addEventListener('click', () => {
      messageButton.classList.add('disabled')
  })
})