package controllers.drafts;

import java.io.IOException;

import javax.persistence.EntityManager;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import models.Idea;
import models.Member;
import utils.DBUtil;

@WebServlet("/drafts/update")
public class DraftsUpdateServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public DraftsUpdateServlet() {
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        EntityManager em = DBUtil.createEntityManager();

        // ログイン中のメンバーIDを取得
        Member loginMember = (Member) request.getSession().getAttribute("loginMember");

        // 提出する下書きのアイデアIDを取得
        Idea idea = em.find(Idea.class, Integer.parseInt(request.getParameter("ideaId")));

        // Ideaテーブルのレビュー状態を更新
        idea.setReviewStatus(Integer.parseInt(request.getParameter("reviewStatus")));

        em.getTransaction().begin();
        em.getTransaction().commit();
        em.close();

        switch (loginMember.getRole()) {
            case 0: // associateの場合
            case 1: // administratorの場合
                request.getSession().setAttribute("toast", "You submitted \"" + idea.getTitle() + "\" to the manager.");
                break;
            case 2: // managerの場合
                request.getSession().setAttribute("toast", "You submitted \"" + idea.getTitle() + "\" to the director.");
                break;
            case 3: // directorの場合
                request.getSession().setAttribute("toast", "You submitted \"" + idea.getTitle() + "\" to the another director.");
                break;
        }

        response.sendRedirect(request.getContextPath() + "/drafts");
    }
}