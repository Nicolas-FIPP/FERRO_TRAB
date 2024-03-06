package org.example.trabalho;

import java.io.*;

import org.example.trabalho.security.User;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

@WebServlet(name = "loginServlet", value = "/login-servlet")
public class LoginServlet extends HttpServlet {

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String login, pswd;
        login=request.getParameter("login");
        if(login!=null)
        {
            pswd=request.getParameter("senha");
            StringBuffer aux=new StringBuffer(pswd);
            if(login.contains("carro@email"))
            {
                User user=new User(login);
                HttpSession session=request.getSession();
                session.setAttribute("user",user);
                response.sendRedirect("index.jsp"); //entra no sistema
                return;
            }
        }
        response.sendRedirect("."); //volta para o login
        return;
    }

}