package it.muthagroup.vo;

import java.io.InputStream;

public class DMS_VO {

	private int srno;
	private String folder, file, share_others, shared_access, blob_name;
	private InputStream blob_file;

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

	public String getShared_access() {
		return shared_access;
	}

	public void setShared_access(String shared_access) {
		this.shared_access = shared_access;
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
