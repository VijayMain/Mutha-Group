package com.muthagroup.vo;

import java.io.InputStream;
import java.sql.Date;

public class Stories_vo {
	String heading, details;
	InputStream blob_doc, blob_photo;
	String doc_filename, photofilename;
	int acc_all = 0, acc_h21 = 0, acc_h25 = 0, acc_mfpl = 0, acc_unit3 = 0,
			acc_di = 0, acc_dept = 0, priority;
	Date date_from = null, date_to = null;

	public int getPriority() {
		return priority;
	}

	public void setPriority(int priority) {
		this.priority = priority;
	}

	public Date getDate_from() {
		return date_from;
	}

	public void setDate_from(Date date_from) {
		this.date_from = date_from;
	}

	public Date getDate_to() {
		return date_to;
	}

	public void setDate_to(Date date_to) {
		this.date_to = date_to;
	}

	public int getAcc_all() {
		return acc_all;
	}

	public void setAcc_all(int acc_all) {
		this.acc_all = acc_all;
	}

	public int getAcc_h21() {
		return acc_h21;
	}

	public void setAcc_h21(int acc_h21) {
		this.acc_h21 = acc_h21;
	}

	public int getAcc_h25() {
		return acc_h25;
	}

	public void setAcc_h25(int acc_h25) {
		this.acc_h25 = acc_h25;
	}

	public int getAcc_mfpl() {
		return acc_mfpl;
	}

	public void setAcc_mfpl(int acc_mfpl) {
		this.acc_mfpl = acc_mfpl;
	}

	public int getAcc_unit3() {
		return acc_unit3;
	}

	public void setAcc_unit3(int acc_unit3) {
		this.acc_unit3 = acc_unit3;
	}

	public int getAcc_di() {
		return acc_di;
	}

	public void setAcc_di(int acc_di) {
		this.acc_di = acc_di;
	}

	public int getAcc_dept() {
		return acc_dept;
	}

	public void setAcc_dept(int acc_dept) {
		this.acc_dept = acc_dept;
	}

	public String getHeading() {
		return heading;
	}

	public void setHeading(String heading) {
		this.heading = heading;
	}

	public String getDetails() {
		return details;
	}

	public void setDetails(String details) {
		this.details = details;
	}

	public InputStream getBlob_doc() {
		return blob_doc;
	}

	public void setBlob_doc(InputStream blob_doc) {
		this.blob_doc = blob_doc;
	}

	public InputStream getBlob_photo() {
		return blob_photo;
	}

	public void setBlob_photo(InputStream blob_photo) {
		this.blob_photo = blob_photo;
	}

	public String getDoc_filename() {
		return doc_filename;
	}

	public void setDoc_filename(String doc_filename) {
		this.doc_filename = doc_filename;
	}

	public String getPhotofilename() {
		return photofilename;
	}

	public void setPhotofilename(String photofilename) {
		this.photofilename = photofilename;
	};

}