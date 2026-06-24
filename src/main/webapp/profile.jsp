<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.sql.*, dao.DBConnection" %>

<%
Integer userId = (Integer) session.getAttribute("userId");

if(userId == null){
    response.sendRedirect("login.jsp");
    return;
}

String dbName = "";
String dbEmail = "";
String dbPhone = "";
String dbAddress = "";

try{

    DBConnection db = new DBConnection();
    Connection con = db.getconnection();

    String sql = "SELECT * FROM users WHERE id=?";

    PreparedStatement ps = con.prepareStatement(sql);
    ps.setInt(1, userId);

    ResultSet rs = ps.executeQuery();

    if(rs.next()){

        dbName = rs.getString("name");
        dbEmail = rs.getString("email");
        dbPhone = rs.getString("phone");
        dbAddress = rs.getString("address");
    }

}catch(Exception e){
    e.printStackTrace();
}

String updated = request.getParameter("updated");
String error = request.getParameter("error");
%>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<title>My Profile</title>

<link href="https://fonts.googleapis.com/css2?family=Rozha+One&family=Mukta:wght@400;500;700&display=swap" rel="stylesheet">

<style>

:root{
    --cream:#FBF1DE;
    --maroon:#7A1F1F;
    --maroon-dark:#541313;
    --mustard:#F4C95D;
    --paper:#FFFDF8;
}

*{
    margin:0;
    padding:0;
    box-sizing:border-box;
}

body{
    background:var(--cream);
    font-family:'Mukta',sans-serif;
}

/* HEADER */

.header{
    background:var(--maroon);
    padding:18px 30px;
    display:flex;
    justify-content:space-between;
    align-items:center;
}

.logo{
    color:var(--mustard);
    font-size:24px;
    font-family:'Rozha One',serif;
}

.back-btn{
    color:white;
    text-decoration:none;
    font-weight:bold;
}

/* MAIN */

.container{
    max-width:600px;
    margin:50px auto;
    padding:20px;
}

/* CARD */

.card{
    background:var(--paper);
    padding:35px;
    border-radius:18px;
    box-shadow:0 10px 25px rgba(0,0,0,0.1);
}

/* USER TOP */

.user-top{
    display:flex;
    align-items:center;
    gap:18px;
    margin-bottom:30px;
}

.avatar{
    width:75px;
    height:75px;
    border-radius:50%;
    background:var(--maroon);
    color:var(--mustard);
    display:flex;
    justify-content:center;
    align-items:center;
    font-size:30px;
    font-weight:bold;
}

.user-info h2{
    color:var(--maroon);
}

.user-info p{
    color:#777;
    font-size:14px;
}

/* FIELD */

.field{
    margin-bottom:22px;
}

.label{
    font-size:13px;
    font-weight:bold;
    color:#777;
    margin-bottom:5px;
    text-transform:uppercase;
}

.value{
    background:#f8f1e2;
    padding:12px;
    border-radius:10px;
    font-size:15px;
}

.note{
    margin-top:5px;
    color:#999;
    font-size:12px;
}

/* INPUT */

input,
textarea{
    width:100%;
    padding:12px;
    border:1px solid #ddd;
    border-radius:10px;
    font-size:14px;
    margin-top:5px;
}

input:focus,
textarea:focus{
    outline:none;
    border-color:var(--maroon);
}

/* BUTTON */

.btn{
    width:100%;
    padding:13px;
    border:none;
    border-radius:10px;
    background:var(--maroon);
    color:white;
    font-weight:bold;
    cursor:pointer;
    margin-top:10px;
}

.btn:hover{
    background:var(--maroon-dark);
}

.cancel-btn{
    background:#888;
}

.cancel-btn:hover{
    background:#666;
}

/* ALERT */

.alert{
    padding:12px;
    border-radius:10px;
    margin-bottom:20px;
    font-weight:bold;
}

.success{
    background:#dff5df;
    color:green;
}

.error{
    background:#ffe0e0;
    color:red;
}

/* LINKS */

.links{
    display:flex;
    gap:10px;
    margin-top:20px;
}

.links a{
    flex:1;
    text-align:center;
    padding:12px;
    border-radius:10px;
    background:#f3ead8;
    text-decoration:none;
    color:black;
    font-weight:bold;
}

.links a:hover{
    background:var(--mustard);
}

</style>

</head>

<body>

<div class="header">

    <div class="logo">
        🫙 SAMPURNA HOME FOODS
    </div>

    <a href="index.jsp" class="back-btn">
        ← Back
    </a>

</div>

<div class="container">

    <% if("true".equals(updated)){ %>

        <div class="alert success">
            ✅ Profile Updated Successfully
        </div>

    <% } %>

    <% if("true".equals(error)){ %>

        <div class="alert error">
            ❌ Something Went Wrong
        </div>

    <% } %>

    <div class="card">

        <!-- TOP -->

        <div class="user-top">

            <div class="avatar">
                <%= dbName.substring(0,1).toUpperCase() %>
            </div>

            <div class="user-info">
                <h2><%= dbName %></h2>
                <p><%= dbEmail %></p>
            </div>

        </div>

        <!-- VIEW MODE -->

        <div id="viewBox">

            <div class="field">
                <div class="label">Full Name</div>
                <div class="value"><%= dbName %></div>
            </div>

            <div class="field">
                <div class="label">Email Address</div>
                <div class="value"><%= dbEmail %></div>
                <div class="note">Email cannot be changed</div>
            </div>

            <div class="field">
                <div class="label">Phone Number</div>
                <div class="value"><%= dbPhone %></div>
            </div>

            <div class="field">
                <div class="label">Delivery Address</div>
                <div class="value"><%= dbAddress %></div>
            </div>

            <button class="btn" onclick="openEdit()">
                Edit Profile
            </button>

        </div>

        <!-- EDIT MODE -->

        <div id="editBox" style="display:none;">

            <form action="UpdateProfileServlet" method="post">

                <div class="field">

                    <div class="label">Full Name</div>

                    <input type="text"
                           name="name"
                           value="<%= dbName %>"
                           required>

                </div>

                <div class="field">

                    <div class="label">Email Address</div>

                    <input type="email"
                           value="<%= dbEmail %>"
                           readonly>

                    <div class="note">
                        Email cannot be changed
                    </div>

                </div>

                <div class="field">

                    <div class="label">Phone Number</div>

                    <input type="text"
                           name="phone"
                           value="<%= dbPhone %>"
                           required>

                </div>

                <div class="field">

                    <div class="label">Delivery Address</div>

                    <textarea name="address"
                              rows="3"
                              required><%= dbAddress %></textarea>

                </div>

                <button type="submit" class="btn">
                    Update Profile
                </button>

                <button type="button"
                        class="btn cancel-btn"
                        onclick="closeEdit()">
                    Cancel
                </button>

            </form>

        </div>

        <div class="links">

            <a href="my-orders.jsp">
                📦 My Orders
            </a>

            <a href="LogoutServlet">
                🚪 Logout
            </a>

        </div>

    </div>

</div>

<script>

function openEdit(){

    document.getElementById("viewBox").style.display = "none";
    document.getElementById("editBox").style.display = "block";
}

function closeEdit(){

    document.getElementById("viewBox").style.display = "block";
    document.getElementById("editBox").style.display = "none";
}

</script>

</body>
</html>