<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="java.sql.ResultSet"%>
<%@page import="com.muthagroup.connectionModel.Connection_Utility"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.muthagroup.bo.Get_UName_bo"%>
<%@page import="java.sql.PreparedStatement"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>DVP SHeet</title>
<style type="text/css">
input.groovybutton {
	font-size: 14px;
	font-family: Georgia, serif;
	font-weight: bold;
	width: 200px;
	height: 30px;
	border-style: outset;
}
</style>

<meta name="keywords"
	content="Free CSS Template, Architect Website, XHTML, CSS" />
<meta name="description"
	content="Architect is a free CSS template or a free XHTML CSS layout for everyone." />
<link href="templatemo_style.css" rel="stylesheet" type="text/css" />
<!-- 
Date Picker======>
 -->
<link rel="stylesheet" href="js/jquery-ui.css" />
<script src="js/jquery-1.9.1.js"></script>
<script src="js/jquery-ui.js"></script>
<script type="text/javascript" src="tabledeleterow.js"></script>

<script type="text/javascript" src="js/highslide.js"></script>
<link rel="stylesheet" type="text/css" href="css/highslide.css" />

<script type="text/javascript">
	hs.graphicsDir = 'graphics/';
	hs.outlineType = null;
	hs.wrapperClassName = 'colored-border';
</script>

<script type="text/javascript">

function validateForm(){
	var dropdown=document.getElementById("customer"); 
	var custNew=document.getElementById("customerNew");
	var part=document.getElementById("part_name"); 
	var partNew=document.getElementById("newPart"); 
	var partno=document.getElementById("part_no");
	var partno_New=document.getElementById("partNo");
	var rNo=document.getElementById("revision_no");
	var grade=document.getElementById("grade_type");
	var gradeNew=document.getElementById("gradeTypeNew");
	var rivisionDate=document.getElementById("datepicker");
	var plantName=document.getElementById("plant_name");
	var plantVendor=document.getElementById("plant_vendor");
	var plantVendorNew=document.getElementById("plantVendorNew");
	var projectLeader=document.getElementById("project_leader"); 
	var castingFrom=document.getElementById("casting_from");
	var relatedPerson=document.getElementById("related_person");
	var castingVendor=document.getElementById("casting_vendor");
	var castingVendorNew=document.getElementById("newCastingVendor"); 
	var plannedStartDate=document.getElementById("plannedstart_date");	
	var plannedEndDate=document.getElementById("plannedend_date");
	var marketingAppr=document.getElementById("marketing_apr");
	var shedulePerMonth=document.getElementById("schedule_per_month");
	var poNumber=document.getElementById("po_number");
	var cust_PoDate=document.getElementById("po_date");
	var dev_PORecDate=document.getElementById("po_receivedDate");
	var attachedPO=document.getElementById("attachedPO");
	 var partImage=document.getElementById("partImage");
	var model2d=document.getElementById("model2d");
	/*
	var poCustImage=document.getElementById("attachedPO");
	var partImage=document.getElementById("partImage");
	var model2dImage=document.getElementById("model2d");
	*/

	
 if(dropdown.disabled ==false){
	 if(dropdown.value=="0" || dropdown.value==null){
		alert("Please Provide Customer !!!");
		return false;
	 }
	} 
 if(dropdown.disabled==true){
	 if(custNew.value==null || custNew.value==""){
		alert("Please Provide Customer !!!!");
		return false;
	 }
	}
 
 if(part.disabled==false){
	 if(part.value=="0" || part.value==null){
		 alert("Please Provide Part !!!");
		 return false;
	 }
 }
 if(part.disabled==true){
	 if(partNew.value==null || partNew.value==""){
		 alert("Please Provide Part !!!");
		 return false;
	 }
 }
 
 if(partno.disabled ==false){
	 if(partno.value=="" || partno.value==null || partno.value=="0"){
		alert("Please Provide Part No !!!");
		return false;
	 }
	} 
 if(partno.disabled==true){
	 if(partno_New.value==null || partno_New.value==""){
		alert("Please Provide Part No !!!");
		return false;
	 }
	}
 
 if(rNo.value=="" || rNo.value==null){
	 alert("Please Provide Revision No !!!");
		return false;
 }
 
	if(grade.disabled ==false){
		 if(grade.value=="0" || grade.value==null || grade.value==""){
			alert("Please Provide Grade !!!");
			return false;
		 }
		} 
	 if(grade.disabled==true){
		 if(gradeNew.value==null || gradeNew.value==""){
			alert("Please Provide Grade !!!!");
			return false;
		 }
		}

	 if(rivisionDate.value=="" || rivisionDate.value==null){
		 alert("Please Provide Rivision Date !!!");
			return false;
	 }

  
 if(plantVendor.disabled==false && plantVendor.value=="null" && plantName.value=="0"){
	 alert("Please Provide Plant Name / Vendor !!!");
		return false;	 
 }
 
 if(plantVendor.disabled==true && (plantVendorNew.value==null || plantVendorNew.value=="") && plantName.value=="0"){
	 alert("Please Provide Plant Name / Vendor !!!");
		return false;
 }
	 
 if(projectLeader.value=="0" || projectLeader.value==null || projectLeader.value==""){
	 alert("Please Provide Project Leader !!!");
		return false;
 }
 
 
 if(castingVendor.disabled==false && castingVendor.value=="null" && castingFrom.value=="0"){
	 alert("Please Provide Casting From / Vendor !!!");
		return false;	 
 }
 
 if(castingVendor.disabled==true && (castingVendorNew.value==null || castingVendorNew.value=="") && castingFrom.value=="0"){
	 alert("Please Provide Casting From / Vendor !!!");
		return false;
 }
 if(relatedPerson.value=="0" || relatedPerson.value==null || relatedPerson.value==""){
	 alert("Please Provide Related Person !!!");
		return false;
 }
 
 if(plannedStartDate.value=="" || plannedStartDate.value==null){
	 alert("Please Provide Planned Start Date !!!");
		return false;
 }
 if(plannedEndDate.value=="" || plannedEndDate.value==null){
	 alert("Please Provide Planned End Date !!!");
		return false;
 }
 if(marketingAppr.value=="" || marketingAppr.value==null || marketingAppr.value!="approved"){
	 alert("Marketing Approval Is Required!!!");
		return false;
 }
 
 if(shedulePerMonth.value=="" || shedulePerMonth.value==null){
	 alert("Please Provide Schedule/Month !!!");
		return false;
 }
 if(poNumber.value==""  || poNumber.value==null){
	 alert("Please Provide PO Number !!!");
		return false;
 }
 if(cust_PoDate.value=="" || cust_PoDate.value==null){
	 alert("Please Provide PO Date Customer !!!");
		return false;
 }
 if(dev_PORecDate.value=="" || dev_PORecDate.value==null){
	 alert("Please Provide PO Received Date ( Development ) !!!");
		return false;
 }
 
 if(attachedPO.value=="" || attachedPO.value==null){
	 alert("Please Attach PO !!!");
		return false;
 }
 
	if(partImage.disabled ==false){
		 if(partImage.value=="" || partImage.value==null){
 alert("Please Attach Part Image!!!");
	return false;
	 }
}
 
 if(model2d.value=="" || model2d.value==null){
	 alert("Please Attach 2D Model!!!");
		return false;
 }
 
 
  
	 return true;
}
</script>


