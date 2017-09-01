<%@page import="com.muthagroup.connectionModel.Connection_Utility"%>
<%@page import="java.text.DateFormatSymbols"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.util.GregorianCalendar"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.concurrent.TimeUnit"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.LinkedHashSet"%>
<%@page import="java.util.Collections"%>
<%@page import="java.util.HashSet"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.CallableStatement"%>
<%@page import="com.muthagroup.connectionUtil.ConnectionUrl"%>
<%@page import="java.sql.Connection"%>
<html>
<head> 
<title>New Item IN ERP</title> 
<link rel="stylesheet" href="js/jquery-ui.css"/>
<script src="js/jquery-1.9.1.js"></script>
<script src="js/jquery-ui.js"></script> 
<script> 			         
	 $(function() {
		 $( "#tin_sst_date").datepicker({
		      changeMonth: true,
		      changeYear: true
		}); 
	});
	 
	 function button1(val) {
			var val1 = val; 
			document.getElementById("hid_code").value = val1;
			edit.submit();
		}

	 function ChangeColor(tableRow, highLight) {
			if (highLight) {
				tableRow.style.backgroundColor = '#CFCFCF';
			} else {
				tableRow.style.backgroundColor = '#FFFFFF';
			}
		}  
</script>
<STYLE TYPE="text/css" MEDIA=all>
input{
background-color: #e6e6ff; 
}
textarea{
background-color: #e6e6ff; 
}
select{
background-color: #e6e6ff;
}
.tftable {
	font-size: 12px;
	color: #333333;
	width: 100%; 
	border: 1px solid #963;
}

.tftable th {
	font-size: 12px;
	background-color: #acc8cc; 
	padding: 5px; 
	border: 1px solid #963;
}

.tftable tr {
	background-color: #ffffff;
	border: 1px solid #963;
}

.tftable td {
	font-size: 12px;
	padding: 2px;  
	border: 1px solid #963;
	font-weight: bold;
}
.tft {
	font-size: 12px;
	color: #333333;
	width: 100%; 
	border: 1px solid #963;
}

.tft th {
	font-size: 12px;
	background-color: #acc8cc; 
	padding: 3px; 
	border: 1px solid #963;
}

.tft tr {
	background-color: #ffffff;
	border: 1px solid #963;
}

.tft td {
	font-size: 12px;
	border: 1px solid #963;
}
</STYLE>
<script type="text/javascript">
function validateNewItemForm() {
	document.getElementById("submit").disabled = true;
	var itemName = document.getElementById("itemName");
	  	if (itemName.value=="0" || itemName.value==null || itemName.value=="" || itemName.value=="null") {
			document.getElementById("submit").disabled = false;
			alert("Please Provide Item Name !!!");  
			return false;
		} 
}
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


