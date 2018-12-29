## SUPER ULTIMATELY COMPREHENSIVE USER GUIDE

* To generate a schedule enter starting date and time, frequency and the number of scheduled events
* Starting date and time is set by default to current time. Select different date and time if you want to generate a schedule that is not starting from now
* Select one of available frequency options (Daily, Weekly, Monthly, Bi-montly, Quarterly, Yearly). The default value is Daily
* Enter a number of schedule items you want to generate. For example, if you want to generate a schedule for the next 6 months on a monthly basis, enter 6. The default value is 14
* After clicking `generate` you will see your schedule below the form


## Reasoning and decisions

* I decided to use Rails framework to show that I was actually familiar with Rails infrastructure, conventions etc
* Didn't want to spend much time on UI however kind of minimal UI can make things more friendly and intuitive
* Decided not to use any database because the task didn't require it at all. However used `ActiveModel::Model` to make `Schedule` class work more like a real model i.e. use validations and so on
* Had to use custom setter methods in `Schedule` model to make it more foolproof
* Didn't use CRUD actions because it didn't actually match the case. So ended up with two basic routes to one single action. You send GET to hit the form and you send POST to submit it
* Could wrap the logic of `ensure_items_count_is_integer` method into `before_action` but decided to go with a method because I try to avoid callbacks if there's no really good reason (authenticating, authorization etc)
* Decided to go with view helpers instead of Presenters because the project is so small that Presenters would be overhead. However I tend to use Presenters on the real-world projects
* Used RSpec as testing tool just because it was most popular and I was familiar with it more than other tools
* Implemented model, controller and feature specs because such set is usually enough. Sometimes even without controller specs
* Didn't DRY the specs. I don't DRY my specs because I believe it makes life harder. I mean when you have a big real-world test suit with a bunch of `let`s, `before` and `after` blocks or maybe even `shared_examples` and `shared_context`, you have to jump back and forth inside a big files and maybe even between different files to realise what's going on in some particular spec and what are the data prepared for it. I believe the ideal spec should be atomic and should contain all the logic, including data initialization so that you look at it and understand what it does right away 

    
