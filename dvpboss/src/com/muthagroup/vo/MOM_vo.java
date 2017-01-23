package com.muthagroup.vo;

import java.io.InputStream;
import java.sql.Date;

public class MOM_vo {
	int comp, hid;
	InputStream blob_doc;
	String doc_filename, partname, partcode, title, description;
	Date MOM_date = null;

	public int getHid() {
		return hid;
	}

	public void setHid(int hid) {
		this.hid = hid;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getPartcode() {
		return partcode;
	}

	public void setPartcode(String partcode) {
		this.partcode = partcode;
	}

	public int getComp() {
		return comp;
	}

	public void setComp(int comp) {
		this.comp = comp;
	}

	public InputStream getBlob_doc() {
		return blob_doc;
	}

	public void setBlob_doc(InputStream blob_doc) {
		this.blob_doc = blob_doc;
	}

	public String getDoc_filename() {
		return doc_filename;
	}

	public void setDoc_filename(String doc_filename) {
		this.doc_filename = doc_filename;
	}

	public String getPartname() {
		return partname;
	}

	public void setPartname(String partname) {
		this.partname = partname;
	}

	public Date getMOM_date() {
		return MOM_date;
	}

	public void setMOM_date(Date mOM_date) {
		MOM_date = mOM_date;
	}

}