<script type="text/javascript">
function editvalidateForm(){
	var customer=document.getElementById("customer");
	var custEditBtn=document.getElementById("to_editCust");
	var custEdit=document.getElementById("edit_Cust");
	var custNewBtn=document.getElementById("btn");
	var customerNew=document.getElementById("customerNew");
	var partName=document.getElementById("part_name");
	var editPartBtn=document.getElementById("to_editPart");
	var editPart=document.getElementById("part_edit");
	var partNewBtn=document.getElementById("pbtn");
	var partNameNew=document.getElementById("partNameNew");
	var partNo=document.getElementById("part_no");
	var pnoEditBtn=document.getElementById("partno_edit");
	var editPartNo=document.getElementById("editPartno");
	var revisionNo=document.getElementById("revision_no"); 
	var partNoNewBtn=document.getElementById("newpnbtn"); 
	var PartNoNew=document.getElementById("PartNoEdit"); 
	var grade=document.getElementById("grade_type");
	var gradeEdit=document.getElementById("editgrade"); 
	var gradeBtn=document.getElementById("grdbtn");
	var gradeNew=document.getElementById("gradeNew"); 
	var revisionDate=document.getElementById("datepicker"); 
	var plantName=document.getElementById("plant_name");
	var plantVendor=document.getElementById("plant_vendor"); 
	var editPVBtn=document.getElementById("edit_PlantVendor"); 
	var editplantVendor=document.getElementById("editMCVendorName"); 
	var newPvBtn=document.getElementById("pvendbtn");
	var newPlantVendor=document.getElementById("newMCvendor"); 
	var project_Lead=document.getElementById("project_leader"); 
	var relatedPerson=document.getElementById("related_person"); 
	var castFrom=document.getElementById("casting_from");
	var castingVendor=document.getElementById("casting_vendor");
	var castVendBtn=document.getElementById("edit_castVendor");
	var editCastVendor=document.getElementById("castVendor"); 
	var castVendorNewBtn=document.getElementById("castVendbtn");
	var newCastingVendor=document.getElementById("newCastVendor"); 
	var plannedStartDate=document.getElementById("plannedstart_date");
	var plannedEndDate=document.getElementById("plannedend_date");
	var marketingApproval=document.getElementById("marketing_apr");
	var shedulePerMonth=document.getElementById("schedule_per_month");
	var poNumber=document.getElementById("po_number");
	var PoDate=document.getElementById("po_date");
	var devPoRecDate=document.getElementById("po_receivedDate");
	
	
	
	
	

	if(custEditBtn.disabled ==false){
		 if(customer.value=="null" || customer.value==null || customer.value=="" || customer.value=="0"){
			alert("Please Provide Customer !!!");
			return false;
		 }
		}
	if(custEditBtn.disabled ==true){
		 if(custEdit.value=="null" || custEdit.value==null || custEdit.value=="" || custEdit.value=="0"){
			alert("Please Provide Customer !!!");
			return false;
		 }
		}
	
	if(custNewBtn.disabled ==true){
		 if(customerNew.value=="null" || customerNew.value==null || customerNew.value=="" || customerNew.value=="0"){
			alert("Please Provide Customer !!!");
			return false;
		 }
		}
	
	if(editPartBtn.disabled ==false){
		 if(partName.value=="null" || partName.value==null || partName.value=="" || partName.value=="0"){
			alert("Please Provide Part Name !!!");
			return false;
		 }
		}
	if(editPartBtn.disabled ==true){
		 if(editPart.value=="null" || editPart.value==null || editPart.value=="" || editPart.value=="0"){
			alert("Please Provide Part Name !!!");
			return false;
		 }
		}
	
	if(partNewBtn.disabled ==true){
		 if(partNameNew.value=="null" || partNameNew.value==null || partNameNew.value=="" || partNameNew.value=="0"){
			alert("Please Provide Part Name !!!");
			return false;
		 }
		}
	
	
	if(pnoEditBtn.disabled ==false){
		 if(partNo.value=="null" || partNo.value==null || partNo.value=="" || partNo.value=="0"){
			alert("Please Provide Part No !!!");
			return false;
		 }
		}
	if(pnoEditBtn.disabled ==true){
		 if(editPartNo.value=="null" || editPartNo.value==null || editPartNo.value=="" || editPartNo.value=="0"){
			alert("Please Provide Part No !!!");
			return false;
		 }
		}
	

	 if(revisionNo.value=="null" || revisionNo.value==null || revisionNo.value=="" || revisionNo.value=="0"){
			alert("Please Provide Revision No !!!");
			return false;
		 }	
	
		if(partNoNewBtn.disabled ==true){
			 if(PartNoNew.value=="null" || PartNoNew.value==null || PartNoNew.value=="" || PartNoNew.value=="0"){
				alert("Please Provide Part Number !!!");
				return false;
			 }
			}
	 
		if(grade.disabled ==false){
			 if(grade.value=="null" || grade.value==null || grade.value==""){
				alert("Please Provide Grade !!!");
				return false;
			 }
			}
		 if(grade.disabled==true){
			 if(gradeEdit.value==null || gradeEdit.value==""){
				alert("Please Provide Grade !!!");
				return false;
			 }
			}
		 
		 if(gradeBtn.disabled==true){
			 if(gradeNew.value==null || gradeNew.value==""){
				alert("Please Provide New Grade !!!");
				return false;
			 }
			}
		
		 if(revisionDate.value=="null" || revisionDate.value==null || revisionDate.value=="" || revisionDate.value=="0"){
				alert("Please Provide Revision Date !!!");
				return false;
			 }
		 
		 
		 if(editPVBtn.disabled ==false){
			 if((plantName.value=="null" || plantName.value==null || plantName.value=="" || plantName.value=="0") && (plantVendor.value=="null" || plantVendor.value==null || plantVendor.value=="" || plantVendor.value=="0")){
				alert("Please Provide Plant / Plant Vendor !!!");
				return false;
			 }
			}
		 if(editPVBtn.disabled==true){
			 if((editplantVendor.value==null || editplantVendor.value=="") && (plantName.value=="null" || plantName.value==null || plantName.value=="" || plantName.value=="0")){
				alert("Please Provide Plant / Plant Vendor !!!");
				return false;
			 }
			}
		
		 if(newPvBtn.disabled==true){
			 if((newPlantVendor.value==null || newPlantVendor.value=="") && (plantName.value=="null" || plantName.value==null || plantName.value=="" || plantName.value=="0")){
				alert("Please Provide Plant / New Plant Vendor !!!");
				return false;
			 }
			}
		  if(project_Lead.value=="null" || project_Lead.value==null || project_Lead.value=="" || project_Lead.value=="0"){
				alert("Please Provide Project Leader !!!");
				return false;
			 }
		 
		  if(relatedPerson.value=="null" || relatedPerson.value==null || relatedPerson.value=="" || relatedPerson.value=="0"){
				alert("Please Provide Related Person !!!");
				return false;
			 }
		  
		  
		  if(castVendBtn.disabled ==false){
				 if((castFrom.value=="null" || castFrom.value==null || castFrom.value=="" || castFrom.value=="0") && (castingVendor.value=="null" || castingVendor.value==null || castingVendor.value=="" || castingVendor.value=="0")){
					alert("Please Provide Casting From / Casting Vendor !!!");
					return false;
				 }
				}
			 if(castVendBtn.disabled==true){
				 if((editCastVendor.value==null || editCastVendor.value=="") && (castFrom.value=="null" || castFrom.value==null || castFrom.value=="" || castFrom.value=="0")){
					alert("Please Provide Casting From / Casting Vendor !!!");
					return false;
				 }
				}
			
			 if(castVendorNewBtn.disabled==true){
				 if((newCastingVendor.value==null || newCastingVendor.value=="") && (castFrom.value=="null" || castFrom.value==null || castFrom.value=="" || castFrom.value=="0")){
					alert("Please Provide Casting From / New Casting Vendor !!!");
					return false;
				 }
				}
	  
			 if(plannedStartDate.value=="null" || plannedStartDate.value==null || plannedStartDate.value=="" || plannedStartDate.value=="0"){
					alert("Please Provide Planned Start Date !!!");
					return false;
				 }
				if(plannedEndDate.value=="null" || plannedEndDate.value==null || plannedEndDate.value=="" || plannedEndDate.value=="0"){
					alert("Please Provide Planned End Date !!!");
					return false;
				 }
				if(marketingApproval.value=="null" || marketingApproval.value==null || marketingApproval.value=="" || marketingApproval.value=="0"){
					alert("Marketing Approval ???");
					return false;
				 }
				if(shedulePerMonth.value=="null" || shedulePerMonth.value==null || shedulePerMonth.value=="" || shedulePerMonth.value=="0"){
					alert("Please Provide Schedule / Month !!!");
					return false;
				 }
				if(poNumber.value=="null" || poNumber.value==null || poNumber.value=="" || poNumber.value=="0"){
					alert("Please Provide PO Number !!!");
					return false;
				 }
				if(PoDate.value=="null" || PoDate.value==null || PoDate.value=="" || PoDate.value=="0"){
					alert("Please Provide PO Date !!!");
					return false;
				 }
				if(devPoRecDate.value=="null" || devPoRecDate.value==null || devPoRecDate.value=="" || devPoRecDate.value=="0"){
					alert("Please Provide PO Received Date !!!");
					return false;
				 }
				
				
					  
			

		  
	return true;
				 
}

</script>


<script>
	$(function() {
		//	$("#datepicker").datepicker();
		$("#datepicker").datepicker({

		});
	});
	$(function() {
		//	$("#datepicker").datepicker();
		$("#start_date").datepicker({

		});
	});
	$(function() {
		//	$("#datepicker").datepicker();
		$("#end_date").datepicker({

		});
	});

	$(function() {
		//	$("#datepicker").datepicker();
		$("#plannedstart_date").datepicker({

		});
	});
	$(function() {
		//	$("#datepicker").datepicker();
		$("#plannedend_date").datepicker({

		});
	});

	$(function() {
		//	$("#datepicker").datepicker();
		$("#po_date").datepicker({

		});
	});
	$(function() {
		//	$("#datepicker").datepicker();
		$("#po_receivedDate").datepicker({

		});
	});

	$(function() {
		$("#accordion").accordion();
	});
</script>
<script>
$(function() {
$( "#menu" ).menu();
});
</script>

<script type="text/javascript">
function showPartImage(str){
	var xmlhttp;
	if (window.XMLHttpRequest) {
		// code for IE7+, Firefox, Chrome, Opera, Safari
		xmlhttp = new XMLHttpRequest();
	} else {
		// code for IE6, IE5
		xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
	}
	xmlhttp.onreadystatechange = function() {
		if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
			document.getElementById("showImage").innerHTML = xmlhttp.responseText;
		}
	};
	xmlhttp.open("POST", "ShowPartImages.jsp?q=" + str, true);
	xmlhttp.send();
};




