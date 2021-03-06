<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:import url="/WEB-INF/views/layout/app.jsp">
    <c:param name="content">
        <div class="ui text container">
            <c:choose>
                <c:when test="${idea != null}">
                    <h2>Edit of an idea "<c:out value="${idea.title}"/>"</h2>
                    <div class="ui raised very padded container segment">
                        <form method="POST" action="<c:url value='/ideas/update' />" class="ui fluid form">
                            <c:import url="_form.jsp"/>
                        </form>
                    </div>
                    <button onclick="location.href='<c:url value='/ideas/show?id=${idea.id}'/>'" class="circular ui icon button">
                        <i class="fas fa-long-arrow-alt-left"></i>
                    </button>
                </c:when>
                <c:otherwise>
                    <h2>The data you were looking for wasn't found.</h2>
                    <button onclick="location.href='<c:url value='/ideas'/>'" class="circular ui icon button">
                        <i class="fas fa-long-arrow-alt-left"></i>
                    </button>
                </c:otherwise>
            </c:choose>
        </div>
    </c:param>
</c:import>