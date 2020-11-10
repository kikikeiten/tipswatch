<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:import url="/WEB-INF/views/layout/app.jsp">
    <c:param name="content">
        <c:if test="${flush != null}">
            <script>
            $('body')
            .toast({
              class: 'success',
              message: "${flush}",
              showProgress: 'top',
              progressUp: true,
              className: {
                  toast: 'ui message'
              }
            })
          ;
            </script>
        </c:if>
        <h2>Director remand</h2>

        <div class="ui raised very padded container segment">

            <c:choose>
                <c:when test="${getDirectorRemandReportsCount == 0}">
                    <h3>部長差し戻しの日報はありません。</h3>
                    <p>提出した日報が部長に差し戻されるとここに表示されます。</p>
                </c:when>
                <c:otherwise>

                    <div class="ui three stackable raised link cards">
                        <c:forEach var="report" items="${getAllDirectorRemandReports}" varStatus="status">

                            <div class="ui green card">
                                <a class="content" href="<c:url value='/reports/show?id=${report.id}' />"> <span class="right floated"><fmt:formatDate value='${report.report_date}' pattern='MM / dd' /></span> <span class="header"><c:out value="${report.title}" /></span> <span class="description"> </span>
                                </a>

                                <div class="extra content">

                                    <form method="POST" action="<c:url value='/director/remand/create' />" class="left floated">
                                        <input type="hidden" name="report_id" value="${report.id}" />
                                        <button type="submit" name="submit" value="${4}" class="circular ui mini icon button">
                                            <i class="fas fa-paper-plane"></i>
                                        </button>
                                    </form>

                                    <a class="right floated date" href="<c:url value='/employees/show?id=${report.employee.id}' />"> <c:out value="${report.employee.name}" />
                                    </a>

                                </div>
                            </div>

                        </c:forEach>
                    </div>

                    <table id="dr_report_list" class="ui celled striped table">
                        <tbody>
                            <tr>
                                <th class="dr_report_name">氏名</th>
                                <th class="dr_report_date">日付</th>
                                <th class="dr_report_title">タイトル</th>
                                <th class="dr_report_action">操作</th>
                                <th class="dr_report_like">いいね数</th>
                                <th class="dr_report_approval">承認</th>
                            </tr>
                            <c:forEach var="report" items="${getAllDirectorRemandReports}" varStatus="status">
                                <tr class="row${status.count % 2}">
                                    <td class="dr_report_name"><c:out value="${report.employee.name}" /></td>
                                    <td class="dr_report_date"><fmt:formatDate value='${report.report_date}' pattern='yyyy-MM-dd' /></td>
                                    <td class="dr_report_title">${report.title}</td>
                                    <td class="dr_report_action"><a href="<c:url value='/reports/show?id=${report.id}' />">詳細を見る</a></td>
                                    <c:choose>
                                        <c:when test="${report.likes == 0}">
                                            <td class="dr_report_likes"><c:out value="${report.likes}" /></td>
                                        </c:when>
                                        <c:otherwise>
                                            <td class="dr_report_likes"><a href="<c:url value='/likes?report_id=${report.id}' />"><c:out value="${report.likes}" /></a></td>
                                        </c:otherwise>
                                    </c:choose>
                                    <td class="dr_report_approval">
                                        <form method="POST" action="<c:url value='/director/remand/create' />">
                                            <input type="hidden" name="report_id" value="${report.id}" />
                                            <button type="submit" name="submit" value="${4}" class="ui positive button">再提出</button>
                                        </form>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                    <div class="ui label">差し戻し件数 ${getDirectorRemandReportsCount}</div>&nbsp;
                <div class="ui mini pagination menu">
                        <c:forEach var="i" begin="1" end="${((getDirectorRemandReportsCount - 1) / 10) + 1}" step="1">
                            <c:choose>
                                <c:when test="${i == page}">
                                    <div class="item active">
                                        <c:out value="${i}" />
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <a class="item" href="<c:url value='/remand/director?page=${i}' />"><c:out value="${i}" /></a>&nbsp;
                            </c:otherwise>
                            </c:choose>
                        </c:forEach>
                    </div>
                </c:otherwise>
            </c:choose>

        </div>

        <br>
        <br>
        <button onclick="location.href='<c:url value='/reports/new' />'" class="ui positive button">新規日報</button>
        <br>
        <br>
        <p>
            <a href="<c:url value='/drafts' />">下書きの日報一覧（${getMyDraftsCount}）</a>
        </p>
        <c:if test="${sessionScope.login_employee.admin_flag == 0 || sessionScope.login_employee.admin_flag == 1}">
            <p>
                <a href="<c:url value='/remand/manager' />">課長差し戻しの日報一覧（${getManagerRemandReportsCount}）</a>
            </p>
        </c:if>
        <c:if test="${sessionScope.login_employee.admin_flag == 2}">
            <p>
                <a href="<c:url value='/approval/manager' />">課長承認待ちの日報一覧（${getManagerApprovalReportsCount}）</a>
            </p>
        </c:if>
    </c:param>
</c:import>