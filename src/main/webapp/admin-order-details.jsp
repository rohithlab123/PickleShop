<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, dao.OrderDetailsDAO, model.CartItem" %>
<!DOCTYPE html>
<html>
<head>
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
<meta charset="UTF-8">
<title>Order Details</title>

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
    margin:30px auto;
    background:white;
    padding:20px;
    border-radius:10px;
}

table{
    width:100%;
    border-collapse:collapse;
}

th, td{
    padding:12px;
    border:1px solid #ddd;
    text-align:center;
}

th{
    background:#7A1F1F;
    color:white;
}

img{
    width:60px;
    height:60px;
    border-radius:8px;
}

.total{
    text-align:right;
    font-size:20px;
    margin-top:20px;
    font-weight:bold;
    color:#7A1F1F;
}

</style>

</head>

<body>

<div class="header">
    📦 Order Details #<%= orderId %>
</div>

<div class="container">

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

    <td>
        <img src="<%= request.getContextPath() %>/<%= item.getImageUrl() %>">
    </td>

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

</body>
</html>