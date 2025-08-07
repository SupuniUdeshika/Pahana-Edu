<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>Point of Sale - Pahana Edu</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    
    <!-- Include all CSS files from admin dashboard -->
    <link href="${pageContext.request.contextPath}/img/favicon.ico" rel="icon">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Roboto:wght@500;700&display=swap" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/lib/tempusdominus/css/tempusdominus-bootstrap-4.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
    
    <style>
        .product-card {
            cursor: pointer;
            transition: all 0.3s;
        }
        .product-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0,0,0,0.1);
        }
        
        /* Cart Styles */
        .cart-container {
            background-color: #2d3748;
            border-radius: 8px;
            padding: 20px;
        }
        
        .cart-item {
            border-bottom: 1px solid #4a5568;
            padding: 12px 0;
            margin-bottom: 8px;
        }
        
        .cart-item:last-child {
            border-bottom: none;
        }
        
        .cart-item-name {
            font-weight: 600;
            color: #ffffff;
            margin-bottom: 4px;
        }
        
        .cart-item-price {
            color: #a0aec0;
            font-size: 0.9rem;
        }
        
        .cart-item-subtotal {
            font-weight: 600;
            color: #ffffff;
            text-align: right;
        }
        
        .cart-quantity-controls {
            display: flex;
            align-items: center;
            gap: 5px;
            margin-top: 8px;
        }
        
        .cart-summary {
            background-color: #4a5568;
            padding: 15px;
            border-radius: 6px;
            margin-top: 15px;
        }
        
        .cart-summary-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 8px;
        }
        
        .cart-summary-label {
            color: #cbd5e0;
        }
        
        .cart-summary-value {
            color: #ffffff;
            font-weight: 600;
        }
        
        #selected-customer {
            background-color: #4a5568;
            padding: 12px;
            border-radius: 6px;
            margin-top: 10px;
        }
        
        .customer-display-name {
            font-weight: 600;
            color: #ffffff;
        }
        
        .customer-display-email {
            color: #a0aec0;
            font-size: 0.9rem;
        }
        .customer-display-account {
		    color: #a0aec0;
		    font-size: 0.85rem;
		    font-weight: 600;
		}
        
        #customer-results {
            background-color: #4a5568;
            border-radius: 6px;
            padding: 10px;
            margin-top: 5px;
            max-height: 200px;
            overflow-y: auto;
        }
        
        .customer-result-item {
            padding: 8px;
            cursor: pointer;
            border-bottom: 1px solid #2d3748;
        }
        
        .customer-result-item:hover {
            background-color: #2d3748;
        }
        
        .text-danger {
            color: #f56565 !important;
        }
        
        .text-success {
            color: #48bb78 !important;
        }
    </style>