function deletePo(str,str1,str2) {
	 
	var where_to = confirm("Do you really want to DELETE this file ???");
	if (where_to == true) {

		var xmlhttp;
		if (window.XMLHttpRequest) {
			// code for IE7+, Firefox, Chrome, Opera, Safari
			xmlhttp = new XMLHttpRequest();
		} else {
			// code for IE6, IE5
			xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
		}
		xmlhttp.onreadystatechange = function() {
			if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
				document.getElementById("delPO").innerHTML = xmlhttp.responseText;
			}
		};
		xmlhttp.open("POST", "Delete.jsp?basic_id=" + str +"&field="+str1+"&action="+str2, true);
		xmlhttp.send();
	} else {
		window.location.reload();
	}
} 
		function deletePart(str,str1,str2) {
			 
			var where_to = confirm("Do you really want to DELETE this file ???");
			if (where_to == true) {

				var xmlhttp;
				if (window.XMLHttpRequest) {
					// code for IE7+, Firefox, Chrome, Opera, Safari
					xmlhttp = new XMLHttpRequest();
				} else {
					// code for IE6, IE5
					xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
				}
				xmlhttp.onreadystatechange = function() {
					if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
						document.getElementById("delPart").innerHTML = xmlhttp.responseText;
					}
				};
				xmlhttp.open("POST", "Delete.jsp?basic_id=" + str +"&field="+str1+"&action="+str2, true);
				xmlhttp.send();
			} else {
				window.location.reload();
			}
		}
		
		function delete3dModel(str,str1,str2) {
			 
			var where_to = confirm("Do you really want to DELETE this file ???");
			if (where_to == true) {

				var xmlhttp;
				if (window.XMLHttpRequest) {
					// code for IE7+, Firefox, Chrome, Opera, Safari
					xmlhttp = new XMLHttpRequest();
				} else {
					// code for IE6, IE5
					xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
				}
				xmlhttp.onreadystatechange = function() {
					if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
						document.getElementById("del3d").innerHTML = xmlhttp.responseText;
					}
				};
				xmlhttp.open("POST", "Delete.jsp?basic_id=" + str +"&field="+str1+"&action="+str2, true);
				xmlhttp.send();
			} else {
				window.location.reload();
			}
		}
		function delete2dModel(str,str1,str2) {
			 
			var where_to = confirm("Do you really want to DELETE this file ???");
			if (where_to == true) {

				var xmlhttp;
				if (window.XMLHttpRequest) {
					// code for IE7+, Firefox, Chrome, Opera, Safari
					xmlhttp = new XMLHttpRequest();
				} else {
					// code for IE6, IE5
					xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
				}
				xmlhttp.onreadystatechange = function() {
					if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
						document.getElementById("del2D").innerHTML = xmlhttp.responseText;
					}
				};
				xmlhttp.open("POST", "Delete.jsp?basic_id=" + str +"&field="+str1+"&action="+str2, true);
				xmlhttp.send();
			} else {
				window.location.reload();
			}
		}
		
		
		function delother(str,str1,str2) {
			 
			var where_to = confirm("Do you really want to DELETE this file ???");
			if (where_to == true) {

				var xmlhttp;
				if (window.XMLHttpRequest) {
					// code for IE7+, Firefox, Chrome, Opera, Safari
					xmlhttp = new XMLHttpRequest();
				} else {
					// code for IE6, IE5
					xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
				}
				xmlhttp.onreadystatechange = function() {
					if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
						document.getElementById("delOther").innerHTML = xmlhttp.responseText;
					}
				};
				xmlhttp.open("POST", "Delete.jsp?basic_id=" + str +"&field="+str1+"&action="+str2, true);
				xmlhttp.send();
			} else {
				window.location.reload();
			}
		}
</script>

<script type="text/javascript">
	function getpart(str) {
		var xmlhttp;
		if (window.XMLHttpRequest) {
			// code for IE7+, Firefox, Chrome, Opera, Safari
			xmlhttp = new XMLHttpRequest();
		} else {
			// code for IE6, IE5
			xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
		}
		xmlhttp.onreadystatechange = function() {
			if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
				document.getElementById("part1").innerHTML = xmlhttp.responseText;
			}
		};
		xmlhttp.open("POST", "Part.jsp?q=" + str, true);
		xmlhttp.send();
	};

	function getpartno(str) {

		var xmlhttp;
		if (window.XMLHttpRequest) {
			// code for IE7+, Firefox, Chrome, Opera, Safari
			xmlhttp = new XMLHttpRequest();
		} else {
			// code for IE6, IE5
			xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
		}
		xmlhttp.onreadystatechange = function() {
			if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
				document.getElementById("partno1").innerHTML = xmlhttp.responseText;
			}
		};
		xmlhttp.open("POST", "Part_No.jsp?q=" + str, true);
		xmlhttp.send();

	}
</script>

<script>
	function getLeader(type) {
		var xmlhttp;
		if (window.XMLHttpRequest) {
			// code for IE7+, Firefox, Chrome, Opera, Safari
			xmlhttp = new XMLHttpRequest();
		} else {
			// code for IE6, IE5
			xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
		}
		xmlhttp.onreadystatechange = function() {
			if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
				document.getElementById("getLeader").innerHTML = xmlhttp.responseText;
			}
		};
		xmlhttp.open("POST", "Project_Leader.jsp", true);
		xmlhttp.send();
	};

	function getRelated(str1) {
		var xmlhttp1;
		if (window.XMLHttpRequest) {
			// code for IE7+, Firefox, Chrome, Opera, Safari
			xmlhttp1 = new XMLHttpRequest();
		} else {
			// code for IE6, IE5
			xmlhttp1 = new ActiveXObject("Microsoft.XMLHTTP");
		}
		xmlhttp1.onreadystatechange = function() {
			if (xmlhttp1.readyState == 4 && xmlhttp1.status == 200) {
				document.getElementById("getRelated").innerHTML = xmlhttp1.responseText;
			}
		};
		xmlhttp1.open("POST", "Related_Person.jsp?rel=" + str1, true);
		xmlhttp1.send();
	};

	function getRelatedVendor(str1) {
		var xmlhttp1;
		if (window.XMLHttpRequest) {
			// code for IE7+, Firefox, Chrome, Opera, Safari
			xmlhttp1 = new XMLHttpRequest();
		} else {
			// code for IE6, IE5
			xmlhttp1 = new ActiveXObject("Microsoft.XMLHTTP");
		}
		xmlhttp1.onreadystatechange = function() {
			if (xmlhttp1.readyState == 4 && xmlhttp1.status == 200) {
				document.getElementById("getRelated").innerHTML = xmlhttp1.responseText;
			}
		};
		xmlhttp1.open("POST", "Casting_Vendor.jsp?rel=" + str1 , true);
		xmlhttp1.send();
	};
</script>
<script type="text/javascript">
function validatenumerics(key) {
//getting key code of pressed key
var keycode = (key.which) ? key.which : key.keyCode;
//comparing pressed keycodes
 
if (keycode > 31 && (keycode < 48 || keycode > 57) && keycode != 46) {
    alert("Only allow numeric Data entry");
    return false;
}else 
{
	return true;
};
}
</script>


<script type="text/javascript">

function enablecust(type) {
	var e = document.getElementById("customer");
	e.setAttribute('disabled', 'disabled'); 
	var e = document.getElementById("to_editCust");
	e.setAttribute('disabled', 'disabled'); 
	document.getElementById("edit_Cust").disabled=false;
 }
 
function gradeEdit(type) {
	var e = document.getElementById("gradeEditbtn");
	e.setAttribute('disabled', 'disabled'); 
	var e = document.getElementById("grade_type");
	e.setAttribute('disabled', 'disabled'); 
	document.getElementById("editgrade").disabled=false;
 }
  
 
function editPartNo(type) {
	var e = document.getElementById("partno_edit");
	e.setAttribute('disabled', 'disabled'); 
	var e = document.getElementById("part_no");
	e.setAttribute('disabled', 'disabled'); 
	document.getElementById("editPartno").disabled=false;
 }


function edit_PartN(type){
	var e = document.getElementById("to_editPart");
	e.setAttribute('disabled', 'disabled');
	var e = document.getElementById("part_name");
	e.setAttribute('disabled', 'disabled');
	document.getElementById("part_edit").disabled=false;
 }


function editMcvendor(type) {
	var e = document.getElementById("edit_PlantVendor");
	e.setAttribute('onchange', getLeader(this.value));
	e.setAttribute('disabled', 'disabled');
	var e = document.getElementById("plant_vendor");
	e.setAttribute('disabled', 'disabled');
	document.getElementById("editMCVendorName").disabled=false;
	 
}

function editcastVendor(type) {
	var e = document.getElementById("edit_castVendor");
	e.setAttribute('onchange', getRelatedVendor(this.value));
	e.setAttribute('disabled', 'disabled');
	var e = document.getElementById("casting_vendor");
	e.setAttribute('disabled', 'disabled');
	document.getElementById("castVendor").disabled=false;
}

function addNewplantVendor(type) {

var element = document.createElement("input");
element.setAttribute("type", "text");
element.setAttribute("name", type);
element.setAttribute("id", "newMCvendor");
element.setAttribute("onchange", getLeader(type));
var here = document.getElementById("VenderP");
here.appendChild(element);
here.appendChild(element);
var e1 = document.getElementById("pvendbtn");
e1.setAttribute('disabled', 'disabled');
var e = document.getElementById("editMCVendorName");
e.setAttribute('disabled', 'disabled');
var e11 = document.getElementById("edit_PlantVendor");
e11.setAttribute('disabled', 'disabled');
var e2 = document.getElementById("plant_vendor");
e2.setAttribute('disabled', 'disabled');
}
function addnewgrad(type) {
	var element = document.createElement("input");
	element.setAttribute("type", "text");
	element.setAttribute("name", type);
	element.setAttribute("id", "gradeNew");
	var here = document.getElementById("newGrade");
	here.appendChild(element);

	var e1 = document.getElementById("grdbtn");
	e1.setAttribute('disabled', 'disabled');

	var e = document.getElementById("editgrade");
	e.setAttribute('disabled', 'disabled');
	
	
	var e11 = document.getElementById("gradeEditbtn");
	e11.setAttribute('disabled', 'disabled');

	var e2 = document.getElementById("grade_type");
	e2.setAttribute('disabled', 'disabled');
	
}

