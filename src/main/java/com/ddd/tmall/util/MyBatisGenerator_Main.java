package com.ddd.tmall.util;

import org.mybatis.generator.api.MyBatisGenerator;
import org.mybatis.generator.config.Configuration;
import org.mybatis.generator.config.xml.ConfigurationParser;
import org.mybatis.generator.internal.DefaultShellCallback;

import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;

public class MyBatisGenerator_Main {
    public static void main(String[] args) throws Exception{
        List<String> warnings = new ArrayList<>();
        boolean overWrite = true;

        //在classes目录下，拿到resource导入的资源包内的generatorConfig.xml
        InputStream inputStream = MyBatisGenerator_Main.class.getClassLoader().getResource("generatorConfig.xml").openStream();

        //构造一个遍历xml的容器
        ConfigurationParser configurationParser = new ConfigurationParser(warnings);

        //利用类去遍历xml内的全部配置文件
        Configuration configuration = configurationParser.parseConfiguration(inputStream);

        inputStream.close();

        DefaultShellCallback callback = new DefaultShellCallback(overWrite);

        MyBatisGenerator myBatisGenerator = new MyBatisGenerator(configuration,callback,warnings);

        myBatisGenerator.generate(null);

        System.out.println("生成代码成功，只执行一次");
    }
}
