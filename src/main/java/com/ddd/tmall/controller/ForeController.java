package com.ddd.tmall.controller;


import com.ddd.tmall.pojo.*;
import com.ddd.tmall.service.*;
import com.ddd.tmall.util.Comparator.*;
import org.apache.commons.lang.math.RandomUtils;
import org.aspectj.weaver.ast.Or;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.util.HtmlUtils;

import javax.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.List;
import java.util.logging.SimpleFormatter;


@Controller
@RequestMapping("")
public class ForeController {
    @Autowired
    UserService userService;

    @Autowired
    OrderService orderService;

    @Autowired
    OrderItemService orderItemService;

    @Autowired
    CategoryService categoryService;

    @Autowired
    ProductService productService;

    @Autowired
    ProductImageService productImageService;

    @Autowired
    PropertyValueService propertyValueService;

    @Autowired
    PropertyService propertyService;

    @Autowired
    ReviewService reviewService;
    private OrderItemService orderItemService1;

    @RequestMapping("forehome")
    public String home(Model model){
        List<Category> cs = categoryService.listCategroy();
        productService.fill(cs);
        productService.fillByRow(cs);
        model.addAttribute("cs",cs);
        return "fore/home";
    }


    @RequestMapping("foreregister")
    public String register(Model model,User user){
        //对字符转义，做保护处理
        //即对name进行重新赋值
        user.setName(HtmlUtils.htmlEscape(user.getName()));
        user.setPassword(HtmlUtils.htmlEscape(user.getPassword()));

        if(userService.isExitst(user.getName())){
            model.addAttribute("msg","该用户已经存在，不能再次注册");
            model.addAttribute("user",null);
            return "fore/register";
        }

        userService.add(user);

        return "redirect:registerSuccessPage";
    }

    //登录界面
    @RequestMapping("forelogin")
    public String login(Model model, User user, HttpSession session){
        User user_  = userService.getUser(user.getName(), user.getPassword());
        if(user_==null){
            model.addAttribute("msg","账户密码错误");
            model.addAttribute("user",null);
            return "fore/login";
        }
        session.setAttribute("user",user_);
        return "redirect:forehome";
    }

    //登出功能
    @RequestMapping("forelogout")
    public String logout(HttpSession session){
        session.removeAttribute("user");
        return "redirect:forehome";
    }

    @RequestMapping("foreproduct")
    public String product(int pid,Model model){
        Product product = productService.getProduct(pid);

        List<ProductImage> productSingleImages = productImageService.list(pid,productImageService.type_single);
        List<ProductImage> productDetailImages = productImageService.list(pid,productImageService.type_single);

        //要使用的图片进行初始化
        product.setProductSingleImages(productSingleImages);
        product.setProductDetailImages(productDetailImages);

        //得到全部的属性值
        List<PropertyValue> pvs = propertyValueService.list(pid);

        //评价列表
        List<Review> rs = reviewService.list(pid);

        productService.setSaleAndReviewNumber(product);

        model.addAttribute("reviews",rs);
        model.addAttribute("p",product);
        model.addAttribute("pvs",pvs);

        return "fore/product";
    }

    @ResponseBody
    @RequestMapping("forecheckLogin")
    public String checkLogin(HttpSession session){
         User user = (User)session.getAttribute("user");
         if(user!=null)
             return "success";
         return "fail";
    }

    //model.jsp内的ajax登录请求
    @ResponseBody
    @RequestMapping("foreloginAjax")
    public String loginAjax(@RequestParam("name")String name,@RequestParam("password")String password,HttpSession session){
        User user = userService.getUser(name,password);
        if(user!=null){
            session.setAttribute("user",user);
            return "success";
        }
        return "fail";
    }

    @RequestMapping("forecategory")
    public String categroy(int cid,String sort,Model model){
        Category c = categoryService.getCategory(cid);
        productService.fill(c);
        productService.setSaleAndReviewNumber(c.getProducts());

        if(sort!=null){
            switch (sort){
                case "review":
                    Collections.sort(c.getProducts(),new ProductReviewComparator());
                    break;
                case "date":
                    Collections.sort(c.getProducts(),new ProductDateComparator());
                    break;
                case "saleCount":
                    Collections.sort(c.getProducts(),new ProductSaleCountComparator());
                    break;
                case "price":
                    Collections.sort(c.getProducts(),new ProductPriceComparator());
                    break;
                case "all":
                    Collections.sort(c.getProducts(),new ProductAllComparator());
                    break;
            }
        }
        model.addAttribute("c",c);
        return "fore/category";
    }

