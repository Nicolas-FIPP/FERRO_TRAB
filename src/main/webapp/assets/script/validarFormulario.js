function validarFormulario() {
    var nomeMusicaErro = document.getElementById("nomeMusicaErro");
    var nomeMusica = document.getElementById("Nomemusica").value;

    if (nomeMusicaErro.textContent !== "") {
        alert("Por favor, corrija os erros no formulário antes de enviar.");
        return false; // Impede o envio do formulário se houver erros de validação
    }

    return true;
}