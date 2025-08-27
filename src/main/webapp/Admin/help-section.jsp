<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="modal fade" id="helpModal" tabindex="-1" aria-labelledby="helpModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-xl">
        <div class="modal-content bg-secondary">
            <div class="modal-header border-0">
                <h5 class="modal-title text-white" id="helpModalLabel">
                    <i class="fa fa-question-circle me-2"></i>Pahana Edu - Complete User Guide
                </h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="row">
                    <!-- Sidebar Navigation -->
                    <div class="col-md-3">
                        <div class="list-group" id="helpNav" role="tablist">
                            <a class="list-group-item list-group-item-action active" data-bs-toggle="list" href="#dashboardHelp" role="tab">
                                <i class="fa fa-tachometer-alt me-2"></i>  Dashboard
                            </a>
                            <a class="list-group-item list-group-item-action" data-bs-toggle="list" href="#employeeHelp" role="tab">
                                <i class="fa fa-users me-2"></i> Employee Management
                            </a>
                            <a class="list-group-item list-group-item-action" data-bs-toggle="list" href="#customerHelp" role="tab">
                                <i class="fa fa-user-tie me-2"></i>   Customer Management
                            </a>
                            <a class="list-group-item list-group-item-action" data-bs-toggle="list" href="#productHelp" role="tab">
                                <i class="fa fa-book me-2"></i> Book Management
                            </a>
                            <a class="list-group-item list-group-item-action" data-bs-toggle="list" href="#categoryHelp" role="tab">
                                <i class="fa fa-tags me-2"></i>Category Management
                            </a>
                            <a class="list-group-item list-group-item-action" data-bs-toggle="list" href="#posHelp" role="tab">
                                <i class="fa fa-shopping-cart me-2"></i>Point of Sale
                            </a>
                            <a class="list-group-item list-group-item-action" data-bs-toggle="list" href="#salesHelp" role="tab">
                                <i class="fa fa-history me-2"></i>Sales History
                            </a>
                            <a class="list-group-item list-group-item-action" data-bs-toggle="list" href="#reportsHelp" role="tab">
                                <i class="fa fa-chart-bar me-2"></i>Reports
                            </a>
                            <a class="list-group-item list-group-item-action" data-bs-toggle="list" href="#settingsHelp" role="tab">
                                <i class="fa fa-cog me-2"></i>Settings
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
                                <h4 class="text-primary mb-4"><i class="fa fa-tachometer-alt me-2"></i>Dashboard Overview</h4>
                                
                                <div class="card bg-dark mb-4">
                                    <div class="card-header">
                                        <h5 class="mb-0">Understanding Your Dashboard</h5>
                                    </div>
                                    <div class="card-body">
                                        <p>The dashboard provides a comprehensive overview of your bookstore management system with real-time metrics and insights.</p>
                                        
                                        <div class="row mb-4">
                                            <div class="col-md-6">
                                                <div class="card bg-secondary mb-3">
                                                    <div class="card-body">
                                                        <h6><i class="fa fa-tags text-warning me-2"></i>Total Categories</h6>
                                                        <p class="mb-0">Shows the number of book categories in your system. Categories help organize your inventory for better management.</p>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="card bg-secondary mb-3">
                                                    <div class="card-body">
                                                        <h6><i class="fa fa-book text-success me-2"></i>Total Products</h6>
                                                        <p class="mb-0">Displays the total number of books/products available in your inventory across all categories.</p>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="card bg-secondary mb-3">
                                                    <div class="card-body">
                                                        <h6><i class="fa fa-exclamation-triangle text-danger me-2"></i>Low Stock Products</h6>
                                                        <p class="mb-0">Indicates products with limited inventory (5 or fewer copies). These need immediate attention for restocking.</p>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="card bg-secondary mb-3">
                                                    <div class="card-body">
                                                        <h6><i class="fa fa-chart-line text-info me-2"></i>Total Sales (This Month)</h6>
                                                        <p class="mb-0">Shows the revenue generated in the current month. This helps track your business performance.</p>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        
                                        <h5 class="mt-4">Sales Chart</h5>
                                        <p>The sales chart visualizes daily sales trends, helping you:</p>
                                        <ul>
                                            <li>Identify peak sales days</li>
                                            <li>Track performance trends</li>
                                            <li>Make informed business decisions</li>
                                            <li>Plan inventory based on sales patterns</li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                            
                            <!-- Employee Management Help -->
                            <div class="tab-pane fade" id="employeeHelp" role="tabpanel">
                                <h4 class="text-primary mb-4"><i class="fa fa-users me-2"></i>Employee Management</h4>
                                
                                <div class="card bg-dark mb-4">
                                    <div class="card-header">
                                        <h5 class="mb-0">Managing Staff Accounts</h5>
                                    </div>
                                    <div class="card-body">
                                        <h6>Adding New Employees</h6>
                                        <ol>
                                            <li>Navigate to <strong>Employee Management</strong> from the sidebar</li>
                                            <li>Click the <span class="badge bg-primary"><i class="fa fa-plus me-1"></i>Add New Employee</span> button</li>
                                            <li>Fill in the required information:
                                                <ul>
                                                    <li><strong>Name:</strong> Full name of the employee</li>
                                                    <li><strong>Email:</strong> Valid email address</li>
                                                    <li><strong>Password:</strong> Secure password</li>
                                                    <li><strong>Role:</strong> Select between Admin or Cashier</li>
                                                </ul>
                                            </li>
                                            <li>Click <span class="badge bg-success">Save</span> to create the account</li>
                                        </ol>
                                        
                                        <h6 class="mt-4">Employee Roles</h6>
                                        <div class="row">
                                            <div class="col-md-6">
                                                <div class="card bg-secondary mb-3">
                                                    <div class="card-body">
                                                        <h6 class="text-warning">Admin Role</h6>
                                                        <ul class="small">
                                                            <li>Full system access</li>
                                                            <li>Manage all settings</li>
                                                            <li>Add/remove employees</li>
                                                            <li>View all reports</li>
                                                            <li>Process sales</li>
                                                        </ul>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="card bg-secondary mb-3">
                                                    <div class="card-body">
                                                        <h6 class="text-info">Cashier Role</h6>
                                                        <ul class="small">
                                                            <li>Process sales only</li>
                                                            <li>View limited dashboard</li>
                                                            <li>Customer lookup</li>
                                                            <li>No management access</li>
                                                            <li>Basic operations only</li>
                                                        </ul>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        
                                        <h6>Editing Employee Information</h6>
                                        <p>To update employee details:</p>
                                        <ol>
                                            <li>Find the employee in the list</li>
                                            <li>Click the <span class="badge bg-warning"><i class="fa fa-edit"></i></span> edit button</li>
                                            <li>Make necessary changes</li>
                                            <li>Click <span class="badge bg-success">Update</span> to save changes</li>
                                        </ol>
                                        
                                        <div class="alert alert-info mt-4">
                                            <h6><i class="fa fa-lightbulb me-2"></i>Best Practices</h6>
                                            <ul class="mb-0">
                                                <li>Use strong passwords for all accounts</li>
                                                <li>Assign appropriate role permissions</li>
                                                <li>Regularly review employee access</li>
                                                <li>Deactivate accounts for former employees</li>
                                            </ul>
                                        </div>
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
                                        
                                        <div class="alert alert-info mt-4">
                                            <h6><i class="fa fa-lightbulb me-2"></i>Customer Management Tips</h6>
                                            <ul class="mb-0">
                                                <li>Maintain accurate customer information</li>
                                                <li>Use unique account numbers for each customer</li>
                                                <li>Regularly update customer records</li>
                                                <li>Use customer data for personalized service</li>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            <!-- Product Management Help -->
                            <div class="tab-pane fade" id="productHelp" role="tabpanel">
                                <h4 class="text-primary mb-4"><i class="fa fa-book me-2"></i>Book Management</h4>
                                
                                <div class="card bg-dark mb-4">
                                    <div class="card-header">
                                        <h5 class="mb-0">Managing Your Book Inventory</h5>
                                    </div>
                                    <div class="card-body">
                                        <h6>Adding New Books</h6>
                                        <ol>
                                            <li>Navigate to <strong>Book Management</strong> from the sidebar</li>
                                            <li>Click <span class="badge bg-primary"><i class="fa fa-plus me-1"></i>Add New Product</span></li>
                                            <li>Fill in book details:
                                                <ul>
                                                    <li><strong>Name:</strong> Book title (required)</li>
                                                    <li><strong>Category:</strong> Select appropriate category (required)</li>
                                                    <li><strong>Description:</strong> Book details and specifications</li>
                                                    <li><strong>Price:</strong> Selling price in Rs. (required)</li>
                                                    <li><strong>Quantity:</strong> Initial stock quantity (required)</li>
                                                    <li><strong>Image:</strong> Upload book cover (optional)</li>
                                                </ul>
                                            </li>
                                            <li>Click <span class="badge bg-success">Save</span> to add the book</li>
                                        </ol>
                                        
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
                                        
                                        <h6>Managing Stock Levels</h6>
                                        <p>To update inventory quantities:</p>
                                        <ol>
                                            <li>Find the product in the list</li>
                                            <li>Click the <span class="badge bg-warning"><i class="fa fa-edit"></i></span> edit button</li>
                                            <li>Update the quantity field</li>
                                            <li>Click <span class="badge bg-success">Update</span> to save changes</li>
                                        </ol>
                                        
                                        <h6>Low Stock Management</h6>
                                        <p>Use the <span class="badge bg-warning"><i class="fa fa-exclamation-triangle me-1"></i>Low Stock</span> button to:</p>
                                        <ul>
                                            <li>Quickly identify products needing restocking</li>
                                            <li>View all low inventory items at once</li>
                                            <li>Plan your inventory purchases</li>
                                            <li>Prevent stockouts</li>
                                        </ul>
                                        
                                        <div class="alert alert-info mt-4">
                                            <h6><i class="fa fa-lightbulb me-2"></i>Inventory Best Practices</h6>
                                            <ul class="mb-0">
                                                <li>Regularly update stock levels</li>
                                                <li>Set minimum stock alerts for popular items</li>
                                                <li>Use categories to organize products effectively</li>
                                                <li>Keep product images updated for better sales</li>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            <!-- Category Management Help -->
                            <div class="tab-pane fade" id="categoryHelp" role="tabpanel">
                                <h4 class="text-primary mb-4"><i class="fa fa-tags me-2"></i>Category Management</h4>
                                
                                <div class="card bg-dark mb-4">
                                    <div class="card-header">
                                        <h5 class="mb-0">Organizing Your Inventory</h5>
                                    </div>
                                    <div class="card-body">
                                        <h6>Creating Categories</h6>
                                        <ol>
                                            <li>Go to <strong>Category Management</strong> from the sidebar</li>
                                            <li>Click <span class="badge bg-primary"><i class="fa fa-plus me-1"></i>Add New Category</span></li>
                                            <li>Fill in category details:
                                                <ul>
                                                    <li><strong>Name:</strong> Category name (required)</li>
                                                    <li><strong>Description:</strong> Brief description (optional)</li>
                                                </ul>
                                            </li>
                                            <li>Click <span class="badge bg-success">Save</span> to create the category</li>
                                        </ol>
                                        
                                        <h6 class="mt-4">Category Examples</h6>
                                        <div class="row">
                                            <div class="col-md-6">
                                                <ul>
                                                    <li>Fiction</li>
                                                    <li>Non-Fiction</li>
                                                    <li>Academic Textbooks</li>
                                                    <li>Children's Books</li>
                                                </ul>
                                            </div>
                                            <div class="col-md-6">
                                                <ul>
                                                    <li>Reference Books</li>
                                                    <li>Exam Preparation</li>
                                                    <li>Local Authors</li>
                                                    <li>International Bestsellers</li>
                                                </ul>
                                            </div>
                                        </div>
                                        
                                        <h6>Editing Categories</h6>
                                        <p>To modify existing categories:</p>
                                        <ol>
                                            <li>Find the category in the list</li>
                                            <li>Click the <span class="badge bg-warning"><i class="fa fa-edit"></i></span> edit button</li>
                                            <li>Update the name or description</li>
                                            <li>Click <span class="badge bg-success">Update</span> to save changes</li>
                                        </ol>
                                        
                                        <div class="alert alert-warning mt-4">
                                            <h6><i class="fa fa-exclamation-circle me-2"></i>Important Notes</h6>
                                            <ul class="mb-0">
                                                <li>Categories cannot be deleted if they contain products</li>
                                                <li>Plan your category structure before adding products</li>
                                                <li>Use descriptive category names for easy navigation</li>
                                                <li>Regularly review and update categories as needed</li>
                                            </ul>
                                        </div>
                                        
                                        <div class="alert alert-info mt-3">
                                            <h6><i class="fa fa-lightbulb me-2"></i>Category Best Practices</h6>
                                            <ul class="mb-0">
                                                <li>Create categories before adding products</li>
                                                <li>Use consistent naming conventions</li>
                                                <li>Limit categories to 10-15 main groups</li>
                                                <li>Use descriptions to clarify category contents</li>
                                            </ul>
                                        </div>
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
                            
                            <!-- Sales History Help -->
                            <div class="tab-pane fade" id="salesHelp" role="tabpanel">
                                <h4 class="text-primary mb-4"><i class="fa fa-history me-2"></i>Sales History</h4>
                                
                                <div class="card bg-dark mb-4">
                                    <div class="card-header">
                                        <h5 class="mb-0">Tracking Past Transactions</h5>
                                    </div>
                                    <div class="card-body">
                                        <h6>Viewing Sales History</h6>
                                        <ol>
                                            <li>Navigate to <strong>Sales History</strong> from the sidebar</li>
                                            <li>Use date filters to specify time period</li>
                                            <li>View the list of all transactions</li>
                                            <li>Click on any sale to view detailed information</li>
                                        </ol>
                                        
                                        <h6 class="mt-4">Sales Information Available</h6>
                                        <div class="row">
                                            <div class="col-md-6">
                                                <ul>
                                                    <li>Invoice Number</li>
                                                    <li>Transaction Date & Time</li>
                                                    <li>Customer Information</li>
                                                    <li>Items Purchased</li>
                                                </ul>
                                            </div>
                                            <div class="col-md-6">
                                                <ul>
                                                    <li>Quantity of Each Item</li>
                                                    <li>Individual Prices</li>
                                                    <li>Total Amount</li>
                                                    <li>Payment Method</li>
                                                </ul>
                                            </div>
                                        </div>
                                        
                                        <h6>Filtering Options</h6>
                                        <p>Use the filter options to:</p>
                                        <ul>
                                            <li>View sales by specific date ranges</li>
                                            <li>Filter by customer</li>
                                            <li>Search for specific transactions</li>
                                            <li>Analyze sales patterns</li>
                                        </ul>
                                        
                                        <h6>Exporting Sales Data</h6>
                                        <p>To export sales history:</p>
                                        <ol>
                                            <li>Apply any desired filters</li>
                                            <li>Click the <span class="badge bg-success"><i class="fa fa-download me-1"></i>Export</span> button</li>
                                            <li>Choose export format (Excel/PDF)</li>
                                            <li>Save the file to your computer</li>
                                        </ol>
                                    </div>
                                </div>
                            </div>
                            
                            <!-- Reports Help -->
                            <div class="tab-pane fade" id="reportsHelp" role="tabpanel">
                                <h4 class="text-primary mb-4"><i class="fa fa-chart-bar me-2"></i>Reports & Analytics</h4>
                                
                                <div class="card bg-dark mb-4">
                                    <div class="card-header">
                                        <h5 class="mb-0">Generating Business Reports</h5>
                                    </div>
                                    <div class="card-body">
                                        <h6>Available Report Types</h6>
                                        <div class="row mb-4">
                                            <div class="col-md-6">
                                                <div class="card bg-secondary mb-3">
                                                    <div class="card-body">
                                                        <h6><i class="fa fa-calendar text-primary me-2"></i>Daily Reports</h6>
                                                        <p class="small mb-0">Sales performance for each day</p>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="card bg-secondary mb-3">
                                                    <div class="card-body">
                                                        <h6><i class="fa fa-calendar-week text-info me-2"></i>Weekly Reports</h6>
                                                        <p class="small mb-0">Weekly sales trends and patterns</p>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="card bg-secondary mb-3">
                                                    <div class="card-body">
                                                        <h6><i class="fa fa-calendar-alt text-success me-2"></i>Monthly Reports</h6>
                                                        <p class="small mb-0">Monthly performance analysis</p>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="card bg-secondary mb-3">
                                                    <div class="card-body">
                                                        <h6><i class="fa fa-box text-warning me-2"></i>Inventory Reports</h6>
                                                        <p class="small mb-0">Stock levels and inventory status</p>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        
                                        <h6>Generating Reports</h6>
                                        <ol>
                                            <li>Go to <strong>Reports</strong> from the sidebar</li>
                                            <li>Select the report type you need</li>
                                            <li>Choose date range for the report</li>
                                            <li>Apply any additional filters</li>
                                            <li>Click <span class="badge bg-primary">Generate Report</span></li>
                                            <li>View or export the report as needed</li>
                                        </ol>
                                        
                                        <h6 class="mt-4">Report Components</h6>
                                        <ul>
                                            <li><strong>Sales Summary:</strong> Total revenue and transactions</li>
                                            <li><strong>Top Products:</strong> Best-selling items</li>
                                            <li><strong>Customer Analysis:</strong> Purchasing patterns</li>
                                            <li><strong>Inventory Status:</strong> Stock levels and alerts</li>
                                            <li><strong>Trend Analysis:</strong> Sales patterns over time</li>
                                        </ul>
                                        
                                        <div class="alert alert-info mt-4">
                                            <h6><i class="fa fa-lightbulb me-2"></i>Reporting Best Practices</h6>
                                            <ul class="mb-0">
                                                <li>Generate daily reports for performance tracking</li>
                                                <li>Create weekly summaries for trend analysis</li>
                                                <li>Use monthly reports for strategic planning</li>
                                                <li>Export and archive reports regularly</li>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            <!-- Settings Help -->
                            <div class="tab-pane fade" id="settingsHelp" role="tabpanel">
                                <h4 class="text-primary mb-4"><i class="fa fa-cog me-2"></i>System Settings</h4>
                                
                                <div class="card bg-dark mb-4">
                                    <div class="card-header">
                                        <h5 class="mb-0">Configuring Your System</h5>
                                    </div>
                                    <div class="card-body">
                                        <h6>System Configuration Options</h6>
                                        <div class="row mb-4">
                                            <div class="col-md-6">
                                                <div class="card bg-secondary mb-3">
                                                    <div class="card-body">
                                                        <h6><i class="fa fa-user-cog text-primary me-2"></i>User Settings</h6>
                                                        <p class="small mb-0">Manage your profile and preferences</p>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="card bg-secondary mb-3">
                                                    <div class="card-body">
                                                        <h6><i class="fa fa-receipt text-info me-2"></i>Receipt Settings</h6>
                                                        <p class="small mb-0">Customize receipt format and content</p>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="card bg-secondary mb-3">
                                                    <div class="card-body">
                                                        <h6><i class="fa fa-bell text-success me-2"></i>Notification Settings</h6>
                                                        <p class="small mb-0">Configure alerts and notifications</p>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="card bg-secondary mb-3">
                                                    <div class="card-body">
                                                        <h6><i class="fa fa-database text-warning me-2"></i>Data Management</h6>
                                                        <p class="small mb-0">Backup and restore system data</p>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        
                                        <h6>User Profile Management</h6>
                                        <p>To update your profile:</p>
                                        <ol>
                                            <li>Click on your profile picture in the top right</li>
                                            <li>Select <strong>My Profile</strong></li>
                                            <li>Update your information as needed</li>
                                            <li>Click <span class="badge bg-success">Save Changes</span></li>
                                        </ol>
                                        
                                        <h6 class="mt-4">System Maintenance</h6>
                                        <p>Regular maintenance tasks:</p>
                                        <ul>
                                            <li>Regular data backups</li>
                                            <li>System updates</li>
                                            <li>Database optimization</li>
                                            <li>Security audits</li>
                                        </ul>
                                        
                                        <div class="alert alert-warning mt-4">
                                            <h6><i class="fa fa-exclamation-triangle me-2"></i>Important Settings</h6>
                                            <ul class="mb-0">
                                                <li>Regularly change passwords</li>
                                                <li>Keep backup of important data</li>
                                                <li>Review system logs periodically</li>
                                                <li>Update system when new versions available</li>
                                            </ul>
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
                                                            <i class="fa fa-question-circle me-2"></i>Can't Add Products
                                                        </button>
                                                    </h6>
                                                </div>
                                                <div id="collapseOne" class="collapse show" aria-labelledby="headingOne" data-bs-parent="#troubleshootingAccordion">
                                                    <div class="card-body">
                                                        <p><strong>Possible Causes:</strong></p>
                                                        <ul>
                                                            <li>Required fields not filled</li>
                                                            <li>Invalid price format</li>
                                                            <li>Category not selected</li>
                                                            <li>System validation error</li>
                                                        </ul>
                                                        <p><strong>Solutions:</strong></p>
                                                        <ol>
                                                            <li>Check that all required fields are completed</li>
                                                            <li>Ensure price is a valid number</li>
                                                            <li>Select an appropriate category</li>
                                                            <li>Refresh the page and try again</li>
                                                        </ol>
                                                    </div>
                                                </div>
                                            </div>
                                            
                                            <div class="card mb-2">
                                                <div class="card-header" id="headingTwo">
                                                    <h6 class="mb-0">
                                                        <button class="btn btn-link collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
                                                            <i class="fa fa-question-circle me-2"></i>Sales Not Recording
                                                        </button>
                                                    </h6>
                                                </div>
                                                <div id="collapseTwo" class="collapse" aria-labelledby="headingTwo" data-bs-parent="#troubleshootingAccordion">
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
                                                <div class="card-header" id="headingThree">
                                                    <h6 class="mb-0">
                                                        <button class="btn btn-link collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseThree" aria-expanded="false" aria-controls="collapseThree">
                                                            <i class="fa fa-question-circle me-2"></i>Low Stock Alerts Not Showing
                                                        </button>
                                                    </h6>
                                                </div>
                                                <div id="collapseThree" class="collapse" aria-labelledby="headingThree" data-bs-parent="#troubleshootingAccordion">
                                                    <div class="card-body">
                                                        <p><strong>Possible Causes:</strong></p>
                                                        <ul>
                                                            <li>Inventory not updated recently</li>
                                                            <li>System cache issue</li>
                                                            <li>Alert threshold not met</li>
                                                            <li>Display filter applied</li>
                                                        </ul>
                                                        <p><strong>Solutions:</strong></p>
                                                        <ol>
                                                            <li>Refresh the dashboard page</li>
                                                            <li>Check inventory levels manually</li>
                                                            <li>Clear browser cache</li>
                                                            <li>Verify low stock threshold settings</li>
                                                        </ol>
                                                    </div>
                                                </div>
                                            </div>
                                            
                                            <div class="card mb-2">
                                                <div class="card-header" id="headingFour">
                                                    <h6 class="mb-0">
                                                        <button class="btn btn-link collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseFour" aria-expanded="false" aria-controls="collapseFour">
                                                            <i class="fa fa-question-circle me-2"></i>Chart Not Displaying
                                                        </button>
                                                    </h6>
                                                </div>
                                                <div id="collapseFour" class="collapse" aria-labelledby="headingFour" data-bs-parent="#troubleshootingAccordion">
                                                    <div class="card-body">
                                                        <p><strong>Possible Causes:</strong></p>
                                                        <ul>
                                                            <li>Internet connection required for Chart.js</li>
                                                            <li>Browser compatibility issue</li>
                                                            <li>No sales data available</li>
                                                            <li>JavaScript disabled</li>
                                                        </ul>
                                                        <p><strong>Solutions:</strong></p>
                                                        <ol>
                                                            <li>Check your internet connection</li>
                                                            <li>Update your web browser</li>
                                                            <li>Enable JavaScript in browser settings</li>
                                                            <li>Verify sales data exists for selected period</li>
                                                        </ol>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        
                                        <h6 class="mt-4">Getting Additional Support</h6>
                                        <p>If you continue to experience issues:</p>
                                        <ul>
                                            <li><strong>Email:</strong> support@pahana.edu</li>
                                            <li><strong>Phone:</strong> +94 11 234 5678</li>
                                            <li><strong>Hours:</strong> Monday-Friday, 8:00 AM - 6:00 PM</li>
                                            <li><strong>Emergency:</strong> After-hours support available for critical issues</li>
                                        </ul>
                                        
                                        <div class="alert alert-info mt-4">
                                            <h6><i class="fa fa-lightbulb me-2"></i>Preventive Measures</h6>
                                            <ul class="mb-0">
                                                <li>Regularly update your system</li>
                                                <li>Perform routine maintenance</li>
                                                <li>Keep backups of important data</li>
                                                <li>Train staff on proper system usage</li>
                                            </ul>
                                        </div>
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