function addEditpartno(type) {
	var element = document.createElement("input");
	element.setAttribute("type", "text");
	element.setAttribute("name", type);
	element.setAttribute("id", "PartNoEdit");
	
	var here = document.getElementById("partno");
	here.appendChild(element);

	
	var e1 = document.getElementById("newpnbtn");
	e1.setAttribute('disabled', 'disabled');

	var e = document.getElementById("editPartno");
	e.setAttribute('disabled', 'disabled');
	
	
	var e11 = document.getElementById("partno_edit");
	e11.setAttribute('disabled', 'disabled');

	var e2 = document.getElementById("part_no");
	e2.setAttribute('disabled', 'disabled');
	
}
 
 
function editpart(type) {
	var element = document.createElement("input");
	element.setAttribute("type", "text");
	element.setAttribute("name", type);
	element.setAttribute("id", "partNameNew");
	var here = document.getElementById("part");
	here.appendChild(element);

	var e1 = document.getElementById("pbtn");
	e1.setAttribute('disabled', 'disabled');

	var e = document.getElementById("part_edit");
	e.setAttribute('disabled', 'disabled');
	
	
	var e11 = document.getElementById("to_editPart");
	e11.setAttribute('disabled', 'disabled');

	var e2 = document.getElementById("part_name");
	e2.setAttribute('disabled', 'disabled');
	
}

	function add(type) {
		var element = document.createElement("input");
		element.setAttribute("type", "text");
		element.setAttribute("name", type);
		element.setAttribute("id", "customerNew"); 
		var here = document.getElementById("here");
		here.appendChild(element);

		var e1 = document.getElementById("btn");
		e1.setAttribute('disabled', 'disabled');
		

		var e11 = document.getElementById("customer");
		var opt = document.createElement("option"); 
		   opt.text = 'disabled'; 
		   e11.options[e11.selectedIndex].value = 'addNew';
		   e11.options.add(opt);
		e11.setAttribute('disabled', 'disabled'); 
		
	}
	
	
	function newCust(type) {
		var element = document.createElement("input");
		element.setAttribute("type", "text");
		element.setAttribute("name", type);
		element.setAttribute("id", "customerNew"); 
		
		var here = document.getElementById("here");
		here.appendChild(element);

		var e = document.getElementById("customer");
		e.setAttribute('disabled', 'disabled');

		var e1 = document.getElementById("btn");
		e1.setAttribute('disabled', 'disabled');
		
		var e2 = document.getElementById("to_editCust");
		e2.setAttribute('disabled', 'disabled');
		
		var e3 = document.getElementById("edit_Cust");
		e3.setAttribute('disabled', 'disabled');
	}
	
	function addpart(type) {
		var element = document.createElement("input");
		element.setAttribute("type", "text");
		element.setAttribute("name", type); 
		element.setAttribute("id", "newPart");
		var here = document.getElementById("part");
		here.appendChild(element);

		var e1 = document.getElementById("part_name");
			var opt = document.createElement("option"); 
		   opt.text = 'disabled'; 
		   e1.options[e1.selectedIndex].value = 'partValue';
		   e1.options.add(opt);
		e1.setAttribute('disabled', 'disabled');

		var e = document.getElementById("pbtn");
		e.setAttribute('disabled', 'disabled');
	}

	function addpartno(type) {
		var element = document.createElement("input");
		element.setAttribute("type", "text");
		element.setAttribute("name", type);
		element.setAttribute("id", "partNo");
		element.setAttribute("onchange", "showPartImage(this.value)");
		var here = document.getElementById("partno");
		here.appendChild(element);

		var e1 = document.getElementById("part_no");
		e1.setAttribute('disabled', 'disabled');

		var e = document.getElementById("pnbtn");
		e.setAttribute('disabled', 'disabled');
	}

	function addcasting(type) {
		var element = document.createElement("input");
		element.setAttribute("type", "text");
		element.setAttribute("name", type);
		var here = document.getElementById("castfrm");
		here.appendChild(element);
		var e1 = document.getElementById("casting_from");
		e1.setAttribute('disabled', 'disabled');
		var e = document.getElementById("castbtn");
		e.setAttribute('disabled', 'disabled');
	}

	function addgradeno(type) {
		var element = document.createElement("input");
		element.setAttribute("type", "text");
		element.setAttribute("name", type);
		element.setAttribute("id", "gradeTypeNew");
		var here = document.getElementById("gradeno");
		here.appendChild(element);
		var e1 = document.getElementById("grade_type");
		e1.setAttribute('disabled', 'disabled');
		var e = document.getElementById("grdbtn");
		e.setAttribute('disabled', 'disabled');
	}

	function addMachiningVendor(type) {
		var element = document.createElement("input");
		element.setAttribute("type", "text");
		element.setAttribute("name", type);
		element.setAttribute("id", "plantVendorNew");
		element.setAttribute("onchange", getLeader(type));
		//element.onchange = getLeader(type);
		var here = document.getElementById("VenderPlant");
		here.appendChild(element);
		var e1 = document.getElementById("mcVendorBTN");
		e1.setAttribute('disabled', 'disabled');
		var e = document.getElementById("plant_vendor");
		e.setAttribute('disabled', 'disabled');

	}

	function addNewcastingVendor(type) {
		var element = document.createElement("input");
		var str = "0";
		element.setAttribute("type", "text");
		element.setAttribute("name", type);
		element.setAttribute("id", "newCastVendor");
		var here = document.getElementById("VenderCasting");
		here.appendChild(element);

		var e1 = document.getElementById("casting_vendor");
		e1.setAttribute('disabled', 'disabled');

		var e = document.getElementById("castVendbtn");
		e.setAttribute('disabled', 'disabled');
		
		var e1 = document.getElementById("castVendor");
		e1.setAttribute('disabled', 'disabled');

		var e = document.getElementById("edit_castVendor");
		e.setAttribute('disabled', 'disabled');
		
		element.onchange == getRelatedVendor(str);
 
	}
	
	
	function addcastingVendor(type) {
		var element = document.createElement("input");
		var str = "0";
		element.setAttribute("type", "text");
		element.setAttribute("name", type);
		element.setAttribute("id", "newCastingVendor");
		var here = document.getElementById("VenderCasting");
		here.appendChild(element);

		var e1 = document.getElementById("casting_vendor");
		e1.setAttribute('disabled', 'disabled');

		var e = document.getElementById("castVendbtn");
		e.setAttribute('disabled', 'disabled');
		
		element.onchange == getRelatedVendor(str);
 
	}
	
 
</script>

<!--********************************************************************************************************
 -->
</head>
<%
	int uid = 0;
	String User_Name = null;

	uid = Integer.parseInt(session.getAttribute("uid").toString());

	Get_UName_bo bo = new Get_UName_bo();

	User_Name = bo.get_UName(uid);
%>

