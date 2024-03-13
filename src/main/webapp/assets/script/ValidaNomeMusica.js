function ValidaNomeMusica() {
    var valor = document.getElementById("Nomemusica").value;
    var regex = /[^\w\s]/;

    if (valor.trim() === "") {
        document.getElementById('nomeMusicaErro').innerText = 'O nome não pode estar vazio.';
    } else if (regex.test(valor)) {
        document.getElementById('nomeMusicaErro').innerText = 'O nome não pode conter caracteres especiais.';
    } else {
        document.getElementById('nomeMusicaErro').innerText = '';
    }
}
