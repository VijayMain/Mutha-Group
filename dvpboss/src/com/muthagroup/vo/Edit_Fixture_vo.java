package com.muthagroup.vo;

import java.sql.Date;

public class Edit_Fixture_vo {

	String fixture = null;
	String fixture_no = null;
	String fixtpono = null;
	String new_fixture = null;
	String new_fixture_no = null;

	int mcdataid = 0;
	int rel_id = 0;
	int fixtqty = 0;
	int fixAvail = 0;
	Date quotdate = null;
	Date podate = null;
	Date targetrecdate = null;
	Date actrecdate = null;

	public int getFixAvail() {
		return fixAvail;
	}

	public void setFixAvail(int fixAvail) {
		this.fixAvail = fixAvail;
	}

	public String getNew_fixture() {
		return new_fixture;
	}

	public void setNew_fixture(String new_fixture) {
		this.new_fixture = new_fixture;
	}

	public String getNew_fixture_no() {
		return new_fixture_no;
	}

	public void setNew_fixture_no(String new_fixture_no) {
		this.new_fixture_no = new_fixture_no;
	}

	public String getFixture() {
		return fixture;
	}

	public void setFixture(String fixture) {
		this.fixture = fixture;
	}

	public String getFixture_no() {
		return fixture_no;
	}

	public void setFixture_no(String fixture_no) {
		this.fixture_no = fixture_no;
	}

	public String getFixtpono() {
		return fixtpono;
	}

	public void setFixtpono(String fixtpono) {
		this.fixtpono = fixtpono;
	}

	public int getMcdataid() {
		return mcdataid;
	}

	public void setMcdataid(int mcdataid) {
		this.mcdataid = mcdataid;
	}

	public int getRel_id() {
		return rel_id;
	}

	public void setRel_id(int rel_id) {
		this.rel_id = rel_id;
	}

	public int getFixtqty() {
		return fixtqty;
	}

	public void setFixtqty(int fixtqty) {
		this.fixtqty = fixtqty;
	}

	public Date getQuotdate() {
		return quotdate;
	}

	public void setQuotdate(Date quotdate) {
		this.quotdate = quotdate;
	}

	public Date getPodate() {
		return podate;
	}

	public void setPodate(Date podate) {
		this.podate = podate;
	}

	public Date getTargetrecdate() {
		return targetrecdate;
	}

	public void setTargetrecdate(Date targetrecdate) {
		this.targetrecdate = targetrecdate;
	}

	public Date getActrecdate() {
		return actrecdate;
	}

	public void setActrecdate(Date actrecdate) {
		this.actrecdate = actrecdate;
	}

}
