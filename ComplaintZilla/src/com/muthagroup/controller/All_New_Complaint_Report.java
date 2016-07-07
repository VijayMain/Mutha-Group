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

import com.muthagroup.connectionModel.Connection_Utility;

import net.sf.jasperreports.engine.JRExporter;
import net.sf.jasperreports.engine.JRExporterParameter;
import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperExportManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.export.JRPdfExporter;

public class All_New_Complaint_Report extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		JasperReport jasperReport;
		JasperPrint jasperPrint;
		Timestamp startdate = null, enddate = null;
		String newReport = null, openReport = null, closeReport = null, startdate1 = null, enddate1 = null, ResolvedReport = null, ReopenReport = null;
		int comp_Name = 0, item = 0, defect = 0, comp_namecd = 0;

		Timestamp end_date_cust = null, start_date_cust = null;
		int cust_comp_id = 0, cust_id = 0;
		String sdate = null, edate = null;

		try {
			Connection con = Connection_Utility.getConnection();
			newReport = request.getParameter("new");
			openReport = request.getParameter("open");
			closeReport = request.getParameter("Close");

			ResolvedReport = request.getParameter("Resolved");
			ReopenReport = request.getParameter("Reopen");

			sdate = request.getParameter("start_date_cust");
			edate = request.getParameter("end_date_cust");
			cust_comp_id = Integer.parseInt(request.getParameter("cust_id"));
			cust_id = Integer.parseInt(request
					.getParameter("company_name_cust"));

			comp_Name = Integer.parseInt(request
					.getParameter("company_name_sup"));
			startdate1 = request.getParameter("start_date_sup");
			enddate1 = request.getParameter("end_date_sup");
			item = Integer.parseInt(request.getParameter("item"));
			defect = Integer.parseInt(request.getParameter("defect"));
			comp_namecd = Integer.parseInt(request
					.getParameter("company_name_cd"));

			System.out.println("Complaint Report " + newReport + openReport
					+ closeReport);

			SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
			if (startdate1 != "" && enddate1 != "") {
				enddate = new java.sql.Timestamp(formatter.parse(enddate1)
						.getTime());
				System.out.print("enddate... :" + enddate);
				startdate = new java.sql.Timestamp(formatter.parse(startdate1)
						.getTime());

				System.out.println("Start date...: " + startdate);
			} else if (sdate != "" && edate != "") {
				start_date_cust = new java.sql.Timestamp(formatter.parse(sdate)
						.getTime());
				System.out.print("Start date for customer... :"
						+ start_date_cust);

				end_date_cust = new java.sql.Timestamp(formatter.parse(edate)
						.getTime());

				System.out.println("End date for customer ...: "
						+ end_date_cust);
			}

			if (newReport != null) {
				try {

					jasperReport = JasperCompileManager
							.compileReport("C:/JRXMLFILES/Complaint.jrxml");

					Map<String, Object> parameters = new HashMap<String, Object>();
					jasperPrint = JasperFillManager.fillReport(jasperReport,
							parameters, con);

					JRExporter exporter = new JRPdfExporter();
					exporter.setParameter(JRExporterParameter.JASPER_PRINT,
							jasperPrint);

					ServletOutputStream servletOutputStream = response
							.getOutputStream();
					JasperExportManager.exportReportToPdfStream(jasperPrint,
							servletOutputStream);
					servletOutputStream.flush();
					servletOutputStream.close();

					// exporter.exportReport();

				} catch (Exception e) {
					e.printStackTrace();
				}
			} else if (openReport != null) {
				try {

					jasperReport = JasperCompileManager
							.compileReport("C:/JRXMLFILES/OpenComplaint.jrxml");

					Map<String, Object> parameters = new HashMap<String, Object>();
					jasperPrint = JasperFillManager.fillReport(jasperReport,
							parameters, con);

					JRExporter exporter = new JRPdfExporter();
					exporter.setParameter(JRExporterParameter.JASPER_PRINT,
							jasperPrint);

					ServletOutputStream servletOutputStream = response
							.getOutputStream();
					JasperExportManager.exportReportToPdfStream(jasperPrint,
							servletOutputStream);
					servletOutputStream.flush();
					servletOutputStream.close();

					// exporter.exportReport();

				} catch (Exception e) {
					e.printStackTrace();
				}
			} else if (closeReport != null) {
				try {

					jasperReport = JasperCompileManager
							.compileReport("C:/JRXMLFILES/ClosedComplaint.jrxml");

					Map<String, Object> parameters = new HashMap<String, Object>();
					parameters.put("company_ID", comp_Name);
					jasperPrint = JasperFillManager.fillReport(jasperReport,
							parameters, con);

					JRExporter exporter = new JRPdfExporter();
					exporter.setParameter(JRExporterParameter.JASPER_PRINT,
							jasperPrint);
					ServletOutputStream servletOutputStream = response
							.getOutputStream();
					JasperExportManager.exportReportToPdfStream(jasperPrint,
							servletOutputStream);
					servletOutputStream.flush();
					servletOutputStream.close();

					// exporter.exportReport();

				} catch (Exception e) {
					e.printStackTrace();
				}
			}

			else if (ResolvedReport != null) {
				try {

					jasperReport = JasperCompileManager
							.compileReport("C:/JRXMLFILES/ResolvedComplaint.jrxml");

					Map parameters = new HashMap();
					jasperPrint = JasperFillManager.fillReport(jasperReport,
							parameters, con);

					JRExporter exporter = new JRPdfExporter();
					exporter.setParameter(JRExporterParameter.JASPER_PRINT,
							jasperPrint);

					ServletOutputStream servletOutputStream = response
							.getOutputStream();
					JasperExportManager.exportReportToPdfStream(jasperPrint,
							servletOutputStream);
					servletOutputStream.flush();
					servletOutputStream.close();

					// exporter.exportReport();

				} catch (Exception e) {
					e.printStackTrace();
				}
			}

			else if (ReopenReport != null) {
				try {

					jasperReport = JasperCompileManager
							.compileReport("C:/JRXMLFILES/ReopenComplaint.jrxml");

					Map parameters = new HashMap();
					jasperPrint = JasperFillManager.fillReport(jasperReport,
							parameters, con);

					JRExporter exporter = new JRPdfExporter();
					exporter.setParameter(JRExporterParameter.JASPER_PRINT,
							jasperPrint);

					ServletOutputStream servletOutputStream = response
							.getOutputStream();
					JasperExportManager.exportReportToPdfStream(jasperPrint,
							servletOutputStream);
					servletOutputStream.flush();
					servletOutputStream.close();

					// exporter.exportReport();

				} catch (Exception e) {
					e.printStackTrace();
				}
			}

			else if (comp_Name != 0 && startdate1 == "" && enddate1 == "") {
				try {
					System.out.println("Company Name = " + comp_Name);
					jasperReport = JasperCompileManager
							.compileReport("C:/JRXMLFILES/compNameComplaint.jrxml");

					Map parameters = new HashMap();
					parameters.put("company_ID", comp_Name);
					jasperPrint = JasperFillManager.fillReport(jasperReport,
							parameters, con);

					JRExporter exporter = new JRPdfExporter();
					exporter.setParameter(JRExporterParameter.JASPER_PRINT,
							jasperPrint);
					ServletOutputStream servletOutputStream = response
							.getOutputStream();
					JasperExportManager.exportReportToPdfStream(jasperPrint,
							servletOutputStream);
					servletOutputStream.flush();
					servletOutputStream.close();

					// exporter.exportReport();

				} catch (Exception e) {
					e.printStackTrace();
				}
			} else if (startdate1 != "" && enddate1 != "" && comp_Name == 0) {
				System.out.println("Testing........");
				try {

					jasperReport = JasperCompileManager
							.compileReport("C:/JRXMLFILES/ComplaintBetweenDates.jrxml");

					Map parameters = new HashMap();
					parameters.put("frm_date", startdate);
					parameters.put("to_date", enddate);
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
					// exporter.exportReport();

				} catch (Exception e) {
					e.printStackTrace();
				}

			}

			else if (startdate1 != "" && enddate1 != "" && comp_Name != 0) {
				System.out.println("Testing........");
				try {

					jasperReport = JasperCompileManager
							.compileReport("C:/JRXMLFILES/CompanyBetweenDates.jrxml");

					Map parameters = new HashMap();
					parameters.put("frm_date", startdate);
					parameters.put("to_date", enddate);
					parameters.put("Comp", comp_Name);
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
					// exporter.exportReport();

				} catch (Exception e) {
					e.printStackTrace();
				}

			}

			else if (comp_namecd != 0 && item != 0 && defect != 0) {

				try {

					jasperReport = JasperCompileManager
							.compileReport("C:/JRXMLFILES/CompDefItem.jrxml");

					Map parameters = new HashMap();
					parameters.put("company_id", comp_namecd);
					parameters.put("defect_id", defect);
					parameters.put("item_id", item);
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
					// exporter.exportReport();

				} catch (Exception e) {
					e.printStackTrace();
				}

			} else if (comp_namecd != 0 && defect != 0) {

				try {

					jasperReport = JasperCompileManager
							.compileReport("C:/JRXMLFILES/CompDef.jrxml");

					Map parameters = new HashMap();
					parameters.put("company_id", comp_namecd);
					parameters.put("defect_id", defect);
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
					// exporter.exportReport();

				} catch (Exception e) {
					e.printStackTrace();
				}

			} else if (comp_namecd != 0 && item != 0) {

				try {

					jasperReport = JasperCompileManager
							.compileReport("C:/JRXMLFILES/CompItem.jrxml");

					Map parameters = new HashMap();
					parameters.put("company_id", comp_namecd);
					parameters.put("item_id", item);
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
					// exporter.exportReport();

				} catch (Exception e) {
					e.printStackTrace();
				}

			} else if (item != 0) {

				try {

					jasperReport = JasperCompileManager
							.compileReport("C:/JRXMLFILES/Item.jrxml");

					Map parameters = new HashMap();
					parameters.put("item_id", item);
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
					// exporter.exportReport();

				} catch (Exception e) {
					e.printStackTrace();
				}

			} else if (defect != 0) {

				try {

					jasperReport = JasperCompileManager
							.compileReport("C:/JRXMLFILES/defect.jrxml");

					Map parameters = new HashMap();
					parameters.put("defect_id", defect);
					jasperPrint = JasperFillManager.fillReport(jasperReport,
							parameters, con);

					JRExporter exporter = new JRPdfExporter();
					exporter.setParameter(JRExporterParameter.JASPER_PRINT,
							jasperPrint);
					ServletOutputStream servletOutputStream = response
							.getOutputStream();
					JasperExportManager.exportReportToPdfStream(jasperPrint,
							servletOutputStream);
					servletOutputStream.flush();
					servletOutputStream.close();

					// exporter.exportReport();

				} catch (Exception e) {
					e.printStackTrace();
				}

			} else if (item != 0 && defect != 0) {

				try {

					jasperReport = JasperCompileManager
							.compileReport("C:/JRXMLFILES/DefItem.jrxml");

					Map parameters = new HashMap();
					parameters.put("defect_id", defect);
					parameters.put("item_id", item);
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
					// exporter.exportReport();

				} catch (Exception e) {
					e.printStackTrace();
				}

			} else if (comp_namecd != 0) {

				try {

					jasperReport = JasperCompileManager
							.compileReport("C:/JRXMLFILES/compNameComplaint.jrxml");

					Map parameters = new HashMap();
					parameters.put("company_ID", comp_namecd);
					jasperPrint = JasperFillManager.fillReport(jasperReport,
							parameters, con);
					JRExporter exporter = new JRPdfExporter();
					exporter.setParameter(JRExporterParameter.JASPER_PRINT,
							jasperPrint);
					ServletOutputStream servletOutputStream = response
							.getOutputStream();
					JasperExportManager.exportReportToPdfStream(jasperPrint,
							servletOutputStream);
					servletOutputStream.flush();
					servletOutputStream.close();

					// response.sendRedirect("Jasper_demo.jsp");
					// exporter.exportReport();

				} catch (Exception e) {
					e.printStackTrace();
				}

			} else if (request.getParameter("cno") != "") {
				try {

					jasperReport = JasperCompileManager
							.compileReport("C:/JRXMLFILES/Complaintwise.jrxml");
					System.out.println("Complaint"
							+ request.getParameter("cno"));
					Map parameters = new HashMap();
					parameters.put("complaintno", request.getParameter("cno"));
					jasperPrint = JasperFillManager.fillReport(jasperReport,
							parameters, con);
					JRExporter exporter = new JRPdfExporter();
					exporter.setParameter(JRExporterParameter.JASPER_PRINT,
							jasperPrint);
					ServletOutputStream servletOutputStream = response
							.getOutputStream();
					JasperExportManager.exportReportToPdfStream(jasperPrint,
							servletOutputStream);
					servletOutputStream.flush();
					servletOutputStream.close();

					// response.sendRedirect("Jasper_demo.jsp");
					// exporter.exportReport();

				} catch (Exception e) {
					e.printStackTrace();
				}
			} else if (cust_comp_id != 0 && cust_id != 0 && sdate != ""
					&& edate != "") {
				try {

					System.out.println("This is input data = " + cust_comp_id
							+ "\n" + cust_id + "\n" + sdate + "\n" + edate);

					jasperReport = JasperCompileManager
							.compileReport("C:/JRXMLFILES/Comp_N_CustomerWise_2Dates.jrxml");
					Map parameters = new HashMap();

					parameters.put("frm_date", start_date_cust);
					parameters.put("to_date", end_date_cust);
					parameters.put("Cust_id", cust_id);
					parameters.put("Company_Id", cust_comp_id);

					jasperPrint = JasperFillManager.fillReport(jasperReport,
							parameters, con);
					JRExporter exporter = new JRPdfExporter();
					exporter.setParameter(JRExporterParameter.JASPER_PRINT,
							jasperPrint);
					ServletOutputStream servletOutputStream = response
							.getOutputStream();
					JasperExportManager.exportReportToPdfStream(jasperPrint,
							servletOutputStream);
					servletOutputStream.flush();
					servletOutputStream.close();

					// response.sendRedirect("Jasper_demo.jsp");
					// exporter.exportReport();

				} catch (Exception e) {
					e.printStackTrace();
				}

			} else if (cust_comp_id != 0 && cust_id != 0 && sdate == ""
					&& edate == "") {
				try {

					System.out.println("This is input data = " + cust_comp_id
							+ "\n" + cust_id + "\n" + sdate + "\n" + edate);

					jasperReport = JasperCompileManager
							.compileReport("C:/JRXMLFILES/Comp_N_CustomerWise.jrxml");
					Map parameters = new HashMap();

					parameters.put("Cust_id", cust_id);
					parameters.put("Company_Id", cust_comp_id);

					jasperPrint = JasperFillManager.fillReport(jasperReport,
							parameters, con);
					JRExporter exporter = new JRPdfExporter();
					exporter.setParameter(JRExporterParameter.JASPER_PRINT,
							jasperPrint);
					ServletOutputStream servletOutputStream = response
							.getOutputStream();
					JasperExportManager.exportReportToPdfStream(jasperPrint,
							servletOutputStream);
					servletOutputStream.flush();
					servletOutputStream.close();

					// response.sendRedirect("Jasper_demo.jsp");
					// exporter.exportReport();

				} catch (Exception e) {
					e.printStackTrace();
				}

			}

		} catch (Exception e) {
			e.printStackTrace();
		}

	}
}
