<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.*" %>
<%@ page import="dao.OrderDetailsDAO" %>
<%@ page import="model.CartItem" %>

<%
String orderIdParam = request.getParameter("orderId");

if(orderIdParam == null){
    out.println("Invalid Order ID");
    return;
}

int orderId = Integer.parseInt(orderIdParam);

OrderDetailsDAO dao = new OrderDetailsDAO();
List<CartItem> items = dao.getOrderItems(orderId);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Order Details</title>

<style>

body{
    margin:0;
    font-family:Arial;
    background:#FBF1DE;
}

.header{
    background:#7A1F1F;
    color:white;
    padding:20px;
    text-align:center;
    font-size:26px;
    font-weight:bold;
}

.container{
    width:90%;
    max-width:1000px;
    margin:40px auto;
}

.card{
    background:white;
    padding:20px;
    border-radius:15px;
    box-shadow:0 5px 15px rgba(0,0,0,0.1);
}

table{
    width:100%;
    border-collapse:collapse;
    margin-top:10px;
}

th, td{
    padding:15px;
    text-align:center;
    border-bottom:1px solid #ddd;
}

th{
    background:#7A1F1F;
    color:white;
}

.product-box{
    display:flex;
    align-items:center;
    justify-content:center;
    gap:10px;
}

.product-box img{
    width:60px;
    height:60px;
    object-fit:cover;
    border-radius:8px;
}

.total-box{
    text-align:right;
    margin-top:20px;
    font-size:22px;
    font-weight:bold;
    color:#7A1F1F;
}

.empty{
    text-align:center;
    padding:40px;
    color:red;
    font-size:18px;
}

.badge{
    display:inline-block;
    background:#7A1F1F;
    color:white;
    padding:6px 12px;
    border-radius:20px;
    margin-bottom:15px;
}

</style>

</head>

<body>

<div class="header">
    📦 Order Details
</div>

<div class="container">

<div class="card">

<span class="badge">Order ID: #<%= orderId %></span>

<%
if(items == null || items.size() == 0){
%>

<div class="empty">
    No items found in this order
</div>

<%
} else {
%>

<table>
<tr>
    <th>Product</th>
    <th>Price</th>
    <th>Quantity</th>
    <th>Total</th>
</tr>

<%
double grandTotal = 0;

for(CartItem item : items){

double total = item.getProductPrice() * item.getQuantity();
grandTotal += total;

// SAFE IMAGE PATH
String img = item.getImageUrl();
if(img == null){
    img = "images/no-image.png"; // optional fallback
}
%>

<tr>

    <td>
        <div class="product-box">

            <img src="<%= request.getContextPath() + "/" + img %>" 
                 alt="product">

            <span><%= item.getProductName() %></span>

        </div>
    </td>

    <td>₹<%= item.getProductPrice() %></td>
    <td><%= item.getQuantity() %></td>
    <td>₹<%= total %></td>

</tr>

<%
}
%>

</table>

<div class="total-box">
    Grand Total: ₹<%= grandTotal %>
</div>

<%
}
%>

</div>
</div>

</body>
</html>