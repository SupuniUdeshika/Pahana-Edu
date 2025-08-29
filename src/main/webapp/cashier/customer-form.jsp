<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <title>${customer == null ? 'Add New' : 'Edit'} Customer - Pahana Edu</title>
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
                    window.location.href = "${pageContext.request.contextPath}/cashier/Cashierdashboard.jsp";
                </script>
            </c:when>
        </c:choose>

        <!-- Sidebar Start -->
        <div class="sidebar pe-4 pb-3">
            <nav class="navbar bg-secondary navbar-dark">
                <a href="${pageContext.request.contextPath}/cashier/Cashierdashboard.jsp" class="navbar-brand mx-4 mb-3">
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
                    <a href="${pageContext.request.contextPath}/cashier/Cashierdashboard" class="nav-item nav-link"><i class="fa fa-tachometer-alt me-2"></i>Dashboard</a>
                    <a href="${pageContext.request.contextPath}/Cashier/customers" class="nav-item nav-link active"><i class="fa fa-user-tie me-2"></i>Customer Management</a>
                    <a href="${pageContext.request.contextPath}/Cashier/categories" class="nav-item nav-link"><i class="fa fa-tags me-2"></i>Category Management</a>
                    <a href="${pageContext.request.contextPath}/Cashier/books" class="nav-item nav-link"><i class="fa fa-book me-2"></i>Book Management</a>
                </div>
            </nav>
        </div>
        <!-- Sidebar End -->

        <!-- Content Start -->
        <div class="content">
            <!-- Navbar Start -->
            <nav class="navbar navbar-expand bg-secondary navbar-dark sticky-top px-4 py-0">
                <a href="${pageContext.request.contextPath}/cashier/Cashierdashboard.jsp" class="navbar-brand d-flex d-lg-none me-4">
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
                            <a href="${pageContext.request.contextPath}/profile" class="dropdown-item">My Profile</a>
                            <a href="${pageContext.request.contextPath}/settings" class="dropdown-item">Settings</a>
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
                            <h3 class="mb-4">${customer == null ? 'Add New' : 'Edit'} Customer</h3>
                            
                            <form action="${pageContext.request.contextPath}/Cashier/customers" method="post" id="customerForm">
                                <input type="hidden" name="action" value="${customer == null ? 'insert' : 'update'}">
                                <c:if test="${customer != null}">
                                    <input type="hidden" name="id" value="${customer.id}">
                                </c:if>
                                
                                <div class="mb-3">
                                    <label for="accountNumber" class="form-label">Account Number <span class="text-danger">*</span></label>
                                    <input type="text" class="form-control" id="accountNumber" name="accountNumber" 
                                           value="${customer.accountNumber}" required>
                                </div>
                                
                                <div class="mb-3">
                                    <label for="name" class="form-label">Name <span class="text-danger">*</span></label>
                                    <input type="text" class="form-control" id="name" name="name" 
                                           value="${customer.name}" required>
                                </div>
                                
                                <div class="mb-3">
                                    <label for="address" class="form-label">Address <span class="text-danger">*</span></label>
                                    <textarea class="form-control" id="address" name="address" rows="3" required>${customer.address}</textarea>
                                </div>
                                
                                <div class="mb-3">
                                    <label for="telephone" class="form-label">Telephone <span class="text-danger">*</span></label>
                                    <input type="tel" class="form-control" id="telephone" name="telephone" 
                                           value="${customer.telephone}" required>
                                </div>
                                
                                <div class="mb-3">
                                    <label for="email" class="form-label">Email <span class="text-danger">*</span></label>
                                    <input type="email" class="form-control" id="email" name="email" 
                                           value="${customer.email}" required>
                                </div>
                                
                                <div class="d-flex justify-content-between">
                                    <button type="submit" class="btn btn-primary">
                                        <i class="fa fa-save me-2"></i>${customer == null ? 'Add' : 'Update'} Customer
                                    </button>
                                    <a href="${pageContext.request.contextPath}/Cashier/customers" class="btn btn-secondary">
                                        <i class="fa fa-times me-2"></i>Cancel
                                    </a>
                                </div>
                            </form>
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
                            <span>${customer == null ? 'Add New' : 'Edit'} Customer</span>
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
                            window.location.href = '${pageContext.request.contextPath}/LoginServlet';
                        }).fail(function() {
                            // If logout fails, still redirect to login page
                            window.location.href = '${pageContext.request.contextPath}/LoginServlet';
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
            
            // Form submission handling
            $('#customerForm').on('submit', function(e) {
                e.preventDefault();
                
                // Simple client-side validation
                if ($('#accountNumber').val().trim() === '') {
                    Swal.fire({
                        icon: 'error',
                        title: 'Error!',
                        text: 'Account number is required!',
                        background: '#1a202c',
                        color: '#fff'
                    });
                    return false;
                }
                
                if ($('#name').val().trim() === '') {
                    Swal.fire({
                        icon: 'error',
                        title: 'Error!',
                        text: 'Customer name is required!',
                        background: '#1a202c',
                        color: '#fff'
                    });
                    return false;
                }
                
                if ($('#email').val().trim() === '') {
                    Swal.fire({
                        icon: 'error',
                        title: 'Error!',
                        text: 'Email is required!',
                        background: '#1a202c',
                        color: '#fff'
                    });
                    return false;
                }
                
                // Show loading animation
                Swal.fire({
                    title: 'Processing...',
                    text: 'Please wait',
                    allowOutsideClick: false,
                    didOpen: () => {
                        Swal.showLoading()
                    },
                    background: '#1a202c',
                    color: '#fff'
                });
                
                // Submit form via AJAX for better UX
                $.ajax({
                    type: $(this).attr('method'),
                    url: $(this).attr('action'),
                    data: $(this).serialize(),
                    success: function(response) {
                        // Close loading animation
                        Swal.close();
                        
                        // Show success message
                        Swal.fire({
                            icon: 'success',
                            title: 'Success!',
                            text: 'Customer ${customer == null ? "added" : "updated"} successfully!',
                            timer: 2000,
                            showConfirmButton: false,
                            background: '#1a202c',
                            color: '#fff'
                        }).then(() => {
                            // Redirect to customers list after successful submission
                            window.location.href = '${pageContext.request.contextPath}/Cashier/customers';
                        });
                    },
                    error: function(xhr, status, error) {
                        // Close loading animation
                        Swal.close();
                        
                        // Show error message
                        Swal.fire({
                            icon: 'error',
                            title: 'Error!',
                            text: 'An error occurred: ' + error,
                            background: '#1a202c',
                            color: '#fff'
                        });
                    }
                });
            });
        });
    </script>
</body>
</html>