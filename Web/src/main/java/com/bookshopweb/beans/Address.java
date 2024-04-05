package com.bookshopweb.beans;

public class Address {
    private long id;
    private long userId;
    private Province province;
    private District district;
    private Ward ward;

    private String houseNumber;

    public Address(long id, long userId, Province province, District district, Ward ward, String houseNumber) {
        this.id = id;
        this.userId = userId;
        this.province = province;
        this.district = district;
        this.ward = ward;
        this.houseNumber = houseNumber;
    }

    public Address(long id, long userId, String houseNumber) {
        this.id = id;
        this.userId = userId;
        this.houseNumber = houseNumber;
    }
    public Address( long userId, String houseNumber) {
        this.userId = userId;
        this.houseNumber = houseNumber;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public long getUserId() {
        return userId;
    }

    public void setUserId(long userId) {
        this.userId = userId;
    }

    public Province getProvince() {
        return province;
    }

    public void setProvince(Province province) {
        this.province = province;
    }

    public District getDistrict() {
        return district;
    }

    public void setDistrict(District district) {
        this.district = district;
    }

    public Ward getWard() {
        return ward;
    }

    public void setWard(Ward ward) {
        this.ward = ward;
    }

    public String getHouseNumber() {
        return houseNumber;
    }

    public void setHouseNumber(String houseNumber) {
        this.houseNumber = houseNumber;
    }
}
