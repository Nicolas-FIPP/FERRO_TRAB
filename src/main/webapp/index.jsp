<%@ page import="org.example.trabalho.security.User" %>
<%@ page import="java.io.File" %>
<%@ page contentType="text/html; charset=UTF8" %>
<!DOCTYPE html>
<%
  User user = (User) session.getAttribute("user");
  String usuario = "";

  if (user != null && user.isAccess()) {
    usuario = user.getName();
    String nome = "";
    for(int i = 0;usuario.charAt(i) != '@';i++)
      nome += usuario.charAt(i);
    usuario = nome;
  }

%>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>SPOTIFY</title>
  <script src="assets/script/playMusic.js"></script>
  <script src="assets/script/validarFormulario.js"></script>
  <script src="assets/script/ValidaNomeMusica.js"></script>
  

  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
</head>
<body>
<nav class="navbar navbar-dark bg-dark">
  <div class="container-fluid">
    <a class="navbar-brand" href="#" style="color: white;">Play My Songs!</a>
    <%if(user == null){ %>
    <form class="d-flex mr-auto" method="post" action="./login-servlet">
      <input  class="form-control me-2" type="text" placeholder="Login" aria-label="Login" name ="login">
      <input  class="form-control me-2" type="password" placeholder="Senha" aria-label="Senha" name ="senha">
      <button class="btn btn-outline-success" type="submit">Login</button>
    </form>
     <% }%>
  </div>
</nav>
<div>
  <% if (user != null && user.isAccess()) { %>
  <div style="text-align: center; margin-top: 50px;">
    <a style="font-size: 24px; color: blue;">Bem-vindo <%= usuario %></a>
  </div>
  <% } %>



</div>
<section>
  <div class="container mt-4 mb-4">
    <div class="row justify-content-center">
      <div class="col-md-8">
        <form enctype="multipart/form-data" action="upservlet" enctype="multipart/form-data"  method="post" onsubmit=" return validarFormulario()">
          <div class="mb-3">
            <label for="Nomemusica" class="form-label">Digite o nome da musica </label>
            <input type="text" class="form-control" id="Nomemusica" name="Nmusica" placeholder="Musica" onblur="ValidaNomeMusica()">
            <div id="nomeMusicaErro" style="color: red;"></div>
            <label for="cantor" class="form-label">Digite o nome do cantor:</label>
            <input type="text" class="form-control" id="cantor" name="cantor" placeholder="Cantor" required>
          </div>

          <div class="mb-3">
            <label for="estilosMusica" class="form-label">Escolha o estilo da música:</label>
            <select class="form-select" id="estilosMusica" name="estilosMusica">
              <option value="pop">Pop</option>
              <option value="rock">Rock</option>
              <option value="metal">Metal</option>
              <option value="gospel">Gospel</option>
            </select>
          </div>

          <div class="mb-3">
            <label for="file" class="form-label">Escolha um arquivo MP3:</label>
            <input type="file" class="form-control" id="file" name="file" accept=".mp3">
          </div>

          <%-- Adicionando a verificação do usuário antes de permitir o envio --%>
          <% if (user != null && user.isAccess()) { %>
          <button type="submit" class="btn btn-outline-success" id="upload" value="Upload" name ="upload" onclick="window.location.reload()">Enviar</button>
          <% } else { %>
          <p style="color:red;margin-bottom: 21px;margin-top: 21px">Você precisa estar logado para enviar músicas.</p>
          <% } %>
        </form>
      </div>
    </div>
  </div>
</section>

<section>
  <div class="container mt-4 mb-4">
    <div class="row justify-content-center">
      <div class="col-md-8">
        <div class="input-group">
          <form>
            <div>
          <input type="text" class="form-control" name = "buscaNome" style="text-align: center;" placeholder="Pesquise sua música">
            <button style="margin-left: 21px;margin-right: 21px" class="btn btn-outline-success"  type="submit" >Pesquisar</button>
            </div>
          </form>
        </div>
      </div>
    </div>
  </div>



  <div class="container mt-5">
    <h2>Tabela de Músicas</h2>
    <table class="table">
      <thead>
      <tr>
        <th scope="col">NOME</th>
        <th scope="col">PLAY</th>
      </tr>
      </thead>
      <tbody>
      <%
        File pastaweb = new File(request.getServletContext().getRealPath("") + "/musicas");
        String nomeProcurado = request.getParameter("buscaNome");
        System.out.println(nomeProcurado);


        pastaweb = new File(request.getServletContext().getRealPath("") + "/musicas");
        File[] files = pastaweb.listFiles();
          if(nomeProcurado != null){

          for (File file : files) {
            if (file.isFile() && file.getName().contains(nomeProcurado)) {

      %>
      <tr>
        <td><%= file.getName() %></td>
        <td>
          <audio controls id="audioPlayer">
            <source src="musicas/<%=file.getName()%>" type="audio/mpeg">

            Seu navegador não suporta a tag de áudio.
          </audio>
        </td>
      </tr>
      <%
              }
            }
          }
              %>

      </tbody>
    </table>
  </div>
</section>


<br/>
</body>
</html>
