<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="dao.CartDAO" %>
<%@ page import="model.Order" %>

<%
Integer userId = (Integer) session.getAttribute("userId");

if(userId == null){
    response.sendRedirect("login.jsp");
    return;
}

CartDAO dao = new CartDAO();
List<Order> orders = dao.getUserOrders(userId);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>My Orders</title>

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
    font-size:28px;
    font-weight:bold;
}

.container{
    width:90%;
    max-width:1000px;
    margin:40px auto;
}

.order-card{
    background:white;
    padding:25px;
    border-radius:15px;
    margin-bottom:20px;
    box-shadow:0 5px 15px rgba(0,0,0,0.1);
}

.row{
    display:flex;
    justify-content:space-between;
    margin-bottom:12px;
}

.label{
    font-weight:bold;
    color:#7A1F1F;
}

.status{
    padding:8px 14px;
    border-radius:20px;
    color:white;
    font-weight:bold;
}

.PLACED{ background:#f39c12; }
.CONFIRMED{ background:#3498db; }
.PACKING{ background:#9b59b6; }
.SHIPPED{ background:#2ecc71; }
.DELIVERED{ background:#27ae60; }
.CANCELLED{ background:red; }

.empty{
    background:white;
    padding:50px;
    text-align:center;
    border-radius:15px;
    font-size:22px;
}

.home-btn{
    display:inline-block;
    margin-top:20px;
    background:#7A1F1F;
    color:white;
    padding:12px 20px;
    text-decoration:none;
    border-radius:10px;
}

.cancel-btn{
    background:red;
    color:white;
    padding:8px 12px;
    border-radius:6px;
    text-decoration:none;
}
</style>

</head>

<body>

<div class="header">📦 My Orders</div>

<div class="container">

<%
if(orders == null || orders.size() == 0){
%>

<div class="empty">
    No Orders Yet
    <br>
    <a href="index.jsp" class="home-btn">Continue Shopping</a>
</div>

<%
} else {

for(Order order : orders){
%>

<div class="order-card">

    <div class="row">
        <div>
            <span class="label">Order ID:</span>
            #<%= order.getId() %>
        </div>

        <div class="status <%= order.getStatus() %>">
            <%= order.getStatus() %>
        </div>
    </div>

    <div class="row">
        <div>
            <span class="label">Total:</span>
            ₹<%= order.getTotalPrice() %>
        </div>

        <div>
            <span class="label">Date:</span>
            <%= order.getOrderDate() %>
        </div>
    </div>

    <!-- VIEW + CANCEL -->
    <div style="display:flex; justify-content:space-between; margin-top:10px;">

        <a href="orderdetails.jsp?orderId=<%= order.getId() %>"
           style="color:#7A1F1F; font-weight:bold;">
            View Details
        </a>

  <%
String status = order.getStatus();
if(status == null) status = "PLACED";
%>

<% if(!"DELIVERED".equals(status) && !"CANCELLED".equals(status)) { %>

    <a class="cancel-btn"
       href="CancelOrderServlet?orderId=<%= order.getId() %>"
       onclick="return confirm('Cancel this order?')">
       Cancel Order
    </a>

<% } %>

    </div>

</div>

<%
} // for loop
} // else
%>

</div>

</body>
</html>