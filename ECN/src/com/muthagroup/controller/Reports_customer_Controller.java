package com.muthagroup.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import net.sf.jasperreports.engine.JRExporter;
import net.sf.jasperreports.engine.JRExporterParameter;
import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperExportManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.export.JRPdfExporter;
import com.muthagroup.connectionUtility.Connection_Utility;
//============================================================================-->
//============================ Controller  ===================================-->
//============================================================================-->
public class Reports_customer_Controller extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

		try {
			JasperReport jasperReport;
			JasperPrint jasperPrint;
			String startsup = null, endsup = null, startitem = null, enditem = null;
			Connection con = Connection_Utility.getConnection();

			// ******************************************************************************************************************
			int comp_sup = Integer.parseInt(request
					.getParameter("company_name_sup"));

			startsup = request.getParameter("start_date_sup");
			endsup = request.getParameter("end_date_sup");
			Timestamp startdatesup = null, enddatesup = null;
			SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
			if (!startsup.equals("") && !endsup.equals("")) {
				enddatesup = new java.sql.Timestamp(formatter.parse(endsup)
						.getTime());
				startdatesup = new java.sql.Timestamp(formatter.parse(startsup)
						.getTime());

			}
			// ******************************************************************************************************************
			int comp_item = Integer.parseInt(request
					.getParameter("company_name_item"));
			int item_item = Integer.parseInt(request.getParameter("item_name"));
			System.out.println("item wise == " + comp_item + "\n" + item_item);
			startitem = request.getParameter("start_date_item");
			enditem = request.getParameter("end_date_item");
			Timestamp startdateitem = null, enddateitem = null;
			if (!startitem.equals("") && !enditem.equals("")) {
				enddateitem = new java.sql.Timestamp(formatter.parse(enditem)
						.getTime());
				startdateitem = new java.sql.Timestamp(formatter.parse(
						startitem).getTime());
			}
			// ******************************************************************************************************************

			// ******************************************************************************************************************

			if (comp_sup != 0 && startsup.equalsIgnoreCase("")
					&& endsup.equalsIgnoreCase("") && comp_item == 0
					&& item_item == 0 && startitem.equalsIgnoreCase("")
					&& enditem.equalsIgnoreCase("")) {
				try {
					System.out.println("Test company");
					jasperReport = JasperCompileManager
							.compileReport("C:/JRXMLFILES/JRXMLCAB/CRC_CompanyWise.jrxml");

					Map parameters = new HashMap();
					parameters.put("company_id", comp_sup);
					jasperPrint = JasperFillManager.fillReport(jasperReport,
							parameters, con);

					// for creating report in excel format
					JRExporter exporter = new JRPdfExporter();
					exporter.setParameter(JRExporterParameter.JASPER_PRINT,
							jasperPrint);
					// exporterXls.setParameter(JRExporterParameter.OUTPUT_FILE_NAME,
					// "D:/demo.xls");
					ServletOutputStream servletOutputStream = response
							.getOutputStream();
					JasperExportManager.exportReportToPdfStream(jasperPrint,
							servletOutputStream);
					servletOutputStream.flush();
					servletOutputStream.close();

					// response.sendRedirect("Jasper_demo.jsp");
					exporter.exportReport();

				} catch (Exception e) {
					e.printStackTrace();
				}

			} else if (comp_sup != 0 && !startsup.equalsIgnoreCase("")
					&& !endsup.equalsIgnoreCase("") && comp_item == 0
					&& item_item == 0 && startitem.equalsIgnoreCase("")
					&& enditem.equalsIgnoreCase("")) {

				try {
					System.out.println("Test company datewise");
					jasperReport = JasperCompileManager
							.compileReport("C:/JRXMLFILES/JRXMLCAB/CRC_CompanyDateWise.jrxml");

					Map parameters = new HashMap();
					parameters.put("company_id", comp_sup);
					parameters.put("fdate", startdatesup);
					parameters.put("sdate", enddatesup);
					jasperPrint = JasperFillManager.fillReport(jasperReport,
							parameters, con);

					// for creating report in excel format
					JRExporter exporter = new JRPdfExporter();
					exporter.setParameter(JRExporterParameter.JASPER_PRINT,
							jasperPrint);
					// exporterXls.setParameter(JRExporterParameter.OUTPUT_FILE_NAME,
					// "D:/demo.xls");
					ServletOutputStream servletOutputStream = response
							.getOutputStream();
					JasperExportManager.exportReportToPdfStream(jasperPrint,
							servletOutputStream);
					servletOutputStream.flush();
					servletOutputStream.close();

					// response.sendRedirect("Jasper_demo.jsp");
					exporter.exportReport();

				} catch (Exception e) {
					e.printStackTrace();
				}

			} else if (comp_sup == 0 && startsup.equals("")
					&& endsup.equals("") && comp_item != 0 && item_item == 0
					&& startitem.equalsIgnoreCase("")
					&& enditem.equalsIgnoreCase("")) {
				try {
					System.out.println("Test company datewise...............");
					jasperReport = JasperCompileManager
							.compileReport("C:/JRXMLFILES/JRXMLCAB/CRC_CompanyWise.jrxml");

					Map parameters = new HashMap();
					parameters.put("company_id", comp_item);
					jasperPrint = JasperFillManager.fillReport(jasperReport,
							parameters, con);

					// for creating report in excel format
					JRExporter exporter = new JRPdfExporter();
					exporter.setParameter(JRExporterParameter.JASPER_PRINT,
							jasperPrint);
					// exporterXls.setParameter(JRExporterParameter.OUTPUT_FILE_NAME,
					// "D:/demo.xls");
					ServletOutputStream servletOutputStream = response
							.getOutputStream();
					JasperExportManager.exportReportToPdfStream(jasperPrint,
							servletOutputStream);
					servletOutputStream.flush();
					servletOutputStream.close();

					// response.sendRedirect("Jasper_demo.jsp");
					exporter.exportReport();

				} catch (Exception e) {
					e.printStackTrace();
				}
			} else if (comp_sup == 0 && startsup.equals("")
					&& endsup.equals("") && comp_item != 0 && item_item != 0
					&& startitem.equalsIgnoreCase("")
					&& enditem.equalsIgnoreCase("")) {

				try {
					System.out.println("Test company item");
					jasperReport = JasperCompileManager
							.compileReport("C:/JRXMLFILES/JRXMLCAB/CRC_CompanyItemWise.jrxml");
					Map parameters = new HashMap();
					parameters.put("company_id", comp_item);
					parameters.put("Item_Id", item_item);
					jasperPrint = JasperFillManager.fillReport(jasperReport,
							parameters, con);

					// for creating report in excel format
					JRExporter exporter = new JRPdfExporter();
					exporter.setParameter(JRExporterParameter.JASPER_PRINT,
							jasperPrint);
					// exporterXls.setParameter(JRExporterParameter.OUTPUT_FILE_NAME,
					// "D:/demo.xls");
					ServletOutputStream servletOutputStream = response
							.getOutputStream();
					JasperExportManager.exportReportToPdfStream(jasperPrint,
							servletOutputStream);
					servletOutputStream.flush();
					servletOutputStream.close();

					// response.sendRedirect("Jasper_demo.jsp");
					exporter.exportReport();

				} catch (Exception e) {
					e.printStackTrace();
				}

			}

			else if (comp_sup == 0 && startsup.equals("") && endsup.equals("")
					&& comp_item != 0 && item_item != 0
					&& !startitem.equalsIgnoreCase("")
					&& !enditem.equalsIgnoreCase("")) {

				try {
					System.out.println("Test company item");
					jasperReport = JasperCompileManager
							.compileReport("C:/JRXMLFILES/JRXMLCAB/CRC_CompanyItemDateWise.jrxml");
					Map parameters = new HashMap();
					parameters.put("company_id", comp_item);
					parameters.put("Item_Id", item_item);
					parameters.put("fdate", startdateitem);
					parameters.put("sdate", enddateitem);
					jasperPrint = JasperFillManager.fillReport(jasperReport,
							parameters, con);

					// for creating report in excel format
					JRExporter exporter = new JRPdfExporter();
					exporter.setParameter(JRExporterParameter.JASPER_PRINT,
							jasperPrint);
					// exporterXls.setParameter(JRExporterParameter.OUTPUT_FILE_NAME,
					// "D:/demo.xls");
					ServletOutputStream servletOutputStream = response
							.getOutputStream();
					JasperExportManager.exportReportToPdfStream(jasperPrint,
							servletOutputStream);
					servletOutputStream.flush();
					servletOutputStream.close();

					// response.sendRedirect("Jasper_demo.jsp");
					exporter.exportReport();

				} catch (Exception e) {
					e.printStackTrace();
				}

			}

			else if (comp_sup == 0 && startsup.equals("") && endsup.equals("")
					&& comp_item == 0 && item_item != 0
					&& startitem.equalsIgnoreCase("")
					&& enditem.equalsIgnoreCase("")) {

				try {
					System.out.println("Test item ");
					jasperReport = JasperCompileManager
							.compileReport("C:/JRXMLFILES/JRXMLCAB/CRC_ItemWise.jrxml");

					Map parameters = new HashMap();
					parameters.put("Item_Id", item_item);
					jasperPrint = JasperFillManager.fillReport(jasperReport,
							parameters, con);

					// for creating report in excel format
					JRExporter exporter = new JRPdfExporter();
					exporter.setParameter(JRExporterParameter.JASPER_PRINT,
							jasperPrint);
					// exporterXls.setParameter(JRExporterParameter.OUTPUT_FILE_NAME,
					// "D:/demo.xls");
					ServletOutputStream servletOutputStream = response
							.getOutputStream();
					JasperExportManager.exportReportToPdfStream(jasperPrint,
							servletOutputStream);
					servletOutputStream.flush();
					servletOutputStream.close();

					// response.sendRedirect("Jasper_demo.jsp");
					exporter.exportReport();

				} catch (Exception e) {
					e.printStackTrace();
				}

			} else if (comp_sup == 0 && startsup.equals("")
					&& endsup.equals("") && comp_item == 0 && item_item != 0
					&& !startitem.equalsIgnoreCase("")
					&& !enditem.equalsIgnoreCase("")) {
				try {
					System.out.println("Test item ");
					jasperReport = JasperCompileManager
							.compileReport("C:/JRXMLFILES/JRXMLCAB/CRC_ItemDateWise.jrxml");

					Map parameters = new HashMap();
					parameters.put("Item_Id", item_item);
					parameters.put("fdate", startdateitem);
					parameters.put("sdate", enddateitem);

					jasperPrint = JasperFillManager.fillReport(jasperReport,
							parameters, con);

					// for creating report in excel format
					JRExporter exporter = new JRPdfExporter();
					exporter.setParameter(JRExporterParameter.JASPER_PRINT,
							jasperPrint);
					// exporterXls.setParameter(JRExporterParameter.OUTPUT_FILE_NAME,
					// "D:/demo.xls");
					ServletOutputStream servletOutputStream = response
							.getOutputStream();
					JasperExportManager.exportReportToPdfStream(jasperPrint,
							servletOutputStream);
					servletOutputStream.flush();
					servletOutputStream.close();

					// response.sendRedirect("Jasper_demo.jsp");
					exporter.exportReport();

				} catch (Exception e) {
					e.printStackTrace();
				}

			} else if (comp_sup == 0 && startsup.equalsIgnoreCase("")
					&& endsup.equalsIgnoreCase("") && comp_item != 0
					&& item_item == 0 && !startitem.equalsIgnoreCase("")
					&& !enditem.equalsIgnoreCase("")) {

				try {
					System.out.println("Test comp datewise");
					jasperReport = JasperCompileManager
							.compileReport("C:/JRXMLFILES/JRXMLCAB/CRC_CompanyDateWise.jrxml");

					Map parameters = new HashMap();
					parameters.put("company_id", comp_item);
					parameters.put("fdate", startdateitem);
					parameters.put("sdate", enddateitem);
					jasperPrint = JasperFillManager.fillReport(jasperReport,
							parameters, con);

					// for creating report in excel format
					JRExporter exporter = new JRPdfExporter();
					exporter.setParameter(JRExporterParameter.JASPER_PRINT,
							jasperPrint);
					// exporterXls.setParameter(JRExporterParameter.OUTPUT_FILE_NAME,
					// "D:/demo.xls");
					ServletOutputStream servletOutputStream = response
							.getOutputStream();
					JasperExportManager.exportReportToPdfStream(jasperPrint,
							servletOutputStream);
					servletOutputStream.flush();
					servletOutputStream.close();

					// response.sendRedirect("Jasper_demo.jsp");
					exporter.exportReport();

				} catch (Exception e) {
					e.printStackTrace();
				}

			}

		} catch (Exception e) {
			e.printStackTrace();
		}

	}

}
//============================================================================--> 
//============================================================================-->