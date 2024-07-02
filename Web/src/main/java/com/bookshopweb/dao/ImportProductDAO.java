package com.bookshopweb.dao;

import com.bookshopweb.beans.ImportProduct;
import com.bookshopweb.beans.Product;
import com.bookshopweb.jdbiInterface.ImportProductJDBI;
import com.bookshopweb.utils.JDBIUltis;

import java.util.List;
import java.util.Random;

public class ImportProductDAO extends  AbsDAO<ImportProduct>{
    private ImportProductJDBI importProductJDBI = JDBIUltis.getJDBI().onDemand(ImportProductJDBI.class);
    @Override
    public ImportProduct selectPrevalue(Long id) {
        return importProductJDBI.getById(id);
    }

    @Override
    public int insert(ImportProduct product, String ip) {
         super.insert(product, ip);
         return importProductJDBI.addProductImport(product);
    }

    public static void main(String[] args) {
        ProductDAO productDAO = new ProductDAO();
        ImportProductDAO importProductDAO = new ImportProductDAO();
        List<Product> productList = productDAO.getAll();
        Random rs = new Random();
        for(Product product:productList){

            ImportProduct importProduct = new ImportProduct(product.getId(), product.getId(), 1, product.getCreatedAt(), rs.nextInt(10)*50, 0.8*product.getPrice());
            System.out.println(product);
//            importProductDAO.insert(importProduct, "");
        }
    }
}
