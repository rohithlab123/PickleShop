package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import model.Review;

public class ReviewDAO {

    // User submits a review — goes in as pending (approved = 0)
    public boolean addReview(int userId, int rating, String comment) {
        boolean status = false;
        try {
            DBConnection db = new DBConnection();
            Connection con = db.getconnection();

            String sql = "INSERT INTO reviews (user_id, rating, comment, approved) VALUES (?, ?, ?, 0)";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, userId);
            ps.setInt(2, rating);
            ps.setString(3, comment);
            status = ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return status;
    }

    // Gets only approved reviews — for public display on home page
    public List<Review> getApprovedReviews() {
        List<Review> list = new ArrayList<>();
        try {
            DBConnection db = new DBConnection();
            Connection con = db.getconnection();

            String sql = "SELECT r.id, r.rating, r.comment, r.created_at, u.name " +
                         "FROM reviews r JOIN users u ON r.user_id = u.id " +
                         "WHERE r.approved = 1 ORDER BY r.created_at DESC";
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Review review = new Review();
                review.setId(rs.getInt("id"));
                review.setRating(rs.getInt("rating"));
                review.setComment(rs.getString("comment"));
                review.setCreatedAt(rs.getString("created_at"));
                review.setUserName(rs.getString("name"));
                list.add(review);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // Gets all reviews (approved + pending) — for admin page
    public List<Review> getAllReviews() {
        List<Review> list = new ArrayList<>();
        try {
            DBConnection db = new DBConnection();
            Connection con = db.getconnection();

            String sql = "SELECT r.id, r.rating, r.comment, r.approved, r.created_at, u.name " +
                         "FROM reviews r JOIN users u ON r.user_id = u.id " +
                         "ORDER BY r.created_at DESC";
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Review review = new Review();
                review.setId(rs.getInt("id"));
                review.setRating(rs.getInt("rating"));
                review.setComment(rs.getString("comment"));
                review.setApproved(rs.getInt("approved"));
                review.setCreatedAt(rs.getString("created_at"));
                review.setUserName(rs.getString("name"));
                list.add(review);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // Admin approves a review
    public boolean approveReview(int reviewId) {
        boolean status = false;
        try {
            DBConnection db = new DBConnection();
            Connection con = db.getconnection();

            String sql = "UPDATE reviews SET approved = 1 WHERE id = ?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, reviewId);
            status = ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return status;
    }

    // Admin deletes a review
    public boolean deleteReview(int reviewId) {
        boolean status = false;
        try {
            DBConnection db = new DBConnection();
            Connection con = db.getconnection();

            String sql = "DELETE FROM reviews WHERE id = ?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, reviewId);
            status = ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return status;
    }

    // Average rating — shown in the summary badge
    public double getAverageRating() {
        double avg = 0;
        try {
            DBConnection db = new DBConnection();
            Connection con = db.getconnection();

            String sql = "SELECT AVG(rating) AS avg FROM reviews WHERE approved = 1";
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                avg = rs.getDouble("avg");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return avg;
    }

    // Total approved review count
    public int getReviewCount() {
        int count = 0;
        try {
            DBConnection db = new DBConnection();
            Connection con = db.getconnection();

            String sql = "SELECT COUNT(*) AS total FROM reviews WHERE approved = 1";
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                count = rs.getInt("total");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return count;
    }
}