package com.muthagroup.vo;

import java.io.InputStream;

public class MyMOM_vo {
	private String remark, blob_name;
	private int event_id;
	private InputStream blob_file = null;

	public int getEvent_id() {
		return event_id;
	}

	public void setEvent_id(int event_id) {
		this.event_id = event_id;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public InputStream getBlob_file() {
		return blob_file;
	}

	public void setBlob_file(InputStream blob_file) {
		this.blob_file = blob_file;
	}

	public String getBlob_name() {
		return blob_name;
	}

	public void setBlob_name(String blob_name) {
		this.blob_name = blob_name;
	}

}
