<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
        <h2>Manager remand</h2>
        <c:choose>
            <c:when test="${getManagerRemandReportsCount == 0}">
                <h3>課長差し戻しの日報はありません。</h3>
                <p>提出した日報が課長に差し戻されるとここに表示されます。</p>
            </c:when>
            <c:otherwise>

            <div class="ui three stackable raised link cards">
                        <c:forEach var="report" items="${getAllManagerRemandReports}" varStatus="status">

                            <div class="ui teal card">
                                <a class="content" href="<c:url value='/reports/show?id=${report.id}' />"> <span class="right floated"><fmt:formatDate value='${report.report_date}' pattern='MM / dd' /></span> <span class="header"><c:out value="${report.title}" /></span> <span class="description"> </span>
                                </a>

                                <div class="extra content">

                                    <form method="POST" action="<c:url value='/manager/remand/create' />" class="left floated">
                                        <input type="hidden" name="report_id" value="${report.id}" />
                                        <button type="submit" name="submit" value="${2}" class="circular ui mini icon button">
                                            <i class="fas fa-paper-plane"></i>
                                        </button>
                                    </form>

                                    <a class="right floated date" href="<c:url value='/employees/show?id=${report.employee.id}' />"> <c:out value="${report.employee.name}" />
                                    </a>

                                </div>
                            </div>

                        </c:forEach>
                    </div>


                <div class="ui label">差し戻し件数 ${getManagerRemandReportsCount}</div>&nbsp;
                <div class="ui mini pagination menu">
                    <c:forEach var="i" begin="1"
                        end="${((getManagerRemandReportsCount - 1) / 10) + 1}" step="1">
                        <c:choose>
                            <c:when test="${i == page}">
                                <div class="item active">
                                    <c:out value="${i}" />
                                </div>
                            </c:when>
                            <c:otherwise>
                                <a class="item"
                                    href="<c:url value='/remand/manager?page=${i}' />"><c:out
                                        value="${i}" /></a>&nbsp;
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                </div>
            </c:otherwise>
        </c:choose>
        <br>
        <br>
        <button onclick="location.href='<c:url value='/reports/new' />'"
            class="ui positive button">新規日報</button>
        <br>
        <br>
        <p>
            <a href="<c:url value='/drafts' />">下書きの日報一覧（${getMyDraftsCount}）</a>
        </p>
        <p>
            <a href="<c:url value='/remand/director' />">部長差し戻しの日報一覧（${getDirectorRemandReportsCount}）</a>
        </p>
    </c:param>
</c:import>