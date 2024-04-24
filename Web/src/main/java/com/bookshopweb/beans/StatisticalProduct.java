package com.bookshopweb.beans;

public class StatisticalProduct {
    private long idProduct;
    private String nameProduct;
//    private Timestamp begin;
//    private Timestamp end;
    private int importQuatity;
    private int sellQuantity;
    private double totalImportPrice;
    private double totalSellPrice;
    private int quantityRemaining;
    private double saleRate;
    private int quantityRefund;

    public StatisticalProduct(long idProduct, String nameProduct, int importQuatity, int sellQuantity, double totalImportPrice, double totalSellPrice) {
        this.idProduct = idProduct;
        this.nameProduct = nameProduct;
        this.importQuatity = importQuatity;
        this.sellQuantity = sellQuantity;
        this.totalImportPrice = totalImportPrice;
        this.totalSellPrice = totalSellPrice;

    }

    public StatisticalProduct(long idProduct, String nameProduct, int sellQuantity, double totalSellPrice) {
        this.idProduct = idProduct;
        this.nameProduct = nameProduct;
        this.sellQuantity = sellQuantity;
        this.totalSellPrice = totalSellPrice;
    }

    public StatisticalProduct(long idProduct, String nameProduct, int quantityRemaining, int sellQuantity) {
        this.idProduct = idProduct;
        this.nameProduct = nameProduct;
        this.quantityRemaining = quantityRemaining;
        this.sellQuantity = sellQuantity;
    }

    public StatisticalProduct(long idProduct, String nameProduct, int importQuatity, int sellQuantity, int quantityRemaining, double saleRate) {
        this.idProduct = idProduct;
        this.nameProduct = nameProduct;
        this.importQuatity = importQuatity;
        this.sellQuantity = sellQuantity;
        this.quantityRemaining = quantityRemaining;
        this.saleRate = saleRate;
    }

    public long getIdProduct() {
        return idProduct;
    }

    public void setIdProduct(long idProduct) {
        this.idProduct = idProduct;
    }

    public String getNameProduct() {
        return nameProduct;
    }

    public void setNameProduct(String nameProduct) {
        this.nameProduct = nameProduct;
    }

    public int getImportQuatity() {
        return importQuatity;
    }

    public void setImportQuatity(int importQuatity) {
        this.importQuatity = importQuatity;
    }

    public int getSellQuantity() {
        return sellQuantity;
    }

    public void setSellQuantity(int sellQuantity) {
        this.sellQuantity = sellQuantity;
    }

    public double getTotalImportPrice() {
        return totalImportPrice;
    }

    public void setTotalImportPrice(double totalImportPrice) {
        this.totalImportPrice = totalImportPrice;
    }

    public double getTotalSellPrice() {
        return totalSellPrice;
    }

    public void setTotalSellPrice(double totalSellPrice) {
        this.totalSellPrice = totalSellPrice;
    }

    public int getQuantityRemaining() {
        return quantityRemaining;
    }

    public void setQuantityRemaining(int quantityRemaining) {
        this.quantityRemaining = quantityRemaining;
    }

    public double getSaleRate() {
        return saleRate;
    }

    public void setSaleRate(double saleRate) {
        this.saleRate = saleRate;
    }

    public int getQuantityRefund() {
        return quantityRefund;
    }

    public void setQuantityRefund(int quantityRefund) {
        this.quantityRefund = quantityRefund;
    }

    @Override
    public String toString() {
        return "StatisticalProduct{" +
                "idProduct=" + idProduct +
                ", nameProduct='" + nameProduct + '\'' +
                ", importQuatity=" + importQuatity +
                ", sellQuantity=" + sellQuantity +
                ", totalImportPrice=" + totalImportPrice +
                ", totalSellPrice=" + totalSellPrice +
                ", quantityRemaining=" + quantityRemaining +
                ", saleRate=" + saleRate +
                ", quantityRefund=" + quantityRefund +
                '}';
    }
}
