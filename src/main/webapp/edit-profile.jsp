<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.sql.*, dao.DBConnection" %>

<%
Integer userId = (Integer) session.getAttribute("userId");

if(userId == null){
    response.sendRedirect("login.jsp");
    return;
}

String name = "";
String email = "";
String phone = "";
String address = "";

try{

    DBConnection db = new DBConnection();
    Connection con = db.getconnection();

    String sql = "SELECT * FROM users WHERE id=?";

    PreparedStatement ps = con.prepareStatement(sql);

    ps.setInt(1, userId);

    ResultSet rs = ps.executeQuery();

    if(rs.next()){

        name = rs.getString("name");
        email = rs.getString("email");
        phone = rs.getString("phone");
        address = rs.getString("address");
    }

}catch(Exception e){
    e.printStackTrace();
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Edit Profile</title>

<style>

body{
    margin:0;
    font-family:Arial;
    background:#FBF1DE;
}

/* HEADER */
.header{
    background:#7A1F1F;
    color:white;
    padding:18px;
    text-align:center;
    font-size:24px;
    font-weight:bold;
}

/* CONTAINER */
.container{
    width:90%;
    max-width:500px;
    margin:40px auto;
}

/* CARD */
.card{
    background:white;
    padding:30px;
    border-radius:15px;
    box-shadow:0 5px 15px rgba(0,0,0,0.1);
}

/* INPUT GROUP */
.input-group{
    margin-bottom:18px;
}

.input-group label{
    display:block;
    margin-bottom:6px;
    font-weight:bold;
    color:#7A1F1F;
}

.input-group input,
.input-group textarea{
    width:100%;
    padding:12px;
    border:1px solid #ddd;
    border-radius:8px;
    font-size:15px;
}

textarea{
    resize:none;
    height:90px;
}

/* BUTTON */
.btn{
    width:100%;
    padding:14px;
    border:none;
    background:#7A1F1F;
    color:white;
    font-size:16px;
    border-radius:10px;
    cursor:pointer;
    font-weight:bold;
}

.btn:hover{
    background:#541313;
}

</style>

</head>

<body>

<div class="header">
    ✏️ Edit Profile
</div>

<div class="container">

<div class="card">

<form action="UpdateProfileServlet" method="post">

    <div class="input-group">
        <label>Name</label>
        <input type="text" name="name"
               value="<%= name %>" required>
    </div>

    <div class="input-group">
        <label>Email</label>
        <input type="email" name="email"
               value="<%= email %>" readonly>
    </div>

    <div class="input-group">
        <label>Phone</label>
        <input type="text" name="phone"
               value="<%= phone %>" required>
    </div>

    <div class="input-group">
        <label>Address</label>
        <textarea name="address" required><%= address %></textarea>
    </div>

    <button type="submit" class="btn">
        Update Profile
    </button>

</form>

</div>
</div>

</body>
</html>