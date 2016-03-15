# TextView-keyboardDemo
引用来源：http://www.hangge.com/blog/cache/detail_911.html


键盘出现后自动改变页面布局，防止下方元素被键盘遮挡；
拟用textView实现类QQ输入框多行输入效果，暂时未实现

方法：
自定义UIView作为toolbar，监听keyboard事件，动态改变UIView的bottomConstraint约束
