package com.bookshopweb.jdbiInterface;

import com.bookshopweb.beans.Voucher;
import org.jdbi.v3.sqlobject.config.RegisterBeanMapper;
import org.jdbi.v3.sqlobject.customizer.Bind;
import org.jdbi.v3.sqlobject.customizer.BindBean;
import org.jdbi.v3.sqlobject.statement.SqlQuery;
import org.jdbi.v3.sqlobject.statement.SqlUpdate;

import java.util.List;

@RegisterBeanMapper(Voucher.class)
public interface VoucherJDBI {
    @SqlQuery("select * from voucher")
    List<Voucher> getAll();

    @SqlQuery("select * from voucher where id=:id")
    Voucher getById(@Bind("id") long id);

    @SqlQuery("select * from voucher where voucher_code=:voucherCode")
    Voucher getByVoucherCode(@Bind("voucherCode") String voucherCode);

    @SqlUpdate("insert into voucher(id, voucher_code, voucher_name, description, percent_decrease, max_decrease, min_price, type, createAt, startAt, endAt, voucher_image) " +
            "values(:id, :voucherCode, :voucherName, :description, :percentDecrease, :maxRecrease, :minPrice, :type, :createAt, :startAt, :endAt, :image )")
    int addVoucher(@BindBean Voucher voucher);

    @SqlUpdate("delete from voucher where id=:id")
    int removeVoucher(@Bind("id") long id);

}
