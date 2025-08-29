<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <title>Admin Dashboard - Book Management System</title>
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

    <!-- Chart.js -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    
    <!-- SweetAlert2 CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">
    
    <style>
        .product-card {
            cursor: pointer;
            transition: transform 0.2s;
        }
        .product-card:hover {
            transform: scale(1.02);
        }
        .cart-item {
            border-bottom: 1px solid #eee;
            padding: 10px 0;
        }
        #customerSearchResults {
            position: absolute;
            z-index: 1000;
            width: 100%;
            max-height: 200px;
            overflow-y: auto;
            background: white;
            border: 1px solid #ddd;
            display: none;
        }
        .customer-result {
            padding: 8px;
            cursor: pointer;
        }
        .customer-result:hover {
            background-color: #f5f5f5;
        }
        
        /* New styles for dashboard */
       .stat-card {
        transition: all 0.3s;
        border-radius: 10px;
        border: none;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        background-color: #2d3748; /* Dark blue-gray background */
        color: #fff; /* White text */
    }
    
    .stat-card:hover {
        transform: translateY(-5px);
        box-shadow: 0 10px 15px rgba(0, 0, 0, 0.2);
        background-color: #3c4657; /* Slightly lighter on hover */
    }
    
    .stat-card .card-body {
        padding: 1.5rem;
    }
    
    .stat-card .card-title {
        font-size: 1rem;
        color: #a0aec0; /* Light gray for titles */
        margin-bottom: 0.5rem;
        text-transform: uppercase;
        letter-spacing: 0.5px;
    }
    
    .stat-card .card-value {
        font-size: 1.75rem;
        font-weight: 600;
        margin-bottom: 0.5rem;
        color: #fff; /* White for values */
    }
    
    .stat-card .card-icon {
        font-size: 2rem;
        opacity: 0.5;
        position: absolute;
        right: 1.5rem;
        top: 1.5rem;
        color: #fff; /* White icons */
    }
    
    /* Border colors for each card type */
    .stat-card.border-left-primary {
        border-left: 4px solid #4299e1 !important; /* Blue */
    }
    
    .stat-card.border-left-success {
        border-left: 4px solid #48bb78 !important; /* Green */
    }
    
    .stat-card.border-left-warning {
        border-left: 4px solid #ed8936 !important; /* Orange */
    }
    
    .stat-card.border-left-info {
        border-left: 4px solid #0bc5ea !important; /* Cyan */
    }
    
    /* Chart container */
    .chart-container {
        background-color: #2d3748;
        border-radius: 10px;
        padding: 20px;
        height: 100%;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
    }
    
    /* Main content area */
    .bg-secondary.rounded.p-4 {
        background-color: #1a202c !important; /* Darker background */
        color: #fff;
    }
    
    /* Text colors for better contrast */
    h3, h6, p {
        color: #fff !important;
    }
        
        .chart-container {
            background-color: #2d3748;
            border-radius: 10px;
            padding: 20px;
            height: 100%;
        }
        
        canvas#salesChart {
            background-color: #2d3748;
        }
        
        /* Help Section Styles */
		.help-btn {
		    position: fixed;
		    bottom: 30px;
		    right: 30px;
		    width: 60px;
		    height: 60px;
		    border-radius: 50%;
		    background-color: #4299e1;
		    color: white;
		    display: flex;
		    align-items: center;
		    justify-content: center;
		    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
		    z-index: 1000;
		    transition: all 0.3s;
		}
		
		.help-btn:hover {
		    transform: scale(1.1);
		    background-color: #3182ce;
		}
		
		.accordion-button:not(.collapsed) {
		    background-color: #2d3748 !important;
		    color: #4299e1 !important;
		}
		
		.accordion-button:focus {
		    box-shadow: none;
		    border-color: rgba(0,0,0,.125);
		}
		
		.modal-content {
		    border: none;
		    border-radius: 10px;
		}
		
		.accordion-body {
		    background-color: #1a202c;
		    color: #a0aec0;
		}
		
		.card.bg-dark {
		    border: 1px solid #4a5568;
		    transition: all 0.3s;
		}
		
		.card.bg-dark:hover {
		    border-color: #4299e1;
		    transform: translateY(-2px);
		}
    </style>
</head>

