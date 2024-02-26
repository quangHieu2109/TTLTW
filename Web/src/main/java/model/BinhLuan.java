package model;

import java.sql.Date;
import java.util.Calendar;
import java.util.Random;

public class BinhLuan {
	private String maBinhLuan;
	private NguoiDung nguoiDung;
	private Date ngayBinhLuan;
	private String noiDung;
	private BaiBao baiBao;;


	public BinhLuan(String maBinhLuan, NguoiDung nguoiDung, Date ngayBinhLuan, String noiDung, BaiBao baiBao) {
		super();
		this.maBinhLuan = maBinhLuan;
		this.nguoiDung = nguoiDung;
		this.ngayBinhLuan = ngayBinhLuan;
		this.noiDung = noiDung;
		this.baiBao = baiBao;
	}

	public BinhLuan(NguoiDung nguoiDung, String noiDung, BaiBao baiBao) {
		super();
		Random rd = new Random();
		int c = 65 + rd.nextInt(25);
		String maBL = (char) c + "" + System.currentTimeMillis();
		this.maBinhLuan = maBL;
		this.ngayBinhLuan = new Date(Calendar.getInstance().getTimeInMillis());
		;
		this.nguoiDung = nguoiDung;
		this.noiDung = noiDung;
		this.baiBao = baiBao;
	}

	
	public String getMaBinhLuan() {
		return maBinhLuan;
	}

	public void setMaBinhLuan(String maBinhLuan) {
		this.maBinhLuan = maBinhLuan;
	}

	public NguoiDung getNguoiDung() {
		return nguoiDung;
	}

	public void setNguoiDung(NguoiDung nguoiDung) {
		this.nguoiDung = nguoiDung;
	}

	public Date getNgayBinhLuan() {
		return ngayBinhLuan;
	}

	public void setNgayBinhLuan(Date ngayBinhLuan) {
		this.ngayBinhLuan = ngayBinhLuan;
	}

	public String getNoiDung() {
		return noiDung;
	}

	public void setNoiDung(String noiDung) {
		this.noiDung = noiDung;
	}

	public BaiBao getBaiBao() {
		return baiBao;
	}

	public void setBaiBao(BaiBao baiBao) {
		this.baiBao = baiBao;
	}

	@Override
	public String toString() {
		return "BinhLuan [maBinhLuan=" + maBinhLuan + ", nguoiDung=" + nguoiDung + ", ngayBinhLuan=" + ngayBinhLuan
				+ ", noiDung=" + noiDung + "]";
	}

}