</head>
<body>
    <div class="container-fluid position-relative d-flex p-0">
        <!-- Sidebar Start -->
        <div class="sidebar pe-4 pb-3">
            <nav class="navbar bg-secondary navbar-dark">
                <a href="${pageContext.request.contextPath}/Cashier/Cashierdashboard.jsp" class="navbar-brand mx-4 mb-3">
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
                    <a href="${pageContext.request.contextPath}/cashier/Cashierdashboard.jsp" class="nav-item nav-link "><i class="fa fa-tachometer-alt me-2"></i>Dashboard</a>
                    <a href="${pageContext.request.contextPath}/Cashier/pos" class="nav-item nav-link active"><i class="fa fa-shopping-cart me-2"></i>Point of Sale</a>
                    <a href="${pageContext.request.contextPath}/Cashier/sales" class="nav-item nav-link"><i class="fa fa-history me-2"></i>Sales History</a>
                    <a href="${pageContext.request.contextPath}/cashier/customers" class="nav-item nav-link"><i class="fa fa-user-tie me-2"></i>Customer Management</a>
                    <a href="${pageContext.request.contextPath}/Cashier/profile" class="nav-item nav-link"><i class="fa fa-user me-2"></i>My Profile</a>
                </div>
            </nav>
        </div>
        <!-- Sidebar End -->

        <!-- Content Start -->
        <div class="content">
            <!-- Navbar Start -->
            <nav class="navbar navbar-expand bg-secondary navbar-dark sticky-top px-4 py-0">
                <a href="${pageContext.request.contextPath}/Cashier/Cashierdashboard.jsp" class="navbar-brand d-flex d-lg-none me-4">
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
                            <a href="${pageContext.request.contextPath}/Cashier/profile" class="dropdown-item">My Profile</a>
                            <a href="${pageContext.request.contextPath}/Auth/index.jsp" class="dropdown-item">Log Out</a>
                        </div>
                    </div>
                </div>
            </nav>
            <!-- Navbar End -->

            <!-- Main Content Start -->
            <div class="container-fluid pt-4 px-4">
                <div class="row g-4">
                    <div class="col-md-8">
                        <div class="bg-secondary rounded p-4">
                            <div class="d-flex justify-content-between align-items-center mb-4">
                                <h4 class="mb-0">Products</h4>
                                <div class="d-flex">
                                    <select id="category-filter" class="form-select me-2">
                                        <option value="">All Categories</option>
                                        <c:forEach var="category" items="${categories}">
                                            <option value="${category.id}">${category.name}</option>
                                        </c:forEach>
                                    </select>
                                    <div class="input-group">
                                        <input type="text" id="product-search" class="form-control" placeholder="Search products...">
                                        <button class="btn btn-primary" id="search-btn">
                                            <i class="fa fa-search"></i>
                                        </button>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="row" id="product-list">
                                <c:forEach var="product" items="${products}">
                                    <div class="col-md-3 mb-3">
                                        <div class="card product-card bg-dark text-white" 
                                             onclick="addToCart(${product.id}, '${product.name.replace("'", "\\'")}', ${product.price}, ${product.quantity})">
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
                            </div>
                        </div>
                    </div>
                    
                    <div class="col-md-4">
                        <div class="bg-secondary rounded p-4">
                            <h4 class="mb-4">Cart</h4>
                            
                            <div class="mb-3">
                                <div class="input-group">
                                    <input type="text" id="customer-search" class="form-control" placeholder="Search customer...">
                                    <button class="btn btn-primary" id="customer-search-btn">
                                        <i class="fa fa-search"></i>
                                    </button>
                                </div>
                                <div id="customer-results" class="mt-2" style="display:none;"></div>
                                <input type="hidden" id="customer-id" name="customerId">
                                <div id="selected-customer" class="mt-2 p-2 bg-dark text-white rounded" style="display:none;"></div>
                            </div>
                            
                            <div id="cart-items">
                                <div class="text-center py-4 text-muted">Your cart is empty</div>
                            </div>
                            
                            <div class="mt-3">
                                <div class="d-flex justify-content-between mb-2">
                                    <span>Subtotal:</span>
                                    <span id="subtotal">Rs. 0.00</span>
                                </div>
                                
                                <div class="mb-3">
                                    <label class="form-label">Payment Method</label>
                                    <select id="payment-method" class="form-select">
                                        <option value="CASH">Cash</option>
                                        <option value="CARD">Card</option>
                                        <option value="ONLINE">Online Payment</option>
                                    </select>
                                </div>
                                
                                <div class="mb-3">
                                    <label class="form-label">Amount Paid</label>
                                    <input type="number" id="amount-paid" class="form-control" step="0.01" min="0" value="0">
                                </div>
                                
                                <div class="d-flex justify-content-between mb-3">
                                    <span>Balance:</span>
                                    <span id="balance">Rs. 0.00</span>
                                </div>
                                
                                <button id="checkout-btn" class="btn btn-primary w-100" disabled>
                                    <i class="fa fa-check-circle me-2"></i>Complete Sale
                                </button>
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
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
    let cart = [];
    let selectedCustomer = null;
    
    $(document).ready(function() {
        // Initialize with empty cart display
        updateCartDisplay();
        
        // Product search
        $('#search-btn').click(searchProducts);
        $('#product-search').keypress(function(e) {
            if (e.which === 13) searchProducts();
        });
        
        // Category filter
        $('#category-filter').change(searchProducts);
        
        // Customer search
        $('#customer-search-btn').click(searchCustomers);
        $('#customer-search').keypress(function(e) {
            if (e.which === 13) searchCustomers();
        });
        
        // Amount paid calculation
        $('#amount-paid').on('input', calculateBalance);
        
        // Checkout button
        $('#checkout-btn').click(processSale);
    });
    
    function searchProducts() {
        const keyword = $('#product-search').val();
        const categoryId = $('#category-filter').val();
        
        $.ajax({
            url: '${pageContext.request.contextPath}/Cashier/search-products',
            type: 'GET',
            data: { keyword: keyword, categoryId: categoryId },
            success: function(response) {
                $('#product-list').html(response);
            }
        });
    }
    
    function searchCustomers() {
        const keyword = $('#customer-search').val();
        if (!keyword) {
            $('#customer-results').hide();
            return;
        }
        
        $.ajax({
            url: '${pageContext.request.contextPath}/Cashier/search-customers',
            type: 'GET',
            data: { keyword: keyword },
            success: function(response) {
                $('#customer-results').html(response).show();
            }
        });
    }
    
    function selectCustomer(id, name, email, phone, accountNumber) {
        selectedCustomer = { 
            id: id, 
            name: name, 
            email: email, 
            phone: phone,
            accountNumber: accountNumber
        };
        $('#customer-id').val(id);
        
        let customerHtml = '<div class="d-flex justify-content-between align-items-center">' +
            '<div>' +
            '<div class="customer-display-name">' + name + '</div>' +
            '<div class="customer-display-account">Account: ' + accountNumber + '</div>' +
            '<div class="customer-display-email">' + email + '</div>';
            
        if (phone) {
            customerHtml += '<div class="customer-display-email">Tel: ' + phone + '</div>';
        }
            
        customerHtml += '</div>' +
            '<button class="btn btn-sm btn-danger" onclick="clearCustomer()">' +
            '<i class="fa fa-times"></i>' +
            '</button>' +
            '</div>';
        
        $('#selected-customer').html(customerHtml).show();
        $('#customer-results').hide();
        $('#customer-search').val('');
        updateCheckoutButton();
    }
    
    function clearCustomer() {
        selectedCustomer = null;
        $('#customer-id').val('');
        $('#selected-customer').hide();
        updateCheckoutButton();
    }
    
    function addToCart(productId, productName, price, stock) {
        // Check if product already in cart
        const existingItem = cart.find(item => item.productId === productId);
        
        if (existingItem) {
            if (existingItem.quantity < stock) {
                existingItem.quantity++;
                existingItem.subtotal = existingItem.quantity * price;
            } else {
                showAlert('Cannot add more than available stock');
                return;
            }
        } else {
            if (stock > 0) {
                cart.push({
                    productId: productId,
                    productName: productName,
                    price: price,
                    quantity: 1,
                    subtotal: price
                });
            } else {
                showAlert('Product out of stock');
                return;
            }
        }
        
        updateCartDisplay();
    }
    
    function updateCartDisplay() {
        const $cartItems = $('#cart-items');
        $cartItems.empty();
        
        if (cart.length === 0) {
            $cartItems.html('<div class="text-center py-4 text-muted">Your cart is empty</div>');
            $('#subtotal').text('Rs. 0.00');
            $('#balance').text('Rs. 0.00');
            updateCheckoutButton();
            return;
        }
        
        let subtotal = 0;
        
        cart.forEach((item, index) => {
            subtotal += item.subtotal;
            
            const itemHtml = '<div class="cart-item">' +
                '<div class="d-flex justify-content-between">' +
                '<div>' +
                '<div class="cart-item-name">' + item.productName + '</div>' +
                '<div class="cart-item-price">Rs. ' + item.price.toFixed(2) + ' x ' + item.quantity + '</div>' +
                '</div>' +
                '<div class="text-end">' +
                '<div class="cart-item-subtotal">Rs. ' + item.subtotal.toFixed(2) + '</div>' +
                '<div class="cart-quantity-controls">' +
                '<button class="btn btn-sm btn-warning" onclick="updateQuantity(' + index + ', ' + (item.quantity - 1) + ')">' +
                '<i class="fa fa-minus"></i>' +
                '</button>' +
                '<span class="px-2">' + item.quantity + '</span>' +
                '<button class="btn btn-sm btn-warning" onclick="updateQuantity(' + index + ', ' + (item.quantity + 1) + ')">' +
                '<i class="fa fa-plus"></i>' +
                '</button>' +
                '<button class="btn btn-sm btn-danger" onclick="removeFromCart(' + index + ')">' +
                '<i class="fa fa-trash"></i>' +
                '</button>' +
                '</div>' +
                '</div>' +
                '</div>' +
                '</div>';
            
            $cartItems.append(itemHtml);
        });
        
        $('#subtotal').text('Rs. ' + subtotal.toFixed(2));
        calculateBalance();
        updateCheckoutButton();
    }
    
    function updateQuantity(index, newQuantity) {
        if (newQuantity <= 0) {
            removeFromCart(index);
            return;
        }
        
        const item = cart[index];
        item.quantity = newQuantity;
        item.subtotal = item.quantity * item.price;
        updateCartDisplay();
    }
    
    function removeFromCart(index) {
        cart.splice(index, 1);
        updateCartDisplay();
    }
    
    function calculateBalance() {
        const subtotalText = $('#subtotal').text();
        const subtotal = parseFloat(subtotalText.replace('Rs. ', '').replace(',', '')) || 0;
        const amountPaid = parseFloat($('#amount-paid').val()) || 0;
        const balance = amountPaid - subtotal;
        
        const $balance = $('#balance');
        $balance.text('Rs. ' + balance.toFixed(2));
        
        if (balance < 0) {
            $balance.addClass('text-danger').removeClass('text-success');
        } else {
            $balance.removeClass('text-danger').addClass('text-success');
        }
    }
    
    function updateCheckoutButton() {
        const $checkoutBtn = $('#checkout-btn');
        $checkoutBtn.prop('disabled', !(cart.length > 0 && selectedCustomer));
    }
    
    function processSale() {
        const paymentMethod = $('#payment-method').val();
        const amountPaid = parseFloat($('#amount-paid').val());
        
        if (isNaN(amountPaid) || amountPaid <= 0) {
            showAlert('Please enter a valid amount paid');
            return;
        }
        
        const subtotalText = $('#subtotal').text();
        const subtotal = parseFloat(subtotalText.replace('Rs. ', '').replace(',', ''));
        
        if (amountPaid < subtotal && paymentMethod === 'CASH') {
            if (!confirm('Amount paid is less than subtotal. Continue anyway?')) {
                return;
            }
        }
        
        // Show processing message
        $('#checkout-btn').html('<i class="fa fa-spinner fa-spin me-2"></i>Processing...').prop('disabled', true);
        
        const form = document.createElement('form');
        form.method = 'POST';
        form.action = '${pageContext.request.contextPath}/Cashier/process-sale';
        
        // Add customer ID
        const customerIdInput = document.createElement('input');
        customerIdInput.type = 'hidden';
        customerIdInput.name = 'customerId';
        customerIdInput.value = selectedCustomer.id;
        form.appendChild(customerIdInput);
        
        // Add payment method
        const paymentMethodInput = document.createElement('input');
        paymentMethodInput.type = 'hidden';
        paymentMethodInput.name = 'paymentMethod';
        paymentMethodInput.value = paymentMethod;
        form.appendChild(paymentMethodInput);
        
        // Add amount paid
        const amountPaidInput = document.createElement('input');
        amountPaidInput.type = 'hidden';
        amountPaidInput.name = 'amountPaid';
        amountPaidInput.value = amountPaid;
        form.appendChild(amountPaidInput);
        
        // Add cart items
        cart.forEach(item => {
            const productIdInput = document.createElement('input');
            productIdInput.type = 'hidden';
            productIdInput.name = 'productId';
            productIdInput.value = item.productId;
            form.appendChild(productIdInput);
            
            const quantityInput = document.createElement('input');
            quantityInput.type = 'hidden';
            quantityInput.name = 'quantity';
            quantityInput.value = item.quantity;
            form.appendChild(quantityInput);
        });
        
        document.body.appendChild(form);
        form.submit();
    }
    
    function showAlert(message) {
        alert(message);
    }
</script>
</body>
</html>