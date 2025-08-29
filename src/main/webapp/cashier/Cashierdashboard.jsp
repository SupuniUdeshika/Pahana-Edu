<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <title>Cashier Dashboard - Pahana Edu</title>
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

        <!-- Check if user is logged in and is CASHIER -->
        <c:choose>
            <c:when test="${empty sessionScope.user}">
                <script>
                    window.location.href = "${pageContext.request.contextPath}/LoginServlet";
                </script>
            </c:when>
            <c:when test="${sessionScope.user.role ne 'CASHIER'}">
                <script>
                    window.location.href = "${pageContext.request.contextPath}/Admin/Admindashboard.jsp";
                </script>
            </c:when>
        </c:choose>

        <!-- Sidebar Start -->
        <div class="sidebar pe-4 pb-3">
            <nav class="navbar bg-secondary navbar-dark">
                <a href="${pageContext.request.contextPath}/cashier/Cashierdashboard" class="navbar-brand mx-4 mb-3">
                    <h3 class="text-primary"><i class="fa fa-user-edit me-2"></i>Cashier Panel</h3>
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
                    <a href="${pageContext.request.contextPath}/cashier/Cashierdashboard" class="nav-item nav-link active"><i class="fa fa-tachometer-alt me-2"></i>Dashboard</a>
                    <a href="${pageContext.request.contextPath}/Cashier/customers" class="nav-item nav-link"><i class="fa fa-user-tie me-2"></i>Customer Management</a>
                    <a href="${pageContext.request.contextPath}/Cashier/categories" class="nav-item nav-link "><i class="fa fa-tags me-2"></i>Category Management</a>
                    <a href="${pageContext.request.contextPath}/Cashier/products" class="nav-item nav-link"><i class="fa fa-book me-2"></i>Book Management</a>
                    <a href="${pageContext.request.contextPath}/Cashier/pos" class="nav-item nav-link "><i class="fa fa-shopping-cart me-2"></i>Point of Sale</a>
                </div>
            </nav>
        </div>
        <!-- Sidebar End -->

        <!-- Content Start -->
        <div class="content">
            <!-- Navbar Start -->
            <nav class="navbar navbar-expand bg-secondary navbar-dark sticky-top px-4 py-0">
                <a href="${pageContext.request.contextPath}/Cashier/Cashierdashboard" class="navbar-brand d-flex d-lg-none me-4">
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
                            <a href="${pageContext.request.contextPath}/logout" class="dropdown-item" id="logoutBtn">Log Out</a>
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
                            <p>You are logged in as a cashier. Use the sidebar to navigate through the system.</p>
                            <div class="d-flex justify-content-between align-items-center mb-4">
						        <button class="btn btn-info" data-bs-toggle="modal" data-bs-target="#helpModal">
						            <i class="fa fa-question-circle me-2"></i>Help Guide
						        </button>
						    </div>
                            
                            <!-- Quick Stats -->
                            <div class="row mt-4">
                                <div class="col-md-4">
                                    <div class="card stat-card border-left-primary shadow h-100 py-2">
                                        <div class="card-body">
                                            <div class="row no-gutters align-items-center">
                                                <div class="col mr-2">
                                                    <div class="text-xs font-weight-bold text-primary text-uppercase mb-1">
                                                        Total Customers</div>
                                                    <div class="h5 mb-0 font-weight-bold text-gray-800 card-value">${totalCustomers}</div>
                                                </div>
                                                <div class="col-auto">
                                                    <i class="fas fa-users fa-2x text-gray-300 card-icon"></i>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-4">
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
                                <div class="col-md-4">
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
                            <span>Cashier Dashboard</span>
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

    <!-- Help Section Modal -->
    <div class="modal fade" id="helpModal" tabindex="-1" aria-labelledby="helpModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-xl">
            <div class="modal-content bg-secondary">
                <div class="modal-header border-0">
                    <h5 class="modal-title text-white" id="helpModalLabel">
                        <i class="fa fa-question-circle me-2"></i>Pahana Edu - Cashier Guide
                    </h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <!-- Sidebar Navigation -->
                        <div class="col-md-3">
                            <div class="list-group" id="helpNav" role="tablist">
                                <a class="list-group-item list-group-item-action active" data-bs-toggle="list" href="#dashboardHelp" role="tab">
                                    <i class="fa fa-tachometer-alt me-2"></i>Dashboard
                                </a>
                                <a class="list-group-item list-group-item-action" data-bs-toggle="list" href="#customerHelp" role="tab">
                                    <i class="fa fa-user-tie me-2"></i>Customer Management
                                </a>
                                <a class="list-group-item list-group-item-action" data-bs-toggle="list" href="#productHelp" role="tab">
                                    <i class="fa fa-book me-2"></i>Book Management
                                </a>
                                <a class="list-group-item list-group-item-action" data-bs-toggle="list" href="#posHelp" role="tab">
                                    <i class="fa fa-shopping-cart me-2"></i>Point of Sale
                                </a>
                                <a class="list-group-item list-group-item-action" data-bs-toggle="list" href="#troubleshootingHelp" role="tab">
                                    <i class="fa fa-wrench me-2"></i>Troubleshooting
                                </a>
                            </div>
                        </div>
                        
                        <!-- Content Area -->
                        <div class="col-md-9">
                            <div class="tab-content">
                                <!-- Dashboard Help -->
                                <div class="tab-pane fade show active" id="dashboardHelp" role="tabpanel">
                                    <h4 class="text-primary mb-4"><i class="fa fa-tachometer-alt me-2"></i>Cashier Dashboard</h4>
                                    
                                    <div class="card bg-dark mb-4">
                                        <div class="card-header">
                                            <h5 class="mb-0">Understanding Your Dashboard</h5>
                                        </div>
                                        <div class="card-body">
                                            <p>The dashboard provides a quick overview of key information relevant to your cashier role.</p>
                                            
                                            <div class="row mb-4">
                                                <div class="col-md-6">
                                                    <div class="card bg-secondary mb-3">
                                                        <div class="card-body">
                                                            <h6><i class="fa fa-users text-primary me-2"></i>Total Customers</h6>
                                                            <p class="mb-0">Shows the total number of registered customers in the system.</p>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-md-6">
                                                    <div class="card bg-secondary mb-3">
                                                        <div class="card-body">
                                                            <h6><i class="fa fa-book text-success me-2"></i>Total Products</h6>
                                                            <p class="mb-0">Displays the total number of books/products available in inventory.</p>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-md-6">
                                                    <div class="card bg-secondary mb-3">
                                                        <div class="card-body">
                                                            <h6><i class="fa fa-exclamation-triangle text-warning me-2"></i>Low Stock Products</h6>
                                                            <p class="mb-0">Indicates products with limited inventory (5 or fewer copies).</p>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            
                                            <h5 class="mt-4">Daily Tasks</h5>
                                            <p>As a cashier, your primary responsibilities include:</p>
                                            <ul>
                                                <li>Processing customer transactions at the Point of Sale</li>
                                                <li>Managing customer information</li>
                                                <li>Handling book inventory lookups</li>
                                                <li>Providing excellent customer service</li>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                                
                                <!-- Customer Management Help -->
                                <div class="tab-pane fade" id="customerHelp" role="tabpanel">
                                    <h4 class="text-primary mb-4"><i class="fa fa-user-tie me-2"></i>Customer Management</h4>
                                    
                                    <div class="card bg-dark mb-4">
                                        <div class="card-header">
                                            <h5 class="mb-0">Managing Customer Accounts</h5>
                                        </div>
                                        <div class="card-body">
                                            <h6>Adding New Customers</h6>
                                            <ol>
                                                <li>Go to <strong>Customer Management</strong> from the sidebar</li>
                                                <li>Click <span class="badge bg-primary"><i class="fa fa-plus me-1"></i>Add New Customer</span></li>
                                                <li>Fill in customer details:
                                                    <ul>
                                                        <li><strong>Account Number:</strong> Unique identifier (required)</li>
                                                        <li><strong>Name:</strong> Customer's full name (required)</li>
                                                        <li><strong>Address:</strong> Complete address (required)</li>
                                                        <li><strong>Telephone:</strong> Contact number (required)</li>
                                                        <li><strong>Email:</strong> Email address (required)</li>
                                                    </ul>
                                                </li>
                                                <li>Click <span class="badge bg-success">Save</span> to create customer record</li>
                                            </ol>
                                            
                                            <h6 class="mt-4">Customer Search</h6>
                                            <p>Use the search functionality to:</p>
                                            <ul>
                                                <li>Find customers by name</li>
                                                <li>Search by account number</li>
                                                <li>Filter customers for specific needs</li>
                                                <li>Quick access during sales transactions</li>
                                            </ul>
                                            
                                            <h6>Editing Customer Information</h6>
                                            <p>To update customer details:</p>
                                            <ol>
                                                <li>Locate the customer in the list</li>
                                                <li>Click the <span class="badge bg-warning"><i class="fa fa-edit"></i></span> edit button</li>
                                                <li>Update the information as needed</li>
                                                <li>Click <span class="badge bg-success">Update</span> to save changes</li>
                                            </ol>
                                        </div>
                                    </div>
                                </div>
                                
                                <!-- Product Management Help -->
                                <div class="tab-pane fade" id="productHelp" role="tabpanel">
                                    <h4 class="text-primary mb-4"><i class="fa fa-book me-2"></i>Book Management</h4>
                                    
                                    <div class="card bg-dark mb-4">
                                        <div class="card-header">
                                            <h5 class="mb-0">Managing Book Inventory</h5>
                                        </div>
                                        <div class="card-body">
                                            <h6>Viewing Book Inventory</h6>
                                            <p>As a cashier, you can:</p>
                                            <ul>
                                                <li>Browse all available books</li>
                                                <li>Search for specific titles or authors</li>
                                                <li>Check stock availability</li>
                                                <li>View book details and pricing</li>
                                            </ul>
                                            
                                            <h6 class="mt-4">Inventory Status Indicators</h6>
                                            <div class="row mb-4">
                                                <div class="col-md-4">
                                                    <div class="card bg-success text-white mb-2">
                                                        <div class="card-body text-center p-2">
                                                            <i class="fa fa-check-circle fa-2x mb-1"></i>
                                                            <p class="mb-0">In Stock<br><small>Good Quantity</small></p>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-md-4">
                                                    <div class="card bg-warning text-dark mb-2">
                                                        <div class="card-body text-center p-2">
                                                            <i class="fa fa-exclamation-triangle fa-2x mb-1"></i>
                                                            <p class="mb-0">Low Stock<br><small>≤ 5 items</small></p>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-md-4">
                                                    <div class="card bg-danger text-white mb-2">
                                                        <div class="card-body text-center p-2">
                                                            <i class="fa fa-times-circle fa-2x mb-1"></i>
                                                            <p class="mb-0">Out of Stock<br><small>0 items</small></p>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            
                                            <h6>Low Stock Management</h6>
                                            <p>Use the <span class="badge bg-warning"><i class="fa fa-exclamation-triangle me-1"></i>Low Stock</span> button to:</p>
                                            <ul>
                                                <li>Quickly identify products needing restocking</li>
                                                <li>View all low inventory items at once</li>
                                                <li>Inform management about stock needs</li>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                                
                                <!-- Point of Sale Help -->
                                <div class="tab-pane fade" id="posHelp" role="tabpanel">
                                    <h4 class="text-primary mb-4"><i class="fa fa-shopping-cart me-2"></i>Point of Sale System</h4>
                                    
                                    <div class="card bg-dark mb-4">
                                        <div class="card-header">
                                            <h5 class="mb-0">Processing Sales Transactions</h5>
                                        </div>
                                        <div class="card-body">
                                            <h6>Step-by-Step Sales Process</h6>
                                            <div class="steps">
                                                <div class="step">
                                                    <span class="step-number">1</span>
                                                    <div class="step-content">
                                                        <h6>Customer Selection</h6>
                                                        <p>Search for existing customers by name or account number. Select the customer to pre-fill their information.</p>
                                                    </div>
                                                </div>
                                                <div class="step">
                                                    <span class="step-number">2</span>
                                                    <div class="step-content">
                                                        <h6>Product Selection</h6>
                                                        <p>Browse or search for products. Use category filters to find items quickly. Click on products to add them to the cart.</p>
                                                    </div>
                                                </div>
                                                <div class="step">
                                                    <span class="step-number">3</span>
                                                    <div class="step-content">
                                                        <h6>Cart Management</h6>
                                                        <p>Review items in cart. Adjust quantities using + and - buttons. Remove items with the delete button.</p>
                                                    </div>
                                                </div>
                                                <div class="step">
                                                    <span class="step-number">4</span>
                                                    <div class="step-content">
                                                        <h6>Payment Processing</h6>
                                                        <p>Select payment method (Cash/Card/Online). Enter amount received. System calculates balance automatically.</p>
                                                    </div>
                                                </div>
                                                <div class="step">
                                                    <span class="step-number">5</span>
                                                    <div class="step-content">
                                                        <h6>Complete Sale</h6>
                                                        <p>Review transaction details. Click "Complete Sale" to finalize. System generates invoice and updates inventory.</p>
                                                    </div>
                                                </div>
                                            </div>
                                            
                                            <h6 class="mt-4">Payment Methods</h6>
                                            <div class="row mb-4">
                                                <div class="col-md-4">
                                                    <div class="card bg-secondary text-center">
                                                        <div class="card-body">
                                                            <i class="fa fa-money-bill-wave fa-2x text-success mb-2"></i>
                                                            <h6>Cash</h6>
                                                            <p class="small mb-0">Physical currency payments</p>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-md-4">
                                                    <div class="card bg-secondary text-center">
                                                        <div class="card-body">
                                                            <i class="fa fa-credit-card fa-2x text-primary mb-2"></i>
                                                            <h6>Card</h6>
                                                            <p class="small mb-0">Debit/Credit card payments</p>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-md-4">
                                                    <div class="card bg-secondary text-center">
                                                        <div class="card-body">
                                                            <i class="fa fa-globe fa-2x text-info mb-2"></i>
                                                            <h6>Online</h6>
                                                            <p class="small mb-0">Digital wallet payments</p>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            
                                            <h6>Keyboard Shortcuts</h6>
                                            <div class="table-responsive">
                                                <table class="table table-dark table-sm">
                                                    <thead>
                                                        <tr>
                                                            <th>Key</th>
                                                            <th>Function</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <tr>
                                                            <td><kbd>Enter</kbd></td>
                                                            <td>Initiate search</td>
                                                        </tr>
                                                        <tr>
                                                            <td><kbd>Tab</kbd></td>
                                                            <td>Navigate between fields</td>
                                                        </tr>
                                                        <tr>
                                                            <td><kbd>Esc</kbd></td>
                                                            <td>Clear selection</td>
                                                        </tr>
                                                        <tr>
                                                            <td><kbd>+</kbd></td>
                                                            <td>Increase quantity</td>
                                                        </tr>
                                                        <tr>
                                                            <td><kbd>-</kbd></td>
                                                            <td>Decrease quantity</td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                
                                <!-- Troubleshooting Help -->
                                <div class="tab-pane fade" id="troubleshootingHelp" role="tabpanel">
                                    <h4 class="text-primary mb-4"><i class="fa fa-wrench me-2"></i>Troubleshooting Guide</h4>
                                    
                                    <div class="card bg-dark mb-4">
                                        <div class="card-header">
                                            <h5 class="mb-0">Common Issues and Solutions</h5>
                                        </div>
                                        <div class="card-body">
                                            <h6>Frequently Encountered Issues</h6>
                                            
                                            <div class="accordion" id="troubleshootingAccordion">
                                                <div class="card mb-2">
                                                    <div class="card-header" id="headingOne">
                                                        <h6 class="mb-0">
                                                            <button class="btn btn-link" type="button" data-bs-toggle="collapse" data-bs-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
                                                                <i class="fa fa-question-circle me-2"></i>Can't Process Sale
                                                            </button>
                                                        </h6>
                                                    </div>
                                                    <div id="collapseOne" class="collapse show" aria-labelledby="headingOne" data-bs-parent="#troubleshootingAccordion">
                                                        <div class="card-body">
                                                            <p><strong>Possible Causes:</strong></p>
                                                            <ul>
                                                                <li>Customer not selected</li>
                                                                <li>Payment details incomplete</li>
                                                                <li>Network connectivity issues</li>
                                                                <li>System error during processing</li>
                                                            </ul>
                                                            <p><strong>Solutions:</strong></p>
                                                            <ol>
                                                                <li>Ensure customer is selected before completing sale</li>
                                                                <li>Verify payment information is complete</li>
                                                                <li>Check internet connection</li>
                                                                <li>Try processing the sale again</li>
                                                            </ol>
                                                        </div>
                                                    </div>
                                                </div>
                                                
                                                <div class="card mb-2">
                                                    <div class="card-header" id="headingTwo">
                                                        <h6 class="mb-0">
                                                            <button class="btn btn-link collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
                                                                <i class="fa fa-question-circle me-2"></i>Product Not Found
                                                            </button>
                                                        </h6>
                                                    </div>
                                                    <div id="collapseTwo" class="collapse" aria-labelledby="headingTwo" data-bs-parent="#troubleshootingAccordion">
                                                        <div class="card-body">
                                                            <p><strong>Possible Causes:</strong></p>
                                                            <ul>
                                                                <li>Incorrect search term</li>
                                                                <li>Product out of stock</li>
                                                                <li>Product not in system</li>
                                                                <li>Category filter applied</li>
                                                            </ul>
                                                            <p><strong>Solutions:</strong></p>
                                                            <ol>
                                                                <li>Check spelling of search term</li>
                                                                <li>Try different search keywords</li>
                                                                <li>Clear any applied filters</li>
                                                                <li>Ask supervisor to check inventory</li>
                                                            </ol>
                                                        </div>
                                                    </div>
                                                </div>
                                                
                                                <div class="card mb-2">
                                                    <div class="card-header" id="headingThree">
                                                        <h6 class="mb-0">
                                                            <button class="btn btn-link collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseThree" aria-expanded="false" aria-controls="collapseThree">
                                                                <i class="fa fa-question-circle me-2"></i>Customer Not Found
                                                            </button>
                                                        </h6>
                                                    </div>
                                                    <div id="collapseThree" class="collapse" aria-labelledby="headingThree" data-bs-parent="#troubleshootingAccordion">
                                                        <div class="card-body">
                                                            <p><strong>Possible Causes:</strong></p>
                                                            <ul>
                                                                <li>Customer not registered</li>
                                                                <li>Incorrect search information</li>
                                                                <li>Account number mistake</li>
                                                                <li>System error</li>
                                                            </ul>
                                                            <p><strong>Solutions:</strong></p>
                                                            <ol>
                                                                <li>Verify customer information</li>
                                                                <li>Try searching by different criteria</li>
                                                                <li>Register new customer if needed</li>
                                                                <li>Ask customer for correct account number</li>
                                                            </ol>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            
                                            <h6 class="mt-4">Getting Additional Support</h6>
                                            <p>If you continue to experience issues:</p>
                                            <ul>
                                                <li><strong>Contact:</strong> System Administrator</li>
                                                <li><strong>Phone:</strong> Internal extension 102</li>
                                                <li><strong>Hours:</strong> Monday-Friday, 8:00 AM - 6:00 PM</li>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer border-0">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    <button type="button" class="btn btn-primary" onclick="window.print()">
                        <i class="fa fa-print me-2"></i>Print Guide
                    </button>
                </div>
            </div>
        </div>
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
                        
                        // Perform logout via form submission
                        setTimeout(function() {
                            window.location.href = '${pageContext.request.contextPath}/LoginServlet';
                        }, 1000);
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
            
            // Help section functionality
            const helpNavLinks = document.querySelectorAll('#helpNav a');
            helpNavLinks.forEach(link => {
                link.addEventListener('click', function() {
                    localStorage.setItem('lastHelpTab', this.getAttribute('href'));
                });
            });
            
            // Restore last active tab
            const lastHelpTab = localStorage.getItem('lastHelpTab');
            if (lastHelpTab) {
                const tabTrigger = new bootstrap.Tab(document.querySelector(`a[href="${lastHelpTab}"]`));
                tabTrigger.show();
            }
        });
        
        // Help section styles
        const style = document.createElement('style');
        style.textContent = `
            .list-group-item {
                background-color: #2d3748;
                border: 1px solid #4a5568;
                color: #cbd5e0;
                transition: all 0.3s ease;
            }
            
            .list-group-item:hover, .list-group-item.active {
                background-color: #4299e1;
                color: white;
                border-color: #4299e1;
            }
            
            .steps .step {
                display: flex;
                margin-bottom: 1.5rem;
                align-items: flex-start;
            }
            
            .step-number {
                background-color: #4299e1;
                color: white;
                width: 30px;
                height: 30px;
                border-radius: 50%;
                display: flex;
                align-items: center;
                justify-content: center;
                font-weight: bold;
                margin-right: 1rem;
                flex-shrink: 0;
            }
            
            .step-content {
                flex-grow: 1;
            }
            
            .step-content h6 {
                color: #4299e1;
                margin-bottom: 0.5rem;
            }
            
            /* Table styles */
            .table-dark {
                background-color: #2d3748;
            }
            
            .table-dark th {
                border-color: #4a5568;
                color: #4299e1;
            }
            
            .table-dark td {
                border-color: #4a5568;
                color: #cbd5e0;
            }
            
            /* Card enhancements */
            .card.bg-secondary {
                background-color: #2d3748 !important;
                border: 1px solid #4a5568;
            }
            
            .card.bg-secondary h6 {
                color: #4299e1;
            }
            
            /* Alert enhancements */
            .alert-info {
                background-color: rgba(66, 153, 225, 0.2);
                border-color: #4299e1;
                color: #cbd5e0;
            }
            
            .alert-warning {
                background-color: rgba(237, 137, 54, 0.2);
                border-color: #ed8936;
                color: #cbd5e0;
            }
            
            /* Badge styles */
            .badge {
                padding: 0.5em 0.75em;
            }
        `;
        document.head.appendChild(style);
    </script>
</body>
</html>