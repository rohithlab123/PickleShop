<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dao.ReviewDAO" %>
<%@ page import="model.Review" %>
<%@ page import="java.util.List" %>
<%
Boolean isAdmin = (Boolean) session.getAttribute("isAdmin");

if(isAdmin == null || !isAdmin){
    response.sendRedirect("admin-login.jsp");
    return;
}
  ReviewDAO dao = new ReviewDAO();
  List<Review> allReviews = dao.getAllReviews();
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Admin — Reviews | SAMPURNA HOME FOODS</title>
<link href="https://fonts.googleapis.com/css2?family=Rozha+One&family=Mukta:wght@400;600;700&display=swap" rel="stylesheet">
<style>
  :root {
    --cream: #FBF1DE; --maroon: #7A1F1F; --maroon-dark: #541313;
    --mustard: #D98E04; --mustard-light: #F4C95D;
    --green: #4B6043; --ink: #2B1B12; --paper: #FFFDF8;
    --font-display: 'Rozha One', serif; --font-body: 'Mukta', sans-serif;
  }
  * { margin:0; padding:0; box-sizing:border-box; }
  body { background: var(--cream); font-family: var(--font-body); color: var(--ink); }
  a { text-decoration: none; color: inherit; }

  header {
    background: var(--maroon); padding: 16px 24px;
    display: flex; justify-content: space-between; align-items: center;
  }
  .logo { font-family: var(--font-display); font-size: 22px; color: var(--mustard-light); }
  header a.back { color: #F4E9D8; font-weight: 600; font-size: 14px; }

  .wrap { max-width: 860px; margin: 0 auto; padding: 36px 20px 60px; }
  h1 { font-family: var(--font-display); font-size: 28px; color: var(--maroon); margin-bottom: 24px; }

  .review-row {
    background: var(--paper); border: 1px solid #EFE2C8;
    border-radius: 12px; padding: 18px 20px; margin-bottom: 14px;
    display: flex; justify-content: space-between;
    align-items: flex-start; gap: 16px; flex-wrap: wrap;
  }

  .review-row.pending { border-left: 4px solid var(--mustard); }
  .review-row.approved { border-left: 4px solid var(--green); }

  .rev-info { flex: 1; }
  .rev-name { font-weight: 700; margin-bottom: 3px; }
  .rev-stars { color: var(--mustard); margin-bottom: 6px; }
  .rev-comment { font-size: 14px; color: #4a3a28; font-style: italic; }
  .rev-date { font-size: 12px; color: #8a7560; margin-top: 6px; }

  .rev-badge {
    font-size: 12px; font-weight: 700; padding: 3px 10px;
    border-radius: 20px; white-space: nowrap;
  }
  .badge-pending { background: #FEF3C7; color: #92400E; }
  .badge-approved { background: #D1FAE5; color: #065F46; }

  .rev-actions { display: flex; gap: 8px; align-items: center; flex-wrap: wrap; }

  .btn-approve {
    background: var(--green); color: #fff;
    border: none; border-radius: 7px;
    padding: 7px 16px; font-weight: 700;
    font-size: 13px; cursor: pointer;
  }

  .btn-delete {
    background: #b04444; color: #fff;
    border: none; border-radius: 7px;
    padding: 7px 16px; font-weight: 700;
    font-size: 13px; cursor: pointer;
  }

  .empty { text-align: center; color: #8a7560; padding: 40px; font-size: 15px; }
</style>
</head>
<body>

<header>
  <span class="logo">🫙 Admin — Reviews</span>
  <a href="index.jsp" class="back">&larr; Back to Site</a>
</header>

<div class="wrap">
  <h1>All Reviews (<%= allReviews.size() %>)</h1>

  <% if (allReviews.isEmpty()) { %>
    <div class="empty">No reviews yet.</div>
  <% } else {
    for (Review r : allReviews) {
      String statusClass = r.getApproved() == 1 ? "approved" : "pending";
      String badgeClass  = r.getApproved() == 1 ? "badge-approved" : "badge-pending";
      String badgeText   = r.getApproved() == 1 ? "Approved" : "Pending";

      StringBuilder stars = new StringBuilder();
      for (int s = 1; s <= 5; s++) {
        stars.append(s <= r.getRating() ? "★" : "☆");
      }
  %>
  <div class="review-row <%= statusClass %>">
    <div class="rev-info">
      <div class="rev-name"><%= r.getUserName() %></div>
      <div class="rev-stars"><%= stars %></div>
      <div class="rev-comment">"<%= r.getComment() %>"</div>
      <div class="rev-date"><%= r.getCreatedAt() %></div>
    </div>

    <div class="rev-actions">
      <span class="rev-badge <%= badgeClass %>"><%= badgeText %></span>

      <% if (r.getApproved() == 0) { %>
      <form action="AdminReviewServlet" method="post">
        <input type="hidden" name="reviewId" value="<%= r.getId() %>">
        <input type="hidden" name="action" value="approve">
        <button class="btn-approve" type="submit">Approve</button>
      </form>
      <% } %>

    <form action="${pageContext.request.contextPath}/AdminReviewServlet" method="post">
        <input type="hidden" name="reviewId" value="<%= r.getId() %>">
        <input type="hidden" name="action" value="delete">
        <button class="btn-delete" type="submit"
          onclick="return confirm('Delete this review?')">Delete</button>
      </form>
    </div>
  </div>
  <% } } %>
</div>

</body>
</html>