<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <title>Sale Receipt - Book Management System</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <meta content="" name="keywords">
    <meta content="" name="description">

    <!-- Favicon -->
    <link href="${pageContext.request.contextPath}/img/favicon.ico" rel="icon">

    <!-- Google Web Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Roboto:wght@500;700&display=swap" rel="stylesheet"> 
    
    <!-- Icon Font Stylesheet -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">

    <!-- Libraries Stylesheet -->
    <link href="${pageContext.request.contextPath}/lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/lib/tempusdominus/css/tempusdominus-bootstrap-4.min.css" rel="stylesheet" />

    <!-- Customized Bootstrap Stylesheet -->
    <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">

    <!-- Template Stylesheet -->
    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">

    <style>
        /* Receipt specific styles */
        .receipt-container {
            max-width: 600px;
            margin: 30px auto;
            background: var(--bs-secondary-bg);
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(0,0,0,0.1);
        }
        
        .receipt-header {
            text-align: center;
            margin-bottom: 30px;
        }
        
        .receipt-header h2 {
            color: var(--bs-primary);
            margin-bottom: 5px;
        }
        
        .receipt-header p {
            color: var(--bs-secondary-color);
            margin-top: 0;
        }
        
        .receipt-table {
            width: 100%;
            margin-bottom: 20px;
            color: var(--bs-body-color);
        }
        
        .receipt-table th {
            background-color: var(--bs-primary);
            color: white;
            padding: 10px;
            text-align: left;
        }
        
        .receipt-table td {
            padding: 10px;
            border-bottom: 1px solid var(--bs-border-color);
        }
        
        .receipt-summary {
            background-color: var(--bs-secondary-bg);
            padding: 15px;
            border-radius: 5px;
            margin-top: 20px;
        }
        
        .receipt-summary-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 8px;
        }
        
        .receipt-footer {
            text-align: center;
            margin-top: 30px;
            color: var(--bs-secondary-color);
        }
        
        /* Print styles */
        @media print {
            .no-print, .receipt-footer, .alert {
                display: none !important;
            }
            .receipt-container {
                box-shadow: none;
                padding: 0;
                margin: 0;
                background: white !important;
            }
            body {
                background-color: white !important;
            }
            .receipt-table {
                color: black !important;
            }
        }
    </style>
</head>

