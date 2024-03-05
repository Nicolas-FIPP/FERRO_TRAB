package org.example.trabalho.REQ;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;  // Importe a classe IOException corretamente
import java.io.InputStream;
import java.io.OutputStream;

@WebServlet(name = "MusicServlet", value = "/MuscREQ/*")
public class MusicServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String requestedFile = request.getPathInfo();
        String basePath = getServletContext().getRealPath("/musicas");
        File file = new File(basePath, requestedFile.substring(1));

        if (requestedFile == null || requestedFile.equals("/")) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }


        if (!file.exists() || !file.isFile()) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        try (InputStream input = new FileInputStream(file);
             OutputStream output = response.getOutputStream()) {

                response.setContentType("audio/mpeg"); // ou o tipo MIME apropriado para o seu arquivo de música
            response.setContentLength((int) file.length());

            byte[] buffer = new byte[4096];
            int bytesRead;
            while ((bytesRead = input.read(buffer)) != -1) {
                output.write(buffer, 0, bytesRead);
            }
        } catch (IOException e) {
            // Lidar com a exceção, por exemplo, registrando-a ou enviando um código de erro ao cliente
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            e.printStackTrace();
        }
    }
}