    @RequestMapping("foresearch")
    public String search(Model model,String keyword){
        List<Product> ps = productService.search(keyword);

        //设置评价数量和销售的数量
        productService.setSaleAndReviewNumber(ps);

        model.addAttribute("ps",ps);

        return "fore/searchResult";
     }

    @RequestMapping("forebuyone")
    public String buyone(int pid,int num,HttpSession session){
        //立即购买，num 为传入的够买的数值
        Product product = productService.getProduct(pid);
        User user = (User)session.getAttribute("user");

        //若在数据库找不到时候，初始化的值
        int oiid = 0;
        boolean find=false;


        //如果在数据库内找到现存的订单项的项目的话，就利用现存的订单项的oid
        //不然，就新增一条OrderItem的项目
        for (OrderItem o:orderItemService.listByUser(user.getId())) {
            if(o.getProduct().getId().intValue()==product.getId()){
                //找到现存的OrderItem的表
                find = true;

                //更新表
                o.setNumber(o.getNumber()+1);
                orderItemService.update(o);

                //结束循环
                oiid = o.getId();
                break;
            }
        }

        //没有找到就新增一条记录
        if(!find){
            OrderItem oi = new OrderItem();
            oi.setNumber(num);
            oi.setPid(pid);
            oi.setUid(user.getId());

            orderItemService.add(oi);


            //插入数据后，原数据也会更着设置ID的值
            oiid = oi.getId();
        }
        return "redirect: forebuy?oiid="+oiid;
    }

    @RequestMapping("forebuy")
    public String forebuy(HttpSession session,Model model,String[] oiid){
        List<OrderItem> ois = new ArrayList<>();
        float total = 0;

        //如果是立即购买的话，就是只生成一个订单项，所以只有一个oid
        for (String strid:oiid) {
            try{
                OrderItem orderItem = orderItemService.get(Integer.parseInt(strid));

                //累计总价
                total += orderItem.getProduct().getPromotePrice();

                ois.add(orderItem);

            }catch (NumberFormatException e){
                //发生转化异常，重新进入循环
                continue;
            }catch (NullPointerException e){
                continue;
            }
        }

        session.setAttribute("ois",ois);
        model.addAttribute("total",total);

        //buy页面中不可修改ois的内容，只是用Input在获取相关的表单参数
        //所以session里的ois可以在支付里直接使用
        return "fore/buy";
    }

    @ResponseBody
    @RequestMapping("foreaddCart")
    public String addCart(int pid,int num,Model model,HttpSession session){

        //与买一个的过程一样
        //只是
        //固有缺陷，就是一旦点击增加购物车，就会更新数据库
        //若要撤销加入购物车的选项，也需要调整数据库的数据

        Product product = productService.getProduct(pid);
        User user = (User)session.getAttribute("user");
        boolean found = false;

        List<OrderItem> orderItemList = orderItemService.listByUser(user.getId());
        for (OrderItem orderItem:orderItemList) {
            if(orderItem.getPid()==pid){
                //如果在数据库内找到相应的订单项
                //则说明找到一个符合条件的pid
                //就使用这个product作为参数，更新数据库

                //更新数据库
                orderItem.setNumber(orderItem.getNumber()+1);
                found=true;
                break;
            }
        }

        if(!found){
            OrderItem orderItem = new OrderItem();
            orderItem.setUid(user.getId());
            orderItem.setNumber(num);
            orderItem.setPid(pid);
            orderItemService.add(orderItem);
        }



        //返还给AJAX的字符串
        return "success";
    }

    @RequestMapping("forecart")
    public String cart(Model model,HttpSession session){
        User user = (User) session.getAttribute("user");
        List<OrderItem> orderItemList = orderItemService.listByUser(user.getId());
        model.addAttribute("ois",orderItemList);
        return "fore/cart";
    }


    @ResponseBody
    @RequestMapping("forechangeOrderItem")
    public String change(Model model,int pid,int num,HttpSession session){
        User user = (User)session.getAttribute("user");
        if(user!=null)
            return "fail";

        //修改相应订单项的数量的，增加或者减少
        //同时更新数据库
        List<OrderItem> orderItemList = orderItemService.listByUser(user.getId());
        for (OrderItem orderItem:orderItemList){
            if(orderItem.getPid()==pid){
                orderItem.setNumber(num);
                orderItemService.update(orderItem);
                break;
            }
        }
        return "success";
    }