<body class="bg-secondary">
    <div class="container-fluid position-relative d-flex p-0">
        <!-- Spinner Start -->
        <div id="spinner" class="show bg-dark position-fixed translate-middle w-100 vh-100 top-50 start-50 d-flex align-items-center justify-content-center">
            <div class="spinner-border text-primary" style="width: 3rem; height: 3rem;" role="status">
                <span class="sr-only">Loading...</span>
            </div>
        </div>
        <!-- Spinner End -->

        <!-- Content Start -->
        <div class="content">
            <div class="container-fluid pt-4 px-4">
                <div class="row g-4">
                    <div class="col-12">
                        <div class="receipt-container">
                            <div class="receipt-header">
                                <h2>Pahana Edu</h2>
                                <p>123 Book Street, Colombo<br>Tel: 011-1234567</p>
                            </div>
                            
                            <div class="receipt-info mb-4">
                                <h4>Receipt #${sale.id}</h4>
                                <p><strong>Date:</strong> <fmt:formatDate value="${sale.saleDate}" pattern="yyyy-MM-dd HH:mm"/></p>
                                <p><strong>Customer:</strong> ${customer.name}</p>
                                <c:if test="${not empty customer.accountNumber}">
                                    <p><strong>Account #:</strong> ${customer.accountNumber}</p>
                                </c:if>
                            </div>
                            
                            <table class="receipt-table">
                                <thead>
                                    <tr>
                                        <th>Product</th>
                                        <th style="text-align: right;">Price</th>
                                        <th style="text-align: center;">Qty</th>
                                        <th style="text-align: right;">Subtotal</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="item" items="${items}">
                                        <tr>
                                            <td>${item.productName}</td>
                                            <td style="text-align: right;">Rs. <fmt:formatNumber value="${item.price}" pattern="#,##0.00"/></td>
                                            <td style="text-align: center;">${item.quantity}</td>
                                            <td style="text-align: right;">Rs. <fmt:formatNumber value="${item.subtotal}" pattern="#,##0.00"/></td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                            
                            <div class="receipt-summary">
                                <div class="receipt-summary-row">
                                    <span><strong>Subtotal:</strong></span>
                                    <span>Rs. <fmt:formatNumber value="${sale.totalAmount}" pattern="#,##0.00"/></span>
                                </div>
                                <div class="receipt-summary-row">
                                    <span><strong>Payment Method:</strong></span>
                                    <span>${sale.paymentMethod}</span>
                                </div>
                                <div class="receipt-summary-row">
                                    <span><strong>Amount Paid:</strong></span>
                                    <span>Rs. <fmt:formatNumber value="${sale.amountPaid}" pattern="#,##0.00"/></span>
                                </div>
                                <div class="receipt-summary-row" style="font-weight: bold;">
                                    <span><strong>Balance:</strong></span>
                                    <span>Rs. <fmt:formatNumber value="${sale.balance}" pattern="#,##0.00"/></span>
                                </div>
                            </div>
                            
                            <c:if test="${emailSent}">
                                <div class="alert alert-success mt-3 no-print">
                                    <i class="fas fa-check-circle"></i> Email receipt has been sent to ${customer.email}
                                </div>
                            </c:if>
                            <c:if test="${not empty customer.email and not emailSent}">
                                <div class="alert alert-warning mt-3 no-print">
                                    <i class="fas fa-exclamation-triangle"></i> Failed to send email receipt to ${customer.email}
                                </div>
                            </c:if>
                            
                            <div class="receipt-footer no-print">
                                <p>Thank you for your purchase!</p>
                                <div class="mt-3">
                                    <button onclick="window.print()" class="btn btn-primary me-2">
                                        <i class="fas fa-print"></i> Print Receipt
                                    </button>
                                    <a href="${pageContext.request.contextPath}/AdminCashier/pos" class="btn btn-secondary">
                                        <i class="fas fa-shopping-cart"></i> New Sale
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Footer Start -->
            <div class="container-fluid pt-4 px-4 no-print">
                <div class="bg-secondary rounded-top p-4">
                    <div class="row">
                        <div class="col-12 col-sm-6 text-center text-sm-start">
                            &copy; <a href="#">Pahana Edu</a>, All Rights Reserved. 
                        </div>
                        <div class="col-12 col-sm-6 text-center text-sm-end">
                            <span>Sales Receipt</span>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Footer End -->
        </div>
        <!-- Content End -->
    </div>

    <!-- JavaScript Libraries -->
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/lib/chart/chart.min.js"></script>
    <script src="${pageContext.request.contextPath}/lib/easing/easing.min.js"></script>
    <script src="${pageContext.request.contextPath}/lib/waypoints/waypoints.min.js"></script>
    <script src="${pageContext.request.contextPath}/lib/owlcarousel/owl.carousel.min.js"></script>
    <script src="${pageContext.request.contextPath}/lib/tempusdominus/js/moment.min.js"></script>
    <script src="${pageContext.request.contextPath}/lib/tempusdominus/js/moment-timezone.min.js"></script>
    <script src="${pageContext.request.contextPath}/lib/tempusdominus/js/tempusdominus-bootstrap-4.min.js"></script>

    <!-- Template Javascript -->
    <script src="${pageContext.request.contextPath}/js/main.js"></script>
    
    <script>
        $(document).ready(function() {
            // Back to top button
            $(window).scroll(function() {
                if ($(this).scrollTop() > 300) {
                    $('.back-to-top').fadeIn('slow');
                } else {
                    $('.back-to-top').fadeOut('slow');
                }
            });
        });
    </script>
</body>
</html>