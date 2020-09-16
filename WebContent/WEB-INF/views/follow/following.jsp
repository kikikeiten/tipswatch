<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:import url="/WEB-INF/views/layout/app.jsp">
    <c:param name="content">
        <h2>フォロー中</h2>
        <table id="following_list">
            <tbody>
                <tr>
                    <th class="report_name">氏名</th>
                    <th class="follow">フォロー</th>
                    <th class="report_date">日付</th>
                </tr>
                <c:forEach var="report" items="${reports}" varStatus="status">
                    <tr class="row${status.count % 2}">
                        <td class="report_name"><c:out
                                value="${report.employee.name}" /></td>

                        <c:choose>
                            <c:when test="${report.employee.id != follow.follower}">
                                <td class="follow">
                                    <form method="POST" action="<c:url value='/follow/create' />">
                                        <input type="hidden" name="report_id"
                                            value="${report.employee.id}">
                                        <button>フォロー</button>
                                    </form>
                                </td>
                            </c:when>
                            <c:otherwise>
                                <td class="follow">
                                    <form method="POST" action="<c:url value='/follow/destroy' />">
                                        <button>フォロー中</button>
                                    </form>
                                </td>
                            </c:otherwise>
                        </c:choose>

                        <td class="report_date"><fmt:formatDate
                                value='${report.report_date}' pattern='yyyy-MM-dd' /></td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>

        <div id="pagination">
            （全 ${reports_count} 件）<br />
            <c:forEach var="i" begin="1" end="${((reports_count - 1) / 10) + 1}"
                step="1">
                <c:choose>
                    <c:when test="${i == page}">
                        <c:out value="${i}" />&nbsp;
                    </c:when>
                    <c:otherwise>
                        <a href="<c:url value='/reports/index?page=${i}' />"><c:out
                                value="${i}" /></a>&nbsp;
                    </c:otherwise>
                </c:choose>
            </c:forEach>
        </div>
        <p>
            <a href="<c:url value='/index.html' />">トップページへ戻る</a>
        </p>

    </c:param>
</c:import>