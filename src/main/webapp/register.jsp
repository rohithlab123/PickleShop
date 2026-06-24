<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Register | SAMPURNA HOME FOODS</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
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
    background: var(--cream);
    font-family: var(--font-body);
    color: var(--ink);
    min-height: 100vh;
    display: flex;
    flex-direction: column;
  }
  a { text-decoration: none; color: inherit; }

  header {
    background: var(--maroon);
    padding: 16px 24px;
    display: flex;
    justify-content: space-between;
    align-items: center;
  }

  .logo {
    font-family: var(--font-display);
    font-size: 24px;
    color: var(--mustard-light);
  }

  header a.back-link {
    color: #F4E9D8;
    font-weight: 600;
    font-size: 14px;
  }

  .auth-wrap {
    flex: 1;
    display: flex;
    align-items: center;
    justify-content: center;
    padding: 50px 20px;
  }

  .auth-card {
    background: var(--paper);
    border: 1px solid #EFE2C8;
    border-radius: 16px;
    box-shadow: 0 12px 30px rgba(122,31,31,0.10);
    width: 100%;
    max-width: 440px;
    padding: 36px 32px;
    position: relative;
    overflow: hidden;
  }

  .auth-card::before {
    content: "";
    position: absolute;
    top: 0; left: 0; right: 0;
    height: 5px;
    background: linear-gradient(90deg, var(--maroon), var(--mustard), var(--green));
  }

  .auth-icon {
    width: 56px;
    height: 56px;
    border-radius: 50%;
    background: var(--mustard);
    color: var(--maroon-dark);
    font-size: 24px;
    display: flex;
    align-items: center;
    justify-content: center;
    margin: 0 auto 18px;
  }

  .auth-card h1 {
    font-family: var(--font-display);
    font-size: 26px;
    color: var(--maroon);
    text-align: center;
    margin-bottom: 6px;
  }

  .auth-card .sub {
    text-align: center;
    font-size: 13.5px;
    color: #8a7560;
    margin-bottom: 26px;
  }

  .field-row {
    display: flex;
    gap: 12px;
  }

  .field-row .field-group { flex: 1; }

  .field-group { margin-bottom: 16px; }

  .field-group label {
    display: block;
    font-size: 13px;
    font-weight: 600;
    color: #6b5840;
    margin-bottom: 6px;
  }

  .field-group input,
  .field-group textarea {
    width: 100%;
    padding: 11px 14px;
    border: 1.5px solid #E5D6B8;
    border-radius: 9px;
    font-family: var(--font-body);
    font-size: 14.5px;
    color: var(--ink);
    background: var(--cream);
    transition: border-color 0.2s, box-shadow 0.2s;
    resize: none;
  }

  .field-group input:focus,
  .field-group textarea:focus {
    outline: none;
    border-color: var(--mustard);
    box-shadow: 0 0 0 3px rgba(217,142,4,0.15);
  }

  .submit-btn {
    width: 100%;
    padding: 13px;
    margin-top: 6px;
    border: none;
    border-radius: 10px;
    background: var(--maroon);
    color: var(--mustard-light);
    font-weight: 700;
    font-size: 15px;
    cursor: pointer;
    transition: background 0.2s;
  }

  .submit-btn:hover { background: var(--maroon-dark); }

  .switch-line {
    text-align: center;
    margin-top: 20px;
    font-size: 13.5px;
    color: #6b5840;
  }

  .switch-line a {
    color: var(--maroon);
    font-weight: 700;
    text-decoration: underline;
  }

  .error-msg {
    background: #FBE5E5;
    border: 1px solid #E3A7A7;
    color: #8B2A2A;
    font-size: 13.5px;
    padding: 10px 14px;
    border-radius: 8px;
    margin-bottom: 18px;
  }

  @media (max-width: 460px) {
    .field-row { flex-direction: column; gap: 0; }
  }
</style>
</head>
<body>

<header>
  <a href="index.jsp" class="logo">🫙 SAMPURNA HOME FOODS</a>
  <a href="index.jsp" class="back-link">&larr; Back to Home</a>
</header>

<div class="auth-wrap">
  <div class="auth-card">
    <div class="auth-icon">🫙</div>
    <h1>Create Account</h1>
    <div class="sub">Just a few details to get your orders delivered</div>

    <%-- This error block will be used once the backend is wired up --%>
    <% if (request.getAttribute("error") != null) { %>
      <div class="error-msg"><%= request.getAttribute("error") %></div>
    <% } %>

    <form action="register" method="post">
      <div class="field-group">
        <label for="name">Full Name</label>
        <input type="text" id="name" name="name" placeholder="Your full name" required>
      </div>

      <div class="field-row">
        <div class="field-group">
          <label for="email">Email</label>
          <input type="email" id="email" name="email" placeholder="you@example.com" required>
        </div>
        <div class="field-group">
          <label for="phone">Phone Number</label>
          <input type="tel" id="phone" name="phone" placeholder="10-digit number" required>
        </div>
      </div>

      <div class="field-group">
        <label for="password">Password</label>
        <input type="password" id="password" name="password" placeholder="Create a password" required>
      </div>

      <div class="field-group">
        <label for="address">Delivery Address</label>
        <textarea id="address" name="address" rows="3" placeholder="House no, street, area, city, pincode" required></textarea>
      </div>

      <button type="submit" class="submit-btn">Create Account</button>
    </form>

    <div class="switch-line">
      Already have an account? <a href="login.jsp">Login here</a>
    </div>
  </div>
</div>

</body>
</html>
