package controllers.follows.followers;

import java.io.IOException;

import javax.persistence.EntityManager;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import models.Follow;
import models.Member;
import utils.DBUtil;

@WebServlet("/followers/destroy")
public class FollowersDestroyServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public FollowersDestroyServlet() {
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        EntityManager em = DBUtil.createEntityManager();

        // ログイン中メンバーのIDを取得
        Member loginMember = (Member) request.getSession().getAttribute("loginMember");

        // フォロー解除されるメンバーのIDを取得
        Follow follower = em.find(Follow.class, Integer.parseInt(request.getParameter("followerId")));

        // フォローリストの中からフォロー解除されるメンバーのIDを取得
        Integer memberId = 0;
        memberId = em.createNamedQuery("getDestroyFollower", Integer.class)
                .setParameter("loginMember", loginMember)
                .setParameter("followerId", follower.getFollowingId())
                .getSingleResult();

        Follow follow = em.find(Follow.class, memberId);

        em.getTransaction().begin();
        em.remove(follow);
        em.getTransaction().commit();
        em.close();

        // トーストメッセージをセッションにセット
        request.getSession().setAttribute("toast", "You unfollowed " + follower.getFollowingId().getName() + ".");

        response.sendRedirect(request.getContextPath() + "/followers");
    }

}