    @RequestMapping("foredeleteOrderItem")
    @ResponseBody
    public String deleteFromItem(Model model,int oiid,HttpSession session){
        //使用参数直接传递参数，假如缺少参数，相关的方法不会执行

        User user = (User) session.getAttribute("user");

        if(user==null){
            return "fail";
        }

        orderItemService.delete(oiid);
        System.out.println("执行了");

        return "success";
    }

    //生成订单的控制器
    @RequestMapping("forecreateOrder")
    public String createOrder(Model model,Order order,HttpSession session){
        User user = (User) session.getAttribute("user");

        //生成一个订单码，由时间戳和一个随机数组成
        String orderCode = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date()) + RandomUtils.nextInt(10000);

        //将订单码放入orderCode
        order.setOrderCode(orderCode);

        //将生成的时间放入Date
        order.setCreateDate(new Date());

        order.setUid(user.getId());

        //设置当下订单的状态
        order.setOrderStatus(OrderService.waitPay);

        //将购物车中的订单，即存储在Session中的订单，轮询并检验
        List<OrderItem> orderItemList =(List<OrderItem>)session.getAttribute("ois");

        float total = orderService.add(order,orderItemList);

        //重定向至支付页面
        return "redirect:forealipay?oid="+order.getId()+"&total="+total;
    }


    @RequestMapping("forepayed")
    public String payed(Model model,int oid,float total){
        Order order = orderService.get(oid);

        //更改状态
        order.setOrderStatus(OrderService.waitConfirm);

        //创建支付时间
        order.setPayDate(new Date());

        orderService.update(order);

        model.addAttribute("o",order);

        return "fore/payed";
    }

    //管理订单
    @RequestMapping("forebought")
    public String bought(Model model,HttpSession session){
        User user = (User) session.getAttribute("user");

        //排除已经删除的订单，用一个标记来标识
        List<Order> orderList =  orderService.list(user.getId(),OrderService.delete);

        for (Order order:orderList) {
            for (OrderItem o :order.getOrderItemList()) {
                System.out.println("xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"+o.getId());
            }
        }
        model.addAttribute("os",orderList);

        return "fore/bought";
    }

    @RequestMapping("foreconfirmPay")
    public String confirmPay(Model model,int oid){
        Order order = orderService.get(oid);
        model.addAttribute("o",order);

        //确认收货后，还需要进行确认付款的业务认证
        return "fore/confirmPay";
    }

    @RequestMapping("foreorderConfirmed")
    public String orderConfirmed(Model model,int oid){
        //点击确认付款后
        //就说明已经确定收货了
        Order order = orderService.get(oid);

        //已完成交易，更改状态
        order.setOrderStatus(OrderService.waitReview);

        order.setConfirmDate(new Date());

        //更新数据库
        orderService.update(order);

        return "fore/orderConfirmed";
    }

    @ResponseBody
    @RequestMapping("foredeleteOrder")
    public String deleteOrder(Model model,int oid){

        Order order = orderService.get(oid);

        //将订单的状态改成删除，并更新数据库
        order.setOrderStatus(OrderService.delete);

        orderService.update(order);

        return "success";
    }

    //进入评价的展示页面
    @RequestMapping("forereview")
    public String review(Model model,int oid){
        Order order = orderService.get(oid);

        //默认选取第一项产品进行评价
        Product product = order.getOrderItemList().get(0).getProduct();

        //得到评价表
        List<Review> reviews = reviewService.list(product.getId());

        productService.setSaleAndReviewNumber(product);

        model.addAttribute("p",product);
        model.addAttribute("o",order);
        model.addAttribute("reviews",reviews);

        return "fore/review";
    }

    @RequestMapping("foredoreview")
    public String doreview(
            Model model,HttpSession session,
            @RequestParam("oid")int oid,@RequestParam("pid")int pid,String content){
        User user = (User)session.getAttribute("user");
        Order order = orderService.get(oid);



//        对内容进行解码过滤，防止xss
        content = HtmlUtils.htmlEscape(content);

        Review review = new Review();
        //设置内容
        review.setContent(content);
        review.setPid(pid);
        review.setUid(user.getId());
        review.setCreateDate(new Date());

        reviewService.add(review);

        //评价完即订单的状态变为结束
        order.setOrderStatus(OrderService.finish);
        //并更新数据库
        orderService.update(order);

        //showonly用于控制输入框的显示
        return "redirect:forereview?oid="+oid+"&showonly=true";
    }

}