<style>
    /* Help Section Styles */
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
    
    /* Print styles */
    @media print {
        .modal-header, .modal-footer, .help-nav {
            display: none !important;
        }
        
        .modal-content {
            box-shadow: none;
            border: none;
        }
        
        .tab-pane {
            display: block !important;
            opacity: 1 !important;
        }
        
        .card {
            break-inside: avoid;
        }
    }
</style>

<script>
    // Initialize help section functionality
    document.addEventListener('DOMContentLoaded', function() {
        // Save last active tab
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
        
        // Make help modal draggable
        const helpModal = document.getElementById('helpModal');
        if (helpModal) {
            helpModal.addEventListener('shown.bs.modal', function() {
                // Enable dragging functionality
                enableDragging(helpModal);
            });
        }
    });
    
    function enableDragging(modal) {
        let isDragging = false;
        let currentX;
        let currentY;
        let initialX;
        let initialY;
        let xOffset = 0;
        let yOffset = 0;
        
        const modalDialog = modal.querySelector('.modal-dialog');
        
        modalDialog.addEventListener('mousedown', dragStart);
        modalDialog.addEventListener('mouseup', dragEnd);
        modalDialog.addEventListener('mousemove', drag);
        
        function dragStart(e) {
            initialX = e.clientX - xOffset;
            initialY = e.clientY - yOffset;
            
            if (e.target === modalDialog || modalDialog.contains(e.target)) {
                isDragging = true;
            }
        }
        
        function dragEnd(e) {
            initialX = currentX;
            initialY = currentY;
            
            isDragging = false;
        }
        
        function drag(e) {
            if (isDragging) {
                e.preventDefault();
                
                currentX = e.clientX - initialX;
                currentY = e.clientY - initialY;
                
                xOffset = currentX;
                yOffset = currentY;
                
                setTranslate(currentX, currentY, modalDialog);
            }
        }
        
        function setTranslate(xPos, yPos, el) {
            el.style.transform = `translate3d(${xPos}px, ${yPos}px, 0)`;
        }
    }
</script>