<body>
    <div class="container-fluid position-relative d-flex p-0">
        <!-- Spinner Start -->
        <div id="spinner" class="show bg-dark position-fixed translate-middle w-100 vh-100 top-50 start-50 d-flex align-items-center justify-content-center">
            <div class="spinner-border text-primary" style="width: 3rem; height: 3rem;" role="status">
                <span class="sr-only">Loading...</span>
            </div>
        </div>
        <!-- Spinner End -->

        <!-- Check if user is logged in and is ADMIN -->
        <c:choose>
            <c:when test="${empty sessionScope.user}">
                <script>
                    window.location.href = "${pageContext.request.contextPath}/LoginServlet";
                </script>
            </c:when>
            <c:when test="${sessionScope.user.role ne 'ADMIN'}">
                <script>
                    window.location.href = "${pageContext.request.contextPath}/Cashier/Cashierdashboard";
                </script>
            </c:when>
        </c:choose>

        <!-- Sidebar Start -->
        <div class="sidebar pe-4 pb-3">
            <nav class="navbar bg-secondary navbar-dark">
                <a href="${pageContext.request.contextPath}/Admin/Admindashboard.jsp" class="navbar-brand mx-4 mb-3">
                    <h3 class="text-primary"><i class="fa fa-user-edit me-2"></i>Admin Panel</h3>
                </a>
                <div class="d-flex align-items-center ms-4 mb-4">
                    <div class="position-relative">
                        <img class="rounded-circle" src="${pageContext.request.contextPath}/img/user.jpg" alt="" style="width: 40px; height: 40px;">
                        <div class="bg-success rounded-circle border border-2 border-white position-absolute end-0 bottom-0 p-1"></div>
                    </div>
                    <div class="ms-3">
                        <h6 class="mb-0">${sessionScope.user.name}</h6>
                        <span>Administrator</span>
                    </div>
                </div>
                <div class="navbar-nav w-100">
                    <a href="${pageContext.request.contextPath}/Admin/Admindashboard" class="nav-item nav-link active"><i class="fa fa-tachometer-alt me-2"></i>Dashboard</a>
                    <a href="${pageContext.request.contextPath}/Admin/users" class="nav-item nav-link"><i class="fa fa-users me-2"></i>Employee Management</a>
                    <a href="${pageContext.request.contextPath}/Admin/customers" class="nav-item nav-link"><i class="fa fa-user-tie me-2"></i>Customer Management</a>
                    <a href="${pageContext.request.contextPath}/Admin/categories" class="nav-item nav-link"><i class="fa fa-tags me-2"></i>Category Management</a>
                    <a href="${pageContext.request.contextPath}/Admin/products" class="nav-item nav-link"><i class="fa fa-book me-2"></i>Book Management</a>
                    <a href="${pageContext.request.contextPath}/AdminCashier/pos" class="nav-item nav-link "><i class="fa fa-shopping-cart me-2"></i>Point of Sale</a>
                    <a href="${pageContext.request.contextPath}/AdminCashier/sales" class="nav-item nav-link"><i class="fa fa-history me-2"></i>Sales History</a>
                    <!--  <a href="${pageContext.request.contextPath}/Admin/settings" class="nav-item nav-link"><i class="fa fa-cog me-2"></i>Settings</a>-->
                </div>
            </nav>
        </div>
        <!-- Sidebar End -->

        <!-- Content Start -->
        <div class="content">
            <!-- Navbar Start -->
            <nav class="navbar navbar-expand bg-secondary navbar-dark sticky-top px-4 py-0">
                <a href="${pageContext.request.contextPath}/Admin/Admindashboard" class="navbar-brand d-flex d-lg-none me-4">
                    <h2 class="text-primary mb-0"><i class="fa fa-user-edit"></i></h2>
                </a>
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
                            <!-- <a href="${pageContext.request.contextPath}/profile" class="dropdown-item">My Profile</a>
                            <a href="${pageContext.request.contextPath}/settings" class="dropdown-item">Settings</a> -->
                            <a href="#" class="dropdown-item" id="logoutBtn">Log Out</a>
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
                            <h3 class="mb-4">Welcome, ${sessionScope.user.name}!</h3>
                            <p>You are logged in as an administrator. Use the sidebar to navigate through the system.</p>
                            <div class="d-flex justify-content-between align-items-center mb-4">
						    <button class="btn btn-info" data-bs-toggle="modal" data-bs-target="#helpModal">
						        <i class="fa fa-question-circle me-2"></i>Help Guide
						    </button>
						</div>
                            <!-- Quick Stats -->
                            <div class="row mt-4">
                                <!-- Total Categories Card -->
                                <div class="col-xl-3 col-md-6 mb-4">
                                    <div class="card stat-card border-left-primary shadow h-100 py-2">
                                        <div class="card-body">
                                            <div class="row no-gutters align-items-center">
                                                <div class="col mr-2">
                                                    <div class="text-xs font-weight-bold text-primary text-uppercase mb-1">
                                                        Total Categories</div>
                                                    <div class="h5 mb-0 font-weight-bold text-gray-800 card-value">${totalCategories}</div>
                                                </div>
                                                <div class="col-auto">
                                                    <i class="fas fa-tags fa-2x text-gray-300 card-icon"></i>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <!-- Total Products Card -->
                                <div class="col-xl-3 col-md-6 mb-4">
                                    <div class="card stat-card border-left-success shadow h-100 py-2">
                                        <div class="card-body">
                                            <div class="row no-gutters align-items-center">
                                                <div class="col mr-2">
                                                    <div class="text-xs font-weight-bold text-success text-uppercase mb-1">
                                                        Total Products</div>
                                                    <div class="h5 mb-0 font-weight-bold text-gray-800 card-value">${totalProducts}</div>
                                                </div>
                                                <div class="col-auto">
                                                    <i class="fas fa-book fa-2x text-gray-300 card-icon"></i>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <!-- Low Stock Products Card -->
                                <div class="col-xl-3 col-md-6 mb-4">
                                    <div class="card stat-card border-left-warning shadow h-100 py-2">
                                        <div class="card-body">
                                            <div class="row no-gutters align-items-center">
                                                <div class="col mr-2">
                                                    <div class="text-xs font-weight-bold text-warning text-uppercase mb-1">
                                                        Low Stock Products</div>
                                                    <div class="h5 mb-0 font-weight-bold text-gray-800 card-value">${lowStockProducts}</div>
                                                </div>
                                                <div class="col-auto">
                                                    <i class="fas fa-exclamation-triangle fa-2x text-gray-300 card-icon"></i>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <!-- Total Sales Card -->
                                <div class="col-xl-3 col-md-6 mb-4">
                                    <div class="card stat-card border-left-info shadow h-100 py-2">
                                        <div class="card-body">
                                            <div class="row no-gutters align-items-center">
                                                <div class="col mr-2">
                                                    <div class="text-xs font-weight-bold text-info text-uppercase mb-1">
                                                        Total Sales (This Month)</div>
                                                    <div class="h5 mb-0 font-weight-bold text-gray-800 card-value">Rs. <fmt:formatNumber value="${totalSales}" pattern="#,##0.00"/></div>
                                                </div>
                                                <div class="col-auto">
                                                    <i class="fas fa-dollar-sign fa-2x text-gray-300 card-icon"></i>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            <!-- Sales Chart -->
                            <div class="row mt-4">
                                <div class="col-12">
                                    <div class="chart-container">
                                        <canvas id="salesChart"></canvas>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Main Content End -->

            <!-- Footer Start -->
            <div class="container-fluid pt-4 px-4">
                <div class="bg-secondary rounded-top p-4">
                    <div class="row">
                        <div class="col-12 col-sm-6 text-center text-sm-start">
                            &copy; <a href="#">Pahana Edu</a>, All Rights Reserved. 
                        </div>
                        <div class="col-12 col-sm-6 text-center text-sm-end">
                            <span>Admin Dashboard</span>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Footer End -->
        </div>
        <!-- Content End -->

        <!-- Back to Top -->
        <a href="#" class="btn btn-lg btn-primary btn-lg-square back-to-top"><i class="bi bi-arrow-up"></i></a>
    </div>


