<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%> 
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>Home Page</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" type="text/css" href="css/style.css"/>  
</head>
<body>
<%
Date date = new Date();
SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy"); 
String strDate = sdf.format(date); 
%>
<!-- <div id="header_container">
    <div id="header" style=" text-align: left;">
        <img src="images/logo.JPG"/>&nbsp;&nbsp;<img src="images/home.png"/>
    </div>
</div> -->
<div id="container">
    <div id="content"> 
  <div id="menu" style="font-size: 15px;font-family: Arial;">
  <a href="homepage.jsp"><strong>Home</strong></a> &nbsp; &nbsp; &nbsp; &nbsp; 
  <a href="http://all-free-download.com/free-website-templates/"><strong>ERP</strong> </a> &nbsp; &nbsp; &nbsp; &nbsp; 
  <a href="http://all-free-download.com/free-website-templates/"><strong>ComplaintZilla</strong></a> &nbsp; &nbsp; &nbsp; &nbsp;
  <a href="http://all-free-download.com/free-website-templates/"><strong>IT Tracker</strong></a> &nbsp; &nbsp; &nbsp; &nbsp;
  <a href="http://all-free-download.com/free-website-templates/"><strong>MIKI</strong></a> &nbsp; &nbsp; &nbsp; &nbsp;  
  <a href="http://all-free-download.com/free-website-templates/"><strong>DVP BOSS</strong></a> &nbsp; &nbsp; &nbsp; &nbsp; 
  <a href="http://all-free-download.com/free-website-templates/"><strong>ECN</strong></a> &nbsp; &nbsp; &nbsp; &nbsp;
  <a href="http://all-free-download.com/free-website-templates/"><strong>Get My Kaizen</strong></a> &nbsp; &nbsp; &nbsp; &nbsp; 
  <a href="http://all-free-download.com/free-website-templates/"><strong>IT Helpline</strong></a> &nbsp; &nbsp; &nbsp; &nbsp; 
  </div>
  <div style="height: 30px;">
 <strong style="color: red;">TODAY'S HEADLINES &#8680;&nbsp;&nbsp; </strong> <marquee WIDTH="75%"><b style="color: green;">Moulding excellence into Quality Castings</b></marquee>
  </div> 
  <div id="sidebar">
  <div style="background-color:#B6CBDB;background-repeat: repeat-x;height: 30px;">
 <strong>Today's Birthday </strong> <br/> 
 <hr />
</div> 
 <marquee direction="up" scrolldelay="200"">
 <div style="font-size: 13px;">
 <strong>Mr. Vijay B. Main</strong><br/>
 Mutha Engineering Pvt. Ltd.<br/>
 (10/10/1985)
 </div>
 <hr />
 <div style="font-size: 13px;">
 <strong>Mr. Vijay B. Main</strong><br/>
 Mutha Engineering Pvt. Ltd.<br/>
 (10/10/1985)
 </div>
 <hr />
 <div style="font-size: 13px;">
 <strong>Mr. Vijay B. Main</strong><br/>
 Mutha Engineering Pvt. Ltd.<br/>
 (10/10/1985)
 </div>
 <hr />
 </marquee>
  <br/>
  <br/> 
 <div style="background-color:#B6CBDB;background-repeat: repeat-x;height: 30px;">
 <strong>User Login  </strong> <br/> 
 <hr />
