<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Verify OTP</title>

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

.error{
    color:red;
    margin-top:10px;
    font-size:14px;
}

.note{
    margin-top:10px;
    font-size:13px;
    color:gray;
}
</style>

</head>

<body>

<div class="box">

    <h2>🔐 Verify OTP</h2>

    <p class="note">Enter the OTP sent to your email</p>

    <% if("true".equals(request.getParameter("error"))) { %>
        <div class="error">❌ Invalid OTP. Try again.</div>
    <% } %>

    <% if("expired".equals(request.getParameter("error"))) { %>
        <div class="error">⏰ OTP expired. Please request again.</div>
    <% } %>

    <form action="VerifyOTPServlet" method="post">

        <input type="text"
               name="otp"
               placeholder="Enter 6-digit OTP"
               maxlength="6"
               required>

        <button type="submit">Verify OTP</button>

    </form>

</div>

</body>
</html>