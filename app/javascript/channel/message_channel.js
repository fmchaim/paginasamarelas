import consumer from "./consumer"

consumer.subscriptions.create("MessageChannel", {
  received(data) {
    // Atualiza a interface do usuário com a nova mensagem
    const notifications = document.querySelector('.navbar');
    notifications.innerHTML += `<span class="badge bg-danger">Nova mensagem</span>`;
  }
});
