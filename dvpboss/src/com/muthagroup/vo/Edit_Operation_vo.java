package com.muthagroup.vo;

import java.io.InputStream;

public class Edit_Operation_vo {
	int avail_opn_id = 0;
	int avail_opn_no_id = 0;
	int basic_id = 0;
	int rel_id = 0;
	int opno = 0;
	int newOpn_no = 0;

	String new_operation = null;
	String operation = null;

	String op_ImageName;
	InputStream op_Image_blob = null;

	public String getOp_ImageName() {
		return op_ImageName;
	}

	public void setOp_ImageName(String op_ImageName) {
		this.op_ImageName = op_ImageName;
	}

	public InputStream getOp_Image_blob() {
		return op_Image_blob;
	}

	public void setOp_Image_blob(InputStream op_Image_blob) {
		this.op_Image_blob = op_Image_blob;
	}

	public int getNewOpn_no() {
		return newOpn_no;
	}

	public void setNewOpn_no(int newOpn_no) {
		this.newOpn_no = newOpn_no;
	}

	public String getNew_operation() {
		return new_operation;
	}

	public void setNew_operation(String new_operation) {
		this.new_operation = new_operation;
	}

	public int getBasic_id() {
		return basic_id;
	}

	public void setBasic_id(int basic_id) {
		this.basic_id = basic_id;
	}

	public int getRel_id() {
		return rel_id;
	}

	public void setRel_id(int rel_id) {
		this.rel_id = rel_id;
	}

	public int getAvail_opn_id() {
		return avail_opn_id;
	}

	public void setAvail_opn_id(int avail_opn_id) {
		this.avail_opn_id = avail_opn_id;
	}

	public int getAvail_opn_no_id() {
		return avail_opn_no_id;
	}

	public void setAvail_opn_no_id(int avail_opn_no_id) {
		this.avail_opn_no_id = avail_opn_no_id;
	}

	public int getOpno() {
		return opno;
	}

	public void setOpno(int opno) {
		this.opno = opno;
	}

	public String getOperation() {
		return operation;
	}

	public void setOperation(String operation) {
		this.operation = operation;
	}

}
