package com.bookshopweb.dao;

import com.bookshopweb.beans.Voucher;
import com.bookshopweb.jdbiInterface.VoucherJDBI;
import com.bookshopweb.utils.JDBIUltis;

import java.util.List;

public class VoucherDAO extends AbsDAO<Voucher> {
    VoucherJDBI voucherJDBI = JDBIUltis.getJDBI().onDemand(VoucherJDBI.class);
    @Override
    public Voucher selectPrevalue(Long id) {
        return voucherJDBI.getById(id);
    }
    public Voucher getByVoucherCode(String code) {
        return voucherJDBI.getByVoucherCode(code);
    }
    public List<Voucher> getAll(){
        return voucherJDBI.getAll();
    }
    @Override
    public int insert(Voucher voucher, String ip) {

        super.insert(voucher, ip);
        return voucherJDBI.addVoucher(voucher);
    }

    @Override
    public int delete(Voucher voucher, String ip) {
        super.delete(voucher, ip);
        return voucherJDBI.removeVoucher(voucher.getId());
    }

}
