<%@ page import="java.util.*, dao.OrderDAO, model.Order" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
OrderDAO dao = new OrderDAO();
int totalOrders = dao.getTotalOrders();
double revenue = dao.getTotalRevenue();
List<Order> orders = dao.getAllOrders();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Dashboard</title>
<link href="https://fonts.googleapis.com/css2?family=Rozha+One&family=Mukta:wght@400;500;600;700&display=swap" rel="stylesheet">
<style>

:root {
  --cream: #FBF1DE;
  --maroon: #7A1F1F;
  --maroon-dark: #541313;
  --mustard: #D98E04;
  --mustard-light: #F4C95D;
  --green: #4B6043;
  --ink: #2B1B12;
  --paper: #FFFDF8;
  --gold-line: #C9A24B;
  --font-display: 'Rozha One', serif;
  --font-body: 'Mukta', sans-serif;
}

* { margin:0; padding:0; box-sizing:border-box; }

body {
  font-family: var(--font-body);
  background: var(--cream);
}

/* ===== HEADER ===== */
.header {
  background: var(--maroon);
  color: white;
  padding: 16px 28px;
  font-size: 22px;
  font-family: var(--font-display);
  color: var(--mustard-light);
  display: flex;
  justify-content: space-between;
  align-items: center;
  flex-wrap: wrap;
  gap: 10px;
  box-shadow: 0 2px 10px rgba(0,0,0,0.2);
  position: sticky;
  top: 0;
  z-index: 100;
}

/* ===== TOP ACTIONS ===== */
.top-actions {
  display: flex;
  gap: 10px;
}

.review-btn {
  background: rgba(255,255,255,0.12);
  color: var(--mustard-light);
  padding: 8px 18px;
  border-radius: 20px;
  text-decoration: none;
  font-size: 14px;
  font-weight: 700;
  border: 1.5px solid rgba(244,201,93,0.4);
  font-family: var(--font-body);
  transition: background 0.2s;
}

.review-btn:hover {
  background: rgba(255,255,255,0.22);
}

/* ===== CONTAINER ===== */
.container {
  width: 95%;
  max-width: 1200px;
  margin: 30px auto;
}

/* ===== CARDS ===== */
.cards {
  display: flex;
  gap: 20px;
  margin-bottom: 26px;
  flex-wrap: wrap;
}

.card {
  flex: 1;
  min-width: 160px;
  background: var(--paper);
  padding: 22px 20px;
  border-radius: 14px;
  box-shadow: 0 2px 10px rgba(0,0,0,0.07);
  text-align: center;
  border: 1px solid #EFE2C8;
  position: relative;
  overflow: hidden;
}

.card::before {
  content: "";
  position: absolute;
  top: 0; left: 0; right: 0;
  height: 4px;
  background: var(--maroon);
}

.card:nth-child(2)::before {
  background: var(--mustard);
}

.card h3 {
  margin: 0 0 10px;
  color: #8a7560;
  font-size: 12px;
  text-transform: uppercase;
  letter-spacing: 0.6px;
  font-weight: 700;
}

.card p {
  font-size: 28px;
  font-weight: 700;
  margin: 0;
  font-family: var(--font-display);
  color: var(--maroon);
}

.card:nth-child(2) p {
  color: var(--mustard);
}

/* ===== SEARCH FORM ===== */
form {
  display: flex;
  gap: 10px;
  margin-bottom: 20px;
  flex-wrap: wrap;
}

form input[type="text"] {
  flex: 1;
  min-width: 200px;
  padding: 10px 16px;
  border: 1.5px solid #E5D6B8;
  border-radius: 9px;
  font-family: var(--font-body);
  font-size: 14px;
  background: var(--paper);
  color: var(--ink);
}

form input[type="text"]:focus {
  outline: none;
  border-color: var(--mustard);
  box-shadow: 0 0 0 3px rgba(217,142,4,0.12);
}

form button {
  padding: 10px 22px;
  background: var(--maroon);
  color: var(--mustard-light);
  border: none;
  border-radius: 9px;
  font-weight: 700;
  cursor: pointer;
  font-family: var(--font-body);
  font-size: 14px;
  transition: background 0.2s;
}

form button:hover {
  background: var(--maroon-dark);
}

/* ===== TABLE ===== */
table {
  width: 100%;
  border-collapse: collapse;
  background: var(--paper);
  border-radius: 14px;
  overflow: hidden;
  box-shadow: 0 2px 10px rgba(0,0,0,0.07);
  border: 1px solid #EFE2C8;
}

th, td {
  padding: 13px 14px;
  border-bottom: 1px solid #F0E6D0;
  text-align: center;
  font-size: 14px;
}