<%@ include file="help-section.jsp" %>
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

    <!-- SweetAlert2 JS -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.all.min.js"></script>

    <!-- Template Javascript -->
    <script src="${pageContext.request.contextPath}/js/main.js"></script>
    
    <script>
        $(document).ready(function() {
            // Handle logout with confirmation
            $('#logoutBtn').on('click', function(e) {
                e.preventDefault();
                
                Swal.fire({
                    title: 'Are you sure?',
                    text: "You will be logged out from the system!",
                    icon: 'warning',
                    showCancelButton: true,
                    confirmButtonColor: '#3085d6',
                    cancelButtonColor: '#d33',
                    confirmButtonText: 'Yes, Logout!',
                    cancelButtonText: 'Cancel',
                    background: '#1a202c',
                    color: '#fff'
                }).then((result) => {
                    if (result.isConfirmed) {
                        // Show loading animation
                        Swal.fire({
                            title: 'Logging out...',
                            text: 'Please wait',
                            allowOutsideClick: false,
                            didOpen: () => {
                                Swal.showLoading()
                            },
                            background: '#1a202c',
                            color: '#fff'
                        });
                        
                        // Perform logout via AJAX
                        $.post('${pageContext.request.contextPath}/logout', function() {
                            // Redirect to login page after successful logout
                            window.location.href = '${pageContext.request.contextPath}/Auth/index.jsp';
                        }).fail(function() {
                            // If logout fails, still redirect to login page
                            window.location.href = '${pageContext.request.contextPath}/Auth/index.jsp';
                        });
                    }
                });
            });
            
            // Initialize tooltips
            $('[data-bs-toggle="tooltip"]').tooltip();
            
            // Back to top button
            $(window).scroll(function() {
                if ($(this).scrollTop() > 300) {
                    $('.back-to-top').fadeIn('slow');
                } else {
                    $('.back-to-top').fadeOut('slow');
                }
            });
            
            $('.back-to-top').click(function() {
                $('html, body').animate({scrollTop: 0}, 1500, 'easeInOutExpo');
                return false;
            });
            
            // Initialize Sales Chart
            var ctx = document.getElementById('salesChart').getContext('2d');
            var salesChart = new Chart(ctx, {
                type: 'line',
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
                        backgroundColor: 'rgba(54, 162, 235, 0.2)',
                        borderColor: 'rgba(54, 162, 235, 1)',
                        borderWidth: 2,
                        tension: 0.1,
                        fill: true
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
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
                                color: '#fff',
                                font: {
                                    size: 14
                                }
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
        });
    </script>
</body>
</html>