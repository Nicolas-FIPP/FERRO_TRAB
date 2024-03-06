package Servletupload;

import java.io.*;
import jakarta.servlet.*;
import jakarta.servlet.annotation.*;
import jakarta.servlet.http.*;
@WebServlet(name = "UploadServlet", value = "/upservlet")
@MultipartConfig(
        location="/",  // Defina o caminho diretamente
        fileSizeThreshold=1024*1024,    // 1MB *
        maxFileSize=1024*1024*100,      // 100MB **
        maxRequestSize=1024*1024*10*10  // 100MB ***
)
public class UploadServlet extends HttpServlet {

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        response.setContentType("text/html;charset=UTF-8");

        try {
            Part filePart = request.getPart("file");  // Lê o arquivo de upload
            String fileName = filePart.getSubmittedFileName();
            String nomeMusica = request.getParameter("Nmusica");
            String estiloMusica = request.getParameter("estilosMusica");
            String cantor = request.getParameter("cantor");

            // Constrói um novo nome para o arquivo mantendo a extensão .mp3
            String novoNome = nomeMusica + "_" + estiloMusica + "_" + cantor + ".mp3";

            // Configura o caminho da pasta diretamente
            String caminhoPasta = getServletContext().getRealPath("/") +"/" + "musicas";

            File fpasta = new File(caminhoPasta);

            // Cria o caminho do arquivo dentro da pasta
            String caminhoArquivo = fpasta.getAbsolutePath() + File.separator + novoNome;

            try (OutputStream out = new FileOutputStream(new File(caminhoArquivo));
                 InputStream filecontent = filePart.getInputStream()) {

                int read;
                byte[] bytes = new byte[1024];
                while ((read = filecontent.read(bytes)) != -1) {
                    out.write(bytes, 0, read);
                }
            }

            // Redireciona o usuário para a mesma página após o envio do arquivo
            response.sendRedirect(request.getContextPath() + "/index.jsp");

        } catch (Exception e) {
            // Trate a exceção conforme necessário
            request.setAttribute("erro", "Erro ao receber o arquivo: " + e.getMessage());
            request.getRequestDispatcher("/index.jsp").forward(request, response);
        }
    }
}
