# beforewecode_flutter_mvvm

In this tutorial, we will implement a Flutter app using MVVM. In the end, you will be able to create a project with a SOLID, clean, and maintainable structure.


Bellow you can interact with another flutter web export which is also built using the MVVM pattern explained in this tutorial. If you want to login to the first sample use 123 as the username and easyasabc as the password.
https://aftercode.s3.us-east-2.amazonaws.com/#/

I prefer to use MVVM as a company pattern. One advantage of using MVVM is that it gives you a design pattern that you can apply to native iOS and Native Android projects as well. In my opinion, using many platforms or framework related software patterns results in island solutions and does not structure the software any better. Using MVVM enables your company, for example, to get iOS devs to start operating with Flutter or Native Android Apps with a much lower learning curve. The same applies to Android devs shifting to iOS.
It also structures all platforms, in the same way, maintaining good code quality.

Single Responsibility

One important rule to keep in mind, whenever we are going to refactor is to indicate the responsibility of the Class. It makes sense to Wrap every third-party framework, for example, for persistent, analytic tools, and similar.

Open-closed Principle
Open for extension and closed for modifications.
Any interface is closed for modifications, and you are able to provide new implementations to extend the functionality of your software. The Interface or Abstract Class is a description of a Class. We will make heavy use of it. It enables you to Inject other Classes by implementing the needed interface, without making changes in any other class.

Liskov substitution principle
In 1988 Barbara Liskov presented on her keynote Data abstraction, an extension of the Open-closed Principle. In general, it's about using interfaces instead of superclasses. The principle enables you to replace objects of a parent class with objects of a subclass without breaking the application.
You can ensure this by testing your application injecting objects of all subclasses to make sure that none of them breaks your App.

Interface segregation principle
Be aware that we can implement several Interfaces. Try to apply the rule if one class does not use and needs a method of the interface to create a second Interface with that method and remove the method from the other interface. Many client-specific interfaces are better than one general-purpose interface.

Dependency inversion principle
Your classes should only refer to source modules containing abstract classes or interfaces.
Try to avoid to import any concrete class, you have created. The most flexible apps are those that mostly depend on abstractions.
You can easily control this principle by looking at the imports of the class and you should start refactoring it if it does implement concrete classes.

You will find a more indeepth explanation on:
https://www.beforewecode.com/readarticle/149
