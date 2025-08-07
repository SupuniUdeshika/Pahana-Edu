<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="customer-results-container">
    <c:forEach var="customer" items="${customers}">
        <div class="customer-result-item" 
             onclick="selectCustomer(
                 ${customer.id}, 
                 '${customer.name.replace("'", "\\'")}', 
                 '${customer.email.replace("'", "\\'")}', 
                 '${customer.telephone.replace("'", "\\'")}', 
                 '${customer.accountNumber.replace("'", "\\'")}'
             )">
            <div class="customer-info">
                <div class="customer-name-account">
                    <span class="customer-name">${customer.name}</span>
                    <span class="customer-account">${customer.accountNumber}</span>
                </div>
                <div class="customer-contact">
                    <span class="customer-email">${customer.email}</span>
                    <c:if test="${not empty customer.telephone}">
                        <span class="customer-phone">${customer.telephone}</span>
                    </c:if>
                </div>
            </div>
        </div>
    </c:forEach>
    
    <c:if test="${empty customers}">
        <div class="no-results-message">
            No customers found matching your search
        </div>
    </c:if>
</div>