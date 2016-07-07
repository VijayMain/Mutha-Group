package com.muthagroup.vo;

import java.io.InputStream;

public class Add_Operation_vo {

	String opnno = null;
	String operation = null;
	int basic_id = 0;
	String op_ImageName;
	InputStream op_Image_blob = null;

	public InputStream getOp_Image_blob() {
		return op_Image_blob;
	}

	public void setOp_Image_blob(InputStream op_Image_blob) {
		this.op_Image_blob = op_Image_blob;
	}

	public String getOp_ImageName() {
		return op_ImageName;
	}

	public void setOp_ImageName(String op_ImageName) {
		this.op_ImageName = op_ImageName;
	}

	public int getBasic_id() {
		return basic_id;
	}

	public void setBasic_id(int basic_id) {
		this.basic_id = basic_id;
	}

	public String getOpnno() {
		return opnno;
	}

	public void setOpnno(String opnno) {
		this.opnno = opnno;
	}

	public String getOperation() {
		return operation;
	}

	public void setOperation(String operation) {
		this.operation = operation;
	}

}
