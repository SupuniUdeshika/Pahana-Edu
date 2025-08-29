<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <title>${empty user.id or user.id == 0 ? 'Add New' : 'Edit'} Employee - Pahana Edu</title>
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

        <!-- Check if user is logged in and is ADMIN -->
        <c:choose>
            <c:when test="${empty sessionScope.user}">
                <script>
                    window.location.href = "${pageContext.request.contextPath}/LoginServlet";
                </script>
            </c:when>
            <c:when test="${sessionScope.user.role ne 'ADMIN'}">
                <script>
                    window.location.href = "${pageContext.request.contextPath}/cashier/dashboard.jsp";
                </script>
            </c:when>
        </c:choose>

        <!-- Sidebar Start -->
        <div class="sidebar pe-4 pb-3">
            <nav class="navbar bg-secondary navbar-dark">
                <a href="${pageContext.request.contextPath}/Admin/dashboard.jsp" class="navbar-brand mx-4 mb-3">
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
                    <a href="${pageContext.request.contextPath}/Admin/Admindashboard" class="nav-item nav-link"><i class="fa fa-tachometer-alt me-2"></i>Dashboard</a>
                    <a href="${pageContext.request.contextPath}/Admin/users" class="nav-item nav-link active"><i class="fa fa-users me-2"></i>Employee Management</a>
                    <a href="${pageContext.request.contextPath}/Admin/customers" class="nav-item nav-link"><i class="fa fa-user-tie me-2"></i>Customer Management</a>
                    <a href="${pageContext.request.contextPath}/Admin/categories" class="nav-item nav-link"><i class="fa fa-tags me-2"></i>Category Management</a>
                    <a href="${pageContext.request.contextPath}/Admin/products" class="nav-item nav-link"><i class="fa fa-book me-2"></i>Book Management</a>
                    <a href="${pageContext.request.contextPath}/AdminCashier/pos" class="nav-item nav-link "><i class="fa fa-shopping-cart me-2"></i>Point of Sale</a>
                    <a href="${pageContext.request.contextPath}/AdminCashier/sales" class="nav-item nav-link"><i class="fa fa-history me-2"></i>Sales History</a>
                    <!--<a href="${pageContext.request.contextPath}/Admin/settings" class="nav-item nav-link"><i class="fa fa-cog me-2"></i>Settings</a>-->
                </div>
            </nav>
        </div>
        <!-- Sidebar End -->

        <!-- Content Start -->
        <div class="content">
            <!-- Navbar Start -->
            <nav class="navbar navbar-expand bg-secondary navbar-dark sticky-top px-4 py-0">
                <a href="${pageContext.request.contextPath}/Admin/Admindashboard.jsp" class="navbar-brand d-flex d-lg-none me-4">
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
                            <!--<a href="${pageContext.request.contextPath}/profile" class="dropdown-item">My Profile</a>
                            <a href="${pageContext.request.contextPath}/settings" class="dropdown-item">Settings</a>-->
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
                           <h3 class="mb-4">${empty user.id or user.id == 0 ? 'Add New' : 'Edit'} Employee</h3>
                            
                            <form id="userForm" action="${pageContext.request.contextPath}/Admin/users" method="post">
							    <input type="hidden" name="action" value="${empty user.id or user.id == 0 ? 'insert' : 'update'}">
							    
							    <c:if test="${not empty user.id and user.id != 0}">
							        <input type="hidden" name="id" value="${user.id}">
							    </c:if>
							    
							    <div class="mb-3">
							        <label for="name" class="form-label">Name <span class="text-danger">*</span></label>
							        <input type="text" class="form-control" id="name" name="name" 
							               value="${user.name}" required>
							    </div>
							    
							    <div class="mb-3">
							        <label for="email" class="form-label">Email <span class="text-danger">*</span></label>
							        <input type="email" class="form-control" id="email" name="email" 
							               value="${user.email}" required>
							    </div>
							    
							     <div class="mb-3">
								    <label for="password" class="form-label">Password 
								        <span class="text-danger">${empty user.id or user.id == 0 ? '*' : ''}</span>
								    </label>
								    <input type="password" class="form-control" id="password" name="password" 
								           ${empty user.id or user.id == 0 ? 'required' : ''}>
								    <small class="text-muted">${not empty user.id and user.id != 0 ? 'Leave blank to keep current password' : ''}</small>
								</div>
							    
							    <div class="mb-3">
							        <label for="role" class="form-label">Role <span class="text-danger">*</span></label>
							        <select class="form-select" id="role" name="role" required>
							            <option value="">Select Role</option>
							            <option value="ADMIN" ${user.role == 'ADMIN' ? 'selected' : ''}>Admin</option>
							            <option value="CASHIER" ${user.role == 'CASHIER' ? 'selected' : ''}>Cashier</option>
							        </select>
							    </div>
							    
							    <div class="d-flex justify-content-between">
							        <button type="submit" class="btn btn-primary">
							            <i class="fa fa-save me-2"></i>${empty user.id or user.id == 0 ? 'Add Employee' : 'Update Employee'}
							        </button>
							        <a href="${pageContext.request.contextPath}/Admin/users" class="btn btn-secondary">
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
                            <span>${user == null ? 'Add New' : 'Edit'} Employee</span>
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
            // Show success/error messages
            <c:if test="${not empty sessionScope.success}">
                Swal.fire({
                    icon: 'success',
                    title: 'Success!',
                    text: '${sessionScope.success}',
                    timer: 3000,
                    showConfirmButton: false
                });
                <c:remove var="success" scope="session"/>
            </c:if>
            
            <c:if test="${not empty sessionScope.error}">
                Swal.fire({
                    icon: 'error',
                    title: 'Error!',
                    text: '${sessionScope.error}',
                    timer: 3000,
                    showConfirmButton: false
                });
                <c:remove var="error" scope="session"/>
            </c:if>

            // Handle form submission
            $('#userForm').on('submit', function(e) {
                e.preventDefault();
                
                // Basic validation
                const name = $('#name').val().trim();
                const email = $('#email').val().trim();
                const role = $('#role').val();
                const password = $('#password').val();
                const isNewUser = ${empty user.id or user.id == 0};
                
                if (!name || !email || !role || (isNewUser && !password)) {
                    Swal.fire({
                        icon: 'error',
                        title: 'Validation Error',
                        text: 'Please fill all required fields',
                        timer: 3000,
                        showConfirmButton: false
                    });
                    return;
                }
                
                // Email validation
                const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
                if (!emailRegex.test(email)) {
                    Swal.fire({
                        icon: 'error',
                        title: 'Validation Error',
                        text: 'Please enter a valid email address',
                        timer: 3000,
                        showConfirmButton: false
                    });
                    return;
                }
                
                // If validation passes, submit the form
                this.submit();
            });
            
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
        });
    </script>
</body> 
</html>