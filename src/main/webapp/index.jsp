<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dao.CartDAO" %>
<%
  Integer sessionUserId = (Integer) session.getAttribute("userId");
  int cartTotalQty = 0;
  if (sessionUserId != null) {
    CartDAO cartDao = new CartDAO();
    cartTotalQty = cartDao.getTotalQuantity(sessionUserId);
  }
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>SAMPURNA | Homemade Pickles, Sweets &amp; Mixtures</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link href="https://fonts.googleapis.com/css2?family=Rozha+One&family=Mukta:wght@400;500;600;700&display=swap" rel="stylesheet">
<style>

  /* ===========================================================
     DESIGN TOKENS
     Theme: a homemade Andhra pickle-jar / spice-label aesthetic.
     =========================================================== */
  :root {
    --cream:        #FBF1DE;   /* page background, like aged paper */
    --maroon:       #7A1F1F;   /* pickle red — primary */
    --maroon-dark:  #541313;
    --mustard:      #D98E04;   /* turmeric/mustard accent */
    --mustard-light:#F4C95D;
    --green:        #4B6043;   /* curry leaf green */
    --ink:          #2B1B12;   /* near-black brown for text */
    --paper:        #FFFDF8;   /* card background */
    --gold-line:    #C9A24B;

    --font-display: 'Rozha One', serif;
    --font-body:    'Mukta', sans-serif;
  }

  * { margin:0; padding:0; box-sizing:border-box; }

  body {
    background: var(--cream);
    color: var(--ink);
    font-family: var(--font-body);
    -webkit-font-smoothing: antialiased;
  }

  a { text-decoration:none; color:inherit; }

  /* ===========================================================
     HEADER
     =========================================================== */
  header {
    position: sticky;
    top: 0;
    z-index: 200;
    background: var(--maroon);
    box-shadow: 0 2px 10px rgba(0,0,0,0.18);
  }

  .header-inner {
    max-width: 1180px;
    margin: 0 auto;
    padding: 14px 24px;
    display: flex;
    align-items: center;
    justify-content: space-between;
  }

  .logo {
    display: flex;
    align-items: center;
    gap: 10px;
    font-family: var(--font-display);
    font-size: 26px;
    color: var(--mustard-light);
    letter-spacing: 0.5px;
  }

  .logo-img{
    width:50px;
    height:50px;
    object-fit:contain;
  }

  .logo .jar-icon {
    width: 34px;
    height: 34px;
    border-radius: 50%;
    background: var(--mustard);
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 18px;
  }

  nav ul {
    display: flex;
    align-items: center;
    list-style: none;
    gap: 28px;
  }

  nav ul li a {
    color: #F4E9D8;
    font-weight: 600;
    font-size: 15px;
    letter-spacing: 0.3px;
    padding: 6px 2px;
    border-bottom: 2px solid transparent;
    transition: border-color 0.2s, color 0.2s;
  }

  nav ul li a:hover {
    color: var(--mustard-light);
    border-bottom-color: var(--mustard-light);
  }

  .cart-link {
    display: flex;
    align-items: center;
    gap: 6px;
    position: relative;
  }

  .cart-count {
    background: var(--mustard-light);
    color: var(--maroon-dark);
    font-size: 12px;
    font-weight: 700;
    border-radius: 50%;
    min-width: 19px;
    height: 19px;
    display: flex;
    align-items: center;
    justify-content: center;
    padding: 0 2px;
  }

  .btn-outline {
    border: 1.5px solid var(--mustard-light);
    border-radius: 20px;
    padding: 6px 16px !important;
  }

  /* ===========================================================
     TOP UTILITY BAR — phone number, always visible above header
     =========================================================== */
  .topbar {
    background: var(--maroon-dark);
    color: #E9D9C0;
    text-align: center;
    font-size: 13px;
    font-weight: 500;
    padding: 6px 16px;
    letter-spacing: 0.2px;
  }

  .topbar a {
    color: var(--mustard-light);
    font-weight: 700;
  }

  /* ===========================================================
     SEARCH BOX (in header)
     =========================================================== */
  .search-box {
    flex: 1;
    max-width: 360px;
    display: flex;
    align-items: center;
    background: rgba(255,255,255,0.12);
    border: 1px solid rgba(244,201,93,0.4);
    border-radius: 22px;
    padding: 7px 14px;
    margin: 0 24px;
  }

  .search-box input {
    flex: 1;
    border: none;
    background: transparent;
    outline: none;
    color: #FBF1DE;
    font-family: var(--font-body);
    font-size: 14px;
  }

  .search-box input::placeholder { color: #d8c5ac; }

  .search-box .search-icon { font-size: 14px; opacity: 0.85; }

  .no-results {
    text-align: center;
    padding: 30px 16px;
    color: #8a7560;
    font-size: 15px;
    display: none;
  }

  /* ===========================================================
     FLOATING CALL BUTTON
     =========================================================== */
  .float-call {
    position: fixed;
    bottom: 22px;
    right: 22px;
    width: 56px;
    height: 56px;
    border-radius: 50%;
    background: var(--green);
    color: #fff;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 24px;
    box-shadow: 0 6px 18px rgba(0,0,0,0.3);
    z-index: 300;
    animation: pulse-call 2.2s infinite;
  }

  @keyframes pulse-call {
    0%   { box-shadow: 0 0 0 0 rgba(75,96,67,0.55), 0 6px 18px rgba(0,0,0,0.3); }
    70%  { box-shadow: 0 0 0 14px rgba(75,96,67,0), 0 6px 18px rgba(0,0,0,0.3); }
    100% { box-shadow: 0 0 0 0 rgba(75,96,67,0), 0 6px 18px rgba(0,0,0,0.3); }
  }

  /* ===========================================================
     HERO
     =========================================================== */
  .hero {
    position: relative;
    background: linear-gradient(180deg, var(--maroon) 0%, var(--maroon-dark) 100%);
    color: var(--cream);
    padding: 70px 24px 90px;
    text-align: center;
    overflow: hidden;
    isolation: isolate;
  }

  .hero-slide {
    position: absolute;
    inset: 0;
    background-size: cover;
    background-position: center;
    opacity: 0;
    transition: opacity 1.6s ease;
    z-index: -2;
  }

  .hero-slide.active { opacity: 1; }

  .hero-overlay {
    position: absolute;
    inset: 0;
    background: linear-gradient(180deg, rgba(58,15,15,0.72) 0%, rgba(40,10,10,0.82) 100%);
    z-index: -1;
  }

  .hero::after {
    content: "";
    position: absolute;
    bottom: -1px;
    left: 0;
    width: 100%;
    height: 26px;
    background:
      radial-gradient(circle at 13px 0, transparent 13px, var(--cream) 13.5px) repeat-x;
    background-size: 26px 26px;
  }

  .hero-badge {
    display: inline-block;
    background: var(--mustard);
    color: var(--maroon-dark);
    font-weight: 700;
    font-size: 13px;
    letter-spacing: 1.5px;
    text-transform: uppercase;
    padding: 7px 18px;
    border-radius: 30px;
    transform: rotate(-3deg);
    margin-bottom: 22px;
  }

  .hero h1 {
    font-family: var(--font-display);
    font-size: clamp(34px, 5vw, 56px);
    line-height: 1.15;
    max-width: 760px;
    margin: 0 auto 18px;
  }

  .hero h1 span {
    color: var(--mustard-light);
  }

  .hero p {
    max-width: 540px;
    margin: 0 auto 30px;
    font-size: 17px;
    color: #E9D9C0;
    line-height: 1.6;
  }

  .hero-cta {
    display: inline-block;
    background: var(--mustard-light);
    color: var(--maroon-dark);
    font-weight: 700;
    font-size: 15px;
    padding: 13px 30px;
    border-radius: 30px;
    transition: transform 0.2s, box-shadow 0.2s;
  }

  .hero-cta:hover {
    transform: translateY(-2px);
    box-shadow: 0 8px 18px rgba(0,0,0,0.25);
  }

  /* ===========================================================
     CATEGORY SECTIONS
     =========================================================== */
  .category-section {
    max-width: 1180px;
    margin: 0 auto;
    padding: 56px 24px 10px;
  }

  .category-head {
    display: flex;
    align-items: center;
    gap: 16px;
    margin-bottom: 26px;
  }

  .seal {
    width: 56px;
    height: 56px;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 26px;
    flex-shrink: 0;
    box-shadow: 0 3px 0 rgba(0,0,0,0.15);
  }

  .seal.pickles   { background: var(--maroon); }
  .seal.sweets    { background: var(--mustard); }
  .seal.mixtures  { background: var(--green); }

  .category-head h2 {
    font-family: var(--font-display);
    font-size: 28px;
    color: var(--ink);
  }

  .category-head .sub {
    font-size: 13px;
    color: #8a7560;
    font-weight: 500;
    letter-spacing: 0.3px;
  }

  /* ===========================================================
     PRODUCT ROW — Swiggy/Zomato style horizontal scroll
     =========================================================== */
  .product-row {
    display: flex;
    gap: 18px;
    overflow-x: auto;
    scroll-snap-type: x mandatory;
    padding: 6px 4px 18px;
  }

  .product-row::-webkit-scrollbar { height: 7px; }
  .product-row::-webkit-scrollbar-track { background: transparent; }
  .product-row::-webkit-scrollbar-thumb {
    background: var(--gold-line);
    border-radius: 10px;
  }

  .product-card {
    flex: 0 0 auto;
    width: 190px;
    background: var(--paper);
    border: 1px solid #EFE2C8;
    border-radius: 14px;
    scroll-snap-align: start;
    overflow: hidden;
    transition: transform 0.22s ease, box-shadow 0.22s ease;
  }

  .product-card:hover {
    transform: translateY(-6px);
    box-shadow: 0 14px 26px rgba(122,31,31,0.16);
  }

  .card-cap {
    height: 100px;
    position: relative;
    overflow: hidden;
    cursor: pointer;
  }

  .card-cap img {
    width: 100%;
    height: 100%;
    object-fit: cover;
    display: block;
  }

  .card-cap .cap-fallback {
    display: none;
    position: absolute;
    inset: 0;
    align-items: center;
    justify-content: center;
    font-size: 38px;
  }

  .pickles   .card-cap .cap-fallback { background: linear-gradient(135deg, #9B3030, var(--maroon)); }
  .sweets    .card-cap .cap-fallback { background: linear-gradient(135deg, var(--mustard-light), var(--mustard)); }
  .mixtures  .card-cap .cap-fallback { background: linear-gradient(135deg, #6E8763, var(--green)); }

  .card-cap .view-hint {
    position: absolute;
    inset: 0;
    background: rgba(20,8,8,0.5);
    color: #fff;
    font-size: 12px;
    font-weight: 700;
    display: flex;
    align-items: center;
    justify-content: center;
    opacity: 0;
    transition: opacity 0.2s;
  }

  .card-cap:hover .view-hint { opacity: 1; }

  .card-body {
    padding: 12px 14px 14px;
  }

  .card-body h4 {
    font-size: 14.5px;
    font-weight: 600;
    margin-bottom: 8px;
    min-height: 36px;
    line-height: 1.25;
  }

  .price-tag {
    display: inline-block;
    background: var(--cream);
    border: 1px solid var(--gold-line);
    color: var(--maroon-dark);
    font-weight: 700;
    font-size: 13px;
    padding: 3px 10px;
    border-radius: 6px;
    margin-bottom: 10px;
  }

  .add-btn {
    width: 100%;
    padding: 9px;
    border: none;
    border-radius: 8px;
    background: var(--maroon);
    color: var(--mustard-light);
    font-weight: 700;
    font-size: 13.5px;
    letter-spacing: 0.3px;
    cursor: pointer;
    transition: background 0.2s, color 0.2s;
  }

  .add-btn:hover { background: var(--maroon-dark); }

  .add-btn.added {
    background: var(--green);
    color: #fff;
  }

  /* ===========================================================
     PRODUCT DETAIL MODAL
     =========================================================== */
  .modal-overlay {
    display: none;
    position: fixed;
    inset: 0;
    background: rgba(20,8,8,0.65);
    z-index: 500;
    align-items: center;
    justify-content: center;
    padding: 20px;
  }

  .modal-overlay.open { display: flex; }

  .modal-box {
    background: var(--paper);
    border-radius: 16px;
    max-width: 480px;
    width: 100%;
    max-height: 88vh;
    overflow-y: auto;
    position: relative;
    box-shadow: 0 20px 50px rgba(0,0,0,0.35);
  }

  .modal-close {
    position: absolute;
    top: 12px;
    right: 12px;
    width: 32px;
    height: 32px;
    background: rgba(0,0,0,0.5);
    color: #fff;
    border: none;
    border-radius: 50%;
    font-size: 16px;
    cursor: pointer;
    z-index: 2;
  }

  .modal-img-wrap {
    height: 220px;
    position: relative;
    overflow: hidden;
  }

  .modal-img-wrap img {
    width: 100%;
    height: 100%;
    object-fit: cover;
    display: block;
  }

  .modal-img-wrap .modal-fallback {
    display: none;
    position: absolute;
    inset: 0;
    align-items: center;
    justify-content: center;
    font-size: 60px;
    background: linear-gradient(135deg, var(--mustard-light), var(--maroon));
  }

  .modal-body { padding: 22px 24px 26px; }

  .modal-body h3 {
    font-family: var(--font-display);
    font-size: 23px;
    color: var(--maroon);
    margin-bottom: 4px;
  }

  .modal-body .modal-price {
    color: var(--mustard);
    font-weight: 700;
    margin-bottom: 16px;
    font-size: 15px;
  }

  .modal-section { margin-bottom: 14px; }

  .modal-section h4 {
    font-size: 12.5px;
    text-transform: uppercase;
    letter-spacing: 0.5px;
    color: var(--green);
    font-weight: 700;
    margin-bottom: 4px;
  }

  .modal-section p {
    font-size: 14px;
    line-height: 1.55;
    color: #4a3a28;
  }

  .modal-body .add-btn { margin-top: 8px; }

  /* ===========================================================
     FOOTER
     =========================================================== */
  footer {
    margin-top: 60px;
    background: var(--maroon-dark);
    color: #E9D9C0;
    text-align: center;
    padding: 34px 24px;
    font-size: 13.5px;
  }

  footer .foot-brand {
    font-family: var(--font-display);
    font-size: 20px;
    color: var(--mustard-light);
    margin-bottom: 6px;
  }

  /* ===========================================================
     RESPONSIVE
     =========================================================== */
  @media (max-width: 640px) {
    nav ul { gap: 14px; }
    nav ul li a { font-size: 13px; }
    .logo { font-size: 21px; }
    .header-inner { flex-wrap: wrap; gap: 10px; }
    .search-box { order: 3; max-width: 100%; margin: 0; width: 100%; }
    .hero { padding: 50px 18px 70px; }
    .hero h1 { font-size: 28px; }
    .category-section { padding: 40px 16px 6px; }
    .product-card { width: 158px; }
    .float-call { width: 50px; height: 50px; font-size: 21px; bottom: 16px; right: 16px; }
    .modal-img-wrap { height: 170px; }
  }

/* ===========================================================
     REVIEWS SECTION
     =========================================================== */
  .reviews-section {
    background: var(--paper);
    border-top: 3px solid var(--gold-line);
    margin-top: 50px;
    padding: 50px 24px 60px;
  }

  .reviews-inner {
    max-width: 1100px;
    margin: 0 auto;
  }

  .reviews-header {
    display: flex;
    align-items: flex-start;
    justify-content: space-between;
    flex-wrap: wrap;
    gap: 12px;
    margin-bottom: 30px;
  }

  .reviews-title {
    font-family: var(--font-display);
    font-size: 28px;
    color: var(--maroon);
    margin-bottom: 6px;
  }

  .rating-summary {
    display: flex;
    align-items: center;
    gap: 6px;
  }

  .big-star { font-size: 22px; }

  .avg-num {
    font-size: 22px;
    font-weight: 700;
    color: var(--mustard);
  }

  .review-count {
    font-size: 14px;
    color: #8a7560;
  }

  .review-thankyou {
    background: #EAF5EA;
    border: 1px solid #7BB87B;
    color: #2E6B2E;
    padding: 12px 18px;
    border-radius: 10px;
    margin-bottom: 24px;
    font-size: 14px;
    font-weight: 600;
  }

  .no-reviews {
    text-align: center;
    color: #8a7560;
    font-size: 15px;
    padding: 30px 0;
  }

  .reviews-grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(290px, 1fr));
    gap: 18px;
    margin-bottom: 30px;
  }

  .review-card {
    background: var(--cream);
    border: 1px solid #EFE2C8;
    border-radius: 12px;
    padding: 18px;
  }

  .review-top {
    display: flex;
    align-items: center;
    gap: 12px;
    margin-bottom: 10px;
  }

  .reviewer-avatar {
    width: 40px;
    height: 40px;
    border-radius: 50%;
    background: var(--maroon);
    color: var(--mustard-light);
    font-weight: 700;
    font-size: 18px;
    display: flex;
    align-items: center;
    justify-content: center;
    flex-shrink: 0;
  }

  .reviewer-name {
    font-weight: 700;
    font-size: 14px;
    margin-bottom: 2px;
  }

  .review-stars {
    color: var(--mustard);
    font-size: 15px;
    letter-spacing: 1px;
  }

  .review-comment {
    font-size: 13.5px;
    line-height: 1.55;
    color: #4a3a28;
    font-style: italic;
  }

  .see-all-btn {
    display: inline-block;
    border: 1.5px solid var(--maroon);
    color: var(--maroon);
    font-weight: 700;
    padding: 9px 24px;
    border-radius: 24px;
    font-size: 14px;
    transition: background 0.2s, color 0.2s;
  }

  .see-all-btn:hover {
    background: var(--maroon);
    color: var(--mustard-light);
  }

  .review-form-wrap {
    margin-top: 40px;
    background: var(--cream);
    border: 1px solid #EFE2C8;
    border-radius: 14px;
    padding: 28px 24px;
    max-width: 520px;
  }

  .form-title {
    font-family: var(--font-display);
    font-size: 20px;
    color: var(--maroon);
    margin-bottom: 16px;
  }

  .login-to-review {
    font-size: 14px;
    color: #6b5840;
  }

  .login-to-review a {
    color: var(--maroon);
    font-weight: 700;
    text-decoration: underline;
  }

  .star-picker {
    display: flex;
    gap: 6px;
    margin-bottom: 14px;
    cursor: pointer;
  }

  .star-opt {
    font-size: 30px;
    color: #ccc;
    transition: color 0.15s;
    user-select: none;
  }

  .star-opt.selected { color: var(--mustard); }

  .review-form textarea {
    width: 100%;
    padding: 12px 14px;
    border: 1.5px solid #E5D6B8;
    border-radius: 9px;
    font-family: var(--font-body);
    font-size: 14px;
    color: var(--ink);
    background: var(--paper);
    resize: none;
    margin-bottom: 14px;
    transition: border-color 0.2s;
  }

  .review-form textarea:focus {
    outline: none;
    border-color: var(--mustard);
  }

  .submit-review-btn {
    background: var(--maroon);
    color: var(--mustard-light);
    font-weight: 700;
    font-size: 14px;
    padding: 11px 28px;
    border: none;
    border-radius: 8px;
    cursor: pointer;
    transition: background 0.2s;
  }

  .submit-review-btn:hover { background: var(--maroon-dark); }
  
  
  /* ===========================================================
     MOBILE HEADER — hamburger menu
     =========================================================== */
  .hamburger {
    display: none;
    flex-direction: column;
    gap: 5px;
    cursor: pointer;
    padding: 4px;
    background: none;
    border: none;
  }

  .hamburger span {
    width: 24px;
    height: 2px;
    background: var(--mustard-light);
    border-radius: 2px;
    display: block;
    transition: all 0.3s;
  }

  .mobile-nav {
    display: none;
    flex-direction: column;
    background: var(--maroon-dark);
    padding: 12px 0;
    position: absolute;
    top: 100%;
    left: 0;
    right: 0;
    z-index: 199;
    box-shadow: 0 6px 16px rgba(0,0,0,0.25);
  }

  .mobile-nav.open { display: flex; }

  .mobile-nav a {
    color: #F4E9D8;
    font-weight: 600;
    font-size: 15px;
    padding: 13px 24px;
    border-bottom: 1px solid rgba(255,255,255,0.07);
    display: block;
  }

  .mobile-nav a:last-child { border-bottom: none; }

  .mobile-nav a:hover { background: rgba(255,255,255,0.07); color: var(--mustard-light); }

  .mobile-search {
    padding: 10px 16px;
    border-bottom: 1px solid rgba(255,255,255,0.07);
  }

  .mobile-search input {
    width: 100%;
    padding: 9px 14px;
    border-radius: 20px;
    border: 1px solid rgba(244,201,93,0.4);
    background: rgba(255,255,255,0.1);
    color: #FBF1DE;
    font-family: var(--font-body);
    font-size: 14px;
    outline: none;
  }

  .mobile-search input::placeholder { color: #d8c5ac; }

  @media (max-width: 768px) {
    .hamburger { display: flex; }
    .search-box { display: none; }
    nav { display: none; }
    header { position: relative; }
  }
  
</style>
</head>
<body>

<!-- ================= TOP CONTACT BAR ================= -->
<div class="topbar">
  📞 Order on call: <a href="tel:+919705107242">+91 97051 07242</a> &nbsp;|&nbsp; Homemade &amp; fresh, delivered with care
</div>


<!-- ================= HEADER ================= -->
<header>
  <div class="header-inner">
    <a href="index.jsp" class="logo">
      <img src="images/logo.webp" alt="Ammamma's Kitchen Logo" class="logo-img" />
      SAMPURNA HOME FOODS
    </a>

    <div class="search-box">
      <span class="search-icon">🔍</span>
      <input type="text" id="searchInput" placeholder="Search pickles, sweets, mixtures..." oninput="filterProducts()">
    </div>

    <nav>
      <ul>
        <li><a href="index.jsp">Home</a></li>
        <li><a href="cart.jsp" class="cart-link">🛒 Cart <span class="cart-count" id="cartCount"><%= cartTotalQty %></span></a></li>
        <li><a href="my-orders.jsp">My Orders</a></li>
        <% if (sessionUserId != null) { %>
          <li><a href="profile.jsp">👤 My Profile</a></li>
          <li><a href="LogoutServlet" class="btn-outline">Logout</a></li>
        <% } else { %>
          <li><a href="login.jsp" class="btn-outline">Login</a></li>
          <li><a href="register.jsp">Register</a></li>
        <% } %>
      </ul>
    </nav>

    <!-- Hamburger button — only visible on mobile -->
    <button class="hamburger" id="hamburgerBtn" onclick="toggleMobileMenu()">
      <span></span>
      <span></span>
      <span></span>
    </button>
  </div>

  <!-- Mobile dropdown menu -->
  <div class="mobile-nav" id="mobileNav">
    <div class="mobile-search">
      <input type="text" placeholder="Search pickles, sweets, mixtures..." oninput="filterProducts()" id="mobileSearchInput">
    </div>
    <a href="index.jsp">🏠 Home</a>
    <a href="cart.jsp">🛒 Cart (<%= cartTotalQty %>)</a>
    <a href="my-orders.jsp">📦 My Orders</a>
    <% if (sessionUserId != null) { %>
      <a href="profile.jsp">👤 My Profile</a>
      <a href="LogoutServlet">🚪 Logout</a>
    <% } else { %>
      <a href="login.jsp">🔑 Login</a>
      <a href="register.jsp">📝 Register</a>
    <% } %>
  </div>
</header>
<!-- ================= HERO ================= -->
<section class="hero">
  <div class="hero-slide active" style="background-image: url('images/banner1.webp')"></div>
  <div class="hero-slide" style="background-image: url('images/banner2.webp')"></div>
  <div class="hero-slide" style="background-image: url('images/banner3.webp')"></div>
  <div class="hero-overlay"></div>

  <span class="hero-badge">Homemade • No Preservatives</span>
  <h1>Andhra's traditional taste,<br><span>pickled, fried &amp; roasted</span> the old way</h1>
  <p>Every jar made fresh in a real home kitchen — mutton to mango, laddus to murukulu. Ordered like Swiggy, tastes like home.</p>
  <a href="#pickles" class="hero-cta">Start Browsing ↓</a>
</section>

<!-- ================= PICKLES ================= -->
<section class="category-section" id="pickles">
  <div class="category-head">
    <div class="seal pickles">🌶</div>
    <div>
      <h2>Pickles</h2>
      <div class="sub">9 varieties &middot; spicy &amp; tangy</div>
    </div>
  </div>

  <div class="product-row pickles">
    <div class="product-card" data-id="1">
      <div class="card-cap" onclick="openModal(1)">
        <img src="images/mutton-pickle.webp" alt="Mutton Pickle" onerror="handleImgError(this)" />
        <div class="cap-fallback">🍖</div>
        <div class="view-hint">🔍 View Details</div>
      </div>
      <div class="card-body">
        <h4>Mutton Pickle</h4>
        <span class="price-tag">₹1400/kg</span>
     <button class="add-btn" onclick="addToCart(this)">Add to Cart</button>
      </div>
    </div>
    <div class="product-card" data-id="2">
      <div class="card-cap" onclick="openModal(2)">
        <img src="images/chicken-pickle.webp" alt="Chicken Pickle" onerror="handleImgError(this)" />
        <div class="cap-fallback">🍗</div>
        <div class="view-hint">🔍 View Details</div>
      </div>
      <div class="card-body">
        <h4>Chicken Pickle</h4>
        <span class="price-tag">₹1000/kg</span>
        <button class="add-btn" onclick="addToCart(this)">Add to Cart</button>
      </div>
    </div>
    <div class="product-card" data-id="3">
      <div class="card-cap" onclick="openModal(3)">
        <img src="images/gongura-pickle.webp" alt="Gongura Pickle" onerror="handleImgError(this)" />
        <div class="cap-fallback">🌿</div>
        <div class="view-hint">🔍 View Details</div>
      </div>
      <div class="card-body">
        <h4>Gongura Pickle</h4>
        <span class="price-tag">₹400/kg</span>
        <button class="add-btn" onclick="addToCart(this)">Add to Cart</button>
      </div>
    </div>
    <div class="product-card" data-id="4">
      <div class="card-cap" onclick="openModal(4)">
        <img src="images/mango-allam-pickle.webp" alt="Mango Allam Pickle" onerror="handleImgError(this)" />
        <div class="cap-fallback">🥭</div>
        <div class="view-hint">🔍 View Details</div>
      </div>
      <div class="card-body">
        <h4>Mango Allam Pickle</h4>
        <span class="price-tag">₹400/kg</span>
        <button class="add-btn" onclick="addToCart(this)">Add to Cart</button>
      </div>
    </div>
    <div class="product-card" data-id="5">
      <div class="card-cap" onclick="openModal(5)">
        <img src="images/mango-avakaya-pickle.webp" alt="Mango Avakaya Pickle" onerror="handleImgError(this)" />
        <div class="cap-fallback">🥭</div>
        <div class="view-hint">🔍 View Details</div>
      </div>
      <div class="card-body">
        <h4>Mango Avakaya Pickle</h4>
        <span class="price-tag">₹400/kg</span>
        <button class="add-btn" onclick="addToCart(this)">Add to Cart</button>
      </div>
    </div>
    <div class="product-card" data-id="6">
      <div class="card-cap" onclick="openModal(6)">
        <img src="images/mulakaya-pickle.webp" alt="Mulakaya Pickle" onerror="handleImgError(this)" />
        <div class="cap-fallback">🌶</div>
        <div class="view-hint">🔍 View Details</div>
      </div>
      <div class="card-body">
        <h4>Mulakaya Pickle</h4>
        <span class="price-tag">₹400/kg</span>
        <button class="add-btn" onclick="addToCart(this)">Add to Cart</button>
      </div>
    </div>
    <div class="product-card" data-id="7">
      <div class="card-cap" onclick="openModal(7)">
        <img src="images/dosakaya-pickle.webp" alt="Dosakaya Pickle" onerror="handleImgError(this)" />
        <div class="cap-fallback">🥒</div>
        <div class="view-hint">🔍 View Details</div>
      </div>
      <div class="card-body">
        <h4>Dosakaya Pickle</h4>
        <span class="price-tag">₹400/kg</span>
        <button class="add-btn" onclick="addToCart(this)">Add to Cart</button>
      </div>
    </div>
    <div class="product-card" data-id="8">
      <div class="card-cap" onclick="openModal(8)">
        <img src="images/tomato-pickle.webp" alt="Tomato Pickle" onerror="handleImgError(this)" />
        <div class="cap-fallback">🍅</div>
        <div class="view-hint">🔍 View Details</div>
      </div>
      <div class="card-body">
        <h4>Tomato Pickle</h4>
        <span class="price-tag">₹400/kg</span>
        <button class="add-btn" onclick="addToCart(this)">Add to Cart</button>
      </div>
    </div>
    <div class="product-card" data-id="9">
      <div class="card-cap" onclick="openModal(9)">
        <img src="images/pandu-mirapakaya-pickle.webp" alt="Pandu Mirapakaya Pickle" onerror="handleImgError(this)" />
        <div class="cap-fallback">🌶</div>
        <div class="view-hint">🔍 View Details</div>
      </div>
      <div class="card-body">
        <h4>Pandu Mirapakaya Pickle</h4>
        <span class="price-tag">₹400/kg</span>
        <button class="add-btn" onclick="addToCart(this)">Add to Cart</button>
      </div>
    </div>
  </div>
</section>

<!-- ================= SWEETS ================= -->
<section class="category-section" id="sweets">
  <div class="category-head">
    <div class="seal sweets">🍬</div>
    <div>
      <h2>Sweets</h2>
      <div class="sub">7 varieties &middot; traditional &amp; festive</div>
    </div>
  </div>

  <div class="product-row sweets">
    <div class="product-card" data-id="10">
      <div class="card-cap" onclick="openModal(10)">
        <img src="images/arisalu.webp" alt="Arisalu" onerror="handleImgError(this)" />
        <div class="cap-fallback">🟤</div>
        <div class="view-hint">🔍 View Details</div>
      </div>
      <div class="card-body">
        <h4>Arisalu</h4>
        <span class="price-tag">₹400/kg</span>
        <button class="add-btn" onclick="addToCart(this)">Add to Cart</button>
      </div>
    </div>
    <div class="product-card" data-id="11">
      <div class="card-cap" onclick="openModal(11)">
        <img src="images/garijalu-bellam.webp" alt="Garijalu Bellam" onerror="handleImgError(this)" />
        <div class="cap-fallback">🟫</div>
        <div class="view-hint">🔍 View Details</div>
      </div>
      <div class="card-body">
        <h4>Garijalu Bellam</h4>
        <span class="price-tag">₹400/kg</span>
        <button class="add-btn" onclick="addToCart(this)">Add to Cart</button>
      </div>
    </div>
    <div class="product-card" data-id="12">
      <div class="card-cap" onclick="openModal(12)">
        <img src="images/garijalu-sugar.webp" alt="Garijalu Sugar" onerror="handleImgError(this)" />
        <div class="cap-fallback">⚪</div>
        <div class="view-hint">🔍 View Details</div>
      </div>
      <div class="card-body">
        <h4>Garijalu Sugar</h4>
        <span class="price-tag">₹400/kg</span>
        <button class="add-btn" onclick="addToCart(this)">Add to Cart</button>
      </div>
    </div>
    <div class="product-card" data-id="13">
      <div class="card-cap" onclick="openModal(13)">
        <img src="images/sunnundalu.webp" alt="Sunnundalu" onerror="handleImgError(this)" />
        <div class="cap-fallback">🟡</div>
        <div class="view-hint">🔍 View Details</div>
      </div>
      <div class="card-body">
        <h4>Sunnundalu</h4>
        <span class="price-tag">₹400/kg</span>
        <button class="add-btn" onclick="addToCart(this)">Add to Cart</button>
      </div>
    </div>
    <div class="product-card" data-id="14">
      <div class="card-cap" onclick="openModal(14)">
        <img src="images/groundnut-laddu.webp" alt="Groundnut Laddu" onerror="handleImgError(this)" />
        <div class="cap-fallback">🥜</div>
        <div class="view-hint">🔍 View Details</div>
      </div>
      <div class="card-body">
        <h4>Groundnut Laddu</h4>
        <span class="price-tag">₹400/kg</span>
        <button class="add-btn" onclick="addToCart(this)">Add to Cart</button>
      </div>
    </div>
    <div class="product-card" data-id="15">
      <div class="card-cap" onclick="openModal(15)">
        <img src="images/til-laddu.webp" alt="Til Laddu" onerror="handleImgError(this)" />
        <div class="cap-fallback">⚫</div>
        <div class="view-hint">🔍 View Details</div>
      </div>
      <div class="card-body">
        <h4>Til Laddu</h4>
        <span class="price-tag">₹400/kg</span>
        <button class="add-btn" onclick="addToCart(this)">Add to Cart</button>
      </div>
    </div>
    <div class="product-card" data-id="16">
      <div class="card-cap" onclick="openModal(16)">
        <img src="images/rose-cookies.webp" alt="Rose Cookies" onerror="handleImgError(this)" />
        <div class="cap-fallback">🌸</div>
        <div class="view-hint">🔍 View Details</div>
      </div>
      <div class="card-body">
        <h4>Rose Cookies</h4>
        <span class="price-tag">₹400/kg</span>
        <button class="add-btn" onclick="addToCart(this)">Add to Cart</button>
      </div>
    </div>
  </div>
</section>

<!-- ================= MIXTURES & NAMKEEN ================= -->
<section class="category-section" id="mixtures">
  <div class="category-head">
    <div class="seal mixtures">🍘</div>
    <div>
      <h2>Mixtures &amp; Namkeen</h2>
      <div class="sub">3 varieties &middot; crunchy &amp; savory</div>
    </div>
  </div>

  <div class="product-row mixtures">
    <div class="product-card" data-id="17">
      <div class="card-cap" onclick="openModal(17)">
        <img src="images/poha-mixture.webp" alt="Poha Mixture" onerror="handleImgError(this)" />
        <div class="cap-fallback">🍚</div>
        <div class="view-hint">🔍 View Details</div>
      </div>
      <div class="card-body">
        <h4>Poha Mixture</h4>
        <span class="price-tag">₹250/kg</span>
        <button class="add-btn" onclick="addToCart(this)">Add to Cart</button>
      </div>
    </div>
    <div class="product-card" data-id="18">
      <div class="card-cap" onclick="openModal(18)">
        <img src="images/murukulu.webp" alt="Murukulu" onerror="handleImgError(this)" />
        <div class="cap-fallback">🌀</div>
        <div class="view-hint">🔍 View Details</div>
      </div>
      <div class="card-body">
        <h4>Murukulu</h4>
        <span class="price-tag">₹350/kg</span>
        <button class="add-btn" onclick="addToCart(this)">Add to Cart</button>
      </div>
    </div>
    <div class="product-card" data-id="19">
      <div class="card-cap" onclick="openModal(19)">
        <img src="images/appalu.webp" alt="Appalu" onerror="handleImgError(this)" />
        <div class="cap-fallback">🟠</div>
        <div class="view-hint">🔍 View Details</div>
      </div>
      <div class="card-body">
        <h4>Appalu</h4>
        <span class="price-tag">₹350/kg</span>
        <button class="add-btn" onclick="addToCart(this)">Add to Cart</button>
      </div>
    </div>
  </div>
</section>

<!-- ================= PRODUCT DETAIL MODAL ================= -->
<div class="modal-overlay" id="productModal" onclick="closeModalOutside(event)">
  <div class="modal-box">
    <button class="modal-close" onclick="closeModal()">✕</button>
    <div class="modal-img-wrap">
      <img id="modalImg" src="" alt="" />
      <div class="modal-fallback" id="modalFallback"></div>
    </div>
    <div class="modal-body">
      <h3 id="modalName"></h3>
      <div class="modal-price" id="modalPrice"></div>

      <div class="modal-section">
        <h4>How We Make It</h4>
        <p id="modalProcess"></p>
      </div>
      <div class="modal-section">
        <h4>Ingredients</h4>
        <p id="modalIngredients"></p>
      </div>
      <div class="modal-section">
        <h4>Shelf Life</h4>
        <p id="modalShelf"></p>
      </div>

      <button class="add-btn" onclick="addToCart(this)">Add to Cart</button>
    </div>
  </div>
</div>

<!-- ================= REVIEWS SECTION ================= -->
<%@ page import="dao.ReviewDAO" %>
<%@ page import="model.Review" %>
<%@ page import="java.util.List" %>
<%
  ReviewDAO reviewDAO = new ReviewDAO();
  List<Review> approvedReviews = reviewDAO.getApprovedReviews();
  double avgRating = reviewDAO.getAverageRating();
  int reviewCount = reviewDAO.getReviewCount();
  String reviewSubmitted = request.getParameter("reviewSubmitted");
  Integer reviewUserId = (Integer) session.getAttribute("userId");
%>

<section class="reviews-section" id="reviews">
  <div class="reviews-inner">

    <!-- Summary bar -->
    <div class="reviews-header">
      <div class="reviews-title-wrap">
        <h2 class="reviews-title">What Our Customers Say</h2>
        <% if (reviewCount > 0) { %>
        <div class="rating-summary">
          <span class="big-star">⭐</span>
          <span class="avg-num"><%= String.format("%.1f", avgRating) %></span>
          <span class="review-count">(<%= reviewCount %> reviews)</span>
        </div>
        <% } %>
      </div>
    </div>

    <!-- Thank you message after submitting -->
    <% if ("true".equals(reviewSubmitted)) { %>
    <div class="review-thankyou">
      ✅ Thank you for your review! It will appear here once approved.
    </div>
    <% } %>

    <!-- Reviews grid — max 6 shown -->
    <% if (approvedReviews.isEmpty()) { %>
    <div class="no-reviews">
      No reviews yet — be the first to share your experience!
    </div>
    <% } else { %>
    <div class="reviews-grid">
      <%
        int shown = 0;
        for (Review rev : approvedReviews) {
          if (shown >= 6) break;
          shown++;
          StringBuilder stars = new StringBuilder();
          for (int s = 1; s <= 5; s++) {
            stars.append(s <= rev.getRating() ? "★" : "☆");
          }
          String initial = rev.getUserName().substring(0, 1).toUpperCase();
      %>
      <div class="review-card">
        <div class="review-top">
          <div class="reviewer-avatar"><%= initial %></div>
          <div>
            <div class="reviewer-name"><%= rev.getUserName() %></div>
            <div class="review-stars"><%= stars %></div>
          </div>
        </div>
        <p class="review-comment">"<%= rev.getComment() %>"</p>
      </div>
      <% } %>
    </div>

    <% if (approvedReviews.size() > 6) { %>
    <div style="text-align:center; margin-top:20px;">
      <a href="allReviews.jsp" class="see-all-btn">See All Reviews</a>
    </div>
    <% } %>
    <% } %>

    <!-- Submit review form -->
    <div class="review-form-wrap">
      <h3 class="form-title">Leave a Review</h3>

      <% if (reviewUserId == null) { %>
        <p class="login-to-review">
          <a href="login.jsp">Login</a> to leave a review.
        </p>
      <% } else { %>
      <form action="SubmitReviewServlet" method="post" class="review-form">
        <div class="star-picker" id="starPicker">
          <span class="star-opt" data-val="1">★</span>
          <span class="star-opt" data-val="2">★</span>
          <span class="star-opt" data-val="3">★</span>
          <span class="star-opt" data-val="4">★</span>
          <span class="star-opt" data-val="5">★</span>
        </div>
        <input type="hidden" name="rating" id="ratingInput" value="0">
        <textarea name="comment" rows="3" placeholder="Share your experience..." required></textarea>
        <button type="submit" class="submit-review-btn">Submit Review</button>
      </form>
      <% } %>
    </div>

  </div>
</section>

<!-- ================= FOOTER ================= -->
<footer>
  <div class="foot-brand">🫙 SAMPURNA HOME FOODS </div>
  <div>Homemade pickles, sweets &amp; mixtures &middot; made fresh, shipped with care</div>
  <div style="margin-top:10px;">📞 <a href="tel:+919705107242" style="color:var(--mustard-light); font-weight:700;">+91 97051 07242</a></div>
</footer>

<!-- Floating call button, always visible bottom-right -->
<a href="tel:+919705107242" class="float-call" title="Call to order">📞</a>

<script>
  // ===== Image error fallback (used by every product image) =====
  function handleImgError(imgEl) {
    imgEl.style.display = 'none';
    imgEl.nextElementSibling.style.display = 'flex';
  }

  // ===== Hero background slideshow =====
  const slides = document.querySelectorAll('.hero-slide');
  let currentSlide = 0;

  setInterval(() => {
    slides[currentSlide].classList.remove('active');
    currentSlide = (currentSlide + 1) % slides.length;
    slides[currentSlide].classList.add('active');
  }, 4000);


// ===== Add to Cart (real version, talks to the server) =====
  const cartCountEl = document.getElementById('cartCount');
  let currentModalProductId = null; // tracks which product the popup is showing

  function addToCart(btn) {
    const card = btn.closest('.product-card');
    const productId = card.getAttribute('data-id');
    sendAddToCart(productId, btn, false);
  }

  function addToCartFromModal() {
    if (currentModalProductId == null) return;
    sendAddToCart(currentModalProductId, null, true);
  }

  function sendAddToCart(productId, btn, fromModal) {
    fetch('AddToCartServlet?productId=' + productId, { method: 'POST' })
      .then(res => res.text())
      .then(result => {
        if (result === 'LOGIN_REQUIRED') {
          window.location.href = 'login.jsp';
          return;
        }
        cartCountEl.textContent = result;

        if (btn) {
          const original = btn.textContent;
          btn.textContent = "Added ✓";
          btn.classList.add('added');
          setTimeout(() => {
            btn.textContent = original;
            btn.classList.remove('added');
          }, 900);
        }

        if (fromModal) closeModal();
      })
      .catch(err => {
        console.error('Add to cart failed:', err);
        alert('Could not add item. Please try again.');
      });
  }

  // ===== Search / filter products =====
  function filterProducts() {
    const query = document.getElementById('searchInput').value.toLowerCase().trim();

    document.querySelectorAll('.product-card').forEach(card => {
      const name = card.querySelector('h4').textContent.toLowerCase();
      card.style.display = name.includes(query) ? '' : 'none';
    });

    document.querySelectorAll('.category-section').forEach(section => {
      const visibleCards = section.querySelectorAll('.product-card:not([style*="display: none"])');
      section.style.display = visibleCards.length > 0 ? '' : 'none';
    });
  }

  // =========================================================
  // PRODUCT DETAIL DATA
  // ⚠️ Replace these descriptions/shelf-life values with your
  // real recipe details before going live — these are placeholders.
  // =========================================================
  const productData = {
    1:  { name:"Mutton Pickle", price:"₹1400/kg", emoji:"🍖", image:"images/mutton-pickle.png",
          process:"Tender mutton pieces are slow-cooked in roasted Andhra spices and pure sesame oil, then matured for deep flavor.",
          ingredients:"Mutton, red chilli powder, mustard seeds, garlic, ginger, sesame oil, salt, traditional spice blend.",
          shelfLife:"Placeholder — confirm actual tested shelf life. Refrigerate after opening; consume within a few weeks." },
    2:  { name:"Chicken Pickle", price:"₹1000/kg", emoji:"🍗", image:"images/chicken-pickle.png",
          process:"Boneless chicken pieces fried and simmered in a spicy masala, finished with sesame oil for richness.",
          ingredients:"Chicken, red chilli powder, garlic, ginger, mustard seeds, sesame oil, salt, spice blend.",
          shelfLife:"Placeholder — confirm actual tested shelf life. Refrigerate after opening; consume within a few weeks." },
    3:  { name:"Gongura Pickle", price:"₹400/kg", emoji:"🌿", image:"images/gongura-pickle.png",
          process:"Fresh sorrel leaves are sautéed and ground with spices into a tangy, traditional Andhra pickle.",
          ingredients:"Gongura (sorrel leaves), red chillies, garlic, mustard seeds, sesame oil, salt.",
          shelfLife:"Up to 30 days at room temperature, longer if refrigerated." },
    4:  { name:"Mango Allam Pickle", price:"₹400/kg", emoji:"🥭", image:"images/mango-allam-pickle.png",
          process:"Raw mango pieces blended with fresh ginger and spices, matured in oil for a tangy-spicy taste.",
          ingredients:"Raw mango, ginger, red chilli powder, mustard seeds, sesame oil, salt.",
          shelfLife:"Up to 6 months at room temperature in an airtight jar." },
    5:  { name:"Mango Avakaya Pickle", price:"₹400/kg", emoji:"🥭", image:"images/mango-avakaya-pickle.png",
          process:"The classic Andhra avakaya — raw mango pieces marinated in mustard, chilli, and oil, sun-matured.",
          ingredients:"Raw mango, mustard powder, red chilli powder, fenugreek, sesame oil, salt.",
          shelfLife:"Up to 12 months at room temperature in an airtight jar." },
    6:  { name:"Mulakaya Pickle", price:"₹400/kg", emoji:"🌶", image:"images/mulakaya-pickle.png",
          process:"Green chillies cooked down with spices and oil into a bold, fiery pickle.",
          ingredients:"Green chillies, mustard seeds, fenugreek, sesame oil, salt, spice blend.",
          shelfLife:"Up to 6 months at room temperature in an airtight jar." },
    7:  { name:"Dosakaya Pickle", price:"₹400/kg", emoji:"🥒", image:"images/dosakaya-pickle.png",
          process:"Yellow cucumber chunks marinated in a tangy mustard-chilli mix, a refreshing Andhra classic.",
          ingredients:"Dosakaya (yellow cucumber), mustard powder, red chilli powder, sesame oil, salt.",
          shelfLife:"Best within 15-20 days; refrigerate after opening." },
    8:  { name:"Tomato Pickle", price:"₹400/kg", emoji:"🍅", image:"images/tomato-pickle.png",
          process:"Ripe tomatoes simmered down with spices into a tangy, slightly sweet pickle.",
          ingredients:"Tomatoes, red chilli powder, garlic, mustard seeds, sesame oil, salt.",
          shelfLife:"Up to 30 days at room temperature, longer if refrigerated." },
    9:  { name:"Pandu Mirapakaya Pickle", price:"₹400/kg", emoji:"🌶", image:"images/pandu-mirapakaya-pickle.png",
          process:"Ripe red chillies blended with spices into an intensely flavorful, spicy pickle.",
          ingredients:"Ripe red chillies, mustard seeds, garlic, sesame oil, salt, spice blend.",
          shelfLife:"Up to 6 months at room temperature in an airtight jar." },
    10: { name:"Arisalu", price:"₹400/kg", emoji:"🟤", image:"images/arisalu.png",
          process:"Rice flour and jaggery dough, shaped and deep-fried golden — a festive Andhra sweet.",
          ingredients:"Rice flour, jaggery, sesame seeds, ghee, oil for frying.",
          shelfLife:"Best within 10-15 days, stored in an airtight container." },
    11: { name:"Garijalu Bellam", price:"₹400/kg", emoji:"🟫", image:"images/garijalu-bellam.png",
          process:"Urad dal and jaggery dough shaped into rings and deep-fried until crisp outside, soft inside.",
          ingredients:"Urad dal, jaggery, rice flour, oil for frying.",
          shelfLife:"Best within 7-10 days, stored in an airtight container." },
    12: { name:"Garijalu Sugar", price:"₹400/kg", emoji:"⚪", image:"images/garijalu-sugar.png",
          process:"Same traditional preparation as garijalu, sweetened with sugar instead of jaggery.",
          ingredients:"Urad dal, sugar, rice flour, oil for frying.",
          shelfLife:"Best within 7-10 days, stored in an airtight container." },
    13: { name:"Sunnundalu", price:"₹400/kg", emoji:"🟡", image:"images/sunnundalu.png",
          process:"Roasted urad dal ground fine and bound with ghee and sugar into soft, melt-in-mouth laddus.",
          ingredients:"Urad dal, sugar, ghee, cardamom.",
          shelfLife:"Best within 10-15 days at room temperature." },
    14: { name:"Groundnut Laddu", price:"₹400/kg", emoji:"🥜", image:"images/groundnut-laddu.png",
          process:"Roasted peanuts ground with jaggery and shaped into firm, nutty laddus.",
          ingredients:"Peanuts, jaggery, a touch of ghee.",
          shelfLife:"Best within 20-25 days at room temperature." },
    15: { name:"Til Laddu", price:"₹400/kg", emoji:"⚫", image:"images/til-laddu.png",
          process:"Roasted sesame seeds bound with jaggery syrup into small, crunchy-soft laddus.",
          ingredients:"Sesame seeds, jaggery, a touch of ghee.",
          shelfLife:"Best within 20-25 days at room temperature." },
    16: { name:"Rose Cookies", price:"₹400/kg", emoji:"🌸", image:"images/rose-cookies.png",
          process:"A flower-shaped batter dipped and deep-fried using a traditional rose cookie mould, lightly sweetened.",
          ingredients:"Rice flour, maida, coconut milk, sesame seeds, sugar, oil for frying.",
          shelfLife:"Best within 15-20 days, stored in an airtight container." },
    17: { name:"Poha Mixture", price:"₹250/kg", emoji:"🍚", image:"images/poha-mixture.png",
          process:"Flattened rice fried crisp and tossed with peanuts, curry leaves, and spices.",
          ingredients:"Poha (flattened rice), peanuts, curry leaves, turmeric, red chilli, oil, salt.",
          shelfLife:"Up to 30 days, stored in an airtight container." },
    18: { name:"Murukulu", price:"₹350/kg", emoji:"🌀", image:"images/murukulu.png",
          process:"Rice and urad dal flour dough pressed into spirals and deep-fried until crunchy.",
          ingredients:"Rice flour, urad dal flour, sesame seeds, butter, red chilli powder, oil for frying.",
          shelfLife:"Up to 30 days, stored in an airtight container." },
    19: { name:"Appalu", price:"₹350/kg", emoji:"🟠", image:"images/appalu.png",
          process:"A fermented rice-and-jaggery batter deep-fried into a sweet, crisp-edged disc.",
          ingredients:"Rice, jaggery, fenugreek seeds, oil for frying.",
          shelfLife:"Best within 10-15 days, stored in an airtight container." }
  };

  function openModal(id) {
	    const p = productData[id];
	    if (!p) return;
	    currentModalProductId = id;

    const img = document.getElementById('modalImg');
    const fallback = document.getElementById('modalFallback');

    img.style.display = '';
    fallback.style.display = 'none';
    img.src = p.image;
    img.alt = p.name;
    img.onerror = function () {
      this.style.display = 'none';
      fallback.style.display = 'flex';
    };
    fallback.textContent = p.emoji;

    document.getElementById('modalName').textContent = p.name;
    document.getElementById('modalPrice').textContent = p.price;
    document.getElementById('modalProcess').textContent = p.process;
    document.getElementById('modalIngredients').textContent = p.ingredients;
    document.getElementById('modalShelf').textContent = p.shelfLife;

    document.getElementById('productModal').classList.add('open');
    document.body.style.overflow = 'hidden';
  }

  function closeModal() {
    document.getElementById('productModal').classList.remove('open');
    document.body.style.overflow = '';
  }

  function closeModalOutside(e) {
    if (e.target.id === 'productModal') closeModal();
  }
  
//===== Star rating picker =====
  const starOpts = document.querySelectorAll('.star-opt');
  const ratingInput = document.getElementById('ratingInput');

  if (starOpts.length > 0) {
    starOpts.forEach(star => {
      star.addEventListener('mouseover', () => {
        const val = parseInt(star.getAttribute('data-val'));
        starOpts.forEach(s => {
          s.classList.toggle('selected', parseInt(s.getAttribute('data-val')) <= val);
        });
      });

      star.addEventListener('click', () => {
        const val = parseInt(star.getAttribute('data-val'));
        ratingInput.value = val;
        starOpts.forEach(s => {
          s.classList.toggle('selected', parseInt(s.getAttribute('data-val')) <= val);
        });
      });
    });

    document.getElementById('starPicker').addEventListener('mouseleave', () => {
      const selected = parseInt(ratingInput.value);
      starOpts.forEach(s => {
        s.classList.toggle('selected', parseInt(s.getAttribute('data-val')) <= selected);
      });
    });
  }
  
  
//===== Mobile hamburger menu =====
  function toggleMobileMenu() {
    document.getElementById('mobileNav').classList.toggle('open');
  }

  // Close mobile menu when user clicks a link inside it
  document.querySelectorAll('.mobile-nav a').forEach(link => {
    link.addEventListener('click', () => {
      document.getElementById('mobileNav').classList.remove('open');
    });
  });

  // Sync mobile search with desktop filter
  const mobileSearchInput = document.getElementById('mobileSearchInput');
  if (mobileSearchInput) {
    mobileSearchInput.addEventListener('input', () => {
      document.getElementById('searchInput').value = mobileSearchInput.value;
      filterProducts();
    });
  }
  
</script>


</body>
</html>