</div>
<%
if (session.getAttribute("loggedIn") != null) { 
        	System.out.println("Logged IN");
%>
<form action="UserLogin_Controller"> 
 <input  type="submit" value="Add Information" style="width: 100px;height: 30px;"/>
 </form>
	<%                
          }else if (session.getAttribute("loggedIn") == null) { 
        	  System.out.println("Not Logged IN");
	%>
<form action="UserLogin_Controller">
 User Name  :<input  type="text" name="name" style="background-color: #EDF7EE;"/>
 Password : <input  type="password" name="name" style="background-color:  #EDF7EE;"/>
 <input  type="submit" value="Login" style="width: 100px;height: 30px;"/>
 </form>
	<%            
         }  
   %>
 </div> 
 
 
  <div id="main" style="overflow: scroll;">
    <h2>Latest News &#8680; </h2>is a free template released by Reality Software under the <a target="_blank" href="http://creativecommons.org/licenses/by/3.0/">Creative Commons Attribution 3.0</a> license, which means you can use it in any way you want provided you keep the link to the author intact.
    <h2>Lorem ipsum dolor?</h2>
    <p>Praesent aliquam,  justo convallis luctus rutrum, erat nulla fermentum diam, at nonummy quam  ante ac quam. Quisque ornare risus quis  ligula. Phasellus tristique purus a augue condimentum adipiscing. Aenean  sagittis. Etiam leo pede, <a href="http://all-free-download.com/free-website-templates/">rhoncus venenatis</a>, tristique in, vulputate at,  odio. Donec et ipsum et sapien vehicula nonummy. Suspendisse potenti. Fusce  varius urna id quam.</p>
    <h2>Suspendisse potenti?</h2>
    <p>Quisque ornare risus quis  ligula. Phasellus tristique purus a augue condimentum adipiscing. Aenean  sagittis. Etiam leo pede, rhoncus venenatis, tristique in, vulputate at,  odio. Donec et ipsum et sapien vehicula nonummy. Suspendisse potenti. Fusce  varius urna id quam. In eget purus. Integer <a href="http://all-free-download.com/free-website-templates/">turpis arcu</a>, pellentesque eget, cursus et, fermentum ut,  sapien. Fusce metus mi, eleifend sollicitudin, molestie id, varius et, nibh.</p>
    <p>Quisque ornare risus quis  ligula. Phasellus tristique purus a augue condimentum adipiscing. Aenean  sagittis. Etiam leo pede, rhoncus venenatis, tristique in, vulputate at,  odio. Donec et ipsum et sapien vehicula nonummy. Suspendisse potenti. Fusce  varius urna id quam. In eget purus. Integer <a href="http://all-free-download.com/free-website-templates/">turpis arcu</a>, pellentesque eget, cursus et, fermentum ut,  sapien. Fusce metus mi, eleifend sollicitudin, molestie id, varius et, nibh.</p>
    <p>Quisque ornare risus quis  ligula. Phasellus tristique purus a augue condimentum adipiscing. Aenean  sagittis. Etiam leo pede, rhoncus venenatis, tristique in, vulputate at,  odio. Donec et ipsum et sapien vehicula nonummy. Suspendisse potenti. Fusce  varius urna id quam. In eget purus. Integer <a href="http://all-free-download.com/free-website-templates/">turpis arcu</a>, pellentesque eget, cursus et, fermentum ut,  sapien. Fusce metus mi, eleifend sollicitudin, molestie id, varius et, nibh.</p>
    <p>Quisque ornare risus quis  ligula. Phasellus tristique purus a augue condimentum adipiscing. Aenean  sagittis. Etiam leo pede, rhoncus venenatis, tristique in, vulputate at,  odio. Donec et ipsum et sapien vehicula nonummy. Suspendisse potenti. Fusce  varius urna id quam. In eget purus. Integer <a href="http://all-free-download.com/free-website-templates/">turpis arcu</a>, pellentesque eget, cursus et, fermentum ut,  sapien. Fusce metus mi, eleifend sollicitudin, molestie id, varius et, nibh.</p>
    <p>Quisque ornare risus quis  ligula. Phasellus tristique purus a augue condimentum adipiscing. Aenean  sagittis. Etiam leo pede, rhoncus venenatis, tristique in, vulputate at,  odio. Donec et ipsum et sapien vehicula nonummy. Suspendisse potenti. Fusce  varius urna id quam. In eget purus. Integer <a href="http://all-free-download.com/free-website-templates/">turpis arcu</a>, pellentesque eget, cursus et, fermentum ut,  sapien. Fusce metus mi, eleifend sollicitudin, molestie id, varius et, nibh.</p>
    <p>Quisque ornare risus quis  ligula. Phasellus tristique purus a augue condimentum adipiscing. Aenean  sagittis. Etiam leo pede, rhoncus venenatis, tristique in, vulputate at,  odio. Donec et ipsum et sapien vehicula nonummy. Suspendisse potenti. Fusce  varius urna id quam. In eget purus. Integer <a href="http://all-free-download.com/free-website-templates/">turpis arcu</a>, pellentesque eget, cursus et, fermentum ut,  sapien. Fusce metus mi, eleifend sollicitudin, molestie id, varius et, nibh.</p>
    <p>Quisque ornare risus quis  ligula. Phasellus tristique purus a augue condimentum adipiscing. Aenean  sagittis. Etiam leo pede, rhoncus venenatis, tristique in, vulputate at,  odio. Donec et ipsum et sapien vehicula nonummy. Suspendisse potenti. Fusce  varius urna id quam. In eget purus. Integer <a href="http://all-free-download.com/free-website-templates/">turpis arcu</a>, pellentesque eget, cursus et, fermentum ut,  sapien. Fusce metus mi, eleifend sollicitudin, molestie id, varius et, nibh.</p>
    <p>Quisque ornare risus quis  ligula. Phasellus tristique purus a augue condimentum adipiscing. Aenean  sagittis. Etiam leo pede, rhoncus venenatis, tristique in, vulputate at,  odio. Donec et ipsum et sapien vehicula nonummy. Suspendisse potenti. Fusce  varius urna id quam. In eget purus. Integer <a href="http://all-free-download.com/free-website-templates/">turpis arcu</a>, pellentesque eget, cursus et, fermentum ut,  sapien. Fusce metus mi, eleifend sollicitudin, molestie id, varius et, nibh.</p>
    
  </div> 
</div>
<div id="footer" style="width: 900px; margin: 0 auto; background: #FFFFFF;">
<a href="http://www.muthagroup.com/"><strong>Mutha Group of Foundries</strong> </a> </span> &nbsp; | &nbsp;
Date :&nbsp;<strong><%=sdf.format(date) %></strong>
</div>
</div>

</body>
</html>