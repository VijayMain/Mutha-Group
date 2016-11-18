<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<script type="text/javascript">
localStorage.setItem("Vijay", "My values");
var taste = localStorage.getItem("Vijay");

alert(taste);

	function ClearList(OptionList, TitleName) {
		OptionList.length = 0;
	}

	function move(side, form_name) {
		var temp1 = new Array();
		var temp2 = new Array();
		var current1 = 0;
		var current2 = 0;
		var attribute;

		//assign what select attribute treat as attribute1 and attribute2
		if (side == "right") {
			attribute1 = document.getElementById('software_name');
			attribute2 = document.getElementById('software_selected');
		} else {
			attribute2 = document.getElementById('software_name');
			attribute1 = document.getElementById('software_selected');
		}

		//fill an array with old values
		for ( var i = 0; i < attribute2.length; i++) {
			temp1[current1++] = attribute2.options[i].value;
		}

		//assign new values to arrays
		for ( var i = 0; i < attribute1.length; i++) {
			if (attribute1.options[i].selected) {
				temp1[current1++] = attribute1.options[i].value;
			} else {
				temp2[current2++] = attribute1.options[i].value;
			}
		}

		//generating new options 
		for ( var i = 0; i < temp1.length; i++) {
			attribute2.options[i] = new Option();
			attribute2.options[i].value = temp1[i];
			attribute2.options[i].text = temp1[i];
			attribute2.options[i].selected = "selected";
		}

		//generating new options
		ClearList(attribute1, attribute1);
		if (temp2.length > 0) {
			for ( var i = 0; i < temp2.length; i++) {
				attribute1.options[i] = new Option();
				attribute1.options[i].value = temp2[i];
				attribute1.options[i].text = temp2[i];
				attribute1.options[i].text = temp2[i];
			}
		}
	}
</script>
</head>
<body>
<form action="Controller" method="post">

<select id="software_name" name="software_name" multiple="multiple" size="5" style="width: 300px;height: 130px;font-size: 15px;" title="Softwares"
onblur="if (this.innerHTML == '') {this.innerHTML = '';}" onfocus="if (this.innerHTML == '') {this.innerHTML = '';}"> 
<option value="One">One</option>
<option value="Two">Two</option>
</select>


<input
								value="&#8658;" onclick="move('right', 'rep')" type="button" style="width: 60px;height: 40px;font-size: 15px;"><br>
								<input value="&#8656;" onclick="move('left', 'rep')"
								type="button" style="width: 60px;height: 40px;font-size: 15px;">
								
	<select id="software_selected"
								name="software_selected" multiple="multiple" size="5"
								style="width: 300px;height: 130px;font-size: 15px;" title="Selected Softwares"
								onblur="if (this.innerHTML == '') {this.innerHTML = '';}"
								onfocus="if (this.innerHTML == '') {this.innerHTML = '';}"></select>							
								
				<input type="submit">				
</form>
</body>
</html>