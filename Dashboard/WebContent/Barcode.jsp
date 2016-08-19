<%@page import="com.itextpdf.text.pdf.Barcode128"%>
<%@page import="com.itextpdf.text.Paragraph"%>
<%@page import="com.itextpdf.text.pdf.PdfWriter"%>
<%@page import="java.io.FileOutputStream"%>
<%@page import="com.itextpdf.text.Rectangle"%>
<%@page import="com.itextpdf.text.PageSize"%>
<%@page import="com.itextpdf.text.Document"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<% 
Document document = new Document(new Rectangle(PageSize.A4));    
PdfWriter writer = PdfWriter.getInstance(document, new FileOutputStream("D:\\Barcode_sample.pdf"));    

document.open();
document.add(new Paragraph("Code128 MuthaGroup"));

	    Barcode128 code128 = new Barcode128();
	    code128.setGenerateChecksum(true);
	    code128.setCode("1234554321");    

    document.add(code128.createImageWithBarcode(writer.getDirectContent(), null, null));
document.close();

System.out.println("Document Generated...!!!!!!");
%>
</body>
</html>