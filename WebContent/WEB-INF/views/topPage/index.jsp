<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:import url="../layout/app.jsp">
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
        <div class="ui info message">
            <i class="close icon"></i>
            <div style="display: inline-flex">
                <c:if test="${attendance_flag == 0}">
                    <form method="POST" action="<c:url value='/punchin/create' />">
                        <button type="submit" class="ui positive button">Work!</button>
                    </form>
                &nbsp;
                </c:if>
                <c:if test="${attendance_flag == 1}">
                    <form method="POST" action="<c:url value='/punchout/create' />">
                        <button type="submit" class="ui negative button">Finish!</button>
                    </form>
                </c:if>
                <c:if test="${attendance_flag == 2}">
                    <form method="POST" action="<c:url value='/punchin/create' />">
                        <button type="submit" class="ui positive button">Work!</button>
                    </form>
                &nbsp;
                </c:if>
                <c:if test="${attendance_flag == 3}">
                    <form method="POST" action="<c:url value='/punchin/create' />">
                        <button type="submit" class="ui positive button">Work!</button>
                    </form>
                &nbsp;
                </c:if>
                <c:if test="${attendance_flag == null}">
                    <form method="POST" action="<c:url value='/punchin/create' />">
                        <button type="submit" class="ui positive button">Work!</button>
                    </form>
                &nbsp;
            </c:if>
            </div>
            &nbsp; <span id="RealtimeClockArea2" class="ui label"></span>
            <script>
    function set2fig(num) {
           var ret;
           if( num < 10 ) { ret = "0" + num; }
           else { ret = num; }
           return ret;
        }
        function showClock2() {
           var nowTime = new Date();
           var nowHour = set2fig( nowTime.getHours() );
           var nowMin  = set2fig( nowTime.getMinutes() );
           var nowSec  = set2fig( nowTime.getSeconds() );
           var msg = "現在時刻は" + nowHour + ":" + nowMin + ":" + nowSec + " です。";
           document.getElementById("RealtimeClockArea2").innerHTML = msg;
        }
        setInterval('showClock2()',1000);
    </script>
            &nbsp;
            <div class="ui right floated buttons">
                <button class="ui button"
                    onclick="location.href='<c:url value='/attendance/my' />'">My打刻履歴</button>
                <c:if
                    test="${sessionScope.login_employee.admin_flag == 2 || sessionScope.login_employee.admin_flag == 3}">
                    <button class="ui button"
                        onclick="location.href='<c:url value='/attendance/all' />'">全打刻履歴</button>
                </c:if>
            </div>
        </div>
        <h2>TipSwatchへようこそ</h2>

        <div class="ui raised very padded container segment">

        <c:choose>
            <c:when test="${reports_count == 0}">
                <h3>
                    <c:out value="${sessionScope.login_employee.name}" />
                    さんのメモはまだありません。
                </h3>
                <p>作成されるとここに表示されます。</p>
            </c:when>
            <c:otherwise>
                <c:if
                    test="${getYesterdayDraftsCount != 0 && getYesterdayManagerApprovalsCount != 0}">
                    <div class="ui error message">
                        <i class="close icon"></i>
                        <script>
                    $('.message .close').on('click', function() {
                        $(this).closest('.message').transition('fade');
                    });
                        </script>
                        <a href="<c:url value='/drafts' />">下書きのメモが<c:out
                                value="${getYesterdayDraftsCount}" />件あります。
                        </a><br> <a href="<c:url value='/approval/manager' />">課長承認待ちの日報が<c:out
                                value="${getYesterdayManagerApprovalsCount}" />件あります。
                        </a>
                    </div>
                </c:if>
                <c:if
                    test="${getYesterdayDraftsCount != 0 && getYesterdayDirectorApprovalsCount != 0}">
                    <div class="ui error message">
                        <i class="close icon"></i>
                        <script>
                    $('.message .close').on('click', function() {
                        $(this).closest('.message').transition('fade');
                    });
                </script>
                        <a href="<c:url value='/drafts' />">下書きのメモが<c:out
                                value="${getYesterdayDraftsCount}" />件あります。
                        </a><br> <a href="<c:url value='/approval/director' />">部長承認待ちの日報が<c:out
                                value="${getYesterdayDirectorApprovalsCount}" />件あります。
                        </a>
                    </div>
                </c:if>
                <c:if
                    test="${getYesterdayDraftsCount != 0 && getYesterdayManagerApprovalsCount == 0 && getYesterdayDirectorApprovalsCount == 0}">
                    <div class="ui error message">
                        <i class="close icon"></i>
                        <script>
                    $('.message .close').on('click', function() {
                        $(this).closest('.message').transition('fade');
                    });
                </script>
                        <a href="<c:url value='/drafts' />">下書きのメモが<c:out
                                value="${getYesterdayDraftsCount}" />件あります。
                        </a>
                    </div>
                </c:if>
                <c:if
                    test="${getYesterdayManagerApprovalsCount != 0 && getYesterdayDraftsCount == 0}">
                    <div class="ui error message">
                        <i class="close icon"></i>
                        <script>
                    $('.message .close').on('click', function() {
                        $(this).closest('.message').transition('fade');
                    });
                </script>
                        <a href="<c:url value='/approval/manager' />">課長承認待ちの日報が<c:out
                                value="${getYesterdayManagerApprovalsCount}" />件あります。
                        </a>
                    </div>
                </c:if>
                <c:if
                    test="${getYesterdayDirectorApprovalsCount != 0 && getYesterdayDraftsCount == 0}">
                    <div class="ui error message">
                        <i class="close icon"></i>
                        <script>
                    $('.message .close').on('click', function() {
                        $(this).closest('.message').transition('fade');
                    });
                </script>
                        <a href="<c:url value='/approval/director' />">部長承認待ちの日報が<c:out
                                value="${getYesterdayDirectorApprovalsCount}" />件あります。
                        </a>
                    </div>
                </c:if>
                <h3>My Swatches</h3>

                <div class="ui three stackable raised link cards">
                        <c:forEach var="report" items="${reports}" varStatus="status">
                            <c:choose>

                                <c:when test="${report.approval == 1}">
                                    <div class="ui olive card">
                                        <a class="content" href="<c:url value='/reports/show?id=${report.id}' />"> <span class="right floated"><fmt:formatDate value='${report.report_date}' pattern='MM / dd' /></span> <span class="header"><c:out value="${report.title}" /></span> <span class="description"> </span>
                                        </a>
                                        <div class="extra content">
                                            <a class="left floated like" href="<c:url value='/likes?report_id=${report.id}' />"> <i class="far fa-heart"></i> <c:out value="${report.likes}" />
                                            </a> <a class="right floated date" href="<c:url value='/employees/show?id=${report.employee.id}' />"> <c:out value="${report.employee.name}" />
                                            </a>
                                        </div>
                                    </div>
                                </c:when>

                                <c:when test="${report.approval == 2}">
                                    <div class="ui green card">
                                        <a class="content" href="<c:url value='/reports/show?id=${report.id}' />"> <span class="right floated"><fmt:formatDate value='${report.report_date}' pattern='MM / dd' /></span> <span class="header"><c:out value="${report.title}" /></span> <span class="description"> </span>
                                        </a>
                                        <div class="extra content">
                                            <a class="left floated like" href="<c:url value='/likes?report_id=${report.id}' />"> <i class="far fa-heart"></i> <c:out value="${report.likes}" />
                                            </a> <a class="right floated date" href="<c:url value='/employees/show?id=${report.employee.id}' />"> <c:out value="${report.employee.name}" />
                                            </a>
                                        </div>
                                    </div>
                                </c:when>

                                <c:when test="${report.approval == 3}">
                                    <div class="ui teal card">
                                        <a class="content" href="<c:url value='/reports/show?id=${report.id}' />"> <span class="right floated"><fmt:formatDate value='${report.report_date}' pattern='MM / dd' /></span> <span class="header"><c:out value="${report.title}" /></span> <span class="description"> </span>
                                        </a>
                                        <div class="extra content">
                                            <a class="left floated like" href="<c:url value='/likes?report_id=${report.id}' />"> <i class="far fa-heart"></i> <c:out value="${report.likes}" />
                                            </a> <a class="right floated date" href="<c:url value='/employees/show?id=${report.employee.id}' />"> <c:out value="${report.employee.name}" />
                                            </a>
                                        </div>
                                    </div>
                                </c:when>

                                <c:when test="${report.approval == 4}">
                                    <div class="ui blue card">
                                        <a class="content" href="<c:url value='/reports/show?id=${report.id}' />"> <span class="right floated"><fmt:formatDate value='${report.report_date}' pattern='MM / dd' /></span> <span class="header"><c:out value="${report.title}" /></span> <span class="description"> </span>
                                        </a>
                                        <div class="extra content">
                                            <a class="left floated like" href="<c:url value='/likes?report_id=${report.id}' />"> <i class="far fa-heart"></i> <c:out value="${report.likes}" />
                                            </a> <a class="right floated date" href="<c:url value='/employees/show?id=${report.employee.id}' />"> <c:out value="${report.employee.name}" />
                                            </a>
                                        </div>
                                    </div>
                                </c:when>

                                <c:when test="${report.approval == 6}">
                                    <div class="ui violet card">
                                        <a class="content" href="<c:url value='/reports/show?id=${report.id}' />"> <span class="right floated"><fmt:formatDate value='${report.report_date}' pattern='MM / dd' /></span> <span class="header"><c:out value="${report.title}" /></span> <span class="description"> </span>
                                        </a>
                                        <div class="extra content">
                                            <a class="left floated like" href="<c:url value='/likes?report_id=${report.id}' />"> <i class="far fa-heart"></i> <c:out value="${report.likes}" />
                                            </a> <a class="right floated date" href="<c:url value='/employees/show?id=${report.employee.id}' />"> <c:out value="${report.employee.name}" />
                                            </a>
                                        </div>
                                    </div>
                                </c:when>

                            </c:choose>
                        </c:forEach>
                    </div>

                <table id="tp_report_list" class="ui celled striped table">
                    <tbody>
                        <tr>
                            <th class="tp_report_date">Day</th>
                            <th class="tp_report_title">Title</th>
                            <th class="tp_report_action">Action</th>
                            <th class="tp_report_likes">Likes</th>
                            <th class="tp_report_approval">Flow</th>
                        </tr>
                        <c:forEach var="report" items="${reports}" varStatus="status">
                            <tr class="row${status.count % 2}">
                                <td class="tp_report_date"><fmt:formatDate
                                        value='${report.report_date}' pattern='yyyy / MM / dd' /></td>
                                <td class="tp_report_title">${report.title}</td>
                                <td class="tp_report_action"><a
                                    href="<c:url value='/reports/show?id=${report.id}' />">詳細を見る</a></td>
                                <c:choose>
                                    <c:when test="${report.likes == 0}">
                                        <td class="tp_report_likes"><c:out
                                                value="${report.likes}" /></td>
                                    </c:when>
                                    <c:otherwise>
                                        <td class="tp_report_likes"><a
                                            href="<c:url value='/likes?report_id=${report.id}' />"><c:out
                                                    value="${report.likes}" /></a></td>
                                    </c:otherwise>
                                </c:choose>
                                <td class="tp_report_approval"><c:if
                                        test="${sessionScope.login_employee.admin_flag == 0 || sessionScope.login_employee.admin_flag == 1}">
                                        <c:choose>
                                            <c:when test="${report.approval == 0}">
                                                <a href="<c:url value='/drafts' />">下書き</a>
                                            </c:when>
                                            <c:when test="${report.approval == 1}">
                                                <a href="<c:url value='/remand/manager' />">課長差し戻し</a>
                                            </c:when>
                                            <c:when test="${report.approval == 2}">
                                        課長承認待ち
                                    </c:when>
                                            <c:when test="${report.approval == 3}">
                                                <a href="<c:url value='/remand/director' />">部長差し戻し</a>
                                            </c:when>
                                            <c:when test="${report.approval == 4}">
                                        部長承認待ち
                                    </c:when>
                                            <c:otherwise>
                                        承認済み
                                    </c:otherwise>
                                        </c:choose>
                                    </c:if> <c:if test="${sessionScope.login_employee.admin_flag == 2}">
                                        <c:choose>
                                            <c:when test="${report.approval == 0}">
                                                <a href="<c:url value='/drafts' />">下書き</a>
                                            </c:when>
                                            <c:when test="${report.approval == 1}">
                                        課長差し戻し
                                    </c:when>
                                            <c:when test="${report.approval == 2 }">
                                        課長承認待ち
                                    </c:when>
                                            <c:when test="${report.approval == 3}">
                                                <a href="<c:url value='/remand/director' />">部長差し戻し</a>
                                            </c:when>
                                            <c:when test="${report.approval == 4}">
                                        部長承認待ち
                                    </c:when>
                                            <c:otherwise>
                                        承認済み
                                    </c:otherwise>
                                        </c:choose>
                                    </c:if> <c:if test="${sessionScope.login_employee.admin_flag == 3}">
                                        <c:choose>
                                            <c:when test="${report.approval == 0}">
                                                <a href="<c:url value='/drafts' />">下書き</a>
                                            </c:when>
                                            <c:when test="${report.approval == 1}">
                                        課長差し戻し
                                    </c:when>
                                            <c:when test="${report.approval == 2}">
                                        課長承認待ち
                                    </c:when>
                                            <c:when test="${report.approval == 3}">
                                        部長差し戻し
                                    </c:when>
                                            <c:when test="${report.approval == 4}">
                                        部長承認待ち
                                    </c:when>
                                            <c:otherwise>
                                        承認済み
                                    </c:otherwise>
                                        </c:choose>
                                    </c:if></td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
                <div class="ui teal image label">My swatches<div class="detail">${reports_count}</div></div>&nbsp;
        <div class="ui mini pagination menu">
                    <c:forEach var="i" begin="1"
                        end="${((reports_count - 1) / 10) + 1}" step="1">
                        <c:choose>
                            <c:when test="${i == page}">
                                <div class="item active">
                                    <c:out value="${i}" />
                                </div>
                            </c:when>
                            <c:otherwise>
                                <a class="item" href="<c:url value='/?page=${i}' />"><c:out
                                        value="${i}" /></a>&nbsp;
                    </c:otherwise>
                        </c:choose>
                    </c:forEach>
                </div>
            </c:otherwise>
        </c:choose>

        </div>

        <br>
        <br>
        <p>
            <a href="<c:url value='/drafts' />">下書きの日報一覧（${getMyDraftsCount}）</a>
        </p>
        <c:if
            test="${sessionScope.login_employee.admin_flag == 0 || sessionScope.login_employee.admin_flag == 1}">
            <p>
                <a href="<c:url value='/remand/manager' />">課長差し戻しの日報一覧（${getManagerRemandReportsCount}）</a>
            </p>
        </c:if>
        <c:if test="${sessionScope.login_employee.admin_flag == 2}">
            <p>
                <a href="<c:url value='/approval/manager' />">課長承認待ちの日報一覧（${getManagerApprovalReportsCount}）</a>
            </p>
        </c:if>
        <c:if
            test="${sessionScope.login_employee.admin_flag == 0 || sessionScope.login_employee.admin_flag == 1 || sessionScope.login_employee.admin_flag == 2}">
            <p>
                <a href="<c:url value='/remand/director' />">部長差し戻しの日報一覧（${getDirectorRemandReportsCount}）</a>
            </p>
        </c:if>
        <c:if test="${sessionScope.login_employee.admin_flag == 3}">
            <p>
                <a href="<c:url value='/approval/director' />">部長承認待ちの日報一覧（${getDirectorApprovalReportsCount}）</a>
            </p>
        </c:if>
    </c:param>
</c:import>