package controllers.joins.all;

import java.io.IOException;
import java.util.List;

import javax.persistence.EntityManager;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import models.Join;
import models.Member;
import utils.DBUtil;

@WebServlet("/joins/all")
public class AllJoinsIndexServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public AllJoinsIndexServlet() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        EntityManager em = DBUtil.createEntityManager();

        // ログイン中のメンバーIDを取得
        Member loginMember = (Member) request.getSession().getAttribute("loginMember");

        // ページネーション
        int page;
        try {
            page = Integer.parseInt(request.getParameter("page"));
        } catch (Exception e) {
            page = 1;
        }

        // 全てのジョイン履歴を取得
        List<Join> getJoins = em.createNamedQuery("getJoins", Join.class)
                .setFirstResult(12 * (page - 1))
                .setMaxResults(12)
                .getResultList();

        // 上記のカウントを取得
        long getJoinsCnt = (long) em.createNamedQuery("getJoinsCnt", Long.class)
                .getSingleResult();

        // ログイン中メンバーの全ジョイン履歴数を取得
        long getMyJoinCnt = (long) em.createNamedQuery("getMyJoinCnt", Long.class)
                .setParameter("loginMember", loginMember)
                .getSingleResult();

        em.close();

        request.setAttribute("getJoins", getJoins);
        request.setAttribute("getJoinsCnt", getJoinsCnt);
        request.setAttribute("getMyJoinCnt", getMyJoinCnt);

        RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/views/joins/all/index.jsp");
        rd.forward(request, response);

    }

}