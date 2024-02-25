package model;

import java.sql.Timestamp;
import java.util.Calendar;
import java.util.Random;

public class DangKyDangBai {
	private String maDK;
	private NguoiDung nguoiDung;
	private Timestamp ngayDK;

	public DangKyDangBai(String maDK, NguoiDung nguoiDung, Timestamp ngayDK) {
		super();
		this.maDK = maDK;
		this.nguoiDung = nguoiDung;
		this.ngayDK = ngayDK;
	}

	public DangKyDangBai(NguoiDung nguoiDung) {
		super();
		Random rd = new Random();
		int c = 65 + rd.nextInt(25);
		String maDK = (char) c + "" + System.currentTimeMillis();
		this.maDK = maDK;
		this.nguoiDung = nguoiDung;
		this.ngayDK = new Timestamp(Calendar.getInstance().getTimeInMillis());
	}

	public String getMaDK() {
		return maDK;
	}

	public void setMaDK(String maDK) {
		this.maDK = maDK;
	}

	public NguoiDung getNguoiDung() {
		return nguoiDung;
	}

	public void setNguoiDung(NguoiDung nguoiDung) {
		this.nguoiDung = nguoiDung;
	}

	public Timestamp getNgayDK() {
		return ngayDK;
	}

	public void setNgayDK(Timestamp ngayDK) {
		this.ngayDK = ngayDK;
	}

	@Override
	public String toString() {
		return "DangKyDangBai [maDK=" + maDK + ", nguoiDung=" + nguoiDung + ", ngayDK=" + ngayDK + "]";
	}

}
