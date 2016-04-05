<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.Map" %>
<%@ page import="serverplus.*" %>

<%@ include file="checkDevicesCount.jsp" %>

<%
	String username = (String)session.getAttribute("username");
	String password = (String)session.getAttribute("password");
	String sessionid = (String)session.getAttribute("session");
	Integer _sid_ = new Integer(Integer.parseInt(sessionid));
	Session _session_ = (Main.getSessionMap()).get(_sid_);
	
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
    <script type="text/javascript" src="./js/jquery.min.js"></script>
    <script type="text/javascript" src="./js/bootstrap.min.js"></script>
    <script type="text/javascript" src="./js/bootstrap-tooltip.js"></script>
    <script type="text/javascript" src="./js/bootstrap-popover.js"></script>


	<script>
    
		var sections = {
		    'random': 'random',
		    'manual': 'manual' ,
		    'bssid' : 'bssid'

		};

		var last_selected_bssid = '';



	var _deviceFilter = function(select) {

//		  alert("LAST"+last_selected_bssid);
//		  alert("CUTTENT"+select.value);

		  if(last_selected_bssid == '' || last_selected_bssid == 'dummy'){
//		  		alert("HAI");
		  }
		  else {
		  	document.getElementById(last_selected_bssid).style.display = "none";		    	
//		  	alert("HELLO");
		  }
		    
		  last_selected_bssid =  select.value;
		    	
//		alert("TABLE "+select.value+document.getElementById("_bssid").style.display );
		    	
		document.getElementById("_bssid").style.display = "block";			    	
		document.getElementById(select.value).style.display = "block";		
		window.location.hash = select.getElementsByTagName('option')[select.selectedIndex].value;    	
		    
		}

    
		var deviceFilter = function(select) {
			//alert(select);
		    for(i in sections){
		    //	alert("I"+i+sections[i]);
		        document.getElementById(sections[i]).style.display = "none";    
		    }

		    if( select.value == 'bssid'){
//		    	alert(select.value);
		    }

		    if(select.value == 'random' || select.value == 'manual' ){
				document.getElementById("_bssid").style.display = "none";			    	
		    }
		    //alert("#"+document.getElementById("mytable").rows[1].cells[0].innerHTML);

		    document.getElementById(sections[select.value]).style.display = "block";
		    window.location.hash = select.getElementsByTagName('option')[select.selectedIndex].value;
		}

	</script>

	<script type="text/javascript">

		function check_checkboxes(){
		  var c = document.getElementsByTagName('input');
		  for (var i = 0; i < c.length; i++){
		    if (c[i].type == 'checkbox'){
		       if (c[i].checked) {return true}
		    }
		  }
		  return false;
		}

		function validate(){
		 	var range = <%out.print("" + _session_.getRegisteredClients().size());%>;
		   	if( document.addExperiment.filter.value == "random" ){
		   	 	if(document.addExperiment.filterNumber.validity && document.addExperiment.filterNumber.validity.valid){
		   	 		if(range==0){
						alert("There are no device registered");
						return false;
					}
		   	 		else if(document.addExperiment.filterNumber.value > range || document.addExperiment.filterNumber.value <1){
		   	 			alert("Select number of devices in Range 1 to Total Device Registered");
		   	 			document.addExperiment.filterNumber.focus();
		   	 			return false;
		   	 		}
		   	 		else{
		   	 			alert("value selected is" + document.addExperiment.filterNumber.value);
		   	 			return true;
		   	 		}
		   		}
		   		else{
		   			alert("Enter number in positive integer");
		   			return false;
		   		}
		   	}
		   	else if(document.addExperiment.filter.value == "manual"){
		   		if(!check_checkboxes()){
        			alert("Select atleast one device for Experiment");  
        			return false;
    			}
    			return true;
		   	}
		   else{
		   		return true;
		   }	
		}
	</script>


  </head>

  	<script>
		$(document).ready(function(){
		    $(".pop-right").popover({
		        placement : 'right'
		    });
		});
		$('#filtering').val("random");
	</script>



  <body>

  <%@ include file="header.jsp" %>  
    

    <div class="content">
      <div class="container">
      
        <div class="page-header">        
			<h1>Load Generator's Server Handler</h1>
		</div>
			
		<div class="container-fluid">
			<h4>Session ID <%  out.print(sessionid); %>  </h4>
			<%@ include file="sessionValidation.jsp" %>

			<div class="row-fluid">
				<div class="span6">
					 <div>
						 <h4>Add Experiment</h4>
						<form method="post" action="addExperimentHandler.jsp" enctype="multipart/form-data" class="form-horizontal form-signin-signup" name="addExperiment" onsubmit="return(validate());">
							<input type="file" name="eventsFile" placeholder="Upload Event File" size="20" required> <br>
							<input type="text" name="expname" placeholder="Experiment Name" required>
							<input type="text" name="location" placeholder="Location of Experiment" required>
							<input type="text" name="description" placeholder="Add Description (Max 1000 characters)" required>
							<fieldset>          
								<div class="form-group">
									<div class="col-lg-3">
										<label for="filtering"><h4>Select your device filtering method</h4></label>
										<select class="form-control" name = "filter" id="filtering" onchange="deviceFilter(this);">
											<option value="bssid" selected>Based on BSSID</option>
											<option value="random" selected>Random</option>
											<option value="manual" >Manual</option>
										</select>
									</div>

									<div id="random">
										<br>
					<%
					out.print("<input type=\"number\" name=\"filterNumber\" style=\"height:2em\" id=\"replynumber\" class=\"form-control\" " 
						+ "\" step=\"1\" value= \"0\""  + "/>");
					%>			


										<!--<input type="number" id="replyNumber" class="form-control bfh-number" min="1" max="10" step="1" data-bind="value:replyNumber" /> -->
								        <br>
								    </div>

								</div>
							</fieldset>
							


						    <div id="manual" style="display:none;">
						        <h4>Select from following registered devices</h4> 
							<div class="bs-example-tooltips">
								<table class="table">
									<thead>
										<tr>

                                            <th>Sl No</th>
                                            <th>Select</th>
											<th>BSSID</th>
                                            <th>SSID</th>
											<th>Device</th>
										</tr>
									</thead>
									<tbody>

			<%  int ser = 0;
				for(Map.Entry<String, DeviceInfo> e : _session_.getRegisteredClients().entrySet()){
                    ser ++ ;
					DeviceInfo d = e.getValue();
					out.print("<tr>");
                        out.print("<td>"+ser+"</td><td><input type=\"checkbox\" name=\"devices\" value=\""+d.getMacAddress()+"\" /></td>");
					out.print("<td>"+d.getBssid()+"</td>");
					out.print("<td>"+d.getSsid()+"</td>");
					out.print("<td>"
						+ "<button type=\"button\" class=\"btn btn-success btn-xs pop-right\"" 
						+ " data-container=\"body\" data-original-title=\"" +d.getMacAddress()
						+ "\" data-toggle=\"popover\" data-placement=\"right\" data-content=\"OS Version: "
						+ d.getOsVersion()+"<br> Wifi Version: "+ d.getWifiVersion() 
			            + "<br> Number of cores: " +d.getNumberOfCores() +"<br> Storage Space: "+d.getStorageSpace()
			            + "<br> Memory: "+d.getMemory()+"<br> Processor Speed: "+d.getProcessorSpeed()
			            + "<br> Signal Strength: "+d.getRssi()+" dBm\"> "
			            + d.getMacAddress()+"</button>"
						+ "</td>");
					out.print("</tr>");
				}
			%>

							</tbody>	
							</table>
							</div>
						    </div>

								<div id="bssid" class="col-lg-3"  style="display:none;">
										<label for="filtering"><h4>Select your BSSID</h4></label>
										<select class="form-control" name = "_filter" id="_filtering" onchange="_deviceFilter(this);">
											

			<%
				for(Map.Entry<String, DeviceInfo> e : _session_.getRegisteredClients().entrySet()){
					DeviceInfo d = e.getValue();
					out.print("<option value=\""+d.getBssid()+"\" selected>"+d.getBssid()+"</option>");
				}
			%>
					<option value="dummy" selected="selected">--------</option>
								
									</select>
									</div>

			

						    <div id="_bssid" style="display:none;">
						        <h4>Select from following registered devices</h4> 
							<div class="bs-example-tooltips">
								<table class="table">
									<thead>
										<tr>
											<th>Select Device (MAC Address)</th>
										<!--	<th>BSSID</th>-->
											<th></th>
										</tr>
									</thead>
									<tbody>

			<%
				//out.print("<tr style=\"display:none;\" id=\"sample\"><td>one</td><td>two</td><td>three</td></tr>");

				for(Map.Entry<String, DeviceInfo> e : _session_.getRegisteredClients().entrySet()){
					DeviceInfo d = e.getValue();
					out.print("<tr style=\"display:none;\" id=\""+d.getBssid()+"\">");
					out.print("<td><input type=\"checkbox\" name=\"devices\" value=\""+d.getMacAddress()+"\" /></td>");
					//out.print("<td>"+d.getBssid()+"</td>");
					out.print("<td>"
						+ "<button type=\"button\" class=\"btn btn-success btn-xs pop-right\"" 
						+ " data-container=\"body\" data-original-title=\"" +d.getMacAddress()
						+ "\" data-toggle=\"popover\" data-placement=\"right\" data-content=\"OS Version: "
						+ d.getOsVersion()+"<br> Wifi Version: "+ d.getWifiVersion() 
			            + "<br> Number of cores: " +d.getNumberOfCores() +"<br> Storage Space: "+d.getStorageSpace()
			            + "<br> Memory: "+d.getMemory()+"<br> Processor Speed: "+d.getProcessorSpeed()
			            + "<br> Signal Strength: "+d.getWifiSignalStrength()+"\"> "
			            + d.getMacAddress()+"</button>"
						+ "</td>");
					out.print("</tr>");
				}
			%>

									</tbody>	
								</table>
							</div>

						    </div>


							<br>
							<input type="submit" name="startExperiment" value="Start Experiment" class="btn btn-primary btn-large">
							<input type="reset" name="reset" value="     Reset Fields      " class="btn btn-warning btn-large">
						</form>
					</div>
									 
					 
					</div>
					<div class="span6">
						<%@ include file="summary.jsp" %>
					</div>
				</div>
				
				<%@ include file="sessionExpiredMessage.msg" %>
				<%@ include file="closeBracket.msg" %>
				
			</div>     
		</div>
    </div>

	<%@ include file="footer.jsp" %>

   
  </body>
</html>

<%@ include file="closeBracket.msg" %>
      
