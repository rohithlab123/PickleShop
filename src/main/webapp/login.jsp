<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Login | SAMPURNA HOME FOODS</title>

<link rel="preconnect" href="https://fonts.googleapis.com">
<link href="https://fonts.googleapis.com/css2?family=Rozha+One&family=Mukta:wght@400;500;600;700&display=swap" rel="stylesheet">

<style>
:root {
  --cream: #FBF1DE;
  --maroon: #7A1F1F;
  --maroon-dark: #541313;
  --mustard: #D98E04;
  --mustard-light: #F4C95D;
  --ink: #2B1B12;
  --paper: #FFFDF8;
  --font-display: 'Rozha One', serif;
  --font-body: 'Mukta', sans-serif;
}

* { margin:0; padding:0; box-sizing:border-box; }

body {
  background: var(--cream);
  font-family: var(--font-body);
  min-height: 100vh;
  display: flex;
  flex-direction: column;
}

a { text-decoration:none; color:inherit; }

/* HEADER */
header {
  background: var(--maroon);
  padding: 16px 24px;
  display:flex;
  justify-content:space-between;
  align-items:center;
}

.logo {
  font-family: var(--font-display);
  font-size: 24px;
  color: var(--mustard-light);
}

.back-link {
  color:#F4E9D8;
  font-weight:600;
  font-size:14px;
}

/* CENTER BOX */
.auth-wrap {
  flex:1;
  display:flex;
  justify-content:center;
  align-items:center;
  padding:40px 20px;
}

.auth-card {
  background: var(--paper);
  width:100%;
  max-width:400px;
  padding:36px 32px;
  border-radius:16px;
  box-shadow:0 12px 30px rgba(0,0,0,0.1);
}

.auth-icon {
  width:56px;
  height:56px;
  border-radius:50%;
  background:var(--maroon);
  color:var(--mustard-light);
  display:flex;
  justify-content:center;
  align-items:center;
  margin:0 auto 15px;
  font-size:24px;
}

h1 {
  text-align:center;
  font-family:var(--font-display);
  color:var(--maroon);
}

.sub {
  text-align:center;
  font-size:13px;
  color:#7a6a5a;
  margin-bottom:20px;
}

/* INPUT */
.field-group { margin-bottom:15px; }

label {
  display:block;
  font-size:13px;
  margin-bottom:5px;
  color:#5c4b3b;
  font-weight:600;
}

input {
  width:100%;
  padding:11px;
  border:1px solid #e5d6b8;
  border-radius:8px;
  background:var(--cream);
}

input:focus {
  outline:none;
  border-color:var(--mustard);
}

/* BUTTON */
button {
  width:100%;
  padding:12px;
  background:var(--maroon);
  color:white;
  border:none;
  border-radius:8px;
  font-weight:bold;
  cursor:pointer;
}

button:hover {
  background:var(--maroon-dark);
}

/* LINKS */
.switch-line {
  text-align:center;
  margin-top:18px;
  font-size:13px;
}

.switch-line a {
  color:var(--maroon);
  font-weight:bold;
  text-decoration:underline;
}

/* ADMIN LINK */
.admin-link {
  text-align:center;
  margin-top:15px;
  font-size:14px;
}

.admin-link a {
  color:red;
  font-weight:bold;
}

/* ERROR */
.error-msg {
  background:#fbe5e5;
  color:#8b2a2a;
  padding:10px;
  border-radius:8px;
  margin-bottom:10px;
  font-size:13px;
}
</style>

</head>

<body>

<header>
  <a href="index.jsp" class="logo">🫙 SAMPURNA HOME FOODS</a>
  <a href="index.jsp" class="back-link">← Back</a>
</header>

<div class="auth-wrap">

  <div class="auth-card">

    <div class="auth-icon">🔑</div>

    <h1>Welcome Back</h1>
    <div class="sub">Login to place your order</div>

    <% if(request.getAttribute("error") != null) { %>
      <div class="error-msg">
        <%= request.getAttribute("error") %>
      </div>
    <% } %>

    <!-- USER LOGIN -->
    <form action="LoginServlet" method="post">

      <div class="field-group">
        <label>Email</label>
        <input type="email" name="email" placeholder="you@example.com" required>
      </div>

      <div class="field-group">
        <label>Password</label>
        <input type="password" name="password" required>
      </div>

      <button type="submit">Login</button>

    </form>

    <!-- REGISTER -->
    <div class="switch-line">
      New here? <a href="register.jsp">Create account</a>
    </div>
     <div class="switch-line">
     <a href="forgot-password.jsp">Forgot Password?</a>
    </div>

    <!-- ADMIN LOGIN -->
    <div class="admin-link">
      <a href="admin-login.jsp">🧑‍💼 Admin Login</a>
    </div>

  </div>

</div>

</body>
</html>