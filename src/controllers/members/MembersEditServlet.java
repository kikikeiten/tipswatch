package controllers.members;

import java.io.IOException;

import javax.persistence.EntityManager;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import models.Member;
import utils.DBUtil;

@WebServlet("/members/edit")
public class MembersEditServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public MembersEditServlet() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        EntityManager em = DBUtil.createEntityManager();

        // members/edit.jspのmember_idからメンバーidを取得
        Member m = em.find(Member.class, Integer.parseInt(request.getParameter("member_id")));

        em.close();

        request.setAttribute("member", m);
        request.setAttribute("_token", request.getSession().getId());
        request.getSession().setAttribute("member_id", m.getId());

        RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/views/members/edit.jsp");
        rd.forward(request, response);
    }

}