th {
  background: var(--maroon);
  color: var(--mustard-light);
  font-size: 13px;
  font-weight: 700;
  letter-spacing: 0.3px;
  border-bottom: none;
}

tr:last-child td {
  border-bottom: none;
}

tr:hover td {
  background: #FDF6E8;
}

/* ===== STATUS BADGES ===== */
.status {
  padding: 5px 12px;
  border-radius: 20px;
  font-weight: 700;
  font-size: 12px;
  display: inline-block;
  letter-spacing: 0.3px;
}

.PLACED    { background: #FEF3C7; color: #92400E; }
.CONFIRMED { background: #DBEAFE; color: #1E40AF; }
.SHIPPED   { background: #E0F2FE; color: #0369A1; }
.DELIVERED { background: #D1FAE5; color: #065F46; }
.CANCELLED { background: #FEE2E2; color: #991B1B; }

/* ===== ACTION LINKS ===== */
a.action {
  margin: 2px;
  padding: 5px 10px;
  text-decoration: none;
  border-radius: 6px;
  font-size: 12px;
  font-weight: 700;
  color: white;
  display: inline-block;
  transition: opacity 0.2s;
}

a.action:hover { opacity: 0.82; }

.confirm  { background: #2563EB; }
.ship     { background: #0891B2; }
.deliver  { background: var(--green); }
.cancel   { background: #DC2626; }

/* ===== VIEW BUTTON ===== */
.view-btn {
  display: inline-block;
  padding: 6px 12px;
  background: var(--maroon);
  color: #fff;
  text-decoration: none;
  border-radius: 7px;
  font-size: 12px;
  font-weight: 700;
  transition: background 0.2s, transform 0.2s;
  margin: 2px;
}

.view-btn:hover {
  background: var(--maroon-dark);
  transform: scale(1.04);
}

/* ===== RESPONSIVE ===== */
@media (max-width: 640px) {
  .cards { flex-direction: column; }
  th, td { padding: 10px 8px; font-size: 12px; }
  .header { font-size: 18px; }
}

</style>
</head>

<body>

<div class="header">
    <div>🧑‍💼 Admin Dashboard - All Orders</div>
    <div class="top-actions">
        <a href="admin-reviews.jsp" class="review-btn">⭐ Manage Reviews</a>
    </div>
</div>

<div class="container">

<div class="cards">
    <div class="card">
        <h3>Total Orders</h3>
        <p><%= totalOrders %></p>
    </div>
    <div class="card">
        <h3>Total Revenue</h3>
        <p>₹<%= revenue %></p>
    </div>
</div>

<form method="get">
    <input type="text" name="search" placeholder="Search Order ID or User ID">
    <button type="submit">Search</button>
</form>

<table>

<tr>
    <th>Order ID</th>
    <th>Customer</th>
    <th>Total</th>
    <th>Status</th>
    <th>Date</th>
    <th>Action</th>
</tr>

<%
for(Order o : orders){
    String status = o.getStatus();
    if(status == null) status = "";
%>

<tr>

    <td>#<%= o.getId() %></td>

    <td>
        <b><%= o.getUserName() %></b><br>
        <small style="color:gray;">ID: <%= o.getUserId() %></small>
    </td>

    <td>₹<%= o.getTotalPrice() %></td>

    <td>
        <span class="status <%= status %>">
            <%= status %>
        </span>
    </td>

    <td><%= o.getOrderDate() %></td>

    <td>

    <% if(!"DELIVERED".equals(status) && !"CANCELLED".equals(status)) { %>

        <a class="action confirm"
           href="UpdateOrderStatusServlet?orderId=<%= o.getId() %>&status=CONFIRMED">
           Confirm
        </a>

        <a class="action ship"
           href="UpdateOrderStatusServlet?orderId=<%= o.getId() %>&status=SHIPPED">
           Ship
        </a>

        <a class="action deliver"
           href="UpdateOrderStatusServlet?orderId=<%= o.getId() %>&status=DELIVERED">
           Deliver
        </a>

        <a class="action cancel"
           href="UpdateOrderStatusServlet?orderId=<%= o.getId() %>&status=CANCELLED"
           onclick="return confirm('Cancel this order?')">
           Cancel
        </a>

        <a class="view-btn"
           href="admin-order-details.jsp?orderId=<%= o.getId() %>">
           Open Order
        </a>

        <a class="view-btn"
           href="admin-order-full-details.jsp?orderId=<%= o.getId() %>">
           📦 View Details
        </a>

    <% } else { %>
        <b style="color:#065F46;">✓ Completed</b>
    <% } %>

    </td>

</tr>

<%
}
%>

</table>

</div>

</body>
</html>