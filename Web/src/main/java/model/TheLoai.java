package model;

import java.util.ArrayList;
import java.util.List;

public class TheLoai {
	private String maTheLoai;
	private String tenTheLoai;

	public TheLoai(String maTheLoai, String tenTheLoai) {
		super();
		this.maTheLoai = maTheLoai;
		this.tenTheLoai = tenTheLoai;
	}
	public TheLoai() {
		super();
		this.maTheLoai = "";
		this.tenTheLoai = "";
	}
	public String checked(String s) {
		return "";
	}
	public String name(String s) {
		return "";
	}
	

	public String getMaTheLoai() {
		return maTheLoai;
	}

	public void setMaTheLoai(String maTheLoai) {
		this.maTheLoai = maTheLoai;
	}

	public String getTenTheLoai() {
		return tenTheLoai;
	}

	public void setTenTheLoai(String tenTheLoai) {
		this.tenTheLoai = tenTheLoai;
	}

	@Override
	public String toString() {
		return "TheLoai [maTheLoai=" + maTheLoai + ", tenTheLoai=" + tenTheLoai + "]";
	}

}
