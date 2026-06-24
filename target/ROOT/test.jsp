<%@ page import="dao.ProductDAO" %>
<%@ page import="model.Product" %>
<%@ page import="java.util.List" %>

<%
ProductDAO dao = new ProductDAO();

List<Product> products = dao.getAllProducts();

for(Product p : products){
    out.println(p.getName() + "<br>");
}
%>