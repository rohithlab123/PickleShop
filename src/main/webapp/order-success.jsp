<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Order Success | SAMPURNA HOME FOODS</title>

<link href="https://fonts.googleapis.com/css2?family=Rozha+One&family=Mukta:wght@400;500;700&display=swap" rel="stylesheet">

<style>

:root{
    --cream:#FBF1DE;
    --maroon:#7A1F1F;
    --maroon-dark:#541313;
    --mustard:#F4C95D;
    --paper:#FFFDF8;
    --green:#2E7D32;
}

*{
    margin:0;
    padding:0;
    box-sizing:border-box;
}

body{
    font-family:'Mukta',sans-serif;
    background:var(--cream);
    min-height:100vh;
    display:flex;
    justify-content:center;
    align-items:center;
    padding:20px;
}

/* SUCCESS CARD */

.box{
    background:var(--paper);
    width:100%;
    max-width:520px;
    padding:45px 40px;
    border-radius:22px;
    text-align:center;
    box-shadow:0 12px 30px rgba(0,0,0,0.12);
    position:relative;
    overflow:hidden;
}

/* TOP COLOR BAR */

.box::before{
    content:"";
    position:absolute;
    top:0;
    left:0;
    right:0;
    height:6px;
    background:linear-gradient(
        90deg,
        var(--maroon),
        var(--mustard),
        var(--green)
    );
}

/* ICON */

.icon{
    width:90px;
    height:90px;
    border-radius:50%;
    background:#E8F5E9;
    color:var(--green);
    display:flex;
    justify-content:center;
    align-items:center;
    font-size:42px;
    margin:0 auto 25px;
}

/* TITLE */

h1{
    color:var(--green);
    margin-bottom:14px;
    font-size:32px;
    font-family:'Rozha One',serif;
}

/* TEXT */

p{
    font-size:16px;
    color:#555;
    margin-bottom:12px;
    line-height:1.7;
}

.highlight{
    color:var(--maroon);
    font-weight:bold;
}

/* BUTTON */

.btn{
    display:inline-block;
    margin-top:25px;
    padding:14px 28px;
    background:var(--maroon);
    color:white;
    text-decoration:none;
    border-radius:12px;
    font-weight:bold;
    transition:0.3s;
}

.btn:hover{
    background:var(--maroon-dark);
    transform:translateY(-2px);
}

/* SMALL NOTE */

.note{
    margin-top:18px;
    font-size:13px;
    color:#888;
}

</style>

</head>

<body>

<div class="box">

    <div class="icon">
        ✅
    </div>

    <h1>Order Placed!</h1>

    <p>
        Thank you for ordering from
        <span class="highlight">SAMPURNA HOME FOODS</span>
    </p>

    <p>
        📞 Our team will contact you as soon as possible
        to confirm your order.
    </p>

    <p>
        ⏰ Expected confirmation time:
        <b>within 3 to 4 hours</b>
    </p>

    <p>
        🚚 Homemade pickles are freshly prepared
        with care and delivered safely.
    </p>

    <a href="index.jsp" class="btn">
        Continue Shopping
    </a>

    <div class="note">
        Need help? SAMPURNA HOME FOODS support.
    </div>

</div>

</body>
</html>