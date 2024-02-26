package model;

import java.sql.Date;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Random;

public class BaiBao {
	private String maBaiBao;
	private String tieuDe;
	private String moTa;
	private String filePath;
	private String noiDung;
	private Timestamp ngayDang;
	private NguoiDung nguoiDang;
	private int luotXem;
	private DSTheLoai theLoai;
	private ArrayList<BinhLuan> dsBinhLuan = new ArrayList<BinhLuan>();

	public BaiBao(String maBaiBao, String tieuDe, String moTa, String filePath, String noiDung, Timestamp ngayDang,
			NguoiDung nguoiDang, int luotXem, DSTheLoai theLoai, ArrayList<BinhLuan> dsBinhLuan) {
		super();
		this.maBaiBao = maBaiBao;
		this.tieuDe = tieuDe;
		this.moTa = moTa;
		this.filePath = filePath;
		this.noiDung = noiDung;
		this.ngayDang = ngayDang;
		this.nguoiDang = nguoiDang;
		this.luotXem = luotXem;
		this.theLoai = theLoai;
		this.dsBinhLuan = dsBinhLuan;
	}

	public BaiBao() {
		super();
	}

	public BaiBao(String maBaiBao, String tieuDe, String moTa, String filePath, String noiDung, Timestamp ngayDang,
			NguoiDung nguoiDang, int luotXem) {
		super();
		this.maBaiBao = maBaiBao;
		this.tieuDe = tieuDe;
		this.moTa = moTa;
		this.filePath = filePath;
		this.noiDung = noiDung;
		this.ngayDang = ngayDang;
		this.nguoiDang = nguoiDang;
		this.luotXem = luotXem;
	}

	public BaiBao(String tieuDe, String moTa, String filePath, String noiDung, NguoiDung nguoiDang, DSTheLoai theLoai) {
		super();
		Random rd = new Random();
		int c = 65 + rd.nextInt(25);
		String maBB = (char) c + "" + System.currentTimeMillis();
		this.maBaiBao = maBB;
		this.ngayDang = new Timestamp(Calendar.getInstance().getTimeInMillis());
		this.tieuDe = tieuDe;
		this.moTa = moTa;
		this.filePath = filePath;
		this.noiDung = noiDung;
		this.nguoiDang = nguoiDang;
		this.theLoai = theLoai;
		this.luotXem = 0;
	}

	public String getMaBaiBao() {
		return maBaiBao;
	}

	public void setMaBaiBao(String maBaiBao) {
		this.maBaiBao = maBaiBao;
	}

	public String getTieuDe() {
		return tieuDe;
	}

	public void setTieuDe(String tieuDe) {
		this.tieuDe = tieuDe;
	}

	public String getMoTa() {
		return moTa;
	}

	public void setMoTa(String moTa) {
		this.moTa = moTa;
	}

	public String getFilePath() {
		return filePath;
	}

	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}

	public String getNoiDung() {
		return noiDung;
	}

	public void setNoiDung(String noiDung) {
		this.noiDung = noiDung;
	}

	public Timestamp getNgayDang() {
		return ngayDang;
	}

	public void setNgayDang(Timestamp ngayDang) {
		this.ngayDang = ngayDang;
	}

	public NguoiDung getNguoiDang() {
		return nguoiDang;
	}

	public void setNguoiDang(NguoiDung nguoiDang) {
		this.nguoiDang = nguoiDang;
	}

	public int getLuotXem() {
		return luotXem;
	}

	public void setLuotXem(int luotXem) {
		this.luotXem = luotXem;
	}

	public DSTheLoai getTheLoai() {
		return theLoai;
	}

	public void setTheLoai(DSTheLoai theLoai) {
		this.theLoai = theLoai;
	}

	public ArrayList<BinhLuan> getDsBinhLuan() {
		return dsBinhLuan;
	}

	public void setDsBinhLuan(ArrayList<BinhLuan> dsBinhLuan) {
		this.dsBinhLuan = dsBinhLuan;
	}

	public void addBinhLuan(BinhLuan bl) {
		this.dsBinhLuan.add(bl);
	}

	public void addAllBinhLuan(ArrayList<BinhLuan> dsbl) {
		this.dsBinhLuan.addAll(dsbl);
	}

	@Override
	public String toString() {
		return "BaiBao [maBaiBao=" + maBaiBao + ", tieuDe=" + tieuDe + ", moTa=" + moTa + ", filePath=" + filePath
				+ ", noiDung=" + noiDung + ", ngayDang=" + ngayDang + ", nguoiDang=" + nguoiDang + ", luotXem="
				+ luotXem + ", theLoai=" + theLoai + ", dsBinhLuan=" + dsBinhLuan + "]";
	}
	
}
