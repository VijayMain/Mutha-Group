package it.muthagroup.vo;

import java.io.InputStream;

public class DMS_VO {

	private int srno, dmscode, shared_access;
	private String folder, subject, file, share_others, blob_name, note;
	private InputStream blob_file = null;

	public int getDmscode() {
		return dmscode;
	}

	public void setDmscode(int dmscode) {
		this.dmscode = dmscode;
	}

	public int getSrno() {
		return srno;
	}

	public void setSrno(int srno) {
		this.srno = srno;
	}

	public String getFolder() {
		return folder;
	}

	public void setFolder(String folder) {
		this.folder = folder;
	}

	public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}

	public String getFile() {
		return file;
	}

	public void setFile(String file) {
		this.file = file;
	}

	public String getShare_others() {
		return share_others;
	}

	public void setShare_others(String share_others) {
		this.share_others = share_others;
	}

	public int getShared_access() {
		return shared_access;
	}

	public void setShared_access(int shared_access) {
		this.shared_access = shared_access;
	}

	public String getNote() {
		return note;
	}

	public void setNote(String note) {
		this.note = note;
	}

	public String getBlob_name() {
		return blob_name;
	}

	public void setBlob_name(String blob_name) {
		this.blob_name = blob_name;
	}

	public InputStream getBlob_file() {
		return blob_file;
	}

	public void setBlob_file(InputStream blob_file) {
		this.blob_file = blob_file;
	}

}
