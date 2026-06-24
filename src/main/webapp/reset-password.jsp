<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>

<%
    String email = (String) session.getAttribute("resetEmail");

    if(email == null){
        response.sendRedirect("forgot-password.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Reset Password</title>

<style>
body{
    font-family: Arial;
    background:#FBF1DE;
    display:flex;
    justify-content:center;
    align-items:center;
    height:100vh;
}

.box{
    background:white;
    padding:40px;
    border-radius:15px;
    width:350px;
    text-align:center;
    box-shadow:0 10px 20px rgba(0,0,0,0.1);
}

h2{
    color:#7A1F1F;
}

input{
    width:100%;
    padding:12px;
    margin-top:15px;
    border:1px solid #ccc;
    border-radius:8px;
    font-size:16px;
}

button{
    margin-top:20px;
    width:100%;
    padding:12px;
    background:#7A1F1F;
    color:white;
    border:none;
    border-radius:8px;
    font-size:16px;
    cursor:pointer;
}

button:hover{
    background:#541313;
}

.note{
    font-size:13px;
    color:gray;
    margin-top:10px;
}
</style>

</head>

<body>

<div class="box">

    <h2>🔒 Reset Password</h2>

    <p class="note">Enter new password for <b><%= email %></b></p>

    <form action="ResetPasswordServlet" method="post">

        <input type="password"
               name="newPassword"
               placeholder="New Password"
               required>

        <input type="password"
               name="confirmPassword"
               placeholder="Confirm Password"
               required>

        <button type="submit">Update Password</button>

    </form>

</div>

</body>
</html>