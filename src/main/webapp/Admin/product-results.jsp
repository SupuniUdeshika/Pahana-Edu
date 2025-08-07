<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:forEach var="product" items="${products}">
    <div class="col-md-3 mb-3">
        <div class="card product-card bg-dark text-white" 
             onclick="addToCart(${product.id}, '${product.name}', ${product.price}, ${product.quantity})">
            <div class="card-body text-center">
                <c:if test="${not empty product.imageBase64}">
                    <img src="data:image/jpeg;base64,${product.imageBase64}" 
                         class="img-fluid mb-2" style="max-height: 100px;">
                </c:if>
                <h6 class="card-title">${product.name}</h6>
                <p class="card-text">Rs. <fmt:formatNumber value="${product.price}" pattern="#,##0.00"/></p>
                <small class="text-muted">Stock: ${product.quantity}</small>
            </div>
        </div>
    </div>
</c:forEach>