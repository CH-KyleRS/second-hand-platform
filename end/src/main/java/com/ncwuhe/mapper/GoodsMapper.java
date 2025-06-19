package com.ncwuhe.mapper;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.ncwuhe.entity.Goods;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;

public interface GoodsMapper extends BaseMapper<Goods> {

    IPage<Goods> findPage(Page<Goods> page,  @Param("name") String name);
/*    方法参数 name 与 SQL 语句中的参数名 "name" 相关联，使得 MyBatis 可以正确地将方法参数的值传递给 SQL 语句，并进行查询操作。*/
    @Select("select * from goods where category_id = #{id}")
    IPage<Goods> pageByCategory(Page<Goods> page, @Param("id") Long id);

    List<Goods> getRecommend();

    @Select("select * from goods order by sales desc limit 5")/*该查询语句会从 goods 表中获取销售量前五高的商品数据，并按照销售量从高到低的顺序进行排序。*/
    List<Goods> sales();

    List<Goods> findAll();

}
