<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <title>Sales Report - Pahana Edu</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    
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
    
    <!-- Chart.js -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    
    <!-- DataTables CSS -->
    <link rel="stylesheet" href="https://cdn.datatables.net/1.11.5/css/dataTables.bootstrap5.min.css">
    <link rel="stylesheet" href="https://cdn.datatables.net/buttons/2.2.2/css/buttons.bootstrap5.min.css">
    
    <!-- Custom CSS -->
    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
    
    <!-- In the head section, update the style tag -->
	<style>
	    .chart-container {
	        background-color: #2d3748; /* Dark background for the chart container */
	        border-radius: 5px;
	        padding: 10px;
	    }
	    
	    canvas#dailySalesChart {
	        background-color: #2d3748; /* Dark background for the canvas */
	    }
	    
	    /* Add these new styles for the card */
	    .sales-card {
	        background-color: #2d3748 !important;
	        border: 1px solid #4a5568 !important;
	    }
	    
	    .sales-card .card-header {
	        background-color: #4a5568 !important;
	        border-bottom: 1px solid #4a5568 !important;
	        color: #fff !important;
	    }
	    
	    .sales-card .card-title {
	        color: #fff !important;
	    }
	</style>
	
</head>

<body>
    <div class="container-fluid position-relative d-flex p-0">
        <!-- Sidebar Start -->
        <div class="sidebar pe-4 pb-3">
            <nav class="navbar bg-secondary navbar-dark">
                <a href="${pageContext.request.contextPath}/Admin/Admindashboard.jsp" class="navbar-brand mx-4 mb-3">
                    <h3 class="text-primary"><i class="fa fa-cash-register me-2"></i>Cashier Panel</h3>
                </a>
                <div class="d-flex align-items-center ms-4 mb-4">
                    <div class="position-relative">
                        <img class="rounded-circle" src="${pageContext.request.contextPath}/img/user.jpg" alt="" style="width: 40px; height: 40px;">
                        <div class="bg-success rounded-circle border border-2 border-white position-absolute end-0 bottom-0 p-1"></div>
                    </div>
                    <div class="ms-3">
                        <h6 class="mb-0">${sessionScope.user.name}</h6>
                        <span>Cashier</span>
                    </div>
                </div>
                <div class="navbar-nav w-100">
                    <a href="${pageContext.request.contextPath}/Admin/Admindashboard.jsp" class="nav-item nav-link "><i class="fa fa-tachometer-alt me-2"></i>Dashboard</a>
                    <a href="${pageContext.request.contextPath}/Admin/users" class="nav-item nav-link"><i class="fa fa-users me-2"></i>Employee Management</a>
                    <a href="${pageContext.request.contextPath}/Admin/customers" class="nav-item nav-link"><i class="fa fa-user-tie me-2"></i>Customer Management</a>
                    <a href="${pageContext.request.contextPath}/Admin/products" class="nav-item nav-link"><i class="fa fa-book me-2"></i>Book Management</a>
                    <a href="${pageContext.request.contextPath}/Admin/categories" class="nav-item nav-link"><i class="fa fa-tags me-2"></i>Category Management</a>
                    <a href="${pageContext.request.contextPath}/AdminCashier/pos" class="nav-item nav-link "><i class="fa fa-shopping-cart me-2"></i>Point of Sale</a>
				    <a href="${pageContext.request.contextPath}/AdminCashier/sales" class="nav-item nav-link active"><i class="fa fa-history me-2"></i>Sales History</a>
                    <a href="${pageContext.request.contextPath}/Admin/reports" class="nav-item nav-link"><i class="fa fa-chart-bar me-2"></i>Reports</a>
                    <a href="${pageContext.request.contextPath}/Admin/settings" class="nav-item nav-link"><i class="fa fa-cog me-2"></i>Settings</a>
                </div>
            </nav>
        </div>
        <!-- Sidebar End -->

        <!-- Content Start -->
        <div class="content">
            <!-- Navbar Start -->
            <nav class="navbar navbar-expand bg-secondary navbar-dark sticky-top px-4 py-0">
                <a href="#" class="sidebar-toggler flex-shrink-0">
                    <i class="fa fa-bars"></i>
                </a>
                <div class="navbar-nav align-items-center ms-auto">
                    <div class="nav-item dropdown">
                        <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">
                            <img class="rounded-circle me-lg-2" src="${pageContext.request.contextPath}/img/user.jpg" alt="" style="width: 40px; height: 40px;">
                            <span class="d-none d-lg-inline-flex">${sessionScope.user.name}</span>
                        </a>
                        <div class="dropdown-menu dropdown-menu-end bg-secondary border-0 rounded-0 rounded-bottom m-0">
                            <a href="${pageContext.request.contextPath}/profile" class="dropdown-item">My Profile</a>
                            <a href="${pageContext.request.contextPath}/logout" class="dropdown-item">Log Out</a>
                        </div>
                    </div>
                </div>
            </nav>
            <!-- Navbar End -->

            <!-- Main Content Start -->
            <div class="container-fluid pt-4 px-4">
                <div class="row g-4">
                    <div class="col-12">
                        <div class="bg-secondary rounded p-4">
                            <div class="d-flex justify-content-between align-items-center mb-4">
                                <h4 class="mb-0">Sales Report</h4>
                                <div>
                                    <form method="GET" action="${pageContext.request.contextPath}/AdminCashier/sales" class="row g-2">
                                        <div class="col-auto">
                                            <label for="startDate" class="visually-hidden">Start Date</label>
                                            <input type="date" id="startDate" name="startDate" 
                                                   value="<fmt:formatDate value='${startDate}' pattern='yyyy-MM-dd'/>" 
                                                   class="form-control">
                                        </div>
                                        <div class="col-auto">
                                            <label for="endDate" class="visually-hidden">End Date</label>
                                            <input type="date" id="endDate" name="endDate" 
                                                   value="<fmt:formatDate value='${endDate}' pattern='yyyy-MM-dd'/>" 
                                                   class="form-control">
                                        </div>
                                        <div class="col-auto">
                                            <button type="submit" class="btn btn-primary">
                                                <i class="fa fa-search me-2"></i>Filter
                                            </button>
                                        </div>
                                        <div class="col-auto">
                                            <button type="button" id="exportBtn" class="btn btn-success">
                                                <i class="fa fa-file-excel me-2"></i>Export
                                            </button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                            
                            <!-- Daily Sales Summary Chart -->
                            <div class="row mb-4">
                                <div class="col-12">
                                    <div class="card sales-card">
                                        <div class="card-header">
                                            <h5 class="card-title">Daily Sales Summary</h5>
                                        </div>
                                        <div class="card-body">
                                            <div class="chart-container" style="height: 300px;">
                                                <canvas id="dailySalesChart"></canvas>
                                            </div>
                                            <c:if test="${empty dailySales}">
                                                <div class="alert alert-info mt-3">No sales data available for the selected date range.</div>
                                            </c:if>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            <!-- Sales Details Table -->
                            <div class="table-responsive">
                                <table class="table table-hover" id="salesTable">
                                    <thead>
                                        <tr>
                                            <th>Sale ID</th>
                                            <th>Date</th>
                                            <th>Customer</th>
                                            <th>Items</th>
                                            <th>Total Amount</th>
                                            <th>Payment Method</th>
                                            <th>Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="sale" items="${sales}">
                                            <tr>
                                                <td>${sale.id}</td>
                                                <td><fmt:formatDate value="${sale.saleDate}" pattern="yyyy-MM-dd HH:mm"/></td>
                                                <td>${sale.customerName}</td>
                                                <td>${sale.items.size()} items</td>
                                                <td>Rs. <fmt:formatNumber value="${sale.totalAmount}" pattern="#,##0.00"/></td>
                                                <td>${sale.paymentMethod}</td>
                                                <td>
                                                    <a href="${pageContext.request.contextPath}/AdminCashier/view-sale?id=${sale.id}" 
                                                       class="btn btn-sm btn-primary">
                                                        <i class="fa fa-eye"></i> View
                                                    </a>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Main Content End -->
        </div>
        <!-- Content End -->
    </div>

    <!-- JavaScript Libraries -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    
    <!-- DataTables JS -->
    <script src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.datatables.net/1.11.5/js/dataTables.bootstrap5.min.js"></script>
    <script src="https://cdn.datatables.net/buttons/2.2.2/js/dataTables.buttons.min.js"></script>
    <script src="https://cdn.datatables.net/buttons/2.2.2/js/buttons.bootstrap5.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js"></script>
    <script src="https://cdn.datatables.net/buttons/2.2.2/js/buttons.html5.min.js"></script>
    
    <script>
        $(document).ready(function() {
            // Initialize DataTable with export buttons
            $('#salesTable').DataTable({
                dom: 'Bfrtip',
                buttons: [
                    'excel'
                ],
                order: [[1, 'desc']],
                language: {
                    search: "_INPUT_",
                    searchPlaceholder: "Search sales..."
                }
            });
            
            // Export button functionality
            $('#exportBtn').click(function() {
                let startDate = $('#startDate').val();
                let endDate = $('#endDate').val();
                window.location.href = '${pageContext.request.contextPath}/AdminCashier/export-sales?startDate=' + 
                                      startDate + '&endDate=' + endDate;
            });
            
            // Initialize chart if we have data
            <c:if test="${not empty dailySales}">
            var ctx = document.getElementById('dailySalesChart').getContext('2d');
            var dailySalesChart = new Chart(ctx, {
                type: 'bar',
                data: {
                    labels: [
                        <c:forEach items="${dailySales}" var="entry">
                            "${entry.key}",
                        </c:forEach>
                    ],
                    datasets: [{
                        label: 'Daily Sales (Rs.)',
                        data: [
                            <c:forEach items="${dailySales}" var="entry">
                                ${entry.value},
                            </c:forEach>
                        ],
                        backgroundColor: '#EB1616', // Teal color
                        borderColor: '#EB1616',
                        borderWidth: 1
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    backgroundColor: '#2d3748', // Dark background for the chart area
                    scales: {
                        y: {
                            beginAtZero: true,
                            grid: {
                                color: 'rgba(255, 255, 255, 0.1)'
                            },
                            ticks: {
                                color: '#fff',
                                callback: function(value) {
                                    return 'Rs. ' + value.toLocaleString();
                                }
                            }
                        },
                        x: {
                            grid: {
                                color: 'rgba(255, 255, 255, 0.1)'
                            },
                            ticks: {
                                color: '#fff'
                            }
                        }
                    },
                    plugins: {
                        legend: {
                            labels: {
                                color: '#fff'
                            }
                        },
                        tooltip: {
                            backgroundColor: 'rgba(0, 0, 0, 0.8)',
                            titleColor: '#fff',
                            bodyColor: '#fff',
                            callbacks: {
                                label: function(context) {
                                    return 'Rs. ' + context.raw.toLocaleString();
                                }
                            }
                        }
                    }
                }
            });
            </c:if>
        });
    </script>
</body>
</html>