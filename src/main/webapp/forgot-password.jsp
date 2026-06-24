<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<title>Forgot Password</title>

<style>
    body{
        font-family: Arial, sans-serif;
        background: #FBF1DE;
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
    }

    .box{
        background: white;
        padding: 40px;
        border-radius: 15px;
        box-shadow: 0 10px 25px rgba(0,0,0,0.2);
        width: 350px;
        text-align: center;
    }

    h2{
        color: #7A1F1F;
        margin-bottom: 20px;
    }

    input{
        width: 100%;
        padding: 12px;
        margin: 10px 0;
        border: 1px solid #ccc;
        border-radius: 8px;
        font-size: 14px;
    }

    button{
        width: 100%;
        padding: 12px;
        background: #7A1F1F;
        color: white;
        border: none;
        border-radius: 8px;
        font-size: 16px;
        cursor: pointer;
        transition: 0.3s;
    }

    button:hover{
        background: #541313;
    }

    .msg{
        color: red;
        margin-top: 10px;
    }
</style>

</head>
<body>

<div class="box">

<h2>Forgot Password</h2>

<form action="SendOTPServlet" method="post">

    Enter Email:
    <input type="email" name="email" required>

    <button type="submit">Send OTP</button>

</form>

</div>

</body>
</html>