function validarFormulario() {
    var nomeMusica = document.getElementById('Nomemusica').value;

    if (!ValidaNomeMusica(nomeMusica)) {
        // Se o nome da música não for válido, interrompe o envio do formulário
        return false;
    }

    // Adicione aqui qualquer outra lógica de validação necessária antes de enviar o formulário

    return true; // Permite o envio do formulário se todas as validações passarem
}