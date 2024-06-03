package com.bookshopweb.beans;

import java.sql.Timestamp;
import java.util.Calendar;
import java.util.List;

public class Voucher extends AbsModel<Voucher> {
    private long id;
    private String voucherCode;
    private String voucherName;
    private String description;
    private double percentDecrease;
    private double maxRecrease;
    private double minPrice;
    private int type;
    private Timestamp startAt;
    private Timestamp endAt;
    private Timestamp createAt;
    private String image;

    public Voucher(long id, String voucherCode, String voucherName, String description, double percentDecrease, double maxRecrease, double minPrice, int type, Timestamp startAt, Timestamp endAt, String image) {
        this.id = id;
        this.voucherCode = voucherCode;
        this.voucherName = voucherName;
        this.description = description;
        this.percentDecrease = percentDecrease;
        this.maxRecrease = maxRecrease;
        this.minPrice = minPrice;
        this.type = type;
        this.startAt = startAt;
        this.endAt = endAt;
        this.image = image;
        this.createAt = new Timestamp(Calendar.getInstance().getTimeInMillis());
    }

    public void setCreateAt(Timestamp createAt) {
        this.createAt = createAt;
    }

    public double getMinPrice() {
        return minPrice;
    }

    public void setMinPrice(double minPrice) {
        this.minPrice = minPrice;
    }

    public Voucher() {
    }

    @Override
    public String getResource() {
        return "Voucher";
    }

    @Override
    public Timestamp getCreateAt() {
        return createAt;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getVoucherCode() {
        return voucherCode;
    }

    public void setVoucherCode(String voucherCode) {
        this.voucherCode = voucherCode;
    }

    public String getVoucherName() {
        return voucherName;
    }

    public void setVoucherName(String voucherName) {
        this.voucherName = voucherName;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public double getPercentDecrease() {
        return percentDecrease;
    }

    public void setPercentDecrease(double percentDecrease) {
        this.percentDecrease = percentDecrease;
    }

    public double getMaxRecrease() {
        return maxRecrease;
    }

    public void setMaxRecrease(double maxRecrease) {
        this.maxRecrease = maxRecrease;
    }

    public int getType() {
        return type;
    }

    public void setType(int type) {
        this.type = type;
    }

    public Timestamp getStartAt() {
        return startAt;
    }

    public void setStartAt(Timestamp startAt) {
        this.startAt = startAt;
    }

    public Timestamp getEndAt() {
        return endAt;
    }

    public void setEndAt(Timestamp endAt) {
        this.endAt = endAt;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    @Override
    public String toString() {
        return "Voucher{" +
                "id=" + id +
                ", voucherCode='" + voucherCode + '\'' +
                ", voucherName='" + voucherName + '\'' +
                ", description='" + description + '\'' +
                ", percentDecrease=" + percentDecrease +
                ", maxRecrease=" + maxRecrease +
                ", type=" + type +
                ", startAt=" + startAt +
                ", endAt=" + endAt +
                ", image='" + image + '\'' +
                '}';
    }
}
