package com.ddd.tmall.util;

import javax.imageio.ImageIO;
import java.awt.*;
import java.awt.image.*;
import java.io.File;
import java.io.IOException;

public class ImageUtil {
    //确保文件的格式是jpg，仅仅通过ImageIO不足以保证jpg文件正常显示
    //所以，这里要转换代码，使得jpg图片可以正常显示
    public static BufferedImage change2jpg(File file){
        try {
            Image image = Toolkit.getDefaultToolkit().createImage(file.getAbsolutePath());

            PixelGrabber pg = new PixelGrabber(image,0,0,-1,-1,true);

            pg.grabPixels();

            int width = pg.getWidth();
            int height = pg.getHeight();

            final int[] RGB_MASKS = {0xFF0000,0xFF00,0xFF};

            //32位图色彩
            final ColorModel RGB_OPAQUE = new DirectColorModel(32,RGB_MASKS[0],RGB_MASKS[1],RGB_MASKS[2]);

            DataBuffer buffer = new DataBufferInt((int[])pg.getPixels(),pg.getWidth()*pg.getHeight());

            WritableRaster raster = Raster.createPackedRaster(buffer,width,height,width,RGB_MASKS,null);

            BufferedImage img = new BufferedImage(RGB_OPAQUE,raster,false,null);

            return img;

        }catch (InterruptedException e){
            e.printStackTrace();
            return  null;
        }
    }

    //将绘制好的新的Image流写入目标文件中
    public static void resizeImage(File srcFile,int width,int height,File desFile)
        throws IOException{
        if(!desFile.getParentFile().exists())
            desFile.getParentFile().mkdirs();
        Image image = ImageIO.read(srcFile);
        image = resizeImage(image,width,height);
        ImageIO.write((RenderedImage)image,"jpg",desFile);
    }


    //重新根据宽高来绘制一个新的Image流
    public static Image resizeImage(Image srcImage,int width,int height){
        BufferedImage bufferedImage = null;
        bufferedImage = new BufferedImage(width,height,bufferedImage.TYPE_INT_RGB);
        bufferedImage.getGraphics().drawImage(srcImage.getScaledInstance(width,height,Image.SCALE_SMOOTH),0,0,null);
        return bufferedImage;
    }


}
