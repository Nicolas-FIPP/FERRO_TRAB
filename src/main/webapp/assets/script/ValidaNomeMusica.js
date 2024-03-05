function pesquisarMusica() {
    var trecho = document.getElementById("pesquisaMusica").value;
    window.location.href = "index.jsp?trecho=" + encodeURIComponent(trecho);
}
