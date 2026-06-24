<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Login | SAMPURNA HOME FOODS</title>

<link href="https://fonts.googleapis.com/css2?family=Rozha+One&family=Mukta:wght@400;500;600&display=swap" rel="stylesheet">

<style>

:root {
    --cream: #FBF1DE;
    --maroon: #7A1F1F;
    --maroon-dark: #541313;
    --paper: #FFFDF8;
    --mustard: #F4C95D;
    --font1: 'Rozha One', serif;
    --font2: 'Mukta', sans-serif;
}

body {
    margin: 0;
    font-family: var(--font2);
    background: var(--cream);
}

/* HEADER */
.header {
    background: var(--maroon);
    padding: 18px;
    text-align: center;
    font-family: var(--font1);
    font-size: 24px;
    color: var(--mustard);
}

/* CENTER BOX */
.container {
    display: flex;
    justify-content: center;
    align-items: center;
    height: 80vh;
}

/* LOGIN CARD */
.card {
    background: var(--paper);
    width: 380px;
    padding: 35px;
    border-radius: 16px;
    box-shadow: 0 10px 25px rgba(0,0,0,0.15);
    border-top: 6px solid var(--maroon);
}

/* TITLE */
.card h2 {
    text-align: center;
    color: var(--maroon);
    margin-bottom: 5px;
    font-family: var(--font1);
}

.card p {
    text-align: center;
    font-size: 13px;
    color: #777;
    margin-bottom: 20px;
}

/* INPUT */
input {
    width: 100%;
    padding: 12px;
    margin: 10px 0;
    border: 1px solid #ddd;
    border-radius: 8px;
    font-size: 14px;
}

input:focus {
    outline: none;
    border-color: var(--maroon);
}

/* BUTTON */
button {
    width: 100%;
    padding: 12px;
    margin-top: 10px;
    background: var(--maroon);
    color: white;
    border: none;
    border-radius: 8px;
    font-weight: bold;
    cursor: pointer;
    font-size: 15px;
}

button:hover {
    background: var(--maroon-dark);
}

/* SMALL NOTE */
.note {
    text-align: center;
    margin-top: 15px;
    font-size: 12px;
    color: #666;
}

</style>

</head>

<body>

<div class="header">
    🧑‍💼 Admin Panel Login
</div>

<div class="container">

    <div class="card">

        <h2>Welcome Admin</h2>
        <p>Login to manage orders & customers</p>

        <form action="AdminLoginServlet" method="post">

            <input type="email" name="email" placeholder="Admin Email" required>

            <input type="password" name="password" placeholder="Password" required>

            <button type="submit">Login</button>

        </form>

        <div class="note">
            Only authorized admin allowed
        </div>

    </div>

</div>

</body>
</html>