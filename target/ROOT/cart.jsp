
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="dao.CartDAO" %>
<%@ page import="model.CartItem" %>

<%
Integer userId = (Integer) session.getAttribute("userId");

if(userId == null){
    response.sendRedirect("login.jsp");
    return;
}

CartDAO dao = new CartDAO();
List<CartItem> cartItems = dao.getCartItems(userId);

double grandTotal = 0;
%>

<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="UTF-8">

<title>SAMPURNA HOME FOODS | Cart</title>

<link rel="preconnect" href="https://fonts.googleapis.com">

<link href="https://fonts.googleapis.com/css2?family=Rozha+One&family=Mukta:wght@400;500;700&display=swap" rel="stylesheet">

<style>

:root{
    --cream:#FBF1DE;
    --maroon:#7A1F1F;
    --maroon-dark:#541313;
    --mustard:#D98E04;
    --mustard-light:#F4C95D;
    --green:#4B6043;
    --paper:#FFFDF8;
    --ink:#2B1B12;
}

*{
    margin:0;
    padding:0;
    box-sizing:border-box;
}

body{
    background:var(--cream);
    font-family:'Mukta', sans-serif;
    color:var(--ink);
}

/* ================= HEADER ================= */

header{
    background:var(--maroon);
    padding:18px 40px;
    display:flex;
    justify-content:space-between;
    align-items:center;
    box-shadow:0 4px 12px rgba(0,0,0,0.2);
}

.logo{
    font-family:'Rozha One', serif;
    color:var(--mustard-light);
    font-size:30px;
}

.nav a{
    color:white;
    text-decoration:none;
    margin-left:24px;
    font-weight:700;
    font-size:16px;
}

/* ================= CONTAINER ================= */

.container{
    max-width:1150px;
    margin:45px auto;
    background:var(--paper);
    padding:35px;
    border-radius:20px;
    box-shadow:0 12px 30px rgba(0,0,0,0.1);
}

.title{
    font-family:'Rozha One', serif;
    color:var(--maroon);
    font-size:42px;
    margin-bottom:30px;
}

/* ================= TABLE ================= */

table{
    width:100%;
    border-collapse:collapse;
}

th{
    background:var(--maroon);
    color:white;
    padding:18px;
    font-size:15px;
}

td{
    padding:22px 15px;
    text-align:center;
    border-bottom:1px solid #eee;
    font-size:17px;
}

.product{
    font-weight:700;
    color:var(--maroon-dark);
}

/* ================= BUTTONS ================= */

button{
    border:none;
    cursor:pointer;
    transition:0.2s;
    font-weight:700;
}

.plus{
    background:var(--green);
    color:white;
    width:35px;
    height:35px;
    border-radius:50%;
    font-size:18px;
}

.minus{
    background:var(--mustard);
    color:white;
    width:35px;
    height:35px;
    border-radius:50%;
    font-size:18px;
}

.remove{
    background:var(--maroon);
    color:white;
    padding:10px 16px;
    border-radius:8px;
}

.plus:hover,
.minus:hover,
.remove:hover{
    transform:scale(1.08);
}

/* ================= TOTAL ================= */

.total-box{
    margin-top:35px;
    text-align:right;
}

.total{
    font-size:32px;
    font-weight:700;
    color:var(--maroon);
}

/* ================= CHECKOUT ================= */

.checkout{
    margin-top:22px;
    width:100%;
    background:var(--green);
    color:white;
    padding:18px;
    border-radius:12px;
    font-size:20px;
}

.checkout:hover{
    background:#394d33;
}

/* ================= EMPTY ================= */

.empty{
    text-align:center;
    padding:90px 20px;
}

.empty h2{
    color:var(--maroon);
    font-size:40px;
    margin-bottom:12px;
}

.empty p{
    color:#666;
    margin-bottom:28px;
    font-size:18px;
}

.shop-btn{
    display:inline-block;
    background:var(--maroon);
    color:white;
    text-decoration:none;
    padding:15px 26px;
    border-radius:10px;
    font-weight:700;
}

/* ================= MOBILE ================= */

@media(max-width:768px){

    header{
        padding:16px 20px;
    }

    .logo{
        font-size:22px;
    }

    .container{
        margin:20px;
        padding:20px;
    }

    .title{
        font-size:30px;
    }

    table{
        font-size:14px;
    }

    th, td{
        padding:10px;
    }

    .total{
        font-size:24px;
    }
}

</style>

</head>

<body>

<!-- ================= HEADER ================= -->

<header>

    <div class="logo">
        🫙 SAMPURNA HOME FOODS
    </div>

    <div class="nav">
        <a href="index.jsp">Home</a>
    </div>

</header>

<!-- ================= MAIN ================= -->

<div class="container">

<h1 class="title">🛒 My Cart</h1>

<%
if(cartItems.size() == 0){
%>

<div class="empty">

    <h2>Your Cart is Empty</h2>

    <p>Add delicious homemade products to continue shopping</p>

    <a href="index.jsp" class="shop-btn">
        Continue Shopping
    </a>

</div>

<%
}else{
%>

<table>

<tr>
    <th>Product</th>
    <th>Price</th>
    <th>Quantity</th>
    <th>Total</th>
    <th>Action</th>
</tr>

<%
for(CartItem item : cartItems){

grandTotal += item.getTotalPrice();
%>

<tr>

<td class="product">
    <%= item.getProductName() %>
</td>

<td>
    ₹<%= item.getProductPrice() %>
</td>

<td>

<form action="UpdateCartServlet" method="post" style="display:inline;">

    <input type="hidden" name="cartItemId" value="<%= item.getId() %>">

    <input type="hidden" name="action" value="decrease">

    <button class="minus">-</button>

</form>

<b style="padding:0 12px; font-size:18px;">
    <%= item.getQuantity() %>
</b>

<form action="UpdateCartServlet" method="post" style="display:inline;">

    <input type="hidden" name="cartItemId" value="<%= item.getId() %>">

    <input type="hidden" name="action" value="increase">

    <button class="plus">+</button>

</form>

</td>

<td>
    ₹<%= item.getTotalPrice() %>
</td>

<td>

<form action="UpdateCartServlet" method="post">

    <input type="hidden" name="cartItemId" value="<%= item.getId() %>">

    <input type="hidden" name="action" value="remove">

    <button class="remove">
        Remove
    </button>

</form>

</td>

</tr>

<%
}
%>

</table>

<div class="total-box">

    <div class="total">
        Grand Total : ₹<%= grandTotal %>
    </div>

<form action="PlaceOrderServlet" method="post">

    <button class="checkout">
        Place Order
    </button>

</form>
</div>

<%
}
%>

</div>

</body>
</html>