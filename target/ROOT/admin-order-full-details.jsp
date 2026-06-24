<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.*" %>
<%@ page import="dao.AdminOrderDAO" %>
<%@ page import="dao.OrderDetailsDAO" %>
<%@ page import="model.CartItem" %>

<%
String orderParam = request.getParameter("orderId");

if(orderParam == null){
    out.println("Invalid Order ID");
    return;
}

int orderId = Integer.parseInt(orderParam);

AdminOrderDAO orderDAO = new AdminOrderDAO();
OrderDetailsDAO itemDAO = new OrderDetailsDAO();

Map<String, Object> order = orderDAO.getOrderWithUser(orderId);
List<CartItem> items = itemDAO.getOrderItems(orderId);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Order Full Details</title>

<style>

body{
    font-family:Arial;
    background:#FBF1DE;
    margin:0;
}

.header{
    background:#7A1F1F;
    color:white;
    padding:15px;
    text-align:center;
}

.container{
    width:90%;
    margin:20px auto;
}

/* CARD */
.card{
    background:white;
    padding:20px;
    border-radius:10px;
    margin-bottom:20px;
}

/* CUSTOMER BOX */
.customer{
    line-height:1.8;
}

label{
    font-weight:bold;
}

/* TABLE */
table{
    width:100%;
    border-collapse:collapse;
    margin-top:10px;
}

th, td{
    padding:10px;
    border:1px solid #ddd;
    text-align:center;
}

th{
    background:#7A1F1F;
    color:white;
}

img{
    width:50px;
    height:50px;
    border-radius:8px;
}

/* TOTAL */
.total{
    text-align:right;
    font-size:20px;
    font-weight:bold;
    color:#7A1F1F;
    margin-top:10px;
}

.badge{
    display:inline-block;
    padding:5px 10px;
    background:#7A1F1F;
    color:white;
    border-radius:15px;
}

</style>

</head>

<body>

<div class="header">
    📦 Order Full Details #<%= orderId %>
</div>

<div class="container">

<!-- CUSTOMER DETAILS -->
<div class="card customer">

<h3>👤 Customer Details</h3>

<label>Name:</label> <%= order.get("name") %><br>
<label>Email:</label> <%= order.get("email") %><br>
<label>Phone:</label> <%= order.get("phone") %><br>
<label>Address:</label> <%= order.get("address") %><br>

</div>

<!-- ORDER DETAILS -->
<div class="card">

<h3>📋 Order Info</h3>

<span class="badge">Status: <%= order.get("status") %></span><br><br>

<label>Date:</label> <%= order.get("date") %><br>
<label>Total:</label> ₹<%= order.get("total") %>

</div>

<!-- ITEMS -->
<div class="card">

<h3>🛒 Products</h3>

<table>

<tr>
    <th>Product</th>
    <th>Image</th>
    <th>Price</th>
    <th>Qty</th>
    <th>Total</th>
</tr>

<%
double grandTotal = 0;

for(CartItem item : items){

double total = item.getProductPrice() * item.getQuantity();
grandTotal += total;
%>

<tr>
    <td><%= item.getProductName() %></td>
    <td><img src="<%= request.getContextPath() %>/<%= item.getImageUrl() %>"></td>
    <td>₹<%= item.getProductPrice() %></td>
    <td><%= item.getQuantity() %></td>
    <td>₹<%= total %></td>
</tr>

<%
}
%>

</table>

<div class="total">
    Grand Total: ₹<%= grandTotal %>
</div>

</div>

</div>

</body>
</html>