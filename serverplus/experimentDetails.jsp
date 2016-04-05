<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="serverplus.*" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.concurrent.ConcurrentHashMap" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.URL" %>
<%@ page import="java.net.URLEncoder" %>
<%@ include file="checksession2.jsp" %>

<%
	String username = (String)session.getAttribute("username");
	String exp = (String)request.getParameter(Constants.getExpID());
	if(exp==null) response.sendRedirect("index.jsp");
		int expid = Integer.parseInt(exp);
		
	int filescount=0;	
	String sessionid= (String)session.getAttribute("session");
	String back = "<a href=\"listExperiments.jsp\">Back</a>";
%>

<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="ServerHandler">
    <meta name="IITB" content="IITB Wi-Fi Load Generator">
    <title>ServerHandler</title>
	
	<link type="text/css" rel="stylesheet" href="./css/bootstrap.min.css" />
	<link type="text/css" rel="stylesheet" href="./css/bootstrap-responsive.min.css" />
	<link type="text/css" rel="stylesheet" href="./css/font-awesome.css" />
	<link type="text/css" rel="stylesheet" href="./css/font-awesome-ie7.css" />
	<link type="text/css" rel="stylesheet" href="./css/boot-business.css" />
	<script type="text/JavaScript">
		<!--
		function AutoRefresh( t ) {
			setTimeout("location.reload(true);", t);
		}
		//   -->
	</script>
	

</head>
<body onload="JavaScript:AutoRefresh(5000);">

	<%@ include file="header.jsp" %>  
    

	<div class="content">
		<div class="container">
      
			<div class="page-header">        
				<h1>Load Generator's Server Handler</h1>
			</div>
			<div>
				<%out.print(back);%>
			</div>
			
			<div>
				<h3> Experiment <% out.print(exp); %> </h3>
<%
	DBManager db = new DBManager();
	ResultSet rs = db.getExperimentDetails(expid);
	
	
	if(rs==null){
		out.print("<h4>There are no experiment details yet...</h4>");
	}
	else{
//     out.print("<h4>There are experiment details yet...</h4>");
%>		
				<table class="table">
					<thead>
						<tr>
							<th>Mac Address</th>
							<th>IP Address</th>
							<th>RSSI</th>
							<th>BSSID</th>
							<th>SSID</th>
							<th>Link Speed</th>

							<th>OS Build</th>

						<!--	<th>Wifi</th>  rs.getString(4)
							<th>Cores</th>  rs.getInt(5)
							<th>Space </th> rs.getInt(6)
							<th>Memory </th> rs.getInt(7)
							<th>Processor Speed </th>  rs.getInt(8)
						-->

							<th>Signal Strength <br/>(Scaled 1 to 10)</th>
							<th>Summary Log</th>
							<th>Detail Log</th>
						</tr>
					</thead>
					<tbody>
<%
		while(rs.next()){
%>				
					<tr>
						<td><%out.print(""+rs.getString(2));%></td>  
						<td><%out.print(""+rs.getString(15));%></td>  
						<td><%out.print(""+rs.getString(11));%> dBm</td>  
						<td><%out.print(""+rs.getString(12));%></td>  
						<td><%out.print(""+rs.getString(13));%></td>  
						<td><%out.print(""+rs.getString(14));%> Mbps</td>  
						<td><%out.print(""+rs.getInt(3));%></td>   
 
						<td><%out.print(""+rs.getInt(9));%></td>
						<td>
						<%
							boolean received = (boolean)rs.getBoolean(10);
							if(!received) out.print("Not Received");
							else{
							String url = "download.jsp?" + URLEncoder.encode("random word £500 bank $", "UTF-8");
								out.print("<a href=\"download.jsp?" + Constants.getExpID() +"="+ rs.getInt(1) 
								+ "&download=log&" + "file" + "="
								+ URLEncoder.encode((String)rs.getString(2) + "_summary.log", "UTF-8")   
								+ "\" > Download </a>");
							
							filescount++;
							}
						%>
						</td>

						<td>
						<%
							boolean dreceived = (boolean)rs.getBoolean(10);
							if(!dreceived) out.print("Not Received");
							else{
							String durl = "download.jsp?" + URLEncoder.encode("random word £500 bank $", "UTF-8");
								out.print("<a href=\"download.jsp?" + Constants.getExpID() +"="+ rs.getInt(1) 
								+ "&download=detail&" + "file" + "="
								+ URLEncoder.encode((String)rs.getString(2), "UTF-8")   
								+ "\" > Download </a>");
							
							filescount++;
							}
						%>
						</td>	
						 
					</tr>
<%				
		}
		db.closeConnection();
	}
%>
					</tbody>
				</table>
			</div>
			<div>
			<%
				if(filescount>0){
					out.print("<a href=\"downloadzip.jsp?" + Constants.getExpID() +"="+ expid + "\" > Download all </a>");
				}
			%>
			</div>
		</div>
	</div>
	
	
	<%@ include file="footer.jsp" %>
    <script type="text/javascript" src="./js/jquery.min.js"></script>
    <script type="text/javascript" src="./js/bootstrap.min.js"></script>
   
  </body>
</html>
<%@ include file="closeBracket.msg" %>