<body>

	<div id="templatemo_container">
		<div id="templatemo_header">
			<%--  	<div id="templatemo_header_logo">
            	<div id="templatemo_header_slogan">
                	Modern Building Designs
                </div>
                
                <div id="templatemo_search">
                	<form action="#" method="post">
                    	<input type="radio" name="search" value="site" checked="checked" /><label class="labels">This Site</label>
						<input type="radio" name="search" value="web" /><label class="labels">The Web</label>
                	  	<input type="text" value="Enter a keyword" name="q" class="field"  title="email" onfocus="clearText(this)" onblur="clearText(this)" />
                	  	<input type="submit" name="search" value = "" alt="Search" class="button" title="Subscribe" />
            		</form>
                </div>
            </div> --%>

			<div id="templatemo_menu">
				<div id="templatemo_menu_left"></div>
				<ul>
					<li><a href="Home.jsp" class="current"  style="font-size: 12px;">HOME</a></li>
					<li><a href="All_DVPSheets.jsp"  style="font-size: 12px;">ALL SHEETS</a></li>
					<li><a href="EditSheet.jsp"  style="font-size: 12px;">EDIT SHEETS</a></li>
					<li><a href="Approval_Requests.jsp"  style="font-size: 12px;">REQUESTS</a></li> 
					<li><a href="MOM_Sheet.jsp" style="font-size: 12px;">DVP MOM</a></li>
					<!-- <li><a href="#"  style="font-size: 12px;">REPORTS</a></li> -->
					<li><a href="Search.jsp"  style="font-size: 12px;">SEARCH</a></li>
					<li><a href="Logout.jsp" class="last"  style="font-size: 12px;">LOG OUT (<b><%=User_Name%></b>)
					</a></li>
					<li><img alt="Mutha Group" src="images/logo.jpg" align="middle"/></li>
				</ul>
			</div>
			<!-- end of menu -->
		</div>

		<ul id="menu" class="templatemo_section_2">
		<li style="color: #020303;"><a href="Home.jsp"><img src="images/homeicon.png"></img> <strong> DVP BOSS</strong></a></li>
		<li><a href="NewSheet.jsp?action=new" style="font-size: 12px;background-color: #E8E8E8;"><b>New DVP Sheet &#8658; </b></a></li>
		<li><a href="My_Approvals.jsp" style="font-size: 12px;">My Approvals</a></li> 
		<li><a href="Approval_Status.jsp" style="font-size: 12px;">Approval Status</a></li> 
		<li><a href="Dev_Summary_Sheet.jsp" style="font-size: 12px;">DVP Summary</a></li> 
		<li><a href="MOM_Sheet.jsp" style="font-size: 12px;">MOM Summary</a><br /></li>
	</ul>
		<div class="cleaner"></div>

		<div class="templatemo_section_1">


			<%
				try {

					Connection con = Connection_Utility.getConnection();
					User_Name = bo.get_UName(uid);
					String action = null;
					int basic_id = 0;
					action = request.getParameter("action");
					if (action.equalsIgnoreCase("new")) {
			%>
			<form action="NewSheet_Controller" method="post"
				enctype="multipart/form-data" onsubmit="return validateForm();"
				name="myForm" id="myForm">

<table width="100%"  style="border: none; background-color: white;border-style: solid;border-width: 1px;">
				<tr align="left" style="background-color: #172380;">
					<th height="33" scope="col" colspan="9"><b style="color: white;">&nbsp;Basic Information &#8658; </b></th>  
				</tr>

				<!-- <table width="97%" border="1" style="background-color: #F5F5F5;">
					<tr>
						<th colspan="8" align="left" scope="col"><b
							style="font-size: 20px; color: #2883B8">Basic Information :</b></th>
					</tr> -->

					<tr>
						<td height="21"><strong>Sheet Number</strong></td>
						<td><strong>:</strong></td>
						<%
							int sheet_no = 0;
									PreparedStatement ps_getSheetNo = con
											.prepareStatement("select max(basic_id) from dev_basicinfo_tbl");
									ResultSet rs_getSheetNo = ps_getSheetNo.executeQuery();

									while (rs_getSheetNo.next()) {
										sheet_no = rs_getSheetNo.getInt("max(basic_id)") + 1;
									}
						%>
						<td><strong><%=sheet_no%> <input type="hidden"
								name="sheet_no" value="<%=sheet_no%>" /> </strong></td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
					</tr>
					<tr>
						<td width="15%" height="33">Customer</td>
						<td width="1%">:</td>
						<td width="16%"><select name="customer" id="customer"
							onchange="getpart(this.value)"
							style="cursor: pointer; max-width: 11em;">
								<option value="0">-------- Select --------</option>
								<%
									PreparedStatement ps_cust = con
													.prepareStatement("select * from customer_tbl");
											ResultSet rs_cust = ps_cust.executeQuery();
											while (rs_cust.next()) {
								%>
								<option value="<%=rs_cust.getString("Cust_Name")%>"><%=rs_cust.getString("Cust_Name")%></option>
								<%
									}
								%>
						</select></td>
						<td width="5%"><input name="cust_other" type="button"
							value="If other" onclick="add('customer')" id="btn"
							style="cursor: pointer;" /></td>
						<td width="16%"><span id="here"> </span></td>
						<td width="12%">&nbsp;</td>
						<td width="1%">&nbsp;</td>
						<td width="21%">&nbsp;</td>
					</tr>
					<tr>
						<td height="36">Part Name</td>
						<td>:</td>
						<td id="part1"><select name="part_name" id="part_name"
							onchange="getpartno(this.value)"
							style="cursor: pointer; max-width: 11em;">
								<option value="0">-------- Select --------</option>
						</select></td>
						<td><input name="part_other" type="button"
							onclick="addpart('part_name')" id="pbtn" value="If other"
							style="cursor: pointer" /></td>
						<td><span id="part"></span></td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
					</tr>

					<tr>
						<td height="30">Part Number</td>
						<td>:</td>
						<td id="partno1"><select name="part_no" id="part_no"
							style="cursor: pointer; max-width: 11em;"
							onchange="showPartImage(this.value)">
								<option>-------- Select --------</option>
						</select></td>
						<td><input type="button" onclick="addpartno('part_no')"
							id="pnbtn" value="If other" style="cursor: pointer" /></td>
						<td><span id="partno"> </span></td>

						<td>Revision Number</td>
						<td>:</td>
						<td><input name="revision_no" type="text" id="revision_no" /></td>

					</tr>
					<tr>
						<td>Grade No.</td>
						<td>:</td>
						<td><select name="grade_type" id="grade_type">
								<option value="0">---Select---</option>
								<%
									PreparedStatement ps_gradeType = con
													.prepareStatement("select Grade_id,Grade_Name from cs_grade_mst_tbl where Enable_Id=1");
											ResultSet rs_gradeType = ps_gradeType.executeQuery();
											while (rs_gradeType.next()) {
								%>
								<option value="<%=rs_gradeType.getString("Grade_Name")%>"><%=rs_gradeType.getString("Grade_Name")%></option>
								<%
									}
								%>
						</select></td>
						<td><input type="button" onclick="addgradeno('grade_type')"
							id="grdbtn" value="If other" style="cursor: pointer" /></td>

						<td><span id="gradeno"> </span></td>

						<td>Revision Date</td>
						<td>:</td>
						<td><input type="text" name="revised_date" id="datepicker"
							readonly="readonly" /></td>





					</tr>

					<tr>
						<td height="29">Plant Name</td>
						<td>:</td>
						<td><select name="plant_name" id="plant_name"
							onchange="getLeader(this.value )"
							style="cursor: pointer; max-width: 11em;">
								<option value="0">-------- Select --------</option>
								<%
									PreparedStatement ps_plant = con
													.prepareStatement("select * from user_tbl_company where Company_Id IN(1,2)");
											ResultSet rs_plant = ps_plant.executeQuery();
											while (rs_plant.next()) {
								%>
								<option value="<%=rs_plant.getInt("Company_Id")%>"><%=rs_plant.getString("Company_Name")%></option>
								<%
									}
											rs_plant.close();
								%>
						</select></td>
						<td>&nbsp;</td>
						<td><span id="castfrm"> </span></td>

						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>




					</tr>

					<tr>
						<td height="29">Vendor ( For Plant )</td>
						<td>:</td>
						<td><select name="plant_vendor" id="plant_vendor"
							onchange="getLeader(this.value)">
								<option value="null">-------- Select --------</option>

								<%
									PreparedStatement ps_plantVendor = con
													.prepareStatement("select * from dev_plantvendor_tbl");
											ResultSet rs_plantVendor = ps_plantVendor.executeQuery();
											while (rs_plantVendor.next()) {
								%>
								<option
									value="<%=rs_plantVendor.getString("plantvendor_name")%>"><%=rs_plantVendor.getString("plantvendor_name")%></option>
								<%
									}
											rs_plantVendor.close();
								%>

						</select></td>
						<td><input name="button2" type="button" id="mcVendorBTN"
							style="cursor: pointer"
							onclick="addMachiningVendor('plant_vendor')" value="If other" /></td>
						<td><span id="VenderPlant"> </span></td>
						<td>Project Leader</td>
						<td>:</td>
						<td><div id="getLeader">
								<select name="project_leader" id="project_leader"
									style="cursor: pointer; max-width: 11em;">
									<option value="0">----- Select -----</option>
								</select>
							</div></td>
					</tr>
					<tr>
						<td height="29">Casting From</td>
						<td>:</td>
						<td><select name="casting_from" id="casting_from"
							onchange="getRelated(this.value)"
							style="cursor: pointer; max-width: 11em;">
								<option value="0">-------- Select --------</option>
								<%
									PreparedStatement ps_cast = con
													.prepareStatement("select * from user_tbl_company where Company_Id IN(3,4,5)");
											ResultSet rs_cast = ps_cast.executeQuery();
											while (rs_cast.next()) {
								%>
								<option value="<%=rs_cast.getInt("Company_Id")%>"><%=rs_cast.getString("Company_Name")%></option>
								<%
									}
								%>
						</select></td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>Related Person</td>
						<td>:</td>
						<td>
							<div id="getRelated">
								<select name="related_person" id="related_person"
									style="cursor: pointer; max-width: 11em;">
									<option value="0">-------- Select --------</option>
								</select>
							</div>
						</td>
					</tr>

					<tr>
						<td height="27">Vendor ( For Casting )</td>
						<td>:</td>
						<td><select name="casting_vendor" id="casting_vendor"
							onchange="getRelatedVendor(this.value)"
							style="cursor: pointer; max-width: 11em;">
								<option value="null">-------- Select --------</option>
								<%
									PreparedStatement ps_castVendor = con
													.prepareStatement("select * from dev_castingvendor_tbl");
											ResultSet rs_castVendor = ps_castVendor.executeQuery();
											while (rs_castVendor.next()) {
								%>
								<option
									value="<%=rs_castVendor.getString("castingvendor_name")%>"><%=rs_castVendor.getString("castingvendor_name")%></option>
								<%
									}
								%>
						</select></td>
						<td><input name="button3" type="button" id="castVendbtn"
							style="cursor: pointer"
							onclick="addcastingVendor('casting_vendor')" value="If other" /></td>
						<td><span id="VenderCasting"> </span></td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
					</tr>
					<tr>
						<td height="21"><strong>Planned Dates </strong></td>
						<td><strong>:</strong></td>
						<td colspan="3">&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
					</tr>
					<tr>
						<td height="27">Start Date</td>
						<td>:</td>
						<td colspan="3"><input type="text" name="plan_start_date"
							id="plannedstart_date" readonly="readonly" /></td>
						<td>End Date</td>
						<td>:</td>
						<td><input type="text" name="plan_end_date"
							id="plannedend_date" readonly="readonly" /></td>
					</tr>
					<tr>
						<td height="21"><strong>Actual Dates </strong></td>
						<td><strong>:</strong></td>
						<td colspan="3">&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
					</tr>

					<tr>
						<td height="30">Start Date</td>
						<td>:</td>
						<td colspan="3"><input type="text" name="act_start_date"
							id="start_date" readonly="readonly" /></td>
						<td>End Date</td>
						<td>:</td>
						<td><input type="text" name="act_end_date" id="end_date"
							readonly="readonly" /></td>
					</tr>
					<tr>
						<td height="30">Marketing Approvals</td>
						<td>:</td>
						<td><select name="marketing_apr" id="marketing_apr"
							style="cursor: pointer; max-width: 11em;">
								<option value="">-------- Select --------</option>
								<option value="approved">Approved</option>
								<option value="declined">Declined</option>
								<option value="pending">Pending</option>
						</select></td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>Schedule/Month</td>
						<td>:</td>
						<td><input name="schedule_per_month" type="text"
							id="schedule_per_month" style="cursor: text"
							onkeypress="return validatenumerics(event);" /></td>
					</tr>
					<tr>
						<td height="28">PO Number(Customer)</td>
						<td>:</td>
						<td><input name="po_number" type="text" id="po_number"
							style="cursor: text" /></td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>PO Date(Customer)</td>
						<td>:</td>
						<td><input type="text" name="po_date" id="po_date"
							readonly="readonly" /></td>
					</tr>
					<tr>
						<td>PO Received Date ( Dev )</td>
						<td>:</td>
						<td><input type="text" name="po_receivedDate"
							id="po_receivedDate" readonly="readonly" /></td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td width="13%">&nbsp;</td>
					</tr>
					<tr>
						<td><strong>Attachments</strong></td>
						<td><strong>:</strong></td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
					</tr>
					<tr>
						<td>PO(Customer)</td>
						<td>:</td>
						<td colspan="3"><input type="file" name="attached_po_cust"
							id="attachedPO" style="cursor: pointer" /></td>
						<td>Part Image</td>
						<td>:</td>
						<td colspan="3"><span id="showImage"> <input
								type="file" name="part_image" id="partImage"
								style="cursor: pointer" /></span></td>
					</tr>
					<tr>
						<td>3D Model</td>
						<td>:</td>
						<td colspan="3"><input type="file" name="3D_drawing"
							id="model3d" style="cursor: pointer" /></td>
						<td>2D Drawing</td>
						<td>:</td>
						<td colspan="3"><input type="file" name="2D_drawing"
							id="model2d" style="cursor: pointer" /></td>
					</tr>
					<tr>
						<td>Other</td>
						<td>:</td>
						<td colspan="4" align="center">&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
					</tr>
					<tr>
						<td colspan="8">
							<table id="tblSample">
								<tr>
									<input type="button" value="ADD More Files" name="button"
										onclick="addRowToTable();"
										style="width: 150px; height: 20px; border-style: outset; color: #08403C;" />
									<input type="button" value="Delete [Selected]"
										onclick="deleteChecked();"
										style="width: 150px; height: 20px; border-style: outset; color: #08403C;" />
									<input type="hidden" id="srno" name="srno" value="">
								</tr>
								<tbody></tbody>
							</table>
						</td>
					</tr>
					<tr>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td colspan="4" align="center">&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
					</tr>
					<tr>

						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td colspan="4" align="center"><input type="submit"
							name="groovybtn1" class="groovybutton" value="Save"
							style="background-color: #BABABA" /></td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
					</tr>


				</table>
			</form>


			<%
				//--------------------------------------------------------------------------------------------------------------------
						//--------------------------------------------------------------------------------------------------------------------
					} else {

						basic_id = Integer.parseInt(request.getParameter("hid"));
						int castVend = 0;
						String castVendor = null;
			%>

			<form action="Edit_NewSheet_Controller" name="editsheet"
				id="editsheet" method="post" onsubmit="return editvalidateForm();"
				enctype="multipart/form-data">


<table width="100%"  style="border: none; background-color: white;border-style: solid;border-width: 1px;">
				<tr align="left" style="background-color: #172380;">
					<th height="33" scope="col" colspan="10"><b style="color: white;">&nbsp;Edit Basic Information &#8658; </b></th>  
				</tr>

				<!-- <table width="99%" border="0"> -->
					<%
						PreparedStatement ps_basicInfo = con
										.prepareStatement("select * from dev_basicinfo_tbl where Basic_Id="
												+ basic_id);
								ResultSet rs_basicinfo = ps_basicInfo.executeQuery();
								while (rs_basicinfo.next()) {
					%>

					<!-- <tr>
						<th colspan="9" align="left" scope="col"><b
							style="font-size: 20px; color: #2883B8">Basic Information :</b></th>
					</tr> -->

					<tr>
						<td height="21"><strong>Sheet Number</strong></td>
						<td><strong>:</strong></td>

						<td><strong><%=basic_id%> <input type="hidden"
								name="sheet_no" value="<%=basic_id%>" /> </strong></td>
						<td>&nbsp;</td>
						<td colspan="2">&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
					</tr>
					<tr>

						<td width="15%" height="27">Customer</td>
						<td width="1%">:</td>
						<td width="16%"><select name="customer" id="customer"
							onchange="getpart(this.value)"
							style="cursor: pointer; max-width: 11em;">

								<%
									String selCust_Name = null;
												PreparedStatement ps_customer = con
														.prepareStatement("select * from customer_tbl where Cust_Id="
																+ rs_basicinfo.getInt("Cust_Id"));
												ResultSet rs_customer = ps_customer.executeQuery();
												while (rs_customer.next()) {
													selCust_Name = rs_customer.getString("Cust_Name");
								%>
								<option value="<%=selCust_Name%>"><%=selCust_Name%></option>

								<%
									}
												PreparedStatement ps_cust = con
														.prepareStatement("select * from customer_tbl where Cust_Id!="
																+ rs_basicinfo.getInt("Cust_Id"));
												ResultSet rs_cust = ps_cust.executeQuery();
												while (rs_cust.next()) {
								%>
								<option value="<%=rs_cust.getString("Cust_Name")%>"><%=rs_cust.getString("Cust_Name")%></option>
								<%
									}
								%>
						</select></td>
						<td><input name="cust_other2" type="button" value="to Edit"
							id="to_editCust" style="cursor: pointer;"
							onclick="enablecust('cust_name')" /></td>
						<td colspan="2"><input type="text" disabled="disabled"
							name="customer" id="edit_Cust" value="<%=selCust_Name%>"></input></td>
						<td width="12%">&nbsp;</td>
						<td width="1%">&nbsp;</td>
						<td width="21%">&nbsp;</td>
					</tr>
					<tr>
						<td height="30">&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td width="5%"><input name="cust_other" type="button"
							value="If other" onclick="newCust('new_customer')" id="btn"
							style="cursor: pointer;" /></td>
						<td width="16%" colspan="2"><span id="here"> </span></td>

						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
					</tr>
					<tr>
						<td height="36">Part Name</td>
						<td>:</td>
						<td id="part1"><select name="part_name" id="part_name"
							onchange="getpartno(this.value)"
							style="cursor: pointer; max-width: 11em;">

								<%
									String selPart_Name = null;
												PreparedStatement ps_part = con
														.prepareStatement("select * from cs_part_name_tbl where PartName_Id="
																+ rs_basicinfo.getInt("PartName_Id"));
												ResultSet rs_part = ps_part.executeQuery();
												while (rs_part.next()) {
													selPart_Name = rs_part.getString("Part_Name");
								%>
								<option value="<%=selPart_Name%>"><%=selPart_Name%></option>
								<%
									}
								%>

						</select></td>
						<td><input name="cust_other22" type="button" value="to Edit"
							id="to_editPart" style="cursor: pointer;"
							onclick="edit_PartN('part_name')" /></td>
						<td colspan="2"><input type="text" name="part_name"
							disabled="disabled" id="part_edit" value="<%=selPart_Name%>"></td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
					</tr>

					<tr>
						<td height="30">&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td><input name="part_other" type="button"
							onclick="editpart('new_part_name')" id="pbtn" value="If other"
							style="cursor: pointer" /></td>
						<td colspan="2" id="part">&nbsp;</td>
						<td>&nbsp;</td>


						<td>&nbsp;</td>
						<td>&nbsp;</td>
					</tr>
					<tr>
						<td height="30">Part Number</td>
						<td>:</td>
						<td id="partno1"><select name="part_no" id="part_no"
							style="cursor: pointer; max-width: 11em;">
								<%
									String selPart_No = null;
												PreparedStatement ps_partNo = con
														.prepareStatement("select * from cs_part_no_tbl where PartNo_Id="
																+ rs_basicinfo.getInt("PartNo_Id"));
												ResultSet rs_partNo = ps_partNo.executeQuery();
												while (rs_partNo.next()) {
													selPart_No = rs_partNo.getString("Part_No");
								%>
								<option value="<%=selPart_No%>"><%=selPart_No%></option>
								<%
									}
								%>

						</select></td>
						<td><input name="cust_other23" type="button" value="to Edit"
							id="partno_edit" style="cursor: pointer;"
							onclick="editPartNo('part_no')" /></td>
						<td colspan="2"><input type="text" name="part_no"
							disabled="disabled" id="editPartno" value="<%=selPart_No%>"></td>


						<td>Revision Number</td>
						<td>:</td>
						<td><input name="revision_no" type="text" id="revision_no"
							value="<%=rs_basicinfo.getString("Revision_No")%>" /></td>
					</tr>
					<tr>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td><input type="button"
							onclick="addEditpartno('new_part_no')" id="newpnbtn"
							value="If other" style="cursor: pointer" /></td>
						<td colspan="2"><span id="partno"> </span></td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
					</tr>
					<tr>
						<td>Grade No.</td>
						<td>:</td>
						<td><select name="grade_type" id="grade_type">
								<%
									String selGrade_Name = null;
												PreparedStatement ps_grade = con
														.prepareStatement("select * from cs_grade_mst_tbl where Grade_Id="
																+ rs_basicinfo.getInt("Grade_Id"));
												ResultSet rs_grade = ps_grade.executeQuery();
												while (rs_grade.next()) {
													selGrade_Name = rs_grade.getString("Grade_Name");
								%>
								<option selected="selected" value="<%=selGrade_Name%>"><%=selGrade_Name%></option>
								<%
									}
												PreparedStatement ps_gradeType = con
														.prepareStatement("select Grade_id,Grade_Name from cs_grade_mst_tbl where Enable_Id=1 and Grade_Id!="
																+ rs_basicinfo.getInt("Grade_Id"));
												ResultSet rs_gradeType = ps_gradeType.executeQuery();
												while (rs_gradeType.next()) {
								%>
								<option value="<%=rs_gradeType.getString("Grade_Name")%>"><%=rs_gradeType.getString("Grade_Name")%></option>
								<%
									}
								%>
						</select></td>
						<td><input name="cust_other24" type="button" value="to Edit"
							id="gradeEditbtn" style="cursor: pointer;"
							onclick="gradeEdit('grade')" /></td>
						<td colspan="2"><input type="text" name="grade_type"
							disabled="disabled" id="editgrade" value="<%=selGrade_Name%>"></td>

						<td>Revision Date</td>
						<td>:</td>
						<td><input type="text" name="revised_date" id="datepicker"
							readonly="readonly"
							value="<%=rs_basicinfo.getDate("Revision_Date")%>" /></td>
					</tr>

					<tr>
						<td height="29">&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td><input type="button"
							onclick="addnewgrad('new_grade_type')" id="grdbtn"
							value="If other" style="cursor: pointer" /></td>
						<td colspan="2"><span id="newGrade"> </span></td>

						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
					</tr>
					<tr>
						<td height="29">Plant Name</td>
						<td>:</td>
						<td><select name="plant_name" id="plant_name"
							onchange="getLeader(this.value)"
							style="cursor: pointer; max-width: 11em;">

								<%
									int co = 0;
												PreparedStatement ps_plantName = con
														.prepareStatement("select * from dev_basic_plant_rel_tbl where Basic_Id="
																+ basic_id + " and Enable_id=1");
												ResultSet rs_plantName = ps_plantName.executeQuery();
												while (rs_plantName.next()) {

													co = rs_plantName.getInt("Plant_Id");

												}

												if (co != 0) {
													PreparedStatement ps_PlantN = con
															.prepareStatement("select * from user_tbl_company where Company_Id="
																	+ co);
													ResultSet rs_PlantN = ps_PlantN.executeQuery();
													while (rs_PlantN.next()) {
								%>
								<option value="<%=rs_PlantN.getInt("Company_Id")%>"><%=rs_PlantN.getString("Company_Name")%></option>
								<%
									}
								%>
								<option value="0">----Select----</option>
								<%
									PreparedStatement ps_plant = con
															.prepareStatement("select * from user_tbl_company where Company_Id IN(1,2) and Company_Id!="
																	+ co);
													ResultSet rs_plant = ps_plant.executeQuery();
													while (rs_plant.next()) {
								%>
								<option value="<%=rs_plant.getInt("Company_Id")%>"><%=rs_plant.getString("Company_Name")%></option>
								<%
									}
													rs_plant.close();
												} else {
								%>
								<option value="0">----Select----</option>
								<%
									PreparedStatement ps_plant = con
															.prepareStatement("select * from user_tbl_company where Company_Id IN(1,2)");
													ResultSet rs_plant = ps_plant.executeQuery();
													while (rs_plant.next()) {
								%>
								<option value="<%=rs_plant.getInt("Company_Id")%>"><%=rs_plant.getString("Company_Name")%></option>
								<%
									}

												}
								%>
						</select></td>
						<td>&nbsp;</td>
						<td colspan="2"><span id="castfrm"> </span></td>

						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
					</tr>

					<tr>
						<td height="29">Vendor ( For Plant )</td>
						<td>:</td>
						<td><select name="plant_vendor" id="plant_vendor"
							onchange="getLeader(this.value)">

								<%
									int pv = 0;
												String selPlantV = null;
												PreparedStatement ps_pVend = con
														.prepareStatement("select * from dev_basic_plantvendor_rel_tbl where Basic_Id="
																+ basic_id + " and Enable_Id=1");
												ResultSet rs_pVend = ps_pVend.executeQuery();
												while (rs_pVend.next()) {
													PreparedStatement ps_plantVend = con
															.prepareStatement("select * from dev_plantvendor_tbl where PlantVendor_Id="
																	+ rs_pVend.getInt("PlantVendor_Id"));
													ResultSet rs_plantVend = ps_plantVend
															.executeQuery();
													while (rs_plantVend.next()) {
														pv = rs_plantVend.getInt("PlantVendor_Id");
														selPlantV = rs_plantVend
																.getString("plantvendor_name");
								%>
								<option value="<%=selPlantV%>"><%=selPlantV%></option>
								<%
									}
												}
								%>
								<option value="">----Select----</option>
								<%
									PreparedStatement ps_plantVendor = con
														.prepareStatement("select * from dev_plantvendor_tbl where PlantVendor_Id!="
																+ pv);
												ResultSet rs_plantVendor = ps_plantVendor
														.executeQuery();
												while (rs_plantVendor.next()) {
								%>
								<option
									value="<%=rs_plantVendor
									.getString("plantvendor_name")%>"><%=rs_plantVendor
									.getString("plantvendor_name")%></option>
								<%
									}
												rs_plantVendor.close();
												ps_plantVendor.close();
								%>

						</select></td>
						<td><input name="cust_other25" type="button" value="to Edit"
							id="edit_PlantVendor" style="cursor: pointer;"
							onclick="editMcvendor('plant_vendor')" /></td>
						<td colspan="2"><input type="text" name="plant_vendor"
							disabled="disabled" id="editMCVendorName" value="<%=selPlantV%>"></td>
						<td>Project Leader</td>
						<td>:</td>
						<td><div id="getLeader">
								<select name="project_leader" id="project_leader"
									style="cursor: pointer; max-width: 11em;">
									<%
										PreparedStatement ps_Plead = con
															.prepareStatement("select * from dev_basic_projectlead_rel_tbl where Basic_Id="
																	+ basic_id);
													ResultSet rs_Plead = ps_Plead.executeQuery();
													while (rs_Plead.next()) {
														PreparedStatement ps_projLead = con
																.prepareStatement("select * from user_tbl where U_Id="
																		+ rs_Plead.getInt("Project_Lead"));
														ResultSet rs_projLead = ps_projLead.executeQuery();
														while (rs_projLead.next()) {
									%>
									<option value="<%=rs_projLead.getInt("U_Id")%>"><%=rs_projLead.getString("U_Name")%></option>
									<%
										}
													}
									%>
								</select>
							</div></td>
					</tr>
					<tr>
						<td height="29">&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td><input name="button2" type="button" id="pvendbtn"
							style="cursor: pointer"
							onclick="addNewplantVendor('new_plant_vendor')" value="If other" /></td>
						<td colspan="2"><span id="VenderP"> </span></td>

						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
					</tr>
					<tr>
						<td height="29">Casting From</td>
						<td>:</td>
						<td><select name="casting_from" id="casting_from"
							onchange="getRelated(this.value)"
							style="cursor: pointer; max-width: 11em;">

								<%
									int compID = 0;
												PreparedStatement ps_casting = con
														.prepareStatement("select * from dev_basic_casting_rel_tbl where Basic_Id="
																+ basic_id + " and Enable_Id=1");
												ResultSet rs_casting = ps_casting.executeQuery();

												while (rs_casting.next()) {
													compID = rs_casting.getInt("Casting_From_Id");
												}

												if (compID != 0) {
													PreparedStatement ps_castf = con
															.prepareStatement("select * from user_tbl_company where Company_Id="
																	+ compID);
													ResultSet rs_castf = ps_castf.executeQuery();
													while (rs_castf.next()) {
								%>
								<option value="<%=rs_castf.getInt("Company_Id")%>"><%=rs_castf.getString("Company_Name")%></option>
								<%
									}
								%>
								<option value="0">----Select----</option>
								<%
									PreparedStatement ps_cast = con
															.prepareStatement("select * from user_tbl_company where Company_Id IN(3,4,5) and Company_Id!="
																	+ compID);
													ResultSet rs_cast = ps_cast.executeQuery();
													while (rs_cast.next()) {
								%>
								<option value="<%=rs_cast.getInt("Company_Id")%>"><%=rs_cast.getString("Company_Name")%></option>
								<%
									}
												} else {
								%>
								<option value="0">----Select----</option>

								<%
									PreparedStatement ps_cast = con
															.prepareStatement("select * from user_tbl_company where Company_Id IN(3,4,5)");
													ResultSet rs_cast = ps_cast.executeQuery();
													while (rs_cast.next()) {
								%>
								<option value="<%=rs_cast.getInt("Company_Id")%>"><%=rs_cast.getString("Company_Name")%></option>
								<%
									}

												}
								%>
						</select></td>
						<td>&nbsp;</td>
						<td colspan="2">&nbsp;</td>
						<td>Related Person</td>
						<td>:</td>
						<td>
							<div id="getRelated">
								<select name="related_person" id="related_person"
									style="cursor: pointer; max-width: 11em;">
									<%
										PreparedStatement ps_castRel = con
															.prepareStatement("select * from dev_basic_relperson_rel_tbl where Basic_Id="
																	+ basic_id);
													ResultSet rs_castRel = ps_castRel.executeQuery();
													while (rs_castRel.next()) {
														PreparedStatement ps_relPer = con
																.prepareStatement("select * from user_tbl where U_Id="
																		+ rs_castRel
																				.getInt("Related_Person"));
														ResultSet rs_relPer = ps_relPer.executeQuery();
														while (rs_relPer.next()) {
									%>
									<option value="<%=rs_relPer.getInt("U_Id")%>"><%=rs_relPer.getString("U_Name")%></option>
									<%
										}
													}
									%>
								</select>
							</div>
						</td>
					</tr>

					<tr>
						<td height="27">Vendor ( For Casting )</td>
						<td>:</td>
						<td><select name="casting_vendor" id="casting_vendor"
							onchange="getRelatedVendor(this.value)"
							style="cursor: pointer; max-width: 11em;">

								<%
									PreparedStatement ps_castVend = con
														.prepareStatement("select * from dev_basic_castingvendor_rel_tbl where Basic_Id="
																+ basic_id);
												ResultSet rs_castVend = ps_castVend.executeQuery();
												while (rs_castVend.next()) {
													PreparedStatement ps_devCastVend = con
															.prepareStatement("select * from dev_castingvendor_tbl where CastingVendor_Id="
																	+ rs_castVend
																			.getInt("CastingVendor_Id"));
													ResultSet rs_devCastVend = ps_devCastVend
															.executeQuery();
													while (rs_devCastVend.next()) {
														castVendor = rs_devCastVend
																.getString("castingvendor_name");
								%>
								<option value="<%=castVendor%>"><%=castVendor%></option>
								<%
									castVend = rs_devCastVend
																.getInt("CastingVendor_Id");

													}
												}
								%>
								<option value="">----Select----</option>
								<%
									PreparedStatement ps_castVendor = con
														.prepareStatement("select * from dev_castingvendor_tbl where CastingVendor_Id!="
																+ castVend);
												ResultSet rs_castVendor = ps_castVendor.executeQuery();
												while (rs_castVendor.next()) {
								%>
								<option
									value="<%=rs_castVendor
									.getString("castingvendor_name")%>"><%=rs_castVendor
									.getString("castingvendor_name")%></option>
								<%
									}
								%>
						</select></td>
						<td><input name="cust_other26" type="button" value="to Edit"
							id="edit_castVendor" style="cursor: pointer;"
							onclick="editcastVendor('cast_vendor')" /></td>
						<td><input type="text" name="casting_vendor" id="castVendor"
							value="<%=castVendor%>" disabled="disabled"></td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
					</tr>
					<tr>
						<td height="21">&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td><input name="button3" type="button" id="castVendbtn"
							style="cursor: pointer"
							onclick="addNewcastingVendor('new_casting_vendor')"
							value="If other" /></td>
						<td colspan="2"><span id="VenderCasting"> </span></td>

						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
					</tr>
					<tr>
						<td height="21"><strong>Planned Dates </strong></td>
						<td><strong>:</strong></td>
						<td colspan="4">&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
					</tr>
					<tr>
						<td height="27">Start Date</td>
						<td>:</td>
						<td colspan="4"><input type="text" name="plan_start_date"
							readonly="readonly" id="plannedstart_date"
							value="<%=rs_basicinfo.getDate("Planned_Start_Date")%>" /></td>
						<td>End Date</td>
						<td>:</td>
						<td><input type="text" name="plan_end_date"
							readonly="readonly" id="plannedend_date"
							value="<%=rs_basicinfo.getDate("Planned_End_Date")%>" /></td>
					</tr>
					<tr>
						<td height="21"><strong>Actual Dates </strong></td>
						<td><strong>:</strong></td>
						<td colspan="4">&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
					</tr>

					<tr>
						<td height="30">Start Date</td>
						<td>:</td>
						<td colspan="4">
							<%
								if (rs_basicinfo.getDate("Actual_Start_Date") == null) {
							%> <input type="text" name="act_start_date" readonly="readonly"
							id="start_date" /> <%
 	} else {
 %> <input type="text" name="act_start_date" readonly="readonly"
							id="start_date"
							value="<%=rs_basicinfo.getDate("Actual_Start_Date")%>" /> <%
 	}
 %>
						</td>
						<td>End Date</td>
						<td>:</td>
						<td>
							<%
								if (rs_basicinfo.getDate("Actual_End_Date") == null) {
							%> <input type="text" name="act_end_date" id="end_date"
							readonly="readonly" />
						</td>
						<%
							} else {
						%>
						<input type="text" name="act_end_date" id="end_date"
							value="<%=rs_basicinfo.getDate("Actual_End_Date")%>"
							readonly="readonly" />
						<%
							}
						%>
						</td>
					</tr>
					<tr>
						<td height="30">Marketing Approvals</td>
						<td>:</td>
						<td><select name="marketing_apr" id="marketing_apr"
							style="cursor: pointer; max-width: 11em;">

								<option value="<%=rs_basicinfo.getString("Mkt_Approval")%>"><%=rs_basicinfo.getString("Mkt_Approval")%></option>
								<option value="approved">Approved</option>
								<option value="declined">Declined</option>
								<option value="pending">Pending</option>
						</select></td>
						<td>&nbsp;</td>
						<td colspan="2">&nbsp;</td>
						<td>Schedule/Month</td>
						<td>:</td>
						<td><input name="schedule_per_month" type="text"
							id="schedule_per_month" style="cursor: text"
							value="<%=rs_basicinfo.getInt("Schedule_Per_Month")%>"
							onkeypress="return validatenumerics(event);" /></td>
					</tr>
					<tr>
						<td height="28">PO Number(Customer)</td>
						<td>:</td>
						<td><input name="po_number" type="text" id="po_number"
							style="cursor: text"
							value="<%=rs_basicinfo.getString("PO_No_From_Cust")%>" /></td>
						<td>&nbsp;</td>
						<td colspan="2">&nbsp;</td>
						<td>PO Date(Customer)</td>
						<td>:</td>
						<td><input type="text" name="po_date" id="po_date"
							readonly="readonly"
							value="<%=rs_basicinfo.getDate("PO_Date_From_Cust")%>" /></td>
					</tr>
					<tr>
						<td>PO Received Date ( Dev )</td>
						<td>:</td>
						<td><input type="text" name="po_receivedDate"
							id="po_receivedDate" readonly="readonly"
							value="<%=rs_basicinfo.getDate("PO_Rcvd_At_Dev_Date")%>" /></td>
						<td>&nbsp;</td>
						<td colspan="2">&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td width="13%">&nbsp;</td>
					</tr>
					<tr>
						<td><strong>Attachments</strong></td>
						<td><strong>:</strong></td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td colspan="2">&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
					</tr>
					<tr>
						<td>PO(Customer)</td>
						<td>:</td>
						<td>
							<%
								PreparedStatement ps_delPo = con
													.prepareStatement("select * from dev_basicinfo_po_attachment_tbl where Basic_Id="
															+ basic_id + " and Enable_Id=1");
											ResultSet rs_delPo = ps_delPo.executeQuery();
											while (rs_delPo.next()) {
							%> <span id="delPO"> <a
								href="Display_AttachedPO.jsp?field=<%=rs_delPo.getInt("BI_PO_Attach_Id")%>"><%=rs_delPo.getString("File_Name")%>
							</a> <input type="button" name="pocustDel" value="Delete"
								onclick="deletePo('<%=basic_id%>','<%=rs_delPo.getInt("BI_PO_Attach_Id")%>','delpo')" />
						</span> <%
 	}
 %>
						</td>
						<td>&nbsp;</td>
						<td>Part Image</td>
						<td>:</td>
						<td colspan="5">
							<%
								PreparedStatement ps_delPart = con
													.prepareStatement("select * from dev_partno_photo_tbl where partno_id="
															+ rs_basicinfo.getInt("partno_id")
															+ " and Enable_Id=1");
											ResultSet rs_delPart = ps_delPart.executeQuery();
											while (rs_delPart.next()) {
							%> <span id="delPart"> 
							
				<a href="PartImageView.jsp?field=<%=rs_delPart.getInt("part_photo_id")%>" title="Click to enlarge" onclick="return hs.expand(this)"  style="cursor:pointer"><%=rs_delPart.getString("file_name") %></a>				
								<input type="button" name="button422" value="Delete"
								onclick="deletePart('<%=basic_id%>','<%=rs_delPart.getInt("part_photo_id")%>','delpart')" />
						</span> <%
 	}
 %>
						</td>
					</tr>
					<tr>
						<td>3D Model</td>
						<td>:</td>
						<td>
							<%
								PreparedStatement ps_del3dModel = con
													.prepareStatement("select * from dev_3d_drawing_attachment_tbl where Basic_Id="
															+ basic_id + " and Enable_Id=1");
											ResultSet rs_del3dModel = ps_del3dModel.executeQuery();
											while (rs_del3dModel.next()) {
							%> <span id="del3d"> <a
								href="Display_3Ddrawing.jsp?field=<%=rs_del3dModel
									.getInt("3D_drawing_attach_id")%>"><%=rs_del3dModel.getString("File_Name")%></a>

								<input type="button" name="button44" value="Delete"
								onclick="delete3dModel('<%=basic_id%>','<%=rs_del3dModel
									.getInt("3D_drawing_attach_id")%>','del3dmodel')" />

						</span> <%
 	}
 %>
						</td>
						<td>&nbsp;</td>
						<td>2D Drawing</td>
						<td>:</td>
						<td colspan="5">
							<%
								PreparedStatement ps_2dModel = con
													.prepareStatement("select * from dev_2d_drawing_attachment where Basic_Id="
															+ basic_id + " and Enable_Id=1");
											ResultSet rs_2dModel = ps_2dModel.executeQuery();
											while (rs_2dModel.next()) {
							%> <span id="del2D"> <a
								href="Display_2Ddrawing.jsp?field=<%=rs_2dModel.getInt("2D_drawing_attach_id")%>"><%=rs_2dModel.getString("file_name")%></a>
								<input type="button" name="button423" value="Delete"
								onclick="delete2dModel('<%=basic_id%>','<%=rs_2dModel.getInt("2D_drawing_attach_id")%>','del2dmodel')" />
						</span> <%
 	}
 %>
						</td>
					</tr>
					<tr>
						<td>Other</td>
						<td>:</td>
						<td>
							<%
								PreparedStatement ps_delOther = con
													.prepareStatement("select * from dev_other_attachement where Basic_Id="
															+ basic_id + " and Enable_Id=1");
											ResultSet rs_delOther = ps_delOther.executeQuery();
											while (rs_delOther.next()) {
							%> <span id="delOther"> <a
								href="Display_othetImages.jsp?field=<%=rs_delOther.getInt("other_attach_id")%>"><%=rs_delOther.getString("file_name")%></a>
								<input type="button" name="button4" value="Delete"
								onclick="delother('<%=basic_id%>','<%=rs_delOther.getInt("other_attach_id")%>','other')" />
						</span> <br /> <%
 	}
 %>
						</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>:</td>
						<td colspan="5">&nbsp;</td>
					</tr>
					<tr>
						<td>PO(Customer)</td>
						<td>:</td>
						<td colspan="4"><input type="file" name="attached_po_cust"
							style="cursor: pointer" /></td>
						<td>Part Image</td>
						<td>:</td>
						<td colspan="3"><input type="file" name="part_image"
							style="cursor: pointer" /></td>
					</tr>
					<tr>
						<td>3D Model</td>
						<td>:</td>
						<td colspan="4"><input type="file" name="3D_drawing"
							style="cursor: pointer" /></td>
						<td>2D Model</td>
						<td>:</td>
						<td colspan="3"><input type="file" name="2D_drawing"
							style="cursor: pointer" /></td>
					</tr>
					<tr>
						<td>Other</td>
						<td>:</td>
						<td colspan="5" align="center">&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
					</tr>
					<tr>
						<td colspan="9">
							<table id="tblSample">
								<tr>

									<input type="button" value="ADD More Files" name="button"
										onclick="addRowToTable();"
										style="width: 150px; height: 20px; border-style: outset; color: #08403C;" />
									<input type="button" value="Delete [Selected]"
										onclick="deleteChecked();"
										style="width: 150px; height: 20px; border-style: outset; color: #08403C;" />
									<input type="hidden" id="srno" name="srno" value="">
								</tr>
								<tbody></tbody>
							</table>
						</td>
					</tr>
					<tr>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td colspan="5" align="center">&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
					</tr>
					<tr>

						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td colspan="5" align="center"><input type="submit"
							name="groovybtn1" class="groovybutton" value="Save"
							style="background-color: #BABABA" /></td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
					</tr>

					<%
						}
					%>
				</table>
			</form>


			<%
				}

				} catch (Exception e) {
					e.printStackTrace();
				}
			%>
			<div class="cleaner"></div>
		</div>
	</div>
</body>
</html>