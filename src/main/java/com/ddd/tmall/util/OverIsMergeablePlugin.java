package com.ddd.tmall.util;

import org.mybatis.generator.api.GeneratedXmlFile;
import org.mybatis.generator.api.IntrospectedTable;
import org.mybatis.generator.api.PluginAdapter;

import java.lang.reflect.Field;
import java.util.List;

public class OverIsMergeablePlugin extends PluginAdapter {
    @Override
    public boolean validate(List<String> list) {
        return true;
    }

    @Override
    public boolean sqlMapGenerated(GeneratedXmlFile sqlMap, IntrospectedTable introspectedTable) {
        try {
            //获取类的属性成员：isMergeable
            Field field = sqlMap.getClass().getDeclaredField("isMergeable");
            field.setAccessible(true);

            //将该boolean值设置成false，就不会重复生成xml了
            field.setBoolean(sqlMap,false);
        }catch (Exception e){
            e.printStackTrace();
        }
        return true;
    }
}
