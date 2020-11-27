<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <title>TipSwatch</title>
    <link rel="stylesheet" href="<c:url value='/css/style.css' />">
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.3.1/dist/jquery.min.js"></script>
    <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/fomantic-ui@2.8.7/dist/semantic.min.css">
    <script src="https://cdn.jsdelivr.net/npm/fomantic-ui@2.8.7/dist/semantic.min.js"></script>
    <link href="https://use.fontawesome.com/releases/v5.15.1/css/all.css" rel="stylesheet">
</head>
<body>
<div id="wrapper">
    <c:if test="${latestJoin == 1}">
        <div class="ui top right attached green label">Working</div>
    </c:if>
    <div class="ui hidden divider"></div>
    <div class="ui borderless container menu">
        <a href="<c:url value='/'/>" class="item">
            <b>TipSwatch</b>
        </a>
        <c:if test="${sessionScope.loginMember != null}">
            <div class="item right">
                <button class="circular ui icon button custom">
                    <i class="far fa-smile"></i>
                </button>
                <div class="ui fluid custom popup bottom left transition hidden">
                    <div class="ui header">
                        <c:out value="${sessionScope.loginMember.name}"/>
                    </div>
                    <p class="ui right">
                        @<c:out value="${sessionScope.loginMember.code}"/>
                    </p>
                    <c:if test="${sessionScope.loginMember.role == 0}">
                        <div class="ui large label">Associate</div>
                    </c:if>
                    <c:if test="${sessionScope.loginMember.role == 1}">
                        <div class="ui large label">Administrator</div>
                    </c:if>
                    <c:if test="${sessionScope.loginMember.role == 2}">
                        <div class="ui large label">Manager</div>
                    </c:if>
                    <c:if test="${sessionScope.loginMember.role == 3}">
                        <div class="ui large label">Director</div>
                    </c:if>
                    <div class="ui link list">
                        <c:if test="${sessionScope.loginMember.role == 1 || sessionScope.loginMember.role == 2 || sessionScope.loginMember.role == 3}">
                            <a href="<c:url value='/members' />" class="item">All members</a>
                        </c:if>
                        <a href="<c:url value='/ideas' />" class="item">All swatches</a>
                        <a href="<c:url value='/timeline' />" class="item">Timeline</a>
                        <a href="<c:url value='/following' />" class="item">
                            <b><c:out value="${getMyFollowingCnt}"/></b>Following
                        </a>
                        <a href="<c:url value='/followers' />" class="item">
                            <b><c:out value="${getMyFollowerCnt}"/></b>Follower
                        </a>
                        <c:if test="${sessionScope.loginMember.role == 2}">
                            <a href="<c:url value='/reviews/manager'/>" class="item">Waiting
                                <b><c:out value="${getManagerReviewsCnt}"/>件</b>
                            </a>
                        </c:if>
                        <c:if test="${sessionScope.loginMember.role == 3}">
                            <a href="<c:url value='/reviews/director' />" class="item">Waiting
                                <b><c:out value="${getDirectorReviewsCnt}"/>件</b>
                            </a>
                        </c:if>
                        <a class="item" href="<c:url value='/logout'/>">
                            Logout
                        </a>
                    </div>
                </div>
                <script>
                    $('.custom.button')
                        .popup({
                            popup: $('.custom.popup'),
                            on: 'click'
                        });
                </script>
                <button onclick="location.href='<c:url value='/ideas/new'/>'" class="ui positive button">
                    <i class="fas fa-feather-alt"></i>
                </button>
            </div>
        </c:if>
    </div>
</div>
<div class="ui hidden divider"></div>
<div id="content">
    <div class="ui container">${param.content}</div>
</div>
<div class="ui hidden divider"></div>
<div id="footer"><c:import url="/WEB-INF/views/layout/footer.jsp"/></div>
</body>
</html>