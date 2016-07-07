package com.muthagroup.vo;

import java.io.InputStream;
import java.sql.Date;

public class New_sheet_vo {

	private Date attendance_date = null;
	private String file_Name_ext = null;
	private InputStream file_blob;

	public Date getAttendance_date() {
		return attendance_date;
	}

	public void setAttendance_date(Date attendance_date) {
		this.attendance_date = attendance_date;
	}

	public String getFile_Name_ext() {
		return file_Name_ext;
	}

	public void setFile_Name_ext(String file_Name_ext) {
		this.file_Name_ext = file_Name_ext;
	}

	public InputStream getFile_blob() {
		return file_blob;
	}

	public void setFile_blob(InputStream file_blob) {
		this.file_blob = file_blob;
	}

}