function get_allAvailItems(name) {
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
			document.getElementById("autofind").innerHTML = xmlhttp.responseText; 
		}
	};
	xmlhttp.open("POST", "Get_AvailItems.jsp?q=" + name, true);  
	xmlhttp.send(); 
}
</script> 
<script type="text/javascript">
<%
if(request.getParameter("status")!=null){
%>
alert("Done");
<%
}
%>
</script>
</head>
<body bgcolor="#DEDEDE" style="font-family: Arial;">
	<%
	try {
		SimpleDateFormat sdfFIrstDate = new SimpleDateFormat("yyyy-MM-dd");
		Date tdate = new Date(); 
		String todaysDate = sdfFIrstDate.format(tdate);
		Connection con = ConnectionUrl.getBWAYSERPMASTERConnection();
		Connection conlocal = ConnectionUrl.getLocalDatabase();
		PreparedStatement ps=null;
		ResultSet rs = null;
		Calendar now = Calendar.getInstance();
		int year = now.get(Calendar.YEAR);
		if(request.getParameter("repMsg")!=null){
	%>
	  <script type="text/javascript">
	  alert("<%=request.getParameter("repMsg") %>");
	  </script>
	<%
		}
	%>
<strong style="color: #1B5869;font-family: Arial;font-size: 14px;">New Item Creation in ERP System</strong> 
<br/>
<strong style="font-family: Arial;font-size: 14px;font-weight: bold;"><a href="HomePage.jsp" style="text-decoration: none;">&lArr; BACK</a></strong>
&nbsp;&nbsp;&nbsp;<b style="font-size: 11px;color: #555306">Note : Please Use Mozilla Firefox Web Browser for full control.......</b>
<br>
<div style="overflow: scroll;background-color: white;width:70%;float:left">
<form action="Master_ItemCreate" method="post"  onSubmit="return validateNewItemForm();">
<table class="tftable" style="width: 100%">
 <tr>
 <th colspan="2" align="left">Product Master ==></th>
 </tr>
<tr>
	  <td align="left"><label class="caption">Item Name*</label></td>
	  <td width="81%" align="left"><Input Type="Text" Id="itemName" name="itemName"  onKeyUp="get_allAvailItems(this.value)" size="40"></td>
</tr>
<tr>
	  <td align="left"><label class="caption">Inv. Name</label></td>
	  <td align="left"><Input Type="Text" Id="invName" name="invName" TabIndex="3"  Size="70" MaxLength="100" ></td>
</tr>
		<tr>
		  <td align="left">
	    <label class="caption">Sub Grade*</label></td>
	  <td align="left">
  				<Select id="SubGrade" name="SubGrade">
				<%
				PreparedStatement ps_subgrd = con.prepareStatement("select * from MSTCOMMCASTGRADE");
				ResultSet rs_subgrd = ps_subgrd.executeQuery();
				while(rs_subgrd.next()){
				%>
					<Option Value="<%=rs_subgrd.getString("CODE") %>" ><%=rs_subgrd.getString("NAME") %></Option>
				<%
				}
				%>	 
				</select>			
		</td> 
	  </tr>
		<tr>
		  <td align="left"><label class="caption" >UOM</label></td>
		  <td align="left"><Select id="drpUnitCode2" name="drpUnitCode2"  TabIndex="5"  disabled >
            <Option Value="NOS" >NUMBERS</Option>
          </select></td>
  </tr>
		<tr>
		  <td align="left">
	    <label class="caption" >Sub Grade Description</label></td>
	  <td align="left">
	    <Input Type="Text" Id="txtSubGradeDesc" name="txtSubGradeDesc" TabIndex="6"  Size="30" MaxLength="50" >			</td>
	  </tr>
		<tr>
		  <td align="left">
	    <label class="caption" >Item Type</label>			</td>
	  <td align="left">
  				<Select id="drpItemType" name="drpItemType" TabIndex="7" >
					<Option Value="0"> Purchase or Own Production </Option>
					<Option Value="1"> Job Work Machining </Option>
					<Option Value="2"> Own Production </Option> 
				    <Option Value="3"> Job Work or Own Production </Option>
				</select>			
	  </td>
	  </tr> 
		<tr>
		  <td align="left">
	    <label class="caption" >Drawing Number</label>			</td>
	  <td  align="left">
	    <Input Type="Text" Id="txtRefPartCode" name="txtRefPartCode" TabIndex="8"  Size="45" MaxLength="40" ></td>
	  </tr>
		<tr>
		  <td align="left"><Label class="Caption">Revision Number</Label></td>
		  <td  align="left"><Input Type="Text" Id="txtRevNo2" name="txtRevNo2" TabIndex="9"  Size="12" MaxLength="10" style="Text-align:Right"></td>
  </tr>
		<tr>
		  <td align="left"><Label class="Caption">Rev. Date</Label></td>
		  <td  align="left"><Input Type="Text" Name="txtRevDate2" Id="txtRevDate2" Size="10" MaxLength="10" Tabindex="10"  OnBlur="chkValidFormatDate(this,'dd/mm/yyyy')" ></td>
  </tr>
		<tr>
		  <td align="left">
	    <label class="caption" >Drawing Location</label>			</td>
	  <td  align="left">
	    <Input Type="Text" Id="txtDrgLocation" name="txtDrgLocation" TabIndex="12"  Size="70" MaxLength="70" >			</td>
	  </tr>
		<tr>
		  <td align="left">
	    <label class="caption">Quality Test Type</label>			</td>
	  <td align="left">
  			<Select id="drpTestCode" name="drpTestCode" TabIndex="13" >
					<Option Value="0"> Inspection Not Required </Option>
					<Option Value="1"> Visual Inspection </Option>
					<Option Value="2"> QA Testing </Option>
				</select>			
	</td>
	  </tr>
		<tr>
		  <td align="left">
	    <label class="caption">Quality Specification No</label></td>
	  <td align="left">
	    <Input Type="Text" Id="txtSpecNo" name="txtSpecNo" TabIndex="14"  Size="22" MaxLength="20" style="Text-align:Right">			</td>
	  </tr>
		<tr>
		  <td align="left"><Label class="Caption">Revision Number</Label></td>
		  <td align="left"><Input Type="Text" Id="txtSpecRevNo" name="txtSpecRevNo" TabIndex="15"  Size="12" MaxLength="10" value="0" style="Text-align:Right"></td>
  </tr>
		<tr>
		  <td align="left"><Label class="Caption">Rev. Date</Label></td>
		  <td align="left"><Input Type="Text" Name="txtSpecRevDate2" Id="txtSpecRevDate2" Size="10" MaxLength="10" Tabindex="16"  OnBlur="chkValidFormatDate(this,'dd/mm/yyyy')" ></td> 
  </tr>
		<tr>
		  <td align="left"><label class="caption" >Casting Weight</label></td>
  <td align="left">
	    <Input Type="Text" Id="txtCastingWt" name="txtCastingWt" TabIndex="18"  Size="12" MaxLength="10" value="0.000" OnBlur="ChkInputWt(this)" style="Text-align:Right">			</td>
</tr>
 <tr>
		  <td align="left"><label class="caption" >Finished Weight</label></td>
		  <td align="left"><Input Type="Text" Id="txtFinishWt" name="txtFinishWt" TabIndex="19"  Size="12" MaxLength="10" value="0.000" OnBlur="ChkInputWt(this)" style="Text-align:Right"></td>
 </tr>
 <tr>
		  <td align="left"><span class="caption">Rate</span></td>
		  <td align="left"><Input Type="Text" Id="txtRate" name="txtRate" TabIndex="20"  Size="12" MaxLength="10" value="0" OnBlur='chkValidNoValue(this,0,"Rate");' style="Text-align:Right" ></td>
  </tr>
		<tr>
		  <td align="left">
	    <label class="caption">Despatch As / Item Type</label></td>
	  <td align="left">
	    <Input Type="Radio" Id="rdoCasting" name="rdoDespType" TabIndex="21"  Value="1"  class="check" /><b>&nbsp;
	    Casting</b>			<Input Type="Radio" Id="rdoFinish"  name="rdoDespType" TabIndex="22" " Value="0" checked runAt="server" class="check" />
	    <b>&nbsp;Finished
	    <Input Type="Radio" Id="rdoAssembly"  name="rdoDespType" TabIndex="23" " Value="2"  class="check" />
	    <b>&nbsp;Assembly</b></b></td>
	  </tr>
		<tr>
		  <td align="left">
	    <label class="caption" >Sales classification</label>			</td>
	  <td   align="left">
  <Select id="drpSaleAs" name="drpSaleAs"  TabIndex="24" > 
					<Option Value="101001" >SALES</Option>
				</select>			</td>
	  </tr>
		<tr>
		  <td align="left">
	    <label class="caption">HS Number</label>			</td>
	  <td align="left">
  				<Select id="drpChapter" name="drpChapter"  style="width: 500px;">
  				<option value=""> - - - - - Select  - - - - - </option>
				<%
				ps_subgrd = con.prepareStatement("SELECT * FROM CNFRATEEXCISE");
				rs_subgrd = ps_subgrd.executeQuery();
				while(rs_subgrd.next()){
				%>
					<Option Value="<%=rs_subgrd.getString("CODE") %>" ><%=rs_subgrd.getString("CHAPTER_NO")%>  <%=rs_subgrd.getString("NAME") %></Option>
				<%
				}
				%>
				</select>			
		</td>
	  </tr>
	<tr>
	   <Td align="left">
	    <Label class="caption">Rejection Scrap Material </label></Td>
	  <Td align="left">
  	<Select id="drpScrap" name="drpScrap">
  	<option value=""> - - - - - Select  - - - - - </option>
  				<%
				ps_subgrd = con.prepareStatement("select * from MSTMATERIALS where MATERIAL_TYPE=131");
				rs_subgrd = ps_subgrd.executeQuery();
				while(rs_subgrd.next()){
				%>
					<Option Value="<%=rs_subgrd.getString("CODE") %>" ><%=rs_subgrd.getString("NAME") %></Option>
				<%
				}
				%>
	</select>
	</td>
	  </tr>
		<tr>
		  <td align="left">
	    <label class="caption" >Purchase GL</label>			</td>
	  <td align="left">
	  <Select id="drpPurhGlAcNo" name="drpPurhGlAcNo">
	  <option value=""> - - - - - Select  - - - - - </option>
				<%
				ps_subgrd = con.prepareStatement("select * from MSTACCTGL order by GL_NAME");
				rs_subgrd = ps_subgrd.executeQuery();
				while(rs_subgrd.next()){
				%>
					<Option Value="<%=rs_subgrd.getString("GL_ACNO") %>" ><%=rs_subgrd.getString("GL_NAME") %></Option>
				<%
				}
				%>	
		</select>			
		</td>
	  </tr>
		<tr>
		  <td align="left">
	    <label class="caption" >Purchase Return</label>			</td>
	  <Td align="left">
  			<Select id="drpPurhRetAcNo" name="drpPurhRetAcNo">
  			<option value=""> - - - - - Select  - - - - - </option>
  			<%
				ps_subgrd = con.prepareStatement("select * from MSTACCTGL order by GL_NAME");
				rs_subgrd = ps_subgrd.executeQuery();
				while(rs_subgrd.next()){
				%>
					<Option Value="<%=rs_subgrd.getString("GL_ACNO") %>" ><%=rs_subgrd.getString("GL_NAME") %></Option>
				<%
				}
				%>
  			</select>			
  </Td>
	  </tr>
		<tr>
		  <td align="left">
	    <label class="caption" >Sales GL</label>			</td>
	  <Td align="left">
	  <Select id="drpSaleGlAcno" name="drpSaleGlAcno">
	  <option value=""> - - - - - Select  - - - - - </option>
				<%
				ps_subgrd = con.prepareStatement("select * from MSTACCTGL order by GL_NAME");
				rs_subgrd = ps_subgrd.executeQuery();
				while(rs_subgrd.next()){
				%>
					<Option Value="<%=rs_subgrd.getString("GL_ACNO") %>" ><%=rs_subgrd.getString("GL_NAME") %></Option>
				<%
				}
				%> 
				</select>			
		</td>
	  </tr>
		<tr>
		  <td align="left">
	    <label class="caption" >Sales Return</label>			</td>
	  <Td align="left">
  		<Select id="drpSaleRetAcno" name="drpSaleRetAcno"  TabIndex="30" >
  		<option value=""> - - - - - Select  - - - - - </option>
  				<%
				ps_subgrd = con.prepareStatement("select * from MSTACCTGL order by GL_NAME");
				rs_subgrd = ps_subgrd.executeQuery();
				while(rs_subgrd.next()){
				%>
					<Option Value="<%=rs_subgrd.getString("GL_ACNO") %>" ><%=rs_subgrd.getString("GL_NAME") %></Option>
				<%
				}
				%>	
		</select>
	</Td>
	  </tr>
		<tr>
		  <Td align="left">
	    <label class="caption">Stock List Group </label>			</Td>
	  <Td align="left">
  		<Select id="drpAcctGroup" name="drpAcctGroup"> 
  		<option value=""> - - - - - Select  - - - - - </option>
				<%
				ps_subgrd = con.prepareStatement("SELECT * FROM MSTMATGROUP");
				rs_subgrd = ps_subgrd.executeQuery();
				while(rs_subgrd.next()){
				%>
					<Option Value="<%=rs_subgrd.getString("CODE") %>" ><%=rs_subgrd.getString("NAME") %></Option>
				<%
				}
				%>	
					
				</select>
		</Td>
	  </tr>
		<tr>
		  <td align="left"><label class="caption">Store Location</label>          </td>
		  <Td align="left"><Select id="drpLocCode" name="drpLocCode"> 
		  <option value=""> - - - - - Select  - - - - - </option>
            <%
				ps_subgrd = con.prepareStatement("SELECT * FROM MSTMATLOCATION");
				rs_subgrd = ps_subgrd.executeQuery();
				while(rs_subgrd.next()){
				%>
					<Option Value="<%=rs_subgrd.getString("CODE") %>" ><%=rs_subgrd.getString("NAME") %></Option>
				<%
				}
				%>	            
          </select></Td>
  </tr>
		<tr>
		  <Td align="left">
	    <label class="caption">DBK </label>			</Td>
	  <Td align="left">
				
  <Select id="drpDbk" name="drpDbk"  TabIndex="33" >
				
					<Option Value="0" >Not Applicable</Option>
				</select>			</Td>
	  </tr>
		<tr>
		  <Td align="left">
	    <label class="caption">Goods Category </label>			</Td>
	  <Td align="left">
				
  <Select id="drpGoodsCat" name="drpGoodsCat"  TabIndex="34" >
				 <option value=""> - - - - - Select  - - - - - </option>
			  <%
				ps_subgrd = con.prepareStatement("SELECT * FROM CNFGSTRATECATEGORY");
				rs_subgrd = ps_subgrd.executeQuery();
				while(rs_subgrd.next()){
				%>
					<Option Value="<%=rs_subgrd.getString("CODE") %>" ><%=rs_subgrd.getString("NAME") %></Option>
				<%
				}
				%>	
				</select>			
			</Td>
	  </tr>
		<tr>
		  <td align="left"><label class="caption">BHN Specification</label>          </td>
		  <td align="left"><Input Type="Text" Id="txtBHNSpec" name="txtBHNSpec" TabIndex="35"  Size="20" MaxLength="20" >          </td>
  </tr>
		<tr>
		  <td align="left"><span class="caption">Old System Code</span></td>
		  <td align="left"><Input Type="Text" Id="txtOldCode" name="txtOldCode" TabIndex="36"  Size="15" MaxLength="10"  ></td>
  </tr>
		<tr>
		  <td align="left"></td>
	  <td align="left"><input type="checkbox" name="chkWTinputSale2"  Class="check" TabIndex=37 >
        <label class="caption">Is Wt.Input in Invoice</label></td>
	  </tr>
		
		<tr>
		  <td align="left" valign="top">Remark</td>
	  <td align="left">
	    <textarea id="txtAddSpec" name="txtAddSpec" TabIndex="38"  Cols=52 rows=3 OnKeyup="CheckTextAreaLength(this , 500)" OnKeyDown="CheckTextAreaLength(this , 500)" > </textarea>			</td>
	  </tr>
		<tr>
		  <td align="left">&nbsp;</td>
		  <td align="left"><input type="submit" name="submit" id="submit" value="Submit for Approval" style="font-weight:bold;height: 29px;width: 200px;background-color: #9ae9ef;"></td>
  </tr>
	</table>
</form>
</div>
<!-------------------------------------------------------------------------------------------------------------------------------------------------------------------------->
<div style="height:100%; overflow: scroll;background-color: white;width:29%;float:right;">
<%
PreparedStatement ps_avail =null;
ResultSet rs_avail = null;
%>
<form action="Supplier_Summary.jsp" method="post" name="edit" id="edit">
<span id="autofind">
<input type="hidden" name="hid_code" id="hid_code">
<table class="tftable">
  <tr>
    <th>Available Supplier Names</th>
  </tr>
<%
ps_avail = conlocal.prepareStatement("select * from erp_itemmaster where enable=1");
rs_avail = ps_avail.executeQuery();
while(rs_avail.next()){
%>
<tr>
	<td><%=rs_avail.getString("NAME") %></td>
</tr>
<%
}
%>
</table>
</span>
</form>
</div>
<!-------------------------------------------------------------------------------------------------------------------------------------------------------------------------->
	<%
		} catch (Exception e) {
			e.printStackTrace();
			e.getMessage();
		}
	%>
</body>
</html>