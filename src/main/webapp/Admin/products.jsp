8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <title>Product Management - Book Management System</title>
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
    
    <!-- DataTables CSS -->
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.11.5/css/dataTables.bootstrap5.min.css">

  <style>
        .product-image {
            width: 80px;
            height: 100px;
            object-fit: cover;
            border: 1px solid #ddd;
            border-radius: 4px;
        }
        .table-danger {
            background-color: #f8d7da !important;
        }
        .table-warning {
            background-color: #fff3cd !important;
        }
        .price-column {
		    text-align: right;
		    white-space: nowrap;
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
                    <a href="${pageContext.request.contextPath}/Admin/Admindashboard.jsp" class="nav-item nav-link"><i class="fa fa-tachometer-alt me-2"></i>Dashboard</a>
                    <a href="${pageContext.request.contextPath}/admin/users" class="nav-item nav-link"><i class="fa fa-users me-2"></i>User Management</a>
                    <a href="${pageContext.request.contextPath}/Admin/categories" class="nav-item nav-link"><i class="fa fa-tags me-2"></i>Category Management</a>
                    <a href="${pageContext.request.contextPath}/Admin/products" class="nav-item nav-link active"><i class="fa fa-book me-2"></i>Book Management</a>
                    <a href="${pageContext.request.contextPath}/admin/reports" class="nav-item nav-link"><i class="fa fa-chart-bar me-2"></i>Reports</a>
                    <a href="${pageContext.request.contextPath}/admin/settings" class="nav-item nav-link"><i class="fa fa-cog me-2"></i>Settings</a>
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
                            <a href="${pageContext.request.contextPath}/profile" class="dropdown-item">My Profile</a>
                            <a href="${pageContext.request.contextPath}/settings" class="dropdown-item">Settings</a>
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
                            <div class="d-flex align-items-center justify-content-between mb-4">
                                <h3 class="mb-0">Product Management</h3>
                                <div>
                                    <a href="products?action=lowstock" class="btn btn-warning me-2">
                                        <i class="fa fa-exclamation-triangle me-2"></i>Low Stock
                                    </a>
                                    <a href="products?action=new" class="btn btn-primary">
                                        <i class="fa fa-plus me-2"></i>Add New Product
                                    </a>
                                </div>
                            </div>
                            
                            <!-- Search Form -->
                            <form action="products" method="get" class="mb-4">
                                <input type="hidden" name="action" value="search">
                                <div class="input-group">
                                    <input type="text" class="form-control" placeholder="Search products..." name="keyword" value="${param.keyword}">
                                    <button class="btn btn-primary" type="submit"><i class="fa fa-search"></i></button>
                                </div>
                            </form>
                            
                            <!-- Products Table -->
                             <div class="table-responsive">
            <table class="table table-hover" id="productTable">
                <thead>
                    <tr>
                        <th scope="col">ID</th>
                        <th scope="col">Image</th>
                        <th scope="col">Name</th>
                        <th scope="col">Category</th>
                        <th scope="col">Description</th>
                        <th scope="col">Price</th>
                        <th scope="col">Quantity</th>
                        <th scope="col">Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${empty products}">
                            <tr>
                                <td colspan="7" class="text-center">No products found</td>
                            </tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="product" items="${products}">
                                <tr class="${product.quantity == 0 ? 'table-danger' : (product.quantity <= 5 ? 'table-warning' : '')}">
                                    <td>${product.id}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${product.image != null}">
                                                <img src="data:image/jpeg;base64,${product.imageBase64}" class="product-image">
                                            </c:when>
                                            <c:otherwise>
                                                <img src="${pageContext.request.contextPath}/img/default-product.png" 
                                                     alt="No image" 
                                                     class="product-image">
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>${product.name}</td>
                                    <td>${product.categoryName}</td>
                                   
                                    <td>
                                        <c:choose>
                                            <c:when test="${fn:length(product.description) > 100}">
                                                ${fn:substring(product.description, 0, 100)}...
                                            </c:when>
                                            <c:otherwise>
                                                ${product.description}
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                     <td class="price-column">
									    Rs. ${product.price}
									</td>
                                    <td>
                                        <div class="d-flex align-items-center">
                                            <span class="me-2">${product.quantity}</span>
                                            <c:if test="${product.quantity == 0}">
                                                <span class="badge bg-danger">Out of Stock</span>
                                            </c:if>
                                            <c:if test="${product.quantity <= 5 && product.quantity > 0}">
                                                <span class="badge bg-warning text-dark">Low Stock</span>
                                            </c:if>
                                        </div>
                                    </td>
                                    <td>
                                        <div class="d-flex">
                                            <a href="products?action=edit&id=${product.id}" class="btn btn-sm btn-warning me-2" 
                                               data-bs-toggle="tooltip" title="Edit">
                                                <i class="fa fa-edit"></i>
                                            </a>
                                            <a href="products?action=delete&id=${product.id}" class="btn btn-sm btn-danger" 
                                               onclick="return confirm('Are you sure you want to delete this product?')"
                                               data-bs-toggle="tooltip" title="Delete">
                                                <i class="fa fa-trash"></i>
                                            </a>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
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
                            <span>Product Management</span>
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
    
    <!-- DataTables JS -->
    <script type="text/javascript" src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.min.js"></script>
    <script type="text/javascript" src="https://cdn.datatables.net/1.11.5/js/dataTables.bootstrap5.min.js"></script>

    <!-- Template Javascript -->
    <script src="${pageContext.request.contextPath}/js/main.js"></script>
    
    <script>
        
            
         // Initialize DataTable with more options
            $('#productTable').DataTable({
                responsive: true,
                columnDefs: [
                    { orderable: false, targets: [1, 6] }, // Make image and actions columns not sortable
                    { width: "80px", targets: [0] }, // ID column width
                    { width: "100px", targets: [1] }, // Image column width
                    { type: 'currency', targets: 4 },
                    { width: "150px", targets: [6] } // Actions column width
                ],
                language: {
                    search: "Search products:",
                    lengthMenu: "Show _MENU_ entries",
                    info: "Showing _START_ to _END_ of _TOTAL_ entries",
                    paginate: {
                        previous: "Previous",
                        next: "Next"
                    }
                },
                dom: '<"top"lf>rt<"bottom"ip><"clear">'
            });
            
            // Handle logout
            $('a[href$="logout"]').on('click', function(e) {
                e.preventDefault();
                $.post('${pageContext.request.contextPath}/logout', function() {
                    window.location.href = '${pageContext.request.contextPath}/LoginServlet';
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
        
        $('#price').on('blur', function() {
            let value = $(this).val();
            if(value && !isNaN(value)) {
                $(this).val(parseFloat(value).toFixed(2));
            }
        });
    </script>
</body